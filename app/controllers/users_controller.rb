class UsersController < ApplicationController
  def index
    if current_user.present?
      redirect_to letters_path
    end
  end
end
