class Preference < ActiveRecord::Base
  attr_accessible :name, :value
  
  def value_in_boolean
    if value == "true"
      return true
    else
      return false
    end
  end
  
end
