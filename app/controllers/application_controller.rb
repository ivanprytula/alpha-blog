class ApplicationController < ActionController::Base

  # makes this method available in views as well
  helper_method :current_user, :logged_in?

  def current_user
    # memoization technique
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    # return boolean value
    !!current_user
  end

end
