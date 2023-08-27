class Category < ApplicationRecord
  belongs_to :user
  has_many :programs, dependent: :destroy

  validates :category_name, presence:true, uniqueness: { case_sensitive: false }
end
