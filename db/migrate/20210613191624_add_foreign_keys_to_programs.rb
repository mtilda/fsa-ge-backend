class AddForeignKeysToPrograms < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :programs, :institutions, column: :institution_id, on_delete: :cascade
    add_foreign_key :programs, :program_classifications, column: :program_classification_id, on_delete: :cascade
  end
end
