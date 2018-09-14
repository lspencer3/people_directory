Rails.application.routes.draw do
  get 'welcome/index'

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  namespace :api, defaults: { format: "json" } do
    get :me, to: 'me#me'
  end

  root to: "main#index"
end
