class CreateBrewery < ActiveRecord::Migration[5.2]
  def change
    create_table :breweries do |t|
      t.boolean :barrel_program
      t.string :name
      t.integer :num_taps
      t.timestamps
    end
  end
end
