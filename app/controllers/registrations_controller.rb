class RegistrationsController < ApplicationController

  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

  post '/registrations' do
    @user = User.new(params[:user]) #sets the instance variable user to the a new user object that sets the values in the argument to the key attributes in the params hash
    if @user.save #if the new user is saved it sets the session user id equal to the @user.id
      session[:user_id] = @user.id
      redirect '/users/home' #then it redirects the user to their home page view.
    else #otherwise it will render the failure page to display this error message
      @errors = ['Signup failed. Please make sure to enter your name, username, and password.']
      erb :failure
    end
  end
end
