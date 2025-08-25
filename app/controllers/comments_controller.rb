class CommentsController < ApplicationController
  before_action :authenticate_user!          
  before_action :set_post
  before_action :set_comment, only: [:destroy]
  before_action :authorize_comment_deletion!, only: [:destroy]
  
  def create
    @comment = @post.comments.build(comment_params)
    @comment.author = current_user.email      

    if @comment.save
      redirect_to @post, notice: "Komentarz dodany."
    else
      @comments = @post.comments.order(created_at: :desc)
      flash.now[:alert] = "Nie udało się dodać komentarza."
      render "posts/show", status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to @post, notice: "Komentarz usunięty."
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)  
  end


  def authorize_comment_deletion!
    
    return if current_user.admin?
    
    return if current_user.writer? && @post.user == current_user
  
    return if @comment.author == current_user.email
  
    redirect_to @post, alert: "You are not authorized to delete this comment."
  end
  
end
