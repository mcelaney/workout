Rails.application.routes.draw do
  resources :users, only: [:show, :new, :create, :edit, :update] do
    resources :workout_plans, only: [:update]
  end

  get 'login' => 'sessions#new', as: 'log_in'
  get 'logout' => 'sessions#destroy', as: 'log_out'
  resources :sessions, only: [:create]

  %w(home).each do |page|
    get page, controller: 'static_pages', action: page
  end

  root 'static_pages#home'
end
