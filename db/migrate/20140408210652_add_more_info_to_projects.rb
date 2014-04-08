class AddMoreInfoToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :preproposal_conf_date, :datetime
  end
end
