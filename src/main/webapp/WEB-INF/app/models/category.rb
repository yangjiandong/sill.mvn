class Category < ActiveRecord::Base
  set_table_name 't_categories'
  acts_as_nested_set :scope => :tree_id

  def leaf?
    if self.rgt - self.lft == 1
      return true
    else
      return false
    end
    
  end
end
