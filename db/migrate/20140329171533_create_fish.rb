class CreateFish < ActiveRecord::Migration
  def change
    create_table :fish do |t|
      t.column :name, :string
      t.column :gender, :boolean
      t.timestamps
    end
  end
end
