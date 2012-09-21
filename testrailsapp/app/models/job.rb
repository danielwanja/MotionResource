class Job < ActiveRecord::Base
  has_many    :employees
  has_many    :courses
  accepts_nested_attributes_for :courses  
  
  validates_length_of :name, :maximum => 20
  
  def self.lov
    find(:all, :select => "id, name", :order => "upper(name)")
  end  
end
