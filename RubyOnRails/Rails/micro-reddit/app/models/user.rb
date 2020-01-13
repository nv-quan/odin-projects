class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  has_many :posts
  has_many :comments
  
end
