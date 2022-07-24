class ChangeDataReleaseDateToItem < ActiveRecord::Migration[6.1]
  def change
    change_column :items, :release_date, :date
  end
end
