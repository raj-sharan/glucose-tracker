class CreateBloodGlucoseLevels < ActiveRecord::Migration
  def change
    create_table :blood_glucose_levels do |t|
      t.references :user
      t.integer :data
      t.datetime :recorded_at

      t.timestamps null: false
    end
  end
end
