class CreateFrames < ActiveRecord::Migration[7.2]
  def change
    create_table :frames do |t|
      t.references :game, null: false, foreign_key: true
      t.integer :number
      t.integer :score
      t.integer :first_roll
      t.integer :second_roll
      t.integer :third_roll

      t.timestamps
    end
  end
end
