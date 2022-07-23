class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :user_id,       null: false, default: ""
      t.integer :item_id,       null: false, default: ""
      t.text :comment,          null: false, default: ""
      t.integer :whitening,     null: false, default: ""
      t.integer :wrinkle,       null: false, default: ""
      t.integer :moisturizing,  null: false, default: ""
      t.integer :no_irritation, null: false, default: ""
      t.integer :acne_cure,     null: false, default: ""

      t.timestamps
    end
  end
end
