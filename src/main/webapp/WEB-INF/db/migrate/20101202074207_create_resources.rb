class CreateResources < ActiveRecord::Migration
  def self.up
    create_table 't_resources' do |t|
      t.string :resname, :limit => 100
      t.string :resurl, :limit => 400
      t.string :description, :limit => 200

      t.timestamps
    end

    create_table 't_groups_resources', :id => false do |t|
      t.integer :resource_id
      t.integer :group_id
    end
  end

  def self.down
    drop_table 't_resources'
    drop_table 't_groups_resources'
  end
end
