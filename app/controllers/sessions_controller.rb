class SessionsController < ApplicationController

  get '/sessions/login' do
    erb :'/sessions/login'
  end

  post '/sessions' do #this method post request
    @user = User.find_by(username: params[:username]) #sets the instance variable user equal to the user object found by username params
    if @user && @user.authenticate(params[:password]) #if it returns that user AND the the password that was entered matches the salted hashed pw in the database and therefore authenticates,
      session[:user_id] = @user.id #then we'll set the session user_id equal to the @user.id
      redirect '/users/home' #and then redirect the user to their homepage view.
    else
      @errors = ['Invalid username or password.'] #otherwise, it will redirect the user to the failure route to display this error message. 
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
