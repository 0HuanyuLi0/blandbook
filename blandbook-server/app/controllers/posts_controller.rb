class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.create post_params
  end

  def index
    @posts = Post.all.order("created_at DESC")
 

    respond_to do |format|
      format.html
      format.json{render json: @posts, include:[:user, :comments]}
    end
  end

  def show
    @post = Post.find params[:id]
  end

  def edit
    @post = Post.find params[:id]
  end

  def update
    @post = Post.find params[:id]
    @post.update post_params
  end

  def destroy
    Post.destroy params[:id]
  end

  def search
    keyword = params[:keyword]
    rlts_post = Post.where("title ilike ?","%#{keyword}%")
    rlts_user = User.where("screen_name ilike ?","%#{keyword}%")
    rlts = rlts_post + rlts_user
    render json: rlts
  end


  private

  def post_params
    params.require(:post).permit(:user_id, :title, :like, :dislike)
  end 


end
