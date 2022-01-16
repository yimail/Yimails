class LettersController < ApplicationController
  before_action :authenticate_user!, :label_folder
  before_action :show_label_list, only:[:index, :starred, :sendmail, :trash, :show, :search]

  def index
    @letters = current_user.letters.where(status: "received").order(id: :desc).page(params[:page]).per(25)
  end

  def starred
    @letters = current_user.letters.where(star: true).order(id: :desc).page(params[:page]).per(25)
  end

  def sendmail
    @letters = current_user.letters.where(status: "sent").order(id: :desc).page(params[:page]).per(25)
  end

  def trash
    @letters = current_user.letters.only_deleted.order(id: :desc).page(params[:page]).per(25)
  end

  def new
    @letter = Letter.new
  end

  def create
    @letter = current_user.letters.build(letter_params)
    @letter[:sender] = current_user.email

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
    @letters = current_user.letters.where("sender ILIKE ? or recipient ILIKE ? or subject ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%").order(id: :desc)
  end

  private
  def letter_params
    params.require(:letter).permit(:sender, :recipient, :subject, :content, :body, :carbon_copy, :star, :blind_carbon_copy, :attachments, :deleted_at, :status)
  end

  def show_label_list
    @labels = current_user.labels.order(:hierarchy)
  end

  def label_folder
    @label_folder = current_user.labels.order(:hierarchy)
  end
end