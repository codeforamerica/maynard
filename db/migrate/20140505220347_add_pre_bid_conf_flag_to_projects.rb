class AddPreBidConfFlagToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :prebid_conf, :boolean
    add_column :projects, :site_visit, :boolean
  end
end
