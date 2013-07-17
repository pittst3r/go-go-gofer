class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :description
      t.references :user
      
      t.timestamps
    end
  end
end
