class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by_email(params[:session][:email])
		if user && user.authenticate(params[:session][:password])
			#Sign the user in and redirect to their show page
			sign_in user
			redirect_to user
		else
			if user
				flash.now[:error] = 'Invalid email/password combination' 
			else
				flash.now[:error] = 'User does not exist'
			end
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end
end
