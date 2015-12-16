class PostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :update, :edit]
  before_action :admin_or_author, only: [:destroy, :edit, :update]

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      image_create
      flash[:success] = "Post created!"
      redirect_to root_url
    else
      @posts = Post.paginate(:page => params[:page])
      render 'static_pages/home'
    end

  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post.destroy
    redirect_to root_url
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    flash[:success] = "Post updated"
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  private

    def image_create
      if params[:images]
        params[:images].each { |image|
          @post.pictures.create(image: image)
        }
      end
    end

    def post_params
      params.require(:post).permit(:content)
    end

    def admin_or_author
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
      redirect_to(root_url) unless administrator? || authorship?
    end

    def administrator?
      current_user.admin?
    end

    def authorship?
      @post.user == current_user
    end
end
