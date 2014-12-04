class CreatePlans < ActiveRecord::Migration
  def change
    create_table :baselines do |t|
      t.references :member
      t.integer :bench_press
      t.integer :lat_pull
      t.integer :deadlift
      t.integer :military_press
      t.integer :one_arm_row
      t.integer :curls
      t.integer :squats
      t.integer :dips
      t.integer :pullups

      t.timestamps
    end
  end
end
