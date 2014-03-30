class AddColumnAge < ActiveRecord::Migration
  def change
    add_column :fish, :age, :integer
  end
end
