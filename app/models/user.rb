class User < ApplicationRecord
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	before_save { email.downcase! }
	validates :name,  presence: true, length: { maximum: 20}, format: { with: /\A[a-zA-Z]+\z/, 
		message: "only allows letters" }
	validates :email, presence: true, length: { maximum: 30}, 
		format: { with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false}

	has_secure_password

	validates :password, presence: true, length: { minimum: 6}

end