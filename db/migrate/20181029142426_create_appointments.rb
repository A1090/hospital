class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.references :medicine, foreign_key: true
      t.references :patient, foreign_key: true
      t.date :appointment_date
      t.string :diagnostic
      t.float :medicine_dose
      t.timestamps
    end
  end
end
