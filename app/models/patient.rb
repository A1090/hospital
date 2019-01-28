class Patient < ApplicationRecord

  #Relationships
  has_many :doctors_patients, dependent: :destroy
  has_many :doctors, through: :doctors_patients
  has_many :appointments, dependent: :destroy
  has_many :medicines, through: :appointments

  attr_accessor :full_name

  def full_name
    first_name + " " + last_name
  end

end
