class CategoriesController < ApplicationController
  def show
  	@categories = Category.all.order("created_at DESC")
  	@category = Category.find(params[:id])
  end
end
