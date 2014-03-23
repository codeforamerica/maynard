class AddMethodToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :question_method, :string
  end
end
