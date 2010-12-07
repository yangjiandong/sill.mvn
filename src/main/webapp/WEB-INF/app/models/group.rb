#
# user groups

class Group < ActiveRecord::Base
  set_table_name 't_groups'

  has_and_belongs_to_many :users, :class_name => "User", :join_table => "t_groups_users"
  #has_many :group_roles, :dependent => :delete_all
  has_and_belongs_to_many :resources, :class_name => "Resource", :join_table => "t_groups_resources"

  validates_presence_of     :name
  validates_length_of       :name,    :within => 1..40
  validates_length_of       :description,    :within => 0..200
  validates_uniqueness_of   :name

  # all the users that are NOT members of this group
  def available_users
    User.all - users
  end

  def set_users(new_users=[])
    self.users.clear

    new_users=(new_users || []).compact.uniq
    self.users = User.find(new_users)
    save
  end

  def <=>(other)
    return 1 if other.nil?
    name<=>other.name
  end
end
