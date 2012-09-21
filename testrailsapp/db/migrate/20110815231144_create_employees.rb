class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.integer :job_id
      t.integer :department_id
      t.integer :manager_id
      t.datetime :hire_date
      t.integer :salary

      t.timestamps
    end
  end
end
