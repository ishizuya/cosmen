class ChangeItmeColumnDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :items, :price, nil
  end
end
