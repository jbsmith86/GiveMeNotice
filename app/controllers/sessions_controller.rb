class SessionsController < ApplicationController

  def new
  end

  def create
  #for debug uncomment raise
  #  raise
    callbackdata = env["omniauth.auth"]
    twitter = TwitterAccount.find_by(twitter_id: callbackdata['uid'])

    if twitter.nil?
      @user = User.new
      @user.save
      @twitter_account = TwitterAccount.new(twitter_id: callbackdata['uid'],
                                            twitter_username: callbackdata['info']['nickname'],
                                            token: callbackdata['credentials']['token'],
                                            secret: callbackdata['credentials']['secret'],
                                            user_id: @user.id)
      @twitter_account.save
      session[:user_id] = @user.id
      flash[:notice] = "Thanks for creating an account."
      redirect_to root_url

    elsif twitter.secret == callbackdata['credentials']['secret']
      session[:user_id] = twitter.user_id
      flash[:notice] = "You logged in with Twitter!"
      redirect_to root_url

    else
      flash.now[:notice] = "Something went wrong"
      redirect_to root_url
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out!"
    redirect_to root_url
  end

end
