class Mahasiswa < ActiveRecord::Base
  attr_accessible :alamat, :email, :nama, :nim, :phone, :semester, :tgllahir, :tmptlahir, :ttingkat

  validates :nama, :nim, :presence => true
  validates :email, :presence => true, :uniqueness => true,  :on => :create
  validates :semester, :presence => true, :numericality => true

  def self.csv_header 
  	"Nim,Nama,Semester,Tingkat,Email,Phone,Alamat,Tgllahir,Tmptlahir".split(',') 
  end 

  def self.build_from_csv(row) 
  # find existing customer from email or create new 
  cust = find_or_initialize_by_email(row[4]) 
  cust.attributes ={:nim => row[0], 
  	:nama => row[1], 
  	:semester => row[2], 
  	:ttingkat => row[3], 
  	:email => row[4], 
  	:phone => row[5], 
  	:alamat => row[6], 
  	:tgllahir => row[7],
  	:tmptlahir => row[8]} 
  	return cust 
  end
end
