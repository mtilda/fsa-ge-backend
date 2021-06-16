class FixProgramClassificationColumnNames < ActiveRecord::Migration[6.1]
  def change
    change_table :program_classifications do |t|
      t.rename :code, :cip_code
      t.rename :name, :cip_name
    end
  end
end
