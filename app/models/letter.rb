class Letter < ApplicationRecord
  acts_as_paranoid

  has_rich_text :content
  belongs_to :user

  has_many :letter_with_label
  has_many :labels, through: :letter_with_label
  has_many_attached :attachments
end