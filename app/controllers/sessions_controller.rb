class SessionsController < ApplicationController

  def new
  end

  def create
    if env["omniauth.auth"]
      sign_in_with_twitter(env["omniauth.auth"])
    elsif params[:email] != nil
      sign_in_with_email(params)
    else
      flash.now[:notice] = "Something went wrong"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out!"
    redirect_to root_url
  end
end

private

def sign_in_with_email(params)
  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    flash[:notice] = "Signed in"
    redirect_to alerts_url
  else
    flash.now[:notice] = "Email/password did not match."
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
    flash[:notice] = "Thanks for creating an account."
    redirect_to edit_user_url(@user.id)

  elsif twitter.secret == callbackdata['credentials']['secret']
    session[:user_id] = twitter.user_id
    flash[:notice] = "You logged in with Twitter!"
    redirect_to alerts_url

  else
    flash.now[:notice] = "Something went wrong"
    redirect_to root_url
  end
end
