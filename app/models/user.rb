class User < ApplicationRecord
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true, presence: true

  has_secure_password

  has_many :api_keys, as: :bearer
  attr_accessor :api_key
end
