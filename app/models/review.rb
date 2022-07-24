class Review < ApplicationRecord
  belongs_to :user
  belongs_to :item
  
  def avg_wrinkle
    unless self.review.empty?
      comments.average(:rate_id).round(1)
    else
      0.0
    end
  end
end
