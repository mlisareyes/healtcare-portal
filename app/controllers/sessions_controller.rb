class SessionsController < ApplicationController

  get '/sessions/login' do
    erb :'/sessions/login'
  end

  post '/sessions' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/users/home'
    else
      @errors = ['Invalid username or password.']
      erb :failure
    end
  end

  get '/sessions/restricted' do
    erb :'/sessions/restricted'
  end

  get '/sessions/logout' do
    session.clear 
    redirect '/'
  end
end
