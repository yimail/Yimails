class LettersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_letter, only:[:show, :destroy]
  before_action :current_user_email, only:[:index, :starred, :trash]
  before_action :show_label_list, only:[:index, :starred, :sendmail, :trash, :show]

  def index 
    @letters = Letter.where("recipient = ?" , "#{current_user_email}").includes(:user, :rich_text_content).order(id: :desc)
  end
  
  def starred
    @letters = Letter.where("sender = ? or recipient = ?", "#{current_user_email}", "#{current_user_email}").where("star = ?", "true").includes(:user, :rich_text_content).order(id: :desc)
  end

  def sendmail
    @letters = current_user.letters.includes(:rich_text_content).order(id: :desc)
  end

  def trash
    @letters = Letter.only_deleted.where("sender = ? or recipient = ?", "#{current_user_email}", "#{current_user_email}").includes(:user, :rich_text_content).order(id: :desc)
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
  end

  def destroy
    @letter.destroy
    redirect_back(fallback_location: letter_path)
  end

  private
  def find_letter
    @letter = Letter.find(params[:id])
  end

  def letter_params
    params.require(:letter).permit(:sender, :recipient, :subject, :content, :carbon_copy, :star, :blind_carbon_copy, :attachments, :deleted_at)
  end

  def current_user_email 
    current_user_email = current_user.email
  end

  def show_label_list
    @labels = Label.order(:hierarchy)
  end
end