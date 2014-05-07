class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.datetime :date
      t.string :street_address
      t.string :street_address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :type

      t.timestamps
    end
  end
end
