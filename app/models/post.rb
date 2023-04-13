class Post < ApplicationRecord

  scope :filter_by_date_range, -> (from_date, to_date) {
    where(created_at: from_date..to_date)
  }
  scope :popular_post, -> (direction = :desc) { order(rating_average: direction) }
  #=== Associations
  belongs_to :topic
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :users
  accepts_nested_attributes_for :tags, reject_if: :all_blank
  has_one_attached :image

  #=== validations
  validates :name,presence: true
  validates :body,presence: true
  validates :name, length: { maximum: 20 }

  #=== Functions/Methods

  def update_rating_average!
    update_attribute(:rating_average, ratings.average(:rate).to_f.round(1))
  end

end
