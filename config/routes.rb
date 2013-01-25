Claudel::Application.routes.draw do
  
  resources :works, :domains, :types, :time_periods
  
  root :to => "works#index"
  match "/admin" => "users#admin"
  
end
