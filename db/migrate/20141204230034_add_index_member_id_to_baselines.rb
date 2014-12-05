class AddIndexMemberIdToBaselines < ActiveRecord::Migration
  change_table :baselines do |t|
    t.index :member_id
  end
end
