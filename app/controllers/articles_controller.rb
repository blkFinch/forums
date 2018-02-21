class ArticlesController < ApplicationController

  before_action :logged_in_user, only: [ :show, :create]
  before_action :correct_user, only: [:destroy]


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
      redirect_to root_url if @article.nil?
    end

   def is_admin
    unless current_user.permission >= 3
      flash[:danger] = "Not Authorized!"
      redirect_to(root_url)
    end
  end
end
