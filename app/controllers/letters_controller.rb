class LettersController < ApplicationController
  before_action :authenticate_user!, :label_folder
  before_action :current_user_email, only:[:trash]
  before_action :show_label_list, only:[:index, :starred, :sendmail, :trash, :show, :search]

  def index
    @letters = current_user.letters.where(status: "received").order(id: :desc)
  end

  def starred
    @letters = current_user.letters.where(star: true).order(id: :desc)
  end

  def sendmail
    @letters = current_user.letters.where(status: "sent").order(id: :desc)
  end

  def trash
    @letters = current_user.letters.only_deleted.order(id: :desc)
  end

  def new
    @letter = Letter.new
  end

  def create
    @letter = current_user.letters.build(letter_params)
    @letter[:sender] = current_user.email
    @letter[:status] = 1

    if @letter.save
      UserSendEmailJob.perform_later(@letter)
      redirect_to letters_path
    else
      render :new
    end
  end

  def show
    @letter = Letter.with_deleted.find(params[:id])
  end

  def reply
    @letter = current_user.letters.find(params[:id])
    @letter[:recipient] = @letter[:sender]
    @letter[:subject] = "RE: " + @letter[:subject]
  end

  def forwarded
    @letter = current_user.letters.find(params[:id])
    @letter[:recipient] = ""
    @letter[:subject] = "FW: " + @letter[:subject]
  end

  def update
    @letter = current_user.letters.build(letter_params)
    @letter[:sender] = current_user.email
    @letter[:status] = 1
    
    if @letter.save
      UserSendEmailJob.perform_later(@letter)
      redirect_to letters_path
    end
  end

  def destroy
    @letter = Letter.find(params[:id])
    @letter.destroy
    redirect_back(fallback_location: letter_path)
  end

  def retrieve
    @letter = current_user.letters.with_deleted.find(params[:id])
    @letter.restore
    redirect_back(fallback_location: letter_path)
  end

  def search
    @letters = Letter.joins(:rich_text_content).where("sender LIKE ? or recipient LIKE ? or subject LIKE ? or action_text_rich_texts.body LIKE ?" , "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
  end

  private
  def letter_params
    params.require(:letter).permit(:sender, :recipient, :subject, :content, :body, :carbon_copy, :star, :blind_carbon_copy, :attachments, :deleted_at, :status)
  end

  def current_user_email 
    current_user_email = current_user.email
    UserSendEmailJob.perform_later(@letter)
  end

  def show_label_list
    @labels = Label.order(:hierarchy)
  end

  def label_folder
    @label_folder = Label.order(:hierarchy)
  end
end