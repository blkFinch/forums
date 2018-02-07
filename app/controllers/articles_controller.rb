class ArticlesController < ApplicationController
  def index
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      flash[:success] = "Article Posted!"
      redirect_to user_path(current_user)
    else
      redirect_to user_path(current_user)
    end
  end

  def destroy
  end

  private

    def article_params
      params.require(:article).permit(:title, :body)
    end
end
