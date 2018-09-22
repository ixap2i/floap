Rails.application.routes.draw do

  resources "flowers", only: :index
  resources "tag_images", only: :index
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
