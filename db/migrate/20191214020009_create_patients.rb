class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :name
      t.string :birthdate
      t.string :gender
      t.string :notes
      t.integer :user_id
    end
  end
end
