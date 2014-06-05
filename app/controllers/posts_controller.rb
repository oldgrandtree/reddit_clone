class PostsController < ApplicationController
  
  before_action :ensure_authorized, only: [:edit, :update, :destroy]
  before_action :ensure_signed_in, only: [:new, :create]
  
  helper_method :is_authorized?
  
  def show
    @post = Post.find(params[:id]).decorate
    @comments = @post.comments.decorate
  end
  
  def edit
    @post = Post.find(params[:id]).decorate
  end
  
  def update
    @post = Post.find(params[:id]).decorate
    
    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end
  
  def new
    @post = Post.new.decorate
    @post.sub = Sub.find(params[:sub_id])
  end
  
  def create
    @post = Post.new(post_params).decorate
    @post.submitter = current_user
    @post.sub = Sub.find(params[:sub_id])
    
    if @post.save
      redirect_to post_url @post
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :url, :content)
  end
  
  def ensure_authorized
    unless is_authorized?(Post.find(params[:id]))
      flash[:errors] = ["You can't touch this!"]
      redirect_to post_url(params[:id])
    end
  end
  
  def is_authorized?(comment)
    [comment.post.sub.moderator, comment.submitter].include?(current_user)
  end
end