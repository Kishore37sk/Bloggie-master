class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #=== Associations
  has_many :posts
  has_many :comments
  has_and_belongs_to_many :posts
  has_many :user_comment_ratings
  has_many :comments, through: :user_comment_ratings
  has_one_attached :avatar

after_create :send_mail  
  
def send_mail 
  SendSignUpEmailJob.perform_now(self)
end

end
