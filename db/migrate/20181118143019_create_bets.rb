class CreateBets < ActiveRecord::Migration[5.2]
  def change
    create_table :bets do |t|
      t.integer :amount
      t.string :color
      t.integer :gain
      t.decimal :player_balance
      t.references :player, foreign_key: true
      t.references :round, foreign_key: true

      t.timestamps
    end
  end
end
