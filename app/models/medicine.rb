class Medicine < ApplicationRecord

  #Relationships
  has_many :appointments, dependent: :destroy
  has_many :patients, through: :appointments

  validates :name, :company, presence: true
end
