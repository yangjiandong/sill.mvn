class CreatePropertiesTable < ActiveRecord::Migration
  def self.up
    create_table 't_properties' do |t|
      t.column :prop_key,   :string, :limit => 512
      t.column :prop_value, :string, :limit => 4000
      t.column :resource_id,:integer, :null => true
      t.column :user_id,    :integer,:null => true
    end

    # 有关修改,新增字段,参考sonar
  end

  def self.down
    drop_table 't_properties'
  end
end
