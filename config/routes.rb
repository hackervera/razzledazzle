ActionController::Routing::Routes.draw do |map|
  map.root :controller => "comps", :action => "home"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
