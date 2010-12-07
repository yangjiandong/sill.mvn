class CreateGroup < ActiveRecord::Migration
  def self.up
    create_table 't_groups' do |t|
      t.string :name, :limit => 40, :null => true
      t.string :description, :limit => 200, :null => true

      t.timestamps
    end

    create_table 't_groups_users', :id => false do |t|
      t.integer :user_id
      t.integer :group_id
    end
    add_index "t_groups_users", "user_id"
    add_index "t_groups_users", "group_id"

    administrators = Group.create(:name => 'administrator', :description => '系统管理员')
    # GroupRole.create(:group_id => administrators.id, :role => 'admin')

    admin = User.find_by_login('admin')
    admin.groups<<administrators
    admin.save!

    usergroups = Group.create(:name => 'users', :description => '一般用户')
    admin = User.find_by_login('admin')
    admin.groups<<usergroups
    admin.save!
  end

  def self.down
    drop_table 't_groups'
    drop_table 't_groups_users'
  end
end
