class SessionsController < ApplicationController

  def new
  end

  def create
    if env["omniauth.auth"]
      sign_in_with_twitter(env["omniauth.auth"])
    elsif params[:email] != nil
      sign_in_with_email(params)
    else
      flash.now[:danger] = "Something went wrong"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Logged out!"
    redirect_to root_url
  end
end

private

def sign_in_with_email(params)
  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    flash[:success] = "Signed in"
    redirect_to alerts_url
  else
    flash.now[:danger] = "Email/password entered did not match our records."
    render 'new'
  end
end

def sign_in_with_twitter(callbackdata)
  twitter = TwitterAccount.find_by(twitteruid: callbackdata['uid'])

  if twitter.nil?
    @user = User.new
    @user.password_digest = callbackdata['credentials']['secret']
    @user.save(validate: false)
    @twitter_account = TwitterAccount.new(twitteruid: callbackdata['uid'],
                                          twitter_username: callbackdata['info']['nickname'],
                                          token: callbackdata['credentials']['token'],
                                          secret: callbackdata['credentials']['secret'],
                                          user_id: @user.id)
    @twitter_account.save
    session[:user_id] = @user.id
    flash[:success] = "Thanks for creating an account."
    flash[:info] = "Please fill out your notification settings"
    redirect_to edit_user_url(@user.id)

  else
    if callbackdata['extra']['access_token'].consumer.secret == TWITTER_CONFIG['consumer_secret']
      twitter.secret = callbackdata['credentials']['secret']
      twitter.token = callbackdata['credentials']['token']
      twitter.save
      session[:user_id] = twitter.user
      flash[:success] = "You signed in with Twitter"
      redirect_to alerts_url
    else
      flash.now[:danger] = "Something went wrong"
    end
  end
end
