class MahasiswaMailer < ActionMailer::Base
  default from: "dfedogawa3@gmail.com"

  def welcome_email(mahasiswa)
    @mahasiswa = mahasiswa
    @url  = "http://localhost:3000/mahasiswas/sign_in"
    mail(:to => user.email, :subject => "Welcome to Mahasiswa Site", :)
  end
end
