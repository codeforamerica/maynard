class AddDraftFlagToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :draft, :boolean
  end
end
