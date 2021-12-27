class UsersController < ApplicationController
  def index
    if current_user.present?
      redirect_to letters_url
    end
  end
end
