class CreateGoferRuns < ActiveRecord::Migration
  def change
    create_table :gofer_runs do |t|
      t.references :user
      
      t.timestamps
    end
    
    add_column :requests, :gofer_run_id, :integer
  end
end
