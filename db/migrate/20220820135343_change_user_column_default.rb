class ChangeUserColumnDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :sex, nil
    change_column_default :users, :age, nil
    change_column_default :users, :skin_type, nil
  end
end
