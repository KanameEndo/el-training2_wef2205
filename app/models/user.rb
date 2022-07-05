class User < ApplicationRecord

  has_secure_password

  before_validation { email.downcase! }
  validates :name, presence: true, length: { maximum: 30 }
  validates :email,uniqueness: true, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
end