class AddContractingOfficersToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :contracting_officer_id, :integer
  end
end
