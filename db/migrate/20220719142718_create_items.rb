class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :genre_id,      null: false
      t.string :name,           null: false, default: ""
      t.string :brand,          null: false, default: ""
      t.text :introduction,     null: false
      t.integer :price,         null: false, default: ""
      t.integer :capacity,      null: false, default: ""
      t.date :release_date,     null: false, default: ""

      t.timestamps
    end
  end
end
