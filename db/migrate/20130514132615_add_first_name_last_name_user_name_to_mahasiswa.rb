class AddFirstNameLastNameUserNameToMahasiswa < ActiveRecord::Migration
  def change
    add_column :mahasiswas, :first_name, :string
    add_column :mahasiswas, :last_name, :string
    add_column :mahasiswas, :username, :string
  end
end
