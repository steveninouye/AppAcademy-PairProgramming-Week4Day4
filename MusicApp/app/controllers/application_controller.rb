class ApplicationController < ActionController::Base

  def set_current_user
    if session[:session_token].nil?
      @current_user = nil
    else
      @current_user = User.find_by(session_token: session[:session_token])
    end
  end

  def login!(user=@current_user)
    session[:session_token] = user.reset_session_token!
  end

  def logout!
    @current_user.reset_session_token!
    @current_user, session[:session_token] = nil, nil
  end

  def set_flash
    flash[:notices] = []
    flash[:errors] = []
  end

  def redirect_home_if_logged_in
    p @current_user
    if @current_user
      flash[:notices] << "You Are Logged In"
      redirect_to users_url
    end
  end

  def redirect_if_not_logged_in
    unless @current_user
      flash[:errors] << "You Are Not Logged In"
      redirect_to new_session_url
    end
  end
end
