class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user, dependent: :destroy
  has_one_attached :image

  with_options presence: true do
    validates :title
    validates :category
    validates :progress
  end

  validates :progress, numericality: true
  validates :progress, numericality: { greater_than_or_equal_to: 0 }
  validates :progress, numericality: { less_than_or_equal_to: 100 }

end
