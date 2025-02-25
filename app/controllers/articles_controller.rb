class ArticlesController < ApplicationController
  def index
    @articles = Article.all

    respond_to do |format|
      format.html  # Renders index.html.erb
      format.atom  # Renders index.atom.builder
    end

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
