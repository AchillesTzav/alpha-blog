class User < ApplicationRecord
  # self references each object of the user class
  # when it comes to email field before saving it runs the downcase method
  before_save { self.email = email.downcase}
  has_secure_password
  has_many :articles, dependent: :destroy
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
