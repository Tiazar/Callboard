class StaticPagesController < ApplicationController
  def home
    @posts = Post.paginate(:page => params[:page])
    @post = current_user.posts.build if signed_in?
  end

  def help
  end

  def about
  end
end
