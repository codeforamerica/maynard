class CreateContractingOfficers < ActiveRecord::Migration
  def change
    create_table :contracting_officers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email_address

      t.timestamps
    end
  end
end
