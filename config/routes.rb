Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"

  resources :tasks
  put '/tasks/complete/:id', to: 'tasks#do', as: 'do_task'
  delete '/tasks/complete/:id', to: 'tasks#undo', as: 'undo_task'
  resources :projects
  resources :tags
end
