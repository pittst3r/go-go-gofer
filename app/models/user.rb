class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :orders
  has_many :gofer_runs
  has_many :preferences
  has_and_belongs_to_many :organizations
  accepts_nested_attributes_for :preferences
  attr_accessible :name, :email, :password, :password_confirmation, :organizations, :preferences_attributes
  attr_accessor :password_confirmation
  
  def first_name
    name.split(" ").first
  end
  
  def add_preference(name, value)
    preferences.create name: name.to_s, value: value.to_s
  end
  
  def order_email_notification_preference
    preferences.where(name: "order_email_notification").first.value_in_boolean
  end
  
end
