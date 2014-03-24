class AddProjectCountToContractingOfficers < ActiveRecord::Migration
  def change
    add_column :contracting_officers, :projects_count, :integer
  end
end
