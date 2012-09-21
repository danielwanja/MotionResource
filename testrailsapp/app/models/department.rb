class Department < ActiveRecord::Base
  has_many    :employees
  accepts_nested_attributes_for :employees, :allow_destroy => true

  attr_accessor :custom_attribute
  
  def as_json(options={})    
    super(:include => :employees)
  end
    
  def city_state
    [city, state].reject(&:blank?).join(', ')
  end
  
  def array_of_strings
    ["s1", "s2", "s3"]
  end
  
  def array_of_numbers
    [1,2,3,4]
  end
  
  def array_of_floats
    [1.0,2.0,3.0, 4.1]
  end
    
  def array_of_departments
    Department.find(:all)
  end
  
  def one_department
    Department.find(:first)
  end
  
  def return_parameters(param1, param2, param3)
    [param1, param2, param3]
  end
  
  def echo(param)
    param
  end
   
  def self.class_array_of_numbers
    [9,8,7]
  end
  
  def self.class_array_of_strings
    ["lots","of","strings"]
  end
  
  def self.class_array_of_numbers_with_args(param1, param2, param3)
    [param1, param2, param3]
  end  
    
  def self.lov
    find(:all, :select => "id, name", :order => "upper(name)")
  end
    
  validates_length_of :state, :maximum => 2
  validates_length_of :name, :city, :maximum => 20  
end
