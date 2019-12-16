require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    erb :home
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def redirect_if_not_logged_in
      unless logged_in?
        redirect "/sessions/login"
      end
    end

    def correct_user?
      session[:user_id] == @patient.user_id
    end

    def current_user
      User.find_by_id(session[:user_id])
    end

    def redirect_if_incorrect_user
      unless correct_user?
        redirect "/sessions/restricted"
      end
    end
    
  end
end
