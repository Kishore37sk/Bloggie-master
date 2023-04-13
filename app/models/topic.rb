class Topic < ApplicationRecord


  #=== Associations
  has_many :posts,dependent: :destroy

  #==validations
  validates :name, presence: true
  validates :description, presence: true
  validates :name, uniqueness: true

end
