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
    def logged_in? #returns true/truthy if the user_id is in the session hash, in other words if a user is logged into the app, it returns true/truthy
      #returns true or false based on whether
      !!session[:user_id]
    end

    def redirect_if_not_logged_in #this method refers back to the logged_in? method. If the that method returned false/falsey, then it will redirect the user to the login page so that user will be able to sign in.
      unless logged_in?
        redirect "/sessions/login"
      end
    end

    def correct_user? #this method compares the session[:user_id] to the @patient.user_id, and if they are equal to each other then it is the correct user. This method is important in determining whether or not a user has authorization.
      #This method comes in handy when a user is trying to edit a patient. A user cannot edit someone else's patient, only their own.
      session[:user_id] == @patient.user_id
    end

    def current_user #this method accepts the session hash as an argument, and it uses the user_id from the session hash to find the user in the database and return that user.
      User.find_by_id(session[:user_id])
    end

    def redirect_if_incorrect_user #If the correct_user method returns false then it will redirect the user to restricted page that informs that that they are not allowed to view private patient information.
      #Again, a user cannot view or edit a patient that does not belong to them. 
      unless correct_user?
        redirect "/sessions/restricted"
      end
    end

  end
end
