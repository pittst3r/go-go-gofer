class Organization < ActiveRecord::Base
  attr_accessible :name
  
  has_many :orders
  has_many :gofer_runs
  has_and_belongs_to_many :users
end
