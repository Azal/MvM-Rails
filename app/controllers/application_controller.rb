class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :oauth

def oauth
  @oauth_code=session[:access_token]
end
end
