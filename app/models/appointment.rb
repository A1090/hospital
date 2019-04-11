class Appointment < ApplicationRecord

  #Relationships
  belongs_to :patient
  belongs_to :medicine

  validates :medicine_dose, numericality: true
  validates :appointment_date, :patient_id, :medicine_id, presence: true
end
