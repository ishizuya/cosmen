class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews, dependent: :destroy
  has_many :favorites

  enum age: { teens: 0, twenties: 1, thirties: 2, forties: 3, fifties: 4, sixties: 5}
  enum sex: { woman: 0, male: 1, others: 2}
  enum skin_type: { normal: 0, dry: 1, oily: 2, mixed: 3, sensitive: 4}
end
