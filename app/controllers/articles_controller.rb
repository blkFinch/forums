class ArticlesController < ApplicationController

  before_action :logged_in_user, only: [ :show]

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

  def show
    @article = Article.find(params[:id])
    @comments = @article.comments.by_time.reverse_order
  end

  def destroy
    @article = current_user.articles.find(params[:id])
    @article.destroy
    redirect_to user_path(current_user) 
  end

  private

    def article_params
      params.require(:article).permit(:title, :body)
    end

    def correct_user
      @article = current_user.articles.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
