class InsertUser < ActiveRecord::Migration
  def self.up

    User.create(:login => 'admin', :name => '系统管理员', :email => 'admin@gmail.com',
    :password => 'admin123', :password_confirmation => 'admin123')

  end

  def self.down
  end
end
