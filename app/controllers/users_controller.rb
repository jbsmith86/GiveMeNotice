class UsersController < ApplicationController

  def index
    @user = User.new
  end

  def edit
    require_user!
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:notice] = "Thanks for creating an account."
      session[:user_id] = @user.id
      redirect_to alerts_url
    else
      render 'new'
    end
  end

  def update
    require_user!
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = "Successfully saved user."
      redirect_to users_url
    else
      render 'edit'
    end
  end

  def destroy
    require_user!
    @user = User.find(params[:id])
    @user.destroy

    flash[:notice] = "Deleted user."

    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:email, :sms_number, :password, :password_confirmation)
  end
end
