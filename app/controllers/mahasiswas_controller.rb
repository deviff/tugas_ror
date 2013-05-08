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

	def import
		@mahasiswa = Mahasiswa.new
	end

	def doimport
		if request.post? && params[:file].present? 
			infile = params[:file].read 
			n, errs = 0, [] 

			CSV.parse(infile) do |row| 
				n += 1 
		# SKP: header i.e. first row OR blank row 
		next if n == 1 or row.join.blank? 
		# build_from_csv method will map customer attributes & 
		# build new customer record 
		mahasiswa = Mahasiswa.build_from_csv(row) 
		# Save upon valid 
		# otherwise collect error records to export 
		if mahasiswa.valid? 
			mahasiswa.save 
		else errs << row 
		end 
		end 
		# Export Error file for later upload upon correction 
		if errs.any? 
			errFile ="errors_#{Date.today.strftime('%d%b%y')}.csv" 
			errs.insert(0, Mahasiswa.csv_header) 
			errCSV = CSV.generate do |csv| 
				errs.each {|row| csv << row} 
			end 
			send_data errCSV, 
			:type => 'text/csv; charset=iso-8859-1; header=present', 
			:disposition => "attachment; filename=#{errFile}.csv" 
		else 
			flash[:notice] = 'mahasiswa.import.success' 
			redirect_to mahasiswas_path
		end 
	end
end
	
	def import_excel
		
	end

	def doimport_excel
		# require 'spreadsheet'
		Spreadsheet.client_encoding = 'UTF-8'
		book = Spreadsheet.open params[:dump][:excel_file].tempfile
		sheet1 = book.worksheet 0
		sheet1.each do |row|
		# you can do any interesing thing with row
		mahasiswa = Mahasiswa.build_from_csv(row)
		@sukses = mahasiswa.save
		end
		if @sukses
			flash[:notice] = "Import Mahasiswa From Excel Successfully"
			redirect_to :action => :index
		else
			flash[:error] = "Import Mahasiswa From Excel Failed"
			redirect_to :action => :import_excel
		end
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
