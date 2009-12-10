ActionController::Routing::Routes.draw do |map|
  map.resources :openid_users

  map.resources :activities
  map.root      :controller => "activities"
  map.oauth     "/oauth", :controller => "activities", :action => "oauth"
  map.callback  "/callback", :controller => "activities", :action => "callback"
  map.login     "/login", :controller => "openid_users", :action => "login"
  map.signup    "/signup", :controller => "openid_users", :action => "signup"
  map.manifesto "/manifesto", :controller => "about", :action => "manifesto"
  map.things_that_matter "/things_that_matter", :controller => "about", :action => "things_that_matter"
  map.connect  ':controller/:action/:id'
  map.connect  ':controller/:action/:id.:format'
end
