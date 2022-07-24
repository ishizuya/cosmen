class ChangeDataCapacityToItem < ActiveRecord::Migration[6.1]
  def change
    change_column :items, :capacity, :string
  end
end
