class CreateInstitutions < ActiveRecord::Migration[6.1]
  def change
    create_table :institutions do |t|
      t.integer :opeid
      t.string :name
      t.string :city
      t.string :state
      t.string :zip
      t.string :type

      t.timestamps
    end
    add_index :institutions, :opeid, unique: true
  end
end
