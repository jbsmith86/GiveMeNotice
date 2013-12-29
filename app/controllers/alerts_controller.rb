class AlertsController < ApplicationController

before_action :require_user!

  def index
    @user = User.find_by id: session[:user_id]
      @alerts = @user.alerts
  end

  def show
    @user = User.find_by id: session[:user_id]
    @alerts = @user.alerts
  end

  def edit
    @alert = Alert.find(params[:id])
    if @alert.user_id != session[:user_id]
      flash[:danger] = "You are not allowed there"
      redirect_to root_url
    end
  end

  def new
    @alert = Alert.new
  end

  def create
    @user = User.find_by id: session[:user_id]
    @alert = @user.alerts.create(alert_params)

    if @alert.save
      flash[:success] = "Successfully created alert."
      redirect_to alerts_url
    else
      render 'new'
    end
  end

  def update
    @alert = Alert.find(params[:id])

    if @alert.update(alert_params)
      flash[:success] = "Successfully saved alert."
      redirect_to alerts_url
    else
      render 'edit'
    end
  end

  def destroy
    @alert = Alert.find(params[:id])
    @alert.destroy

    flash[:success] = "Deleted alert."

    redirect_to alerts_url
  end

  private
  def alert_params
    params.require(:alert).permit(:name, :email_enabled, :sms_enabled, :feed_username, :feed_number, keywords_attributes: [:id, :phrase, :_destroy])
  end
end
