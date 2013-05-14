class Authentication < ActiveRecord::Base
  attr_accessible :mahasiswa_id, :provider, :token, :uid

  belongs_to :mahasiswa
end
