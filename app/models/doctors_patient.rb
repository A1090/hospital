class DoctorsPatient < ApplicationRecord

  #Relationships
  belongs_to :doctor
  belongs_to :patient
end
