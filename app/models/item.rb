class Item < ApplicationRecord
  belongs_to :genre
  has_many :favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_one_attached :image

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def add_tax_price
    (price * 1.1).floor.to_s(:delimited)
  end

  def avg_wrinkle
    unless self.reviews.empty?
      reviews.average(:wrinkle).round(1)
    else
      "未評価"
    end
  end

  def avg_whitening
    unless self.reviews.empty?
      reviews.average(:whitening).round(1)
    else
      "未評価"
    end
  end

  def avg_moisturizing
    unless self.reviews.empty?
      reviews.average(:moisturizing).round(1)
    else
      "未評価"
    end
  end

  def avg_acne_cure
    unless self.reviews.empty?
      reviews.average(:acne_cure).round(1)
    else
      "未評価"
    end
  end

  def avg_no_irritation
    unless self.reviews.empty?
      reviews.average(:no_irritation).round(1)
    else
      "未評価"
    end
  end

  def avg_reviews
    unless self.reviews.empty?
      (avg_whitening + avg_wrinkle + avg_moisturizing + avg_acne_cure + avg_no_irritation)/5.round(1)
    else
      "未評価"
    end
  end

  def review_sort_value
    if avg_reviews == "未評価"
      -1
    else
      avg_reviews
    end
  end

  def self.search(keyword)
      where(["name like? OR brand like? OR introduction like?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
  end

end
