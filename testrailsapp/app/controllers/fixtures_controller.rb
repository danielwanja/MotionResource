# This controller is used from Flex to reset the test database between test methods.

if Rails.env.test?
  require 'active_record/fixtures'
  require 'factory_girl'
  
  class FixturesController < ActionController::Base
    FIXTURES_ROOT = "#{Rails.root}/test/fixtures"
    
    def reset
      ActiveRecord::Fixtures.reset_cache
      factory_names = Array(params[:fixtures].split(","))
      fixtures = {}
      factory_names.each do |factory| 
        fixtures.merge!(self.send(factory)) # Here we could use the factory as key.
      end      
      
      render :json => fixtures
    end
    
    # def setup_fixtures
    #   ActiveRecord::Fixtures.create_fixtures(FIXTURES_ROOT, [:posts]) # [:authors, :comments, :essays, :posts, :todos]      
    # end
    
    def setup_departments
      Department.delete_all  
      Employee.delete_all
      dep = Department.create(:name=> 'department1', :city => 'Littleton', :state => 'CO')      
      employee1 = dep.employees.create(:first_name=>"first_1", :last_name =>"last_1", :job_id => 12)      
      employee2 = dep.employees.create(:first_name=>"first_2", :last_name =>"last_2", :job_id => 12)      
      employee3 = dep.employees.create(:first_name=>"first_3", :last_name =>"last_3", :job_id => 12)      
      employee3.manager = employee1
     
      departments = {:department1 => dep,
                      :department2 => Department.create(:name=> 'department2', :city => 'Littleton', :state => 'CO') ,
                      :department3 => Department.create(:name=> 'department3', :city => 'Littleton', :state => 'CO') 
      }
      departments
    end
  
    def setup_data_type_table
      RcDataTypeTable.delete_all
      data = RcDataTypeTable.create(
        :a_string    =>  "MyString",
        :a_text      => "MyText",
        :an_integer  => 1,
        :a_float     => 1.5,
        :a_decimal   => 9.99,
        :a_datetime  => "2011-08-15 17:06:09",
        :a_timestamp => "2011-08-15 17:06:09",
        :a_time      => "2011-08-15 17:06:09",
        :a_date      => "2011-08-15",
        :a_binary    => nil,  # FIXME: Figure out how to test binary conversion? Do we want to?
        :a_boolean   => false
      )      
      {:rc_data_type_table => data }
    end
        
    def inspect_headers
      result = {}
      request.headers.each do |k,v|
        result[k] = v.to_s
      end
      render :text => result.to_xml(:dasherize => false, :root => 'headers')
    end
    
    def crossdomain
      render :text => <<-EOXML
<?xml version="1.0"?>
<!DOCTYPE cross-domain-policy SYSTEM "http://www.macromedia.com/xml/dtds/cross-domain-policy.dtd">
<cross-domain-policy>
   <allow-access-from domain="*" />
</cross-domain-policy>
      EOXML
    end
    
    RESULTS_FILE = File.join(Rails.root, '..', 'active_resource', 'testResults', 'TEST-AllTests.xml')
    def save_test_results
      File.open(RESULTS_FILE, 'w') { |f| f.write params['0'] }
      head :ok
    end
    
        
  end
  
end #if test