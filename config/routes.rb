ActionController::Routing::Routes.draw do |map|
  map.resources :activities
  map.root      :controller => "activities"
  map.manifesto "/manifesto", :controller => "about", :action => "manifesto"
  map.things_that_matter "/things_that_matter", :controller => "about", :action => "things_that_matter"
  map.connect  ':controller/:action/:id'
  map.connect  ':controller/:action/:id.:format'
end
