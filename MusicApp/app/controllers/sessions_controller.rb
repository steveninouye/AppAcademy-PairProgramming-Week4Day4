class SessionsController < ApplicationController
  before_action :set_current_user, :set_flash
  before_action :redirect_home_if_logged_in, only: [:new]
  before_action :get_user_params, only: [:create]

  def new
    @user = User.new
  end

  def create
    @current_user = User.validate_login(@user_params[:email], @user_params[:password])
    if @current_user
      login!
      redirect_to users_url
    else
      flash[:errors] << "Invalid Credentials"
      redirect_to new_session_url
    end
  end

  def destroy
    logout!
    flash[:notices] << "You have been Logged Out"
    redirect_to users_url
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def get_user_params
    @user_params = params.require(:user).permit(:email, :password, :validate_password)
  end
end
