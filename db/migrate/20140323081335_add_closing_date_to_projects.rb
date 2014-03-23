class AddClosingDateToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :closing_date, :datetime
  end
end
