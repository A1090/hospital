class PatientsController < ApplicationController
  before_action :load_patient, only: %i[show edit update delete]
  before_action :load_patients, only: %i[list]

  def list
    @patients
  end

  def show
    @patient
  end

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)
  
    if @patient.save
      redirect_to :action => 'list'
    end
  end

  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :address, :cnp, :ensurance_id)
  end

  def edit
    @patient
  end

  def update
    if @patient.update_attributes(patient_params)
      redirect_to :action => 'show', :id => @patient
    end
  end

  def delete
    @patient.destroy
    redirect_to :action => 'list'
  end

  private

  def load_patient
    @patient = Patient.find(params[:id])
  end

  def load_patients
    @patients = Patient.all
  end
end
