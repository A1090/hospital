class DoctorsController < ApplicationController
  before_action :load_doctor, only: %i[show edit update delete show_patients add_patient]
  before_action :load_doctors, only: %i[list]

  def list
    @doctors
  end

  def show
    @doctor
  end

  def new
    @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.new(doctor_params)
  
    if @doctor.save
      redirect_to :action => 'list'
    else 
      @error = @doctor.errors
      render file: "app/views/error"
    end
  end

  def doctor_params
    params.require(:doctor).permit(:first_name, :last_name, :specialization, :patient_ids)
  end

  def patient_params
    params.require(:doctor).permit(:patient_id, :doctor_id)
  end

  def doctors_patient_params
    params.require(:doctors_patient).permit(:patient_id, :doctor_id)
  end

  def add_patient
    @doctors_patient = DoctorsPatient.new
    @patients = Patient.where.not(id: DoctorsPatient.where(doctor_id: @doctor.id).pluck(:patient_id))
  end

  def create_patient
    dp = DoctorsPatient.new(doctors_patient_params.merge(doctor_id: params[:doctor_id]))
    if dp.save
      redirect_to :action => 'show_patients', id: dp.doctor_id
    else
      @error = dp.errors
      render file: "app/views/error"
    end
  end

  def show_patients
    @patients = Patient.where(id: DoctorsPatient.where(doctor_id: @doctor.id).pluck(:patient_id))
  end

  def edit
    @doctor
  end

  def update
    if @doctor.update_attributes(doctor_params)
      redirect_to :action => 'show', :id => @doctor
    else
      @error = @doctor.errors
      render file: "app/views/error"
    end
  end

  def delete
    if current_user.admin
      @doctor.destroy
      redirect_to :action => 'list'
    else
      @error = "The current user is not an admin."
    end
  end

  def delete_patients
    @dp = DoctorsPatient.where(doctor_id: params[:id], patient_id: params[:patient_id])
    if current_user.admin
      @dp.first.destroy if @dp.present?
      redirect_to :action => 'show_patients', id: params[:id]
    else
      @error = "The current user is not an admin."
    end
  end

  private

  def load_doctor
    @doctor = Doctor.find(params[:id])
  end

  def load_doctors
    @doctors = Doctor.all.order(created_at: :desc)
  end
end
