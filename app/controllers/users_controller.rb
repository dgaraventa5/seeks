class UsersController < ApplicationController

  before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
  end

  def create
  	@user = User.new(name: params[:Name], email: params[:Email], password: params[:Password], password_confirmation: params[:Password_Confirmation])
  	if @user.save
  		session[:user_id] = @user.id
  		redirect_to "/users/#{@user[:id]}"
  	else
  		flash[:errors] = @user.errors.full_messages
  		redirect_to '/users/new'
  	end
  	
  end

  def show
  	@user = User.find(params[:id])
  	@secrets = User.find(params[:id]).secrets
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(name: params[:name], email: params[:email])
  		redirect_to "/users/#{params[:id]}"
  	else
  		flash[:errors] = @user.errors.full_messages
  		redirect_to "/users/#{params[:id]}/edit"
  	end
  end


  def destroy
  	User.find(params[:id]).destroy
  	reset_session
  	redirect_to '/sessions/new'	
  end

end
