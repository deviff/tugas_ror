Tugas::Application.routes.draw do
  root :to => 'mahasiswas#index'
  resources :mahasiswas 
  match "import_mahasiswa" => "mahasiswas#import", :via => :get
  match "doimport_mahasiswa" => "mahasiswas#doimport", :via => :post
end
