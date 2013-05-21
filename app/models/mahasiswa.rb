class Mahasiswa < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :alamat, :email, :nama, :nim, :phone, :semester, :tgllahir, :tmptlahir, :ttingkat
  attr_accessible :first_name, :last_name, :username

  validates :username, :first_name, :presence => true
  # validates :email, :presence => true, :uniqueness => true,  :on => :create
  
  #for facebooklogin
  has_many :authentications, :dependent => :delete_all

  def apply_omniauth(auth)
      # In previous omniauth, 'user_info' was used in place of 'raw_info'
      self.first_name = auth['info']['first_name']
      self.last_name = auth['info']['last_name']
      self.nama = auth['info']['name']
      self.email = auth['extra']['raw_info']['email']
      self.username = auth['info']['nickname']
      self.password = auth['info']['name']
      # Again, saving token is optional. If you haven't created the column in authentications table, this will fail
      authentications.build(:provider => auth['provider'], :uid => auth['uid'], :token => auth['credentials']['token'])
  end
  #---------------------------------------

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
