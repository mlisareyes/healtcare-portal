require 'pry'
class PatientsController < ApplicationController

  get '/patients' do
    redirect_if_not_logged_in
    @patients = Patient.all
    erb :'patients/index'
  end

  get '/patients/new' do
    redirect_if_not_logged_in
    erb :'patients/new'
  end

  post '/patients' do
    @patient = Patient.new(params[:patient])
    @patient.user_id = current_user.id

    if @patient.save
      redirect "/patients/#{@patient.id}"
    else
      #erb :'patients/new'
      @errors = ['Patient was not created. Please try again.']
      erb :failure
    end
  end

  get '/patients/:id' do
    @patient = Patient.find_by(id: params[:id])
    redirect_if_not_logged_in
    redirect_if_incorrect_user

    if @patient
      erb :'patients/show'
    else
      redirect "/patients"
    end
  end

  get '/patients/:id/edit' do
    @patient = Patient.find_by(id: params[:id])
    redirect_if_not_logged_in
    redirect_if_incorrect_user

    erb :'patients/edit'
  end

  patch '/patients/:id' do
    @patient = Patient.find_by(id: params[:id])
    redirect_if_not_logged_in
    redirect_if_incorrect_user

    if @patient.update(params[:patient])
      redirect "/patients/#{@patient.id}"
    else
      @errors = ['Patient was not updated.']
      erb :failure
    end
  end

  delete '/patients/:id' do
    @patient = Patient.find_by(id: params[:id])
    redirect_if_not_logged_in
    redirect_if_incorrect_user

    if @patient.destroy
      redirect "/patients"
    else
      @errors = ['Patient was not deleted.']
      erb :failure
    end
  end
end
