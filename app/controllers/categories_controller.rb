class CategoriesController < ApplicationController
  before_action :require_admin, except: [ :index, :show ]
  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category successfully created!"
      redirect_to @category
    else
      render "new", status: :unprocessable_entity
    end
  end

  def show
    @category = Category.find(params[:id])
    @articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:info] = " Category name updated successfully!"
      redirect_to @category
    else
      render "edit", status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:warning] = "Only admins can perform that action."
      redirect_to categories_path
    end
  end
end
