class Comment < ApplicationRecord
  #=== Associations
  belongs_to :post, counter_cache: true, touch: true
  belongs_to :user
  has_many :user_comment_ratings
  has_many :users, through: :user_comment_ratings

  #=== validations
  validates :body, presence: true
  validates :body, length: { minimum: 2}

  def update_ucr_avg!
    update_attribute(:ucr_avg, user_comment_ratings.average(:star))
  end

end
