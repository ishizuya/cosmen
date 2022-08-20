class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :user_id,       null: false
      t.integer :item_id,       null: false
      t.text :comment,          null: false
      t.integer :whitening,     null: false
      t.integer :wrinkle,       null: false
      t.integer :moisturizing,  null: false
      t.integer :no_irritation, null: false
      t.integer :acne_cure,     null: false

      t.timestamps
    end
  end
end
