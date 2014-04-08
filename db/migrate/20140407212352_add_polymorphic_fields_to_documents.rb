class AddPolymorphicFieldsToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :attachable_type, :string
    add_column :documents, :attachable_id, :integer
  end
end
