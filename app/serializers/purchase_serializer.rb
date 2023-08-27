class PurchaseSerializer < ActiveModel::Serializer
  attributes :id, :status
  has_many :program
end
