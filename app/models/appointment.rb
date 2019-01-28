class Appointment < ApplicationRecord

  #Relationships
  belongs_to :patient
  belongs_to :medicine
end
