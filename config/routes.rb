Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  resources :exams
  resources :questions
  resources :assignments, except: [:edit, :delete] do
    member do
      get 'start_exam'
    end
    collection do
      get 'completed'
    end
  end
  get '*path' => redirect('/')
end
