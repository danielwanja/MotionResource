class Employee < ActiveRecord::Base
    has_one :manager, :class_name => "Employee", :foreign_key => "manager_id"
    belongs_to  :department
    belongs_to  :job
    accepts_nested_attributes_for :job


    def full_name
      [first_name, last_name].reject(&:blank?).join(" ")
    end

    def annual_salary
      salary * 12
    end

    validates_presence_of :first_name
    validates_presence_of :last_name
    validates_length_of :first_name, :maximum => 15
  #  validates_presence_of :department_id, :job_id

    before_create :validate_record

    def self.lov
      find(:all, :select => "id, first_name, last_name", :order => "upper(first_name), upper(last_name)")
    end

    private

    def validate_record
      errors.add_to_base("Testing errors on base") if first_name == "fail_create"  # Magic first_name that Rails recognize to fail the create
       errors.size == 0
    end  
end
