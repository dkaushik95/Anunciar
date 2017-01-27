class ApplicationController < ActionController::API
    include AbstractController::Translation
    # only respond with JSON
    respond_to :json

    # authentication of student/admin
    def authenticate_student_from_token!
      auth_token = request.headers['Authorization']
      # if auth token is present
      if auth_token
        authenticate_with_auth_token auth_token
      else
        authentication_error
      end
    end

  private
  # this is the actual authentication process
  def authenticate_with_auth_token auth_token
    # if the format is right
    unless auth_token.include?(':')
      authentication_error
      return
    end

    student_id = auth_token.split(':').first
    student = Student.where(id: student_id).first

    if student && Devise.secure_compare(student.access_token, auth_token)
      # User can access
      sign_in student, store: false
    else
      authentication_error
    end
  end

  ##
  # Authentication Failure
  # Renders a 401 error
  def authentication_error
    # User's token is either invalid or not in the right format
    render json: {error: ('unauthorized')}, status: 401  # Authentication timeout
  end

end