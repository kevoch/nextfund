class UsersController < ApplicationController


	def show
		@user = User.find(params[:id])
	end

	def edit 
		
		@user = User.find(params[:id])

		unless current_user.id == @user.id
			authorize! :update, @user
		end

		@user = current_user
	end 

	def update 
		@user = current_user 
		# byebug
		@user.avatar = params[:user][:avatar]
		if @user.save
			redirect_to root_path
		else 
			render :edit
		end
	end 
end
