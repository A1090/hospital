class AddCompanyToMedicines < ActiveRecord::Migration[5.2]
  def change
    add_column :medicines, :company, :string
    add_column :medicines, :substances, :string
  end
end
