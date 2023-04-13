class UserCommentRating < ApplicationRecord

  #=== Associations
  belongs_to :user
  belongs_to :comment

  #=== Validates
  validates :star, presence: true

  after_save do
    comment.update_ucr_avg!
  end

end
