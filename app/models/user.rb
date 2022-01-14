class User < ApplicationRecord
  after_create :create_hello_letter
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

  private
  def create_hello_letter
    self.letters.create(
      subject: "Hello", 
      recipient: self.email,
      body: "歡迎使用Yimail! 簡單介面、輕鬆編輯，是您電子郵件的最佳選擇",
      status: 0
    )
  end
end