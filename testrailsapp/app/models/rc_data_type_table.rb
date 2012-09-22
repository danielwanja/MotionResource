class RcDataTypeTable < ActiveRecord::Base
  attr_accessible :a_string, :a_text, :an_integer, :a_float, :a_decimal, :a_datetime, :a_timestamp, :a_time, :a_date, :a_binary, :a_boolean
end
