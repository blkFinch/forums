class StaicPagesController < ApplicationController
  def home
    if logged_in?
      @article = current_user.articles.build 
      @feed_items = current_user.feed
    end
    @articles = Article.all.by_time
  end
end
