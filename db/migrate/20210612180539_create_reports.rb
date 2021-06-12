class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.references :program, null: false, foreign_key: true
      t.integer :year_published
      t.string :official_pzf
      t.string :appeal_status
      t.decimal :annual_de_ratio, precision: 10, scale: 2
      t.decimal :median_annual_debt, precision: 10, scale: 2
      t.decimal :average_annual_earnings, precision: 10, scale: 2
      t.string :annual_pzf
      t.decimal :discretionary_de_ratio
      t.decimal :average_discretionary_earnings, precision: 10, scale: 2
      t.string :discretionary_pzf
      t.decimal :transitional_de_ratio, precision: 10, scale: 2
      t.decimal :median_transitional_debt, precision: 10, scale: 2
      t.string :transitional_pzf
      t.decimal :transitional_discretionary_de_ratio, precision: 10, scale: 2
      t.string :transitional_discretionary_pzf
      t.decimal :mean_annual_earnings, precision: 10, scale: 2
      t.decimal :median_annual_earnings, precision: 10, scale: 2

      t.timestamps
    end
  end
end
