class CreateBudgets < ActiveRecord::Migration[8.0]
  def change
    create_table :budgets do |t|
      t.integer :month
      t.integer :year
      t.decimal :available_amount, null: false, default: 0.0
      t.string :status, null: false, default: "inactive"
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
