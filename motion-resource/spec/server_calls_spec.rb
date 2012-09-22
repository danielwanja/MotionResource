describe "Server Calls" do
  class WaitResponse
    attr_accessor :response
    attr_accessor :body
  end

  class RcDataTypeTable
    include MotionResource::Resource

    columns :id => :integer, :an_integer => :integer
    columns :a_string, :a_text
    columns :a_float => :float, :a_decimal => :float
    columns :a_datetime => :date
    columns :a_boolean => :boolean
  end

  before do
    @app = UIApplication.sharedApplication
    @wait = WaitResponse.new
    @fixtures = nil
    BubbleWrap::HTTP.get("http://localhost:3000/fixtures/reset?fixtures=setup_data_type_table", {}) do |response|
      if response.ok?
        json = BubbleWrap::JSON.parse(response.body.to_str)
        @wait.body = json
        @wait.response = response
      else
        raise "Failed to setup fixtures. #{response.body}"
      end
    end    
    wait_for_change(@wait, "response") do
      @fixtures = @wait.body
    end
  end

  it "has fixtures" do
    @wait.response.status_code.should == 200
    @fixtures.class.should == Hash
    valid_rc_data_type_table(@fixtures["rc_data_type_table"])
  end

  def valid_rc_data_type_table(rc_data_type_table)
    rc_data_type_table.should.not.be.nil
    rc_data_type_table["a_decimal"].should == "9.99"
    rc_data_type_table["a_datetime"].should == "2011-08-15T17:06:09Z"
    rc_data_type_table["a_time"].should == "2000-01-01T17:06:09Z"
    rc_data_type_table["a_string"].should == "MyString"
    rc_data_type_table["an_integer"].should == 1
    rc_data_type_table["a_float"].should == 1.5
    rc_data_type_table["a_timestamp"].should == "2011-08-15T17:06:09Z"
    rc_data_type_table["a_date"].should == "2011-08-15"
    rc_data_type_table["a_binary"].should == nil
    rc_data_type_table["a_boolean"].should == false
    rc_data_type_table["a_text"].should == "MyText"    
  end

  it "find all" do
    @wait = WaitResponse.new
    RcDataTypeTable.findAll() do |response|
      if response.ok?
        json = BubbleWrap::JSON.parse(response.body.to_str)
        @wait.body = json
        @wait.response = response
      else
        raise "Failed to setup fixtures. #{response.body}"
      end
    end
    wait_for_change(@wait, "response") do
      result = @wait.body
      result.class.should == Array
      result.length.should == 1
      valid_rc_data_type_table(result[0])
      result[0].class.should == RcDataTypeTable
    end    
  end

end
