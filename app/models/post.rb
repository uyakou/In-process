class Post < ApplicationRecord
  belongs_to :user
  attachment :image

  with_options presence: true do
    validates :title
    validates :category
    validates :progress
  end

  validates :progress, numericality: true

end
