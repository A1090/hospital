class DoctorsController < ApplicationController
  before_action :load_doctor, only: %i[show edit update delete]
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
    end
  end

  def doctor_params
    params.require(:doctor).permit(:first_name, :last_name, :specialization)
  end

  def edit
    @doctor
  end

  def update
    if @doctor.update_attributes(doctor_params)
      redirect_to :action => 'show', :id => @doctor
    end
  end

  def delete
    @doctor.destroy
    redirect_to :action => 'list'
  end

  private

  def load_doctor
    @doctor = Doctor.find(params[:id])
  end

  def load_doctors
    @doctors = Doctor.all
  end
end
