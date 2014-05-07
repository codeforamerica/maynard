class AddSiteVisitDateFieldToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :site_visit_date, :datetime
  end
end
