class Doctor < ApplicationRecord

  #Relationships
  has_many :doctors_patients, dependent: :destroy
  has_many :patients, through: :doctors_patients
end
