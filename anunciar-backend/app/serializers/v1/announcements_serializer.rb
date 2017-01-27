module V1
  class AnnouncementsSerializer < ActiveModel::Serializer

    attributes :title, :created_at, :description, :tags, :deadline, :id

  end
end