class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :slack_id
      t.string :name
      t.string :picture
      t.string :slack_token
      t.string :email
      t.string :status
      t.timestamps null: false
    end
  end
end
