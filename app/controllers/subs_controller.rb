class SubsController < ApplicationController
  
  before_action :ensure_moderator, only: [:edit, :update, :destroy]
  
  helper_method :is_moderator?
  
  def index
    @subs = Sub.all
  end
  
  def show
    @sub = Sub.find(params[:id])
  end
  
  def edit
    @sub = Sub.find(params[:id]).decorate
  end
  
  def update
    @sub = Sub.find(params[:id]).decorate
    
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :edit
    end
  end
  
  def new
    @sub = Sub.new.decorate
  end
  
  def create
    @sub = Sub.new(sub_params).decorate
    @sub.moderator = current_user
    
    if @sub.save
      redirect_to sub_url @sub
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end
  
  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
  
  def ensure_moderator
    @sub = Sub.find(params[:id])
    is_moderator?(@sub)
  end
  
  def is_moderator?(sub)
    sub.moderator == current_user
  end
end
