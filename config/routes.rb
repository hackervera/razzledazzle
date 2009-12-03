ActionController::Routing::Routes.draw do |map|
  map.resources :activities
  map.root      :controller => "activities"
  map.connect  ':controller/:action/:id'
  map.connect  ':controller/:action/:id.:format'
end
