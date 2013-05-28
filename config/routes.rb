DivvyUpBaseBackend::Application.routes.draw do
  root to: 'pages#index'

  match 'app', to: 'pages#app'

  if Rails.env == 'e2e_test' || Rails.env == 'test'
    match 'db_reset', to: 'test_support#db_reset'
  end

  get 'sessions/create'
  match 'logout', to: 'sessions#destroy'

  resources :bucket_groups do
    resources :buckets
  end

  match '/auth/:provider/callback', to: 'sessions#create'
  match '/auth/failure', to: 'sessions#auth_failure'
end
