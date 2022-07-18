class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum age: { early_teens: 0, late_teens: 1, early_20s: 2, late_20s: 3, early_30s: 4, late_30s: 5, early_40s: 6, late_40s: 7, early_50s: 8, late_50s: 9, over_60s: 10}
  enum sex: { woman: 0, male: 1, others: 2}
  enum skin_type: { normal: 0, dry: 1, oily: 2, mixed: 3, sensitive: 4}
end
