class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,  :authentication_keys => [:username]

  validates :email, :uniqueness => {:allow_blank => true}
  validates :firstname, :lastname, :username, :backup_email, presence: true
  validates :username, uniqueness: true

  def email_required?
    false
  end

end
