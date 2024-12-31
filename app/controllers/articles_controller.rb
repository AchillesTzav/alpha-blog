class ArticlesController < ApplicationController
  #before action runs the given action in this case :find_article
  #in every method unless you specify
  #in which methods you want to run the action before these methods
  before_action :find_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = User.first
    if @article.save
      flash[:notice] = "Article was created successfully!"
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:info] = "Article was updated successfully!"
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    flash[:warning] = "Alert deleted successfully!"
    redirect_to articles_path status: :see_other
  end

  private
    def article_params
      params.require(:article).permit(:title, :description)
    end

    def find_article
      @article = Article.find(params[:id])
    end
end
