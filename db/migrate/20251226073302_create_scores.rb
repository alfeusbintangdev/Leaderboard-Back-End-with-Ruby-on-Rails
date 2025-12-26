class CreateScores < ActiveRecord::Migration[8.1]
  def change
    create_table :scores do |t|
      t.references :player, null: false, foreign_key: true
      t.integer :value

      t.timestamps
    end
  end
end
