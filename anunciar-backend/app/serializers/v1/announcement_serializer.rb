module V1
  class AnnouncementSerializer < ActiveModel::Serializer

    attributes :title, :description, :created_at, :deadline, :tags, :id
  end
end