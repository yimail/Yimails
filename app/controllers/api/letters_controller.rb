class Api::LettersController < ApplicationController
  before_action :check_login

  def star
    @letter = Letter.find(params[:id])
      if @letter.star.present?
        @letter.update(star: false)
        render json: { result: 'remove' }
      else
        @letter.update(star: true)
        render json: { result: 'add' }
      end
  end

  def add_label
    letter_ids = params[:letter_ids]
    label = Label.find(params[:label_id])
    letter_ids.each do |id|
      letter = Letter.find(id)
      letter.labels << label
      letter.save
    end
  end

  private 

  def check_login
    if !user_signed_in?
      render json: { status: 'fail', message: 'you need to login first!' }, status: 401
    end
  end
end
