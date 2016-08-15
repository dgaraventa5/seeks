class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead. 
  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end
  def require_login
    redirect_to '/sessions/new' if session[:user_id] == nil
  end
  def require_correct_user
    if params[:user_id]
      user = User.find(params[:user_id])
    else
      user = User.find(params[:id])
    end
    redirect_to current_user if current_user != user
  end
  
  helper_method :current_user
  protect_from_forgery with: :exception
end
