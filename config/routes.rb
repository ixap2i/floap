Rails.application.routes.draw do
  get "/" => "top#index"

  resources "tops", only: :index
  resources "flowers", only: :index
  resources "tag_images", only: :index
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
