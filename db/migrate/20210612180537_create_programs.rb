class CreatePrograms < ActiveRecord::Migration[6.1]
  def change
    create_table :programs do |t|
      t.references :institution, null: false, foreign_key: true
      t.references :program_classification, null: false, foreign_key: true
      t.integer :credential_level

      t.timestamps
    end
  end
end
