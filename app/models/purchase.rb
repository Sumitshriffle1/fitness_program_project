class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :program
  validates :program_id,:customer_name,:mobile, presence: true, uniqueness: {scope: :user_id}
  validates :mobile, length: { is: 10 }, uniqueness: true
  validate :only_customer_can_purchase_program

  private
  def only_customer_can_purchase_program
    unless user.type == "Customer"
      errors.add(:base, "Only Customer Can Purchase Program..")
    end
  end
end
