class UsersController < ApplicationController
	def show
		@user = User.all
		@user = User.find(params[:id])
	end
end
