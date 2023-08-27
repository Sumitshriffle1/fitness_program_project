class ProgramSerializer < ActiveModel::Serializer
  attributes :id, :category, :name, :status, :price

  def category
    object.category.category_name
  end
end
