class LikesController < ApplicationController

	before_action :require_login, only: [:create, :destroy]
	before_action :require_correct_user, only: [:create, :destroy]

	def create
		secret = Secret.find(params[:secret_id])
		Like.create(user_id: params[:user_id], secret: secret)
		redirect_to '/secrets' 
	end

	def destroy
		like = Like.find_by_sql("SELECT * from likes WHERE user_id = #{params[:user_id]} AND secret_id = #{params[:secret_id]}")[0]
		like.destroy
		redirect_to '/secrets'
	end

end
