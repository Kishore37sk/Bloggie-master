class UserCommentRatingsController < ApplicationController
  before_action :set_topic
  before_action :set_post
  before_action :set_comment,only: [:index, :new, :create]
  before_action :authenticate_user!,except: [:index]

  def index
    @user_comment_ratings = @comment.user_comment_ratings.includes([:user])
  end
  def new
    @user_comment_rating = @comment.user_comment_ratings.build
  end

  def create
    @user_comment_rating = @comment.user_comment_ratings.build(user_comment_rating_params)
    @user_comment_rating.user = current_user
    if @user_comment_rating.save
      redirect_to  topic_post_url(@topic,@post),notice: "rated successfully"
    end
  end

  private

  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

  def set_post
    @post = @topic.posts.find(params[:post_id])
  end
  def set_comment
    @comment = Comment.find(params[:comment_id])
  end
  def user_comment_rating_params
    params.require(:user_comment_rating).permit(:star, :comment_id, :user_id)
  end

end
