class CreatePixels < ActiveRecord::Migration[7.0]
  def change
    create_table :pixels do |t|
      t.integer :user_id

      t.integer :red
      t.integer :green
      t.integer :blue

      t.integer :x
      t.integer :y

      t.timestamps
    end
  end
end
