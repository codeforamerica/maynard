class AddProjectToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :project_id, :integer
  end
end
