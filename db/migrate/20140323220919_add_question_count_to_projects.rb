class AddQuestionCountToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :questions_count, :integer
  end
end
