class Letter < ApplicationRecord
  acts_as_paranoid

  has_rich_text :content
  has_rich_text :body
  belongs_to :user

  has_many :letter_with_label
  has_many :labels, through: :letter_with_label
  has_many_attached :attachments

  enum status: {
    received: 0,
    sent: 1
  }
end