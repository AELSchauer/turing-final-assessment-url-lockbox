class User < ApplicationRecord
  has_secure_password

  has_many :links

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true
end
