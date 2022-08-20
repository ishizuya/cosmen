class ChangeItmeColumnDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :items, :price, nil
    change_column_default :items, :release_date, nil
  end
end
