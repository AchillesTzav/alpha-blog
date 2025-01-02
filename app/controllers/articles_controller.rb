class ArticlesController < ApplicationController
  #before action runs the given action in this case :find_article
  #in every method unless you specify
  #in which methods you want to run the action before these methods
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
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
    flash[:warning] = "Article deleted successfully!"
    redirect_to articles_path status: :see_other
  end

  private
    def article_params
      params.require(:article).permit(:title, :description)
    end

    def find_article
      @article = Article.find(params[:id])
    end

    def require_same_user
      if current_user != @article.user && !current_user.admin?
        flash[:warning] = "You can only edit or delete your own article"
        redirect_to @article
      end
    end
end
