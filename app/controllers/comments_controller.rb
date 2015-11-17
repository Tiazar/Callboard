class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to @post
    else
      flash.now[:danger] = "error"
    end
  end

  def destroy
    @comment.destroy
    redirect_to root_url
  end


  private
    def comment_params
      params.require(:comment).permit(:user_id, :content)
    end
end
