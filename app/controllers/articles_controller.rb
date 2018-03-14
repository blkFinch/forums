class ArticlesController < ApplicationController

  # before_action :authorize_request [:index]
  
  before_action :correct_user, only: [:destroy]


  def index
    @articles = Article.all
    # json_response(@articles)
    respond_to do |format |
      format.json {render json: @articles.to_json}
      format.html 
    end
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
    # json_response(@article)
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
