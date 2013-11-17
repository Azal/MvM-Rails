class OauthController < ApplicationController
  def redirect
    oauth_redirect_url=root_url
    session[:access_token] = Koala::Facebook::OAuth.new(oauth_redirect_url).get_access_token(params[:code]) if params[:code]

    redirect_to session[:access_token] ? root_path : failure_path
  end
end
