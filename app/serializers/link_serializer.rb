class LinkSerializer < ActiveModel::Serializer
  attributes :id, :title, :url, :read, :hot
end
