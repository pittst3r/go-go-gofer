class RenameRequestsToOrders < ActiveRecord::Migration
  def up
    rename_table :requests, :orders
  end

  def down
    rename_table :orders, :requests
  end
end
