class ChangeColumnsOnProjects < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.remove :contracting_officer
      t.remove :contracting_officer_id
      t.references :contracting_officer
    end
  end
end
