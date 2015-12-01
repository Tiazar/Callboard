class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      respond_to do |format|
        format.html do
          flash[:success] = "Your comment has been posted."
          redirect_to @post
        end
        format.js
      end
    else
      flash.now[:danger] = "error"
      respond_to do |format|
        format.html { render @post }
        format.js
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy


    respond_to do |format|
      format.html do
        flash[:success] = "Comment deleted."
        redirect_to post_path(@post)
      end
      format.js
    end
  end


  private
    def comment_params
      params.require(:comment).permit(:user_id, :content)
    end
end
