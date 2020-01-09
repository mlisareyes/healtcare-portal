require 'pry'
class PatientsController < ApplicationController

  get '/patients' do #method for get request to the /patients path
    redirect_if_not_logged_in
    @patients = Patient.all #setting the instance variable patients equal to all the patients that were created, and this is referred to in the index page to show the current user's patients.
    erb :'patients/index' #it renders this viewpage that shows a list of all of the current user's patients
    #binding.pry
  end

  get '/patients/new' do #method for the get request to the /patients/new path
    redirect_if_not_logged_in
    erb :'patients/new' #renders this page to a form that will prompt the user to create a new patient
  end

  post '/patients' do #method for the post request /patients (post is sending data to the server)
    @patient = Patient.new(params[:patient]) #sets the instance variable patient equal to a new instance of a patient object, assigning each value to the correct attributes in the patient params.
    @patient.user_id = current_user.id #sets the patient's user_id equal to the current user's id, so that it assigns that patient to that specific user that created the patient.
    binding.pry
    if @patient.save #if the patient is saved, it will redirect the user to the patient's page that shows all the information that the user entered for that patient.
      redirect "/patients/#{@patient.id}"
    else
      #erb :'patients/new'
      @errors = ['Patient was not created. Please try again.'] # if the patient wasn't saved, it will show this message
      erb :failure #and render the failure page that shows the error message
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
    binding.pry
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
