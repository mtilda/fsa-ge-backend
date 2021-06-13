class AddForeignKeysToReports < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :reports, :programs, column: :program_id, on_delete: :cascade
  end
end
