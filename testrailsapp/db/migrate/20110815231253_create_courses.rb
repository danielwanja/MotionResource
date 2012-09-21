class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :job_id
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
