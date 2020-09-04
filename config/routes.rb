Rails.application.routes.draw do
  resources :notes do
    get :tags, on: :collection
  end
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup',
    auto_login: 'auto_login'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'user/auto_login', :to => 'users/sessions#auto_login'
  end
end
