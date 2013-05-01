class MahasiswasController < ApplicationController
	
	def index
		@mahasiswas = Mahasiswa.page(params[:page]).per(10)
	end

	def show
		@mahasiswa = Mahasiswa.find(params[:id])
	end

	def new
		@mahasiswa = Mahasiswa.new
	end

	def edit
		@mahasiswa = Mahasiswa.find(params[:id])
	end

	def create
		@mahasiswa = Mahasiswa.new(params[:mahasiswa])
		if @mahasiswa.save
			flash[:notice] = "Create new Mahasiswa Successfully"
			redirect_to :action => :index
		else
			flash[:error] = "Create new Mahasiswa Failed"
			render :action => :new
		end
	end

	def update
			@mahasiswa = Mahasiswa.find(params[:id])
		if @mahasiswa.update_attributes (params[:mahasiswa])
			flash[:notice] = "Update Mahasiswa Successfully"
			redirect_to :action => :index
		else
			flash[:error] = "Update Mahasiswa Failed"
			render :action => :edit
		end
	end

	def destroy
		@mahasiswa = Mahasiswa.find(params[:id])
    	if @mahasiswa.destroy
			flash[:notice] = "Delete Mahasiswa Successfully"
    	else
			flash[:error] = "Delete Mahasiswa Failed"
    	end	
    		redirect_to mahasiswas_path
	end

end
