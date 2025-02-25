class ArticlesController < ApplicationController
  def index
    @articles = Article.all


    benchmark "Loading all articles" do
      @articles = Article.all
    end
  end

  def show
    benchmark "Fetching an article" do
      @article = Article.find(params[:id])
    end
  end
end
