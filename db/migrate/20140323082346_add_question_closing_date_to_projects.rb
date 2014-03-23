class AddQuestionClosingDateToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :question_closing_date, :datetime
  end
end
