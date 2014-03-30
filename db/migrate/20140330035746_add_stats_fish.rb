class AddStatsFish < ActiveRecord::Migration
  def change
    add_column :fish, :hunger, :string
    add_column :fish, :mood, :string
    add_column :fish, :discipline, :string
  end
end
