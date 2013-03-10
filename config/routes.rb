Claudel::Application.routes.draw do
  
  resources :works, :domains, :types, :time_periods, :images
  
  root :to => "works#index"
  match "/admin" => "users#admin"
  match "/works/:id/images" => "works#images"
  match "/works/:id/edit/images" => "works#edit_images"
  
end
