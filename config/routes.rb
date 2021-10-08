Rails.application.routes.draw do

  unauthenticated :user do
    devise_scope :user do
      root to: 'devise/sessions#new', :as => 'user_unauthenticated'
    end
  end

  devise_for :users, controllers: { 
    passwords:          "users/passwords",
    registrations:      "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  get '/',                                          to: 'dashboard#show', as: :root_user 
  get 'analytics',                                  to: 'analytics#show'
  get 'analytics/:user_id/:type_analytic/:type_id', to: 'analytics#increment'
  get 'see_your_email',                             to: 'pages#see_your_email'  
  get 'welcome',                                    to: 'pages#welcome'

  get 'privacy', to: 'diip#privacy'

  delete 'tips/:id', to: 'tips#destroy'

  resources :users do
    collection do
      get  'profile/empty',  to: 'users#profile_empty'
      post 'profile/finish', to: 'users#profile_finish'
      
      post   'piid',                     to: 'users/piid#capture' 
    end
  end

  get ':username', to: 'diip#profile', format: false, defaults: { format: 'html' }, constraints: { username: %r{[a-zA-Z0-9\._-]+} }
end
