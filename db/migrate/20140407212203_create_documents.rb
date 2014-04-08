class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :document_file_name
      t.integer :document_file_size
      t.string :document_content_type
      t.datetime :document_updated_at

      t.timestamps
    end
  end
end
