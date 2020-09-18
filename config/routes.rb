Rails.application.routes.draw do
  root 'maxminds#index'

  namespace :maxminds do
    get '/', action: :index
    get :search
  end
end
