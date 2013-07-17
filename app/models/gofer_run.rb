class GoferRun < ActiveRecord::Base
  attr_accessible :user, :user_id, :organization, :organization_id
  
  belongs_to :user
  belongs_to :organization
  has_many :orders
  
  before_destroy :clear_orders
  
  state_machine :initial => :pending do
    event :close do
      transition :pending => :closed
    end
  end
  
  class << self
    def pending
      where(state: "pending")
    end
    
    def in_organization(org_id)
      where(organization_id: org_id)
    end
  end
    
  def clear_orders
    orders.clear
  end
  
end
