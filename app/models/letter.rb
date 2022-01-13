class Letter < ApplicationRecord
  acts_as_paranoid

  has_rich_text :content
  has_rich_text :body
  belongs_to :user

  has_many :letter_with_labels
  has_many :labels, through: :letter_with_labels
  has_many_attached :attachments

  # validates_each :attachments, less_than: 0.megabytes
  validates :recipient, presence: true, format: { with: Devise.email_regexp }

  enum status: {
    received: 0,
    sent: 1
  }
end