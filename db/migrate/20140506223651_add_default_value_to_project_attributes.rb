class AddDefaultValueToProjectAttributes < ActiveRecord::Migration
  def change
    change_column :projects, :site_visit,  :boolean, default: false
    change_column :projects, :prebid_conf, :boolean, default: false
  end
end
