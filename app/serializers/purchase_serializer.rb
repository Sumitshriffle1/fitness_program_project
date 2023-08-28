class PurchaseSerializer < ActiveModel::Serializer
  attributes :id, :customer_name,:program,:mobile, :status
  def program
    object.program.name
  end
end
