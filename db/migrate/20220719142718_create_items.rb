class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :genre_id,      null: false
      t.string :name,           null: false, default: ""
      t.string :brand,          null: false, default: ""
      t.text :introduction,     null: false
      t.integer :price,         null: false
      t.integer :capacity,      null: false
      t.date :release_date,     null: false

      t.timestamps
    end
  end
end
