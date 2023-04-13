# frozen_string_literal: true

class CommentsController < ApplicationController

  before_action :set_topic
  before_action :set_post
  before_action :authenticate_user!
  before_action :comment_params, only: [:create]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user
    @comment.save
    redirect_to topic_post_url(@topic, @post)
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to topic_post_url(@topic, @post)
  end

  private

  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

  def set_post
    @post = @topic.posts.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :post_id, :user_id)
  end
end
