class CreateUser < ActiveRecord::Migration
  def self.up
    create_users
  end

  def self.down
    drop_table 't_users'
  end

  private
  def self.create_users
    create_table 't_users' do |t|
      t.column :login, :string, :limit => 40
      t.column :name,  :string, :limit => 100, :null=> true
      t.column :email, :string, :limit => 100, :null=> true
      t.column :crypted_password, :string, :limit => 40
      t.column :salt,  :string, :limit => 40
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
      t.column :remember_token, :string, :limit => 500, :null => true
      t.column :remember_token_expires_at, :datetime
    end

   end
end
