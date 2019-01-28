class CreateDoctors < ActiveRecord::Migration[5.2]
  def change
    create_table :doctors do |t|
      t.string :last_name
      t.string :first_name
      t.string :specialization
      t.timestamps
    end
  end
end