module V1
  class AnnouncementsController < ApplicationController
    before_action :authenticate_student_from_token!, only: [:index, :show, :create]
    # GET /v1/stories
    # Get all the stories
    def index
      @announcements = Announcement.order(created_at: :desc).all
      render json: @announcements, each_serializer: AnnouncementsSerializer
    end

    def show
      @announcement = Announcement.find(params[:id])
      render json: @announcement, serializer: AnnouncementSerializer
    end
    def create
      @student = Student.find((request.headers["Authorization"]).split(':').first)
      if @student.admin?
        @announcement = Announcement.new(story_params)
        if @announcement.save
          render json: @announcement, serializer: AnnouncementSerializer
        else
          render json: { error: 'announcement_create_error' }, status: :unprocessable_entity
        end
      else
        authentication_error
      end

    end

    private

    def story_params
      params.require(:announcement).permit(:title, :description, :deadline, :tags)
    end

  end
end