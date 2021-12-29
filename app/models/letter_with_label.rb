class LetterWithLabel < ApplicationRecord
  belongs_to :letter
  belongs_to :label
end
