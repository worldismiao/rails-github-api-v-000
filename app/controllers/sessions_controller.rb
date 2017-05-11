class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create
  def create
  	resp=Faraday.post('https://github.com/login/oauth/access_token') do |req|
  		req.params[:client_id]=ENV['GITHUB_CLIENT_ID']
  		req.params[:client_secret]=ENV['GITHUB_CLIENT_SECRET']
  		req.params[:code]=params[:code]
  		req.headers['Accept'] = 'application/json'
  	end 
  	user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
  	body=JSON.parse(user_response.body)
  	session[:username]=body['login']
  	redirect_to root_path
  end
end