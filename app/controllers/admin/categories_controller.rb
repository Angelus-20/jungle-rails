class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path, notice: 'Category created!'
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def authenticate_admin!
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["HTTP_BASIC_AUTH_USERNAME"] && password == ENV["HTTP_BASIC_AUTH_PASSWORD"]
    end
  end
end
