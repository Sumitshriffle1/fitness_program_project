class UserSerializer < ActiveModel::Serializer
  attributes :id,:name,:email,:password,:dob,:mobile,:type
end
