class Post < ApplicationRecord
  belongs_to :user
  attachment :image

  with_options presence: true do
    validates :title
    validates :category
    validates :progress
  end

  validates :progress, length: { is: 3 }
  validates :progress, numericality: true

end
