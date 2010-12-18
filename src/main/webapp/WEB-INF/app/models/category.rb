require 'awesome_nested_set'

class Category < ActiveRecord::Base
  set_table_name 't_categories'
  # rails plugin install git://github.com/galetahub/awesome_nested_set.git 
  acts_as_nested_set
  
  Category.include_root_in_json = false if Category.respond_to?(:include_root_in_json)
  
  def leaf?
    if self.rgt - self.lft == 1
      return true
    else
      return false
    end
    
  end
end
