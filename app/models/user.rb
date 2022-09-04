class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews, dependent: :destroy
  has_many :favorites

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :sex, presence: true
  validates :age, presence: true
  validates :skin_type, presence: true

  enum age: { teens: 0, twenties: 1, thirties: 2, forties: 3, fifties: 4, sixties: 5}
  enum sex: { woman: 0, male: 1}
  enum skin_type: { normal: 0, dry: 1, oily: 2, mixed: 3, sensitive: 4}

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
      user.sex = 1
      user.age = 1
      user.skin_type = 0
    end
  end

end
