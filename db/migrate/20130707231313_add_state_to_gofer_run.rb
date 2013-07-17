class AddStateToGoferRun < ActiveRecord::Migration
  def change
    add_column :gofer_runs, :state, :string
  end
end
