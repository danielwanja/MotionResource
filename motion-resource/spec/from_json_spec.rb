describe "From JSON" do

  class DataTypeTable
    include MotionResource::Resource

    columns :id => :integer, :an_integer => :integer
    columns :a_boolean => :boolean
    columns :another_boolean => :boolean
    columns :a_string, :a_text
    columns :a_float => :float, :a_decimal => :float
    columns :a_datetime => :date
  end

  def assert_record(record)
    record.a_boolean.should == true
    record.another_boolean.should == false
    record.a_decimal.should == 9.99
    record.a_float.should ==1.5
    record.a_string.should == "MyString"
    record.a_text.should == "MyText"
    record.an_integer.should == 1
  end

  it "should an instance from hash" do
    json = {:a_decimal=>"9.99", :a_datetime=>"2011-08-15T17:06:09Z", :a_time=>"2000-01-01T17:06:09Z", :id=>980191079, :a_string=>"MyString", :an_integer=>1, :updated_at=>"2012-09-24T18:15:14Z", :created_at=>"2012-09-24T18:15:14Z", :a_float=>1.5, :a_timestamp=>"2011-08-15T17:06:09Z", :a_date=>"2011-08-15", :a_binary=>nil, :a_boolean=>true, :another_boolean=>false, :a_text=>"MyText"}
    record = DataTypeTable.new(json)
    assert_record(record)
    record.id.should == 980191079
  end

  it "should create an instance" do
    json = {:a_decimal=>"9.99", :a_datetime=>"2011-08-15T17:06:09Z", :a_time=>"2000-01-01T17:06:09Z", :id=>980191079, :a_string=>"MyString", :an_integer=>1, :updated_at=>"2012-09-24T18:15:14Z", :created_at=>"2012-09-24T18:15:14Z", :a_float=>1.5, :a_timestamp=>"2011-08-15T17:06:09Z", :a_date=>"2011-08-15", :a_binary=>nil, :a_boolean=>true, :another_boolean=>false, :a_text=>"MyText"}
    record = DataTypeTable.from_rails(json)
    assert_record(record)
    record.id.should == 980191079
  end

  it "should create an array" do
    json = [
            {:a_decimal=>"9.99", :a_datetime=>"2011-08-15T17:06:09Z", :a_time=>"2000-01-01T17:06:09Z", :id=>12345, :a_string=>"MyString", :an_integer=>1, :updated_at=>"2012-09-24T18:15:14Z", :created_at=>"2012-09-24T18:15:14Z", :a_float=>1.5, :a_timestamp=>"2011-08-15T17:06:09Z", :a_date=>"2011-08-15", :a_binary=>nil, :a_boolean=>true, :another_boolean=>false, :a_text=>"MyText"},
            {:a_decimal=>"9.99", :a_datetime=>"2011-08-15T17:06:09Z", :a_time=>"2000-01-01T17:06:09Z", :id=>67890, :a_string=>"MyString", :an_integer=>1, :updated_at=>"2012-09-24T18:15:14Z", :created_at=>"2012-09-24T18:15:14Z", :a_float=>1.5, :a_timestamp=>"2011-08-15T17:06:09Z", :a_date=>"2011-08-15", :a_binary=>nil, :a_boolean=>true, :another_boolean=>false, :a_text=>"MyText"}
          ]
    records =  DataTypeTable.from_rails(json)
    records.class.should == Array
    records.length.should == 2
    assert_record(records[0]) 
    records[0].id.should == 12345
    assert_record(records[1]) 
    records[1].id.should == 67890
  end

  # it "should create has_one association" do
  # end

  # it "should create has_many associations" do
  # end

end
