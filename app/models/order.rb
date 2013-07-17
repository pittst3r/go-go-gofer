class Order < ActiveRecord::Base
  attr_accessible :user, :user_id, :description, :gofer_run, :gofer_run_id, :organization, :organization_id
  
  belongs_to :user
  belongs_to :gofer_run
  belongs_to :organization
    
  class << self
    def by_updated_at
      order("updated_at DESC")
    end
    
    def unaccepted
      where("gofer_run_id IS NULL")
    end
  end
  
  def add_to_new_or_existing_gofer_run
    pending_run = user.gofer_runs.pending.in_organization(self.organization_id).first
    pending_run ||= user.gofer_runs.create!(organization_id: self.organization_id)
    self.gofer_run = pending_run
    self.save
  end
  
end
