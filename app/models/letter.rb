class Letter < ApplicationRecord
  has_rich_text :content
  belongs_to :user
end
