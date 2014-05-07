class ChangeSiteVisitBooleanName < ActiveRecord::Migration
  def change
    rename_column :projects, :site_visit, :site_visit_planned
  end
end
