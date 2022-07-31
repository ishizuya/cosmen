class RemoveIsActiveFromGenres < ActiveRecord::Migration[6.1]
  def change
    remove_column :genres, :is_active, :boolean
  end
end
