class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :status
      t.string :fellow_uid

      t.timestamps null: false
    end
  end
end
