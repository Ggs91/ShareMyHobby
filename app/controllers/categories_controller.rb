class CategoriesController < ApplicationController
  def index
  	@categories = Category.all.order("created_at DESC")
  end

  def show
  	@categories = Category.all.order("created_at DESC")
  	@category = Category.find(params[:id])
  	@events = @category.events

  end
end
