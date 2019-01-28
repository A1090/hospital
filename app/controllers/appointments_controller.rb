class AppointmentsController < ApplicationController
  before_action :load_appointment, only: %i[show edit update delete]
  before_action :load_appointments, only: %i[list]
  before_action :load_patients, only: %i[new edit]
  before_action :load_medicines, only: %i[new edit]

  def list
    @appointments
  end

  def show
    @appointment
  end

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(appointment_params)
  
    if @appointment.save
      redirect_to :action => 'list'
   else
      @patients = Patient.all
      @medicines = Medicine.all
      render :action => 'new'
   end
  end

  def appointment_params
    params.require(:appointment).permit(:patient_id, :medicine_id, :appointment_date, :diagnostic, :medicine_dose)
  end

  def edit
    @appointment
  end

  def update
    if @appointment.update_attributes(appointment_params)
      redirect_to :action => 'show', :id => @appointment
    else
      @patients = Patient.all
      @medicines = Medicine.all
      render :action => 'edit'
    end
  end

  def delete
    @appointment.destroy
    redirect_to :action => 'list'
  end

  def show_patients
    @patient = Patient.find(params[:id])
  end
 
  def show_medicines
    @medicine = Medicine.find(params[:id])
  end

  private

  def load_appointment
    @appointment = Appointment.find(params[:id])
  end

  def load_appointments
    @appointments = Appointment.all
  end

  def load_patients
    @patients = Patient.all
  end

  def load_medicines
    @medicines = Medicine.all
  end
end
