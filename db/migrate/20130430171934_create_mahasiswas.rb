class CreateMahasiswas < ActiveRecord::Migration
  def change
    create_table :mahasiswas do |t|
      t.string :nim
      t.string :nama
      t.integer :semester
      t.integer :ttingkat
      t.string :email
      t.string :phone
      t.string :alamat
      t.date :tgllahir
      t.string :tmptlahir

      t.timestamps
    end
  end
end
