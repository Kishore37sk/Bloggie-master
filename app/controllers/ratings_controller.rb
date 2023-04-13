class RatingsController < ApplicationController
  before_action :authenticate_user!,except: [:show]
  before_action :set_topic
  before_action :set_post

  def create
    @rating = @post.ratings.create(ratings_params)
     if @rating.save
       redirect_to topic_post_url(@topic,@post)
     end

  end


  private

  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

  def set_post
    @post = @topic.posts.find(params[:post_id])
  end

  def ratings_params
    params.require(:rating).permit(:rate, :post_id)
  end
end
