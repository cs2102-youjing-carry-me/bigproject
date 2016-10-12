class CreateBids < ActiveRecord::Migration[5.0]
  def change
    create_table :bids do |t|
      t.references :stuff, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :point
      t.boolean :status

      t.timestamps
    end
  end
end
