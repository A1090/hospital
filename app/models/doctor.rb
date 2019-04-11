class Doctor < ApplicationRecord

  #Relationships
  has_many :doctors_patients, dependent: :destroy
  has_many :patients, through: :doctors_patients

  validates :first_name, :last_name, :specialization, presence: true

  attr_accessor :full_name

  def full_name
    first_name + " " + last_name
  end
end
