module V1
  class StudentsController < ApplicationController
    #skip_before_action :authenticate_student_from_token!, only: [:create]

    # POST /v1/users
    # Creates an user
    def create
      @user = Student.new user_params

      if @user.save
        render json: @user, serializer: V1::SessionSerializer, root: nil
      else
        render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :username, :password, :password_confirmation, :role)
    end
  end
end
