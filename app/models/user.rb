class User < ApplicationRecord
  has_many :programs, dependent: :destroy
	has_many :purchases, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_secure_password

  validates :name, :email, :blood_group, :dob, :mobile,  presence: true
	validates :type, presence: true
	validates :email, uniqueness: { case_sensitive: false }
  validates :password_digest, length: { minimum: 8 }, format: { with: /\A\S+\z/ }
	validates :name, length: { minimum: 2 }, format: { with: /\A[a-zA-Z]+ *[a-zA-Z]*\z/ }
	validates :mobile, length: { is: 10 }, uniqueness: true
  validates :dob, presence: true
  validates :blood_group, inclusion: { in: ['A+', 'B+', 'AB+', 'O+', 'A-', 'B-', 'AB-', 'O-'],
    message: "%{value} is not a valid blood group" }
end
