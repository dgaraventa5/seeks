class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:Email])
  	if user.authenticate(params[:Password]) == false
  		flash[:errors] = "Invalid email/password combination. Please try again."
  		redirect_to '/sessions/new'
  	else
  		user.authenticate(params[:Password])
      session[:user_id] = user.id
  		redirect_to "/users/#{user[:id]}"
  	end
  end

  def destroy
    reset_session
    redirect_to '/sessions/new'
  end

end
