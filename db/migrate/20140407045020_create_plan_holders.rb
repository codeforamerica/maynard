class CreatePlanHolders < ActiveRecord::Migration
  def change
    create_table :plan_holders do |t|
      t.integer :project_id
      t.integer :company_id

      t.timestamps
    end
  end
end
