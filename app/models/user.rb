class User < ApplicationRecord
  has_many :articles
  validates :username, presence: true,
              length: { minimun: 3, maximum: 25 },
              uniqueness: { case_sensitive: false }

  #constant variable , it will not change
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
              length: { maximum: 105 },
              uniqueness: { case_sensitive: false },
              format: { with: VALID_EMAIL_REGEX }
end
