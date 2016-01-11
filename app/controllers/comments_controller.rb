class CommentsController < ApplicationController
before_action :admin_or_author, only: [:destroy, :edit, :update]
before_action :signed_in_user, only:  :destroy

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash.now[:success] = "Your comment has been posted."
      respond_to do |format|
        format.html { redirect_to @post }
        format.js
      end
    else
      flash.now[:danger] = "error"
      respond_to do |format|
        format.html { render @post }
        format.json { head :no_content }
        format.js
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash.now[:success] = "Comment deleted."
    respond_to do |format|
      format.html { redirect_to post_path(@post) }
      format.js
    end
  end


  private
    def comment_params
      params.require(:comment).permit(:user_id, :content)
    end

    def admin_or_author
      @comment = Comment.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
      redirect_to(root_url) unless administrator? || authorship?
    end

    def administrator?
      current_user.try(:admin?)
    end

    def authorship?
      @comment.user == current_user
    end
end
