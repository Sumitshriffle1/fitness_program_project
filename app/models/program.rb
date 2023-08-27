class Program < ApplicationRecord
  has_many :purchases, dependent: :destroy
  belongs_to :user
  belongs_to :category

  validates :name, :status, :price, presence: true
	validates :status, inclusion: { in: %w(active inactive) }
	validates :name, uniqueness: { scope: :user_id, case_sensitive: false  }
end
