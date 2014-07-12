class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  
  def current_course
    if Course.find(session[:course_id])
      @current_course ||= Course.find(session[:course_id]) if session[:course_id]
    end
  end
  helper_method :current_course

  # Overwriting the sign_out redirect path method
  def after_sign_in_path_for(users)
    users_path
  end

end
