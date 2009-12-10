class Tweets
  def self.get_tweets(user)
    tweets = []
    oauth= Twitter::OAuth.new('U6GRVQLS2H04xQusqYPA', 'qgXLq2Roj4ZOaDWgVcAnB8p6lBFczv0CxoIrMx1NEX8')
    oauth.authorize_from_access(user.atoken, user.asecret)
    client = Twitter::Base.new(oauth)
    client.friends_timeline.each do |tweet|
      
      regex = Regexp.new '((https?:\/\/|www\.)([-\w\.]+)+(:\d+)?(\/([\w\/_\.]*(\?\S+)?)?)?)'
      tweet['text'].gsub!( regex, '<a href="\1">\1</a>' )

      tweets << { :text => tweet['text'], :created => tweet['created_at'], :name => tweet['user']['name'], :nickname => tweet['user']['screen_name'], :picture => tweet['user']['profile_image_url'], :service => "twitter", :service_url => "http://www.twitter.com" }
    end
    return tweets
  end
end




class ApplicationController < ActionController::Base
  helper :all
  filter_parameter_logging :fb_sig_friends
  helper_method :facebook_session
  before_filter :exclude_production, :except => [:index]
  before_filter :set_facebook_session


  protect_from_forgery
  
  private
  def exclude_production
    if RAILS_ENV == "production"
      redirect_to activities_path
    end
  end

end