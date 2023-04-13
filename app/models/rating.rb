class Rating < ApplicationRecord
  #=== Associations
  belongs_to :post, counter_cache: true, touch: true

  #=== Validations
  validates :rate, presence: true

  #=== Using Active Record callback to save average ratings of each posts
  after_save do
    post.update_rating_average!
  end

end
