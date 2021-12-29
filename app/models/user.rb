class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :authy_authenticatable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,  :authentication_keys => [:username]

  validates :firstname, :lastname, :username, :backup_email, presence: true
  validates :username, uniqueness: true
  
  # references
  has_many :letters
  has_many :labels

  # Devise內建的signup條件是email_required? True，在這裡重新定義
  def email_required?
    false
  end    
end
