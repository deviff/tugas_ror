class Mahasiswa < ActiveRecord::Base
  attr_accessible :alamat, :email, :nama, :nim, :phone, :semester, :tgllahir, :tmptlahir, :ttingkat

  validates :nama, :nim, :presence => true
  validates :email, :presence => true, :uniqueness => true,  :on => :create
  validates :semester, :presence => true, :numericality => true
end
