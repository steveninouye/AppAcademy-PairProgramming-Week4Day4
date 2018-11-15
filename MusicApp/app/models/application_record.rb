class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def current_user
    @current_user
  end

  def set_current_user
    @current_user = User.find_by(session_token: params[:session_token])
  end

  def login!
    session[:session_token] = @current_user.reset_session_token!
    @current_user.session_token
  end

  def logout!
    @current_user, session[:session_token] = nil, nil
    @user.reset_session_token!
  end
end
