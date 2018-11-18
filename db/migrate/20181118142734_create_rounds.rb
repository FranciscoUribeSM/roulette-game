class CreateRounds < ActiveRecord::Migration[5.2]
  def change
    create_table :rounds do |t|
      t.decimal :temp
      t.string :color

      t.timestamps
    end
  end
end
