class ActivitiesController < ApplicationController
  before_filter :exclude_production, :except => [:index]
  before_filter :set_user
  
  def index
    @activities = Activity.all

  end

  def show
    redirect_to activities_path
  end

  def new
    @activity = Activity.new
  end

  def edit
    @activity = Activity.find(params[:id])
  end

  def create
    @activity = Activity.new(params[:activity])

    if @activity.save
      flash[:notice] = 'Activity was successfully created.'
      redirect_to activities_path
    else
      render :action => "new"
    end
  end

  def update
    @activity = Activity.find(params[:id])

    if @activity.update_attributes(params[:activity])
      flash[:notice] = 'Activity was successfully updated.'
      redirect_to activities_path
    else
      render :action => "edit"
    end
  end

  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy
    redirect_to activities_path
  end
  
  def oauth
    consumer = Twitter::OAuth.new('U6GRVQLS2H04xQusqYPA', 'qgXLq2Roj4ZOaDWgVcAnB8p6lBFczv0CxoIrMx1NEX8')
    request_token = consumer.request_token(:oauth_callback => "http://localhost:3001/callback")  
    session[:request_token] = request_token.token  
    session[:request_token_secret] = request_token.secret  
    session[:returnurl] = params[:returnurl]
    redirect_to request_token.authorize_url  
  end
  
  def callback
    consumer = Twitter::OAuth.new('U6GRVQLS2H04xQusqYPA', 'qgXLq2Roj4ZOaDWgVcAnB8p6lBFczv0CxoIrMx1NEX8')
    atoken, asecret = consumer.authorize_from_request(session[:request_token], session[:request_token_secret], params[:oauth_verifier])  
    consumer.authorize_from_access(atoken,asecret)
    client = Twitter::Base.new(consumer)
    @user.atoken = atoken
    @user.asecret = asecret
    @user.save
    redirect_to "/"
  end
  
  private
  def exclude_production
    if RAILS_ENV == "production"
      redirect_to activities_path
    end
  end
  private
  def set_user
    @user=OpenidUser.find(cookies[:openid]) if cookies[:openid]
    @token_set = 1 if @user && @user.atoken
    @tweets = Tweets.get_tweets(@user) if @user
  end
end
