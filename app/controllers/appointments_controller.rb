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
      @error = @appointment.errors
      render file: "app/views/error"
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
      @error = @appointment.errors
      render file: "app/views/error"
    end
  end

  def delete
    if current_user.admin
      @appointment.destroy
      redirect_to :action => 'list'
    else
      @error = "The current user is not an admin."
    end
  end

  private

  def load_appointment
    @appointment = Appointment.find(params[:id])
  end

  def load_appointments
    @appointments = Appointment.all.order(created_at: :desc)
  end

  def load_patients
    @patients = Patient.all.order(created_at: :desc)
  end

  def load_medicines
    @medicines = Medicine.all.order(created_at: :desc)
  end
end
