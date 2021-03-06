class Label < ApplicationRecord
  validates :title, presence: true

  belongs_to :user

  has_many :letter_with_labels
  has_many :letters, through: :letter_with_labels
end
