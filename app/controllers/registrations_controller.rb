class RegistrationsController < ApplicationController

  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

  post '/registrations' do
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect '/users/home'
    else
      @errors = ['Signup failed. Please make sure to enter your name, username, and password.']
      erb :failure
    end
  end
end
