class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  helper_method :current_user

  def current_user
    @user ||= User.find_by(session_token: params[:session_token])
  end

  def set_current_user
    current_user
  end

  def login!
    session[:session_token] = @user.reset_session_token!
  end

  def logout!
    session[:session_token] = nil
    @user.reset_session_token!
  end

  def is_logged_in?
    @user = User.find_by(session_token: params[:session_token])
    @user ? true : false
  end
end
