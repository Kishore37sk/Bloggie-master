# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_topic
  before_action :set_post, only: %i[show edit update destroy post_read]

  # GET /posts or /posts.json

  def posts
    @posts = if @topic.present?
               @topic.posts.includes(:user)
             else
               Post.all.includes(:topic, :user)
             end
  end
  def index
    @posts = posts

    #=== Date filtration
    if params[:from_date].present? && params[:to_date].present?
      from_date = params[:from_date] || 1.day.ago.to_date.to_s
      to_date = params[:to_date] || Date.today.to_s
      @posts = @posts.filter_by_date_range(from_date, to_date)
    end
    #=== Sort by Avg Ratings (DESC)
    @posts = @posts.popular_post(params[:direction]) if params[:sort] == 'rating_average'
    #=== Pagination
    @posts = @posts.paginate(page: params[:page], per_page: 5).order('created_at DESC')

    if current_user.present?
      @post_read = {}
      @posts.each do |post|
        if post.users.find_by_id(current_user.id)
          @post_read[post.id] = true
        else
          false
        end
      end
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
    @rating = @post.ratings.group(:rate).count
  end

  # GET /posts/new
  def new
    @post = @topic.posts.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts or /posts.json
  def create
    @post = @topic.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.js
        format.html { redirect_to topic_post_url(@topic, @post), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.js
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end

    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)

        format.html { redirect_to topic_post_url(@topic, @post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else

        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to topic_posts_url(@topic), notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def post_read

    unless @post.users.find_by_id(current_user.id)
      @post.users << User.find(current_user.id)
    end

    respond_to do |format|
      format.html { redirect_to topic_post_url(@topic, @post) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  def set_topic
    @topic = Topic.find(params[:topic_id]) if params[:topic_id].present?
  end

  def set_post
    @post = @topic.posts.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:name, :body, :topic_id, :user_id, tags_attributes: [:tagname], tag_ids: [])
  end

  def ratings_params
    params.require(:rating).permit(:rate, :post_id)
  end
end
