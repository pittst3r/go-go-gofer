class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  attr_accessible :name, :email, :password, :password_confirmation, :organizations, :preferences_attributes
  attr_accessor :password_confirmation
  
  has_many :orders
  has_many :gofer_runs
  has_many :preferences
  has_and_belongs_to_many :organizations
  accepts_nested_attributes_for :preferences
  
  after_create :set_default_preferences
  
  def first_name
    name.split(" ").first
  end
  
  def add_preference(k, v)
    preferences.create(name: k, value: v) unless preferences.where(name: k).count >= 1
  end
  
  def update_preference(k, v)
    @pref = preferences.where(name: k).first
    @pref.value = v
    @pref.save
  end
  
  def order_email_notification_preference
    preferences.where(name: "order_email_notification").first.value_in_boolean
  end
  
  def set_default_preferences
    Preference::DEFAULT_PREFERENCES.each do |k, v|
      add_preference k, v
    end
  end
  
end
