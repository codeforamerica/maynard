class AddMailHashToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :mail_hash, :string
  end
end
