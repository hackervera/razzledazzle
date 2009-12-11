class ApplicationController < ActionController::Base
  helper :all
  filter_parameter_logging :fb_sig_friends
  helper_method :facebook_session
  #before_filter :exclude_production, :except => [:index]
  before_filter :set_facebook_session, :check_server


  protect_from_forgery
  
  private
  def exclude_production
    if RAILS_ENV == "production"
      redirect_to activities_path
    end
  end
  
  private
  def check_server # put all default variables
    
    
    require 'cgi'
    @consumer = Twitter::OAuth.new(APP_CONFIG['twitter_key'], APP_CONFIG['twitter_secret'])
    @callback = APP_CONFIG['callback']
    @clickpass = APP_CONFIG['clickpass']
    @registration = CGI.escape(APP_CONFIG['signup'])
=begin
    @consumer = Twitter::OAuth.new('U6GRVQLS2H04xQusqYPA', 'qgXLq2Roj4ZOaDWgVcAnB8p6lBFczv0CxoIrMx1NEX8')
    @callback = "http://simple-stone-44.heroku.com/callback"
    require 'cgi'
    if (%x[cat server] =~ /localhost/)
      @clickpass = "7koO02B3Gc"
      registration = CGI.escape("http://localhost:3001/signup")
    else
      @clickpass = "DveqJcbXNv"
      registration = CGI.escape("http://simple-stone-44.heroku.com/signup")
    end
=end
    @signup = "http://www.clickpass.com/process_new_openid?site_key=#{@clickpass}&process_openid_registration_url=#{@registration}&site_name=Razzle%20Dazzle&requested_fields=nickname&required_fields=nickname&nickname_label=Nickname"
  end

end