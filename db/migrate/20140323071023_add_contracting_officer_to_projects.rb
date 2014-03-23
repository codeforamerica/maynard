class AddContractingOfficerToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :contracting_officer, :string
    add_column :projects, :contracting_officer_email, :string
  end
end
