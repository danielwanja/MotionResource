class CreateRcDataTypeTables < ActiveRecord::Migration
  def change
    create_table :rc_data_type_tables do |t|
      t.string :a_string
      t.text :a_text
      t.integer :an_integer
      t.float :a_float
      t.decimal :a_decimal
      t.datetime :a_datetime
      t.timestamp :a_timestamp
      t.time :a_time
      t.date :a_date
      t.binary :a_binary
      t.boolean :a_boolean

      t.timestamps
    end
  end
end
