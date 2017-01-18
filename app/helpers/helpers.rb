require './config/environment'

module Sinatra
  module SessionHelper
    def current_user
      User.find_by(id:session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end
  end
end
