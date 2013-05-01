Tugas::Application.routes.draw do
  root :to => 'mahasiswas#index'
  resources :mahasiswas 
end
