class StaicPagesController < ApplicationController
  def home
    @article = current_user.articles.build if logged_in?
  end
end
