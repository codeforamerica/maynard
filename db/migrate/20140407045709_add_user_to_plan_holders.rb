class AddUserToPlanHolders < ActiveRecord::Migration
  def change
    add_column :plan_holders, :user_id, :integer
  end
end
