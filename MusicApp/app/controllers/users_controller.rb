class UsersController < ApplicationController
  before_action :set_current_user
  before_action :set_flash, only: [:create, :update, :destroy]
  before_action :redirect_home_if_logged_in, only: [:new]
  before_action :redirect_if_not_logged_in, only: [:edit, :show]
  before_action :get_user_params, only: [:create, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(email: @user_params[:email], password: @user_params[:password]).set_token
    flash[:errors] << "Passwords Do Not Match" unless @user.is_password?(@user_params[:validate_new_password])

    if @user.valid? && flash[:errors].none? && @user.save
      login!(@user)
      flash[:notices] << "User Was Successfully Created"
      redirect_to users_url

    else
      flash[:errors] += @user.errors.full_messages
      render :new
    end
  end

  def update
    render json: "Invalid Request", status: 401 unless @current_user
    flash[:errors] << "Incorrect Credentials" unless @current_user.is_password?(@user_params[:password])
    flash[:errors] << "Passwords Do Not Match" unless @user_params[:new_password] == @user_params[:validate_new_password]
    @current_user.email, @current_user.password = @user_params[:email], @user_params[:new_password]

    unless @current_user.valid? && flash[:errors] && @current_user.save
      flash[:notices] << "User Was Successfully Created"
      redirect_to users_url

    else
      flash[:errors] += @current_user.errors.full_messages
      render :edit
    end
  end

  def destroy
    user = @current_user.destroy
    flash[:notices] << "#{user.email} was deleted"
    redirect_to users_url
  end

  private

  def get_user_params
    @user_params = params.require(:user).permit(:email, :password, :new_password, :validate_new_password) if params[:user]
  end
end
