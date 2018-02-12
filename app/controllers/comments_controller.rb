class CommentsController < ApplicationController

  def create
    @article = Article.find(params[:article_id])
    @user = current_user
    @comment = @article.comments.create(comment_params.merge(user: @user))
    if @comment.save
      redirect_to article_path(@article)
    else
      flash[:danger] = "Couldnt create comment : ((("
    end
  end

  def destroy
    @article = current_user.comments.find(params[:id]).article
    @comment = @article.comments.find(params[:id])

    @comment.destroy
    redirect_to article_path(@article)
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
