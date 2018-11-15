class UsersController < ApplicationController
  before_action :set_flash
  before_action :set_current_user, only: [:show, :edit, :update, :destroy]
  before_action :get_user_params, only: [:create, :update]

  def index
    @users = User.all
  end

  def show
    return redirect_to new_session_url unless is_logged_in?
  end

  def new
    # if user is logged in, return them to their profile
    @user = User.new
  end

  def edit
    return redirect_to new_session_url unless is_logged_in?
  end

  def create
    @user = User.new(email: @user_params[:email], password: @user_params[:new_password]).set_token
    flash[:errors] << "Passwords Do Not Match" unless @user.is_password?(@user_params[:validate_new_password])

    if @user.valid? && flash[:errors].none? && @user.save
      session[:session_token] = @user.session_token
      flash[:notices] << "User Was Successfully Created"
      redirect_to users_url

    else
      flash[:errors] += @user.errors.full_messages
      render :new
    end
  end

  def update

  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_flash
      flash[:notices] = []
      flash[:errors] = []
    end

    def get_user_params
      @user_params = params.require(:user).permit(:email, :password, :new_password, :validate_new_password) if params[:user]
    end
end
