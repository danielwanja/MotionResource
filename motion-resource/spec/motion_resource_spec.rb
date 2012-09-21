describe "MotionResource" do

  class Department
    include MotionResource::Resource
    columns :id => :integer, :name => :string, :city => :string, :state => :string    
  end

  class Employee
    include MotionResource::Resource

    columns :id => :integer
    columns :first_name, :last_name
    columns :job_id => :integer, :department_id => :integer, :manager_id => :integer
    columns :hire_date => :date
    columns :salary => :integer
  end

  class BubbleWrap::HTTP::Query
    attr_reader :url, :headers
  end

  before do
    #@localhost_url = 'http://localhost:3000'
  end

  describe "Resource" do
    it "should have resource name" do
      Department.resource_name.should == "departments"
      Employee.resource_name.should == "employees"
    end

    it "should have RESTful URLs" do      
      # Index
      query = Department.findAll()
      query.class.should == BubbleWrap::HTTP::Query
      query.url.absoluteString.should == "http://localhost:3000/departments.json"
      query.method.should == "GET"

      # Show
      query = Department.find(1)
      query.class.should == BubbleWrap::HTTP::Query
      query.url.absoluteString.should == "http://localhost:3000/departments/1.json"
      query.method.should == "GET"      
      
      # Create
      query = Department.create(Department.new)
      query.class.should == BubbleWrap::HTTP::Query
      query.url.absoluteString.should == "http://localhost:3000/departments.json"
      query.method.should == "POST"      
      
      # assertRestCall(MotionResource.find(Department, 1),      "/departments/1.json", "GET");
      
      # Update
      department = Department.new( id: 1)
      query = Department.update(department)
      query.class.should == BubbleWrap::HTTP::Query
      query.url.absoluteString.should == "http://localhost:3000/departments/1.json"
      query.method.should == "POST"      
      query.headers['X_HTTP_METHOD_OVERRIDE'].should == "put"
      
      # Delete
      department = Department.new( id: 1)
      query = Department.delete(department)
      query.class.should == BubbleWrap::HTTP::Query
      query.url.absoluteString.should == "http://localhost:3000/departments/1.json"
      query.method.should == "POST"      
      query.headers['X_HTTP_METHOD_OVERRIDE'].should == "delete"
    end


  end

  # describe "CRUD" do

  #   def test_find_method(method)
  #   end

  #   it "should find all" do
  #   end

  #   it "should show" do
  #   end

  #   it "should create" do
  #   end

  #   it "should update" do
  #   end

  #   it "should delete" do
  #   end

  # end

end