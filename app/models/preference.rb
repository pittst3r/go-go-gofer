class Preference < ActiveRecord::Base
  attr_accessible :name, :value
  
  before_save :convert_value_to_string, on: :create
  
  DEFAULT_PREFERENCES = {
    order_email_notification: true
  }
  
  def value_in_boolean
    if value == "true"
      return true
    else
      return false
    end
  end
  
  def convert_value_to_string
    self.value = value.to_s
  end
  
end
