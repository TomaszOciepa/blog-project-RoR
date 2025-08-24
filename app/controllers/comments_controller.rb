class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: [:destroy]
  before_action :authorize_post_author!, only: [:destroy]
  
    def create
      @comment = @post.comments.build(comment_params)
      if @comment.save
        redirect_to @post, notice: "Komentarz dodany."
      else
        # pokaż błędy na stronie posta
        @comments = @post.comments.order(created_at: :desc)
        flash.now[:alert] = "Nie udało się dodać komentarza."
        render "posts/show", status: :unprocessable_entity
      end
    end
  
    def destroy
      @comment = @post.comments.find(params[:id])
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
      params.require(:comment).permit(:author, :content)
    end

   def authorize_post_author!
  return if @post.user == current_user

  redirect_to @post, alert: "Nie masz uprawnień do usuwania komentarzy pod tym postem."
end

  end
  
