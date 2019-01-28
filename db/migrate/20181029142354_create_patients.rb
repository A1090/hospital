class CreatePatients < ActiveRecord::Migration[5.2]
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :last_name
      t.string :cnp
      t.string :address
      t.string :ensurance_id
      t.timestamps
    end
  end
end
