class Label < ApplicationRecord
  belongs_to :user

  has_many :letter_with_label
  has_many :letters, through: :letter_with_label
end
