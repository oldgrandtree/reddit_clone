class CommentsController < ApplicationController
  
  before_action :ensure_authorized, only: [:edit, :update, :destroy]
  before_action :ensure_signed_in, only: [:new, :create]
  
  helper_method :is_authorized?
  
  def edit
    @comment = Comment.find(params[:id]).decorate
  end
  
  def update
    @comment = Comment.find(params[:id]).decorate
    
    if @comment.update_attributes(comment_params)
      redirect_to post_url(@comment.post)
    else
      flash[:errors] = @comment.errors.full_messages
      render :edit
    end
  end
  
  def new
    @comment = Comment.new.decorate
    if params[:post_id]
      @comment.post = Post.find(params[:post_id])
    else
      @comment.post = Comment.find(params[:comment_id]).post
      @comment.parent_comment_id = params[:comment_id]
    end
    
  end
  
  def create
    @comment = Comment.new(comment_params).decorate
    
    if params[:post_id]
      @comment.post = Post.find(params[:post_id])
    else
      parent_comment = Comment.find(params[:comment_id])
      @comment.post = parent_comment.post
      parent_comment.child_comments << @comment
    end
    
    @comment.submitter = current_user
    
    if @comment.save
      redirect_to post_url @comment.post
    else
      flash[:errors] = @comment.errors.full_messages
      render :new
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content)
  end
  
  def ensure_authorized
    comment = Comment.find(params[:id])

    unless is_authorized?(comment)
      flash[:errors] = ["You can't touch this!"]
      redirect_to :back
    end
  end
  
  def is_authorized?(comment)
    [comment.post.sub.moderator, comment.submitter].include?(current_user)
  end
end
