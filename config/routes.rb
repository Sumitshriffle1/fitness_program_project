Rails.application.routes.draw do
  post 'user_login', to: 'users#user_login'
  resource :users do
    resources :programs
    resources :purchases
    resources :categories
  end

  resource :users do
    get 'search_program_name', to: 'programs#search_program_name'
    get 'search_program_status', to: 'programs#search_program_status'
    get 'show_active_program', to: 'programs#show_active_program'
  end

  match "*path", to: "application#render_404", via: :all
end
