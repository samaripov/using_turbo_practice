Rails.application.routes.draw do
  root "pages#home"
  devise_for :users
  resources :quotes do
    resources :line_item_dates, except: [ :index, :show ] do
      resources :line_item, except: [ :index, :show ]
    end
  end
end
