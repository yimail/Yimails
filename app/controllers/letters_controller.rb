class LettersController < ApplicationController
  before_action :authenticate_user!, :label_folder
  before_action :current_user_email, only:[:trash]
  before_action :show_label_list, only:[:index, :starred, :sendmail, :trash, :show]

  def index
    @letters = current_user.letters.where(status: "receiver").order(id: :desc)
  end

  def starred
    @letters = current_user.letters.where(star: true).order(id: :desc)
  end

  def sendmail
    @letters = current_user.letters.where(status: "sent").order(id: :desc)
  end

  def trash
    @letters = Letter.only_deleted.wherex
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
    @letter[:recipient] = @letter[:sender][2..-3]
    @letter[:subject] = "Re:" + @letter[:subject]
  end

  def forwarded
    @letter = current_user.letters.find(params[:id])
    @letter[:recipient] = ""
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