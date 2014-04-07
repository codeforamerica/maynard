class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :street_address
      t.string :street_address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone_number

      t.timestamps
    end
  end
end
