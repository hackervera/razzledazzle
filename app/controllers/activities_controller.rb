class ActivitiesController < ApplicationController
    before_filter :set_user, :set_book


  
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
    
    request_token = @consumer.request_token(:oauth_callback => @callback)  
    session[:request_token] = request_token.token  
    session[:request_token_secret] = request_token.secret  
    session[:returnurl] = params[:returnurl]
    redirect_to request_token.authorize_url  
  end
  
  def callback
    atoken, asecret = @consumer.authorize_from_request(session[:request_token], session[:request_token_secret], params[:oauth_verifier])  
    @consumer.authorize_from_access(atoken,asecret)
    client = Twitter::Base.new(@consumer)
    @user.atoken = atoken
    @user.asecret = asecret
    @user.save
    redirect_to "/"
  end
  
    private
  def set_user
    begin
    @user=OpenidUser.find(cookies[:openid]) if cookies[:openid]
    @token_set = 1 if @user && @user.atoken
    @tweets = Tweets.get_tweets(@user) if @user && @user.atoken
  rescue ActiveRecord::RecordNotFound
    render :text => "Userid Corrupted please refresh to clear"
    cookies.delete 'openid'
    end
  end
  private
  def set_book
    begin
    unless facebook_session.nil? || @tweets.nil?
      @attributes = []
      @books = facebook_session.fql_query("SELECT post_id, actor_id, message, created_time FROM stream WHERE filter_key in (SELECT filter_key FROM stream_filter WHERE uid=#{facebook_session.user.id} AND type='newsfeed') AND is_hidden = 0") 
      @books.each do |book|
        regex = Regexp.new '((https?:\/\/|www\.)([-\w\.]+)+(:\d+)?(\/([\w\/_\.]*(\?\S+)?)?)?)'
        book['message'].gsub!( regex, '<a href="\1" target="_blank">\1</a>' )
        nameandpic = facebook_session.fql_query("SELECT name, pic FROM user WHERE uid=#{book['actor_id']}")
        @tweets << { :created => Time.at(book['created_time'].to_i), :name => nameandpic[0].name, :text => book['message'], :picture => nameandpic[0].pic, :service => "facebook", :service_url => "http://www.facebook.com", :user_id => book['actor_id'] } unless book['message'].empty? || nameandpic[0].nil?
      end
    end
    rescue Facebooker::Session::SessionExpired
      render :text => "Session expired please refresh"
      clear_fb_cookies!
      clear_facebook_session_information
      reset_session
    end
  end

end
