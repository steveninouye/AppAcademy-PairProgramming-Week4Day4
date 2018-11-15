class UsersController < ApplicationController
  before_action :set_flash
  before_action :set_current_user
  before_action :get_user_params, only: [:create, :update]

  def index
    @users = User.all
  end

  def show
    return redirect_to new_session_url unless @current_user
  end

  def new
    # if user is logged in, return them to their profile
    @current_user = User.new
  end

  def edit
    return redirect_to new_session_url unless @current_user
  end

  def create
    @current_user = User.new(email: @user_params[:email], password: @user_params[:new_password]).set_token
    flash[:errors] << "Passwords Do Not Match" unless @current_user.is_password?(@user_params[:validate_new_password])

    if @current_user.valid? && flash[:errors].none?
      login!
      flash[:notices] << "User Was Successfully Created"
      redirect_to users_url

    else
      flash[:errors] += @current_user.errors.full_messages
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
