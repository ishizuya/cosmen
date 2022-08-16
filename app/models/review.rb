class Review < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :item_id, presence: true
  validates :user_id, presence: true
  validates :comment, presence: true
  validates :whitening, presence: true
  validates :wrinkle, presence: true
  validates :moisturizing, presence: true
  validates :no_irritation, presence: true
  validates :acne_cure, presence: true

  def avg_wrinkle
    unless self.review.empty?
      comments.average(:rate_id).round(1)
    else
      0.0
    end
  end
end
