class CreateBeer < ActiveRecord::Migration[5.2]
  def change
    create_table :beers do |t|
      t.boolean :nitro
      t.float :abv
      t.string :style
      t.timestamps
      t.references :brewery, index: true, foreign_key: true
    end
  end
end
