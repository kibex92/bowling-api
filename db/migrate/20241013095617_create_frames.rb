class CreateFrames < ActiveRecord::Migration[7.2]
  def change
    create_table :frames do |t|
      t.references :game, null: false, foreign_key: true
      t.integer :number, null: false
      t.integer :score, default: 0
      t.integer :first_roll, default: 0
      t.integer :second_roll, default: 0
      t.integer :third_roll, default: 0

      t.timestamps
    end
  end
end
