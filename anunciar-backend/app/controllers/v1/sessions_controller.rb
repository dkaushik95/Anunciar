module V1
  class SessionsController < ApplicationController
    # POST /v1/login
    def create
      @user = Student.find_for_database_authentication(email: params[:email])
      return invalid_login_attempt unless @user

      if @user.valid_password?(params[:password])
        sign_in :student, @user
        render json: @user, serializer: SessionSerializer, root: nil
      else
        invalid_login_attempt
      end
    end

    private

    def invalid_login_attempt
      warden.custom_failure!
      render json: {error: ('sessions_controller.invalid_login_attempt')}, status: :unprocessable_entity
    end

  end
end