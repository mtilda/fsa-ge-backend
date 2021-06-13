class CreateProgramClassifications < ActiveRecord::Migration[6.1]
  def change
    create_table :program_classifications do |t|
      t.integer :code
      t.string :name

      t.timestamps
    end
  end
end
