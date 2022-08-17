class ChangeColumnToAllowNull < ActiveRecord::Migration[6.1]
  def change
    def up
      change_column :items, :release_date, null: true
    end

    def down
      change_column :items, :release_date, null: false
    end
  end
end
