class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :name
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
