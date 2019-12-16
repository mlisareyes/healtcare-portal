class UsersController < ApplicationController

  get '/users/home' do
    @user = User.find(session[:user_id])
    if !logged_in?
      redirect "/sessions/login"
    else
      erb :'/users/home'
    end
  end
end
