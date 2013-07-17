class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :orders
  has_many :gofer_runs
  has_and_belongs_to_many :organizations
  attr_accessible :name, :email, :password, :password_confirmation, :organizations
  attr_accessor :password_confirmation
end
