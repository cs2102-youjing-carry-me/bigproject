class CreateStuffs < ActiveRecord::Migration[5.0]
  def change
    create_table :stuffs do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.string :pickup_location
      t.string :return_location
      t.boolean :availability
      t.datetime :available_date

      t.timestamps
    end
  end
end
