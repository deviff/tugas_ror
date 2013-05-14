Tugas::Application.routes.draw do
  devise_for :mahasiswas

  root :to => 'mahasiswas#index'
  resources :mahasiswas 
  match "import_mahasiswa" => "mahasiswas#import", :via => :get
  match "doimport_mahasiswa" => "mahasiswas#doimport", :via => :post
  match "import_excel_mahasiswa" => "mahasiswas#import_excel", :via => :get
  match "doimport_excel_mahasiswa" => "mahasiswas#doimport_excel", :via => :post
  match "/auth/:provider/callback" => 'authentications#create'
end
