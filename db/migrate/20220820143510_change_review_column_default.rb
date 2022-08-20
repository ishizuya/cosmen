class ChangeReviewColumnDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :reviews, :comment, nil
  end
end
