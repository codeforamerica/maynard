class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :body
      t.integer :project_id
      t.integer :user_id

      t.timestamps
    end
  end
end
