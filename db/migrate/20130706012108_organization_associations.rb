class OrganizationAssociations < ActiveRecord::Migration
  def change
    add_column :orders, :organization_id, :integer
    add_column :gofer_runs, :organization_id, :integer
    create_table :organizations_users, id: false do |t|
      t.integer :organization_id
      t.integer :user_id
    end
  end
end
