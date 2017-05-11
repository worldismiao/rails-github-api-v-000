class RepositoriesController < ApplicationController
	
  def index
  	 resp=Faraday.get('https://api.github.com/user/repos') do |req|
  	 #req.params[:access_token]=session[:token]
  	 req.headers['Authorization']="token #{session[:token]}"
  	 #req.headers['Accept'] = 'application/json'
  	 end 
  	 @repos=JSON.parse(resp.body)
  	 get_user_info
  end

  def create
  	resp=Faraday.post('https://api.github.com/user/repos') do |req|
  	 req.params[:name]=params[:name].to_json
  	 req.headers['Authorization']="token #{session[:token]}"
  	 end
  	 redirect_to root_path
  end

  private 
  def get_user_info
  	resp=Faraday.get('https://api.github.com/user') do |req|
  	req.headers['Authorization']="token #{session[:token]}"
  	 end
  	 @user_info=JSON.parse(resp.body)
  	end 

end
