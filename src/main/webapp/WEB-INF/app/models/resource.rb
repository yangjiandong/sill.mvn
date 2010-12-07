#

class Resource < ActiveRecord::Base
  set_table_name 't_resources'

  has_and_belongs_to_many :groups, :class_name => 'Group', :join_table => 't_groups_resources'

end
