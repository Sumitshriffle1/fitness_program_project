class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :program
  validates :program_id, presence: true, uniqueness: {scope: :user_id}
  validates :customer_name,:mobile, presence: true
  validates :mobile, length: { is: 10 }
  validate :only_customer_can_purchase_program

  private
  def only_customer_can_purchase_program
    unless user.type == "Customer"
      errors.add(:base, "Only Customer Can Purchase Program..")
    end
  end
end
