class StaicPagesController < ApplicationController
  skip_before_action :logged_in_user
  def home
    if logged_in?
      @article = current_user.articles.build 
      Rails.logger.info @article.inspect
      Rails.logger.info "here"
      @feed_items = current_user.feed
    end

    Rails.logger.info "outside if"
    @articles = Article.all.by_time
  end
end
