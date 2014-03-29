class UpdateGender < ActiveRecord::Migration
  def change
    remove_column :fish, :gender
    add_column :fish, :gender, :string
  end
end
