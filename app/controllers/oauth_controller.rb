class OauthController < ApplicationController
  def redirect
  	callback="http://rocky-mountain-1051.herokuapp.com/oauth_redirect_url"
    session[:access_token] = Koala::Facebook::OAuth.new(callback).get_access_token(params[:code]) if params[:code]

    redirect_to session[:access_token] ? root_path : failure_path
  end
end
