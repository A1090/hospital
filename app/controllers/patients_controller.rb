class PatientsController < ApplicationController
  before_action :load_patient, only: %i[show edit update delete add_doctor show_doctors]
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
      redirect_to :action=>'list'
    else
      @error = @patient.errors
      render file: "app/views/error"
    end
  end

  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :address, :cnp, :ensurance_id)
  end

  def doctors_patient_params
    params.require(:doctors_patient).permit(:patient_id, :doctor_id)
  end

  def add_doctor
    @doctors_patient = DoctorsPatient.new
    @doctors = Doctor.where.not(id: DoctorsPatient.where(patient_id: @patient.id).pluck(:doctor_id))
  end

  def create_doctor
    dp = DoctorsPatient.new(doctors_patient_params.merge(patient_id: params[:patient_id]))
    if dp.save
      redirect_to :action => 'show_doctors', id: dp.patient_id
    else
      @error = dp.errors
      render file: "app/views/error"
    end
  end

  def show_doctors
    @doctors = Doctor.where(id: DoctorsPatient.where(patient_id: @patient.id).pluck(:doctor_id))
  end

  def delete_doctors
    @dp = DoctorsPatient.where(doctor_id: params[:doctor_id], patient_id: params[:id])
    if current_user.admin
      @dp.first.destroy if @dp.present?
      redirect_to :action => 'show_doctors', id: params[:id]
    else
      @error = "The current user is not an admin."
    end
  end

  def edit
    @patient
  end

  def update
    if @patient.update_attributes(patient_params)
      redirect_to :action => 'show', :id => @patient
    else
      @error = @patient.errors
      render file: "app/views/error"
    end
  end

  def delete
    if current_user.admin
      @patient.destroy
      redirect_to :action => 'list'
    else
      @error = "The current user is not an admin."
    end
  end

  private

  def load_patient
    @patient = Patient.find(params[:id])
  end

  def load_patients
    @patients = Patient.all.order(created_at: :desc)
  end
end
