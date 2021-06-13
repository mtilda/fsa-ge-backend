class CreatePrograms < ActiveRecord::Migration[6.1]
  def change
    create_table :programs do |t|
      t.bigint :institution_id, null: false
      t.bigint :program_classification_id, null: false
      t.integer :credential_level
      
      t.timestamps
    end
  end
end
