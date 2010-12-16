class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :t_categories do |t|
      t.string :name, :limit => 40, :null => false
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.string :description, :limit => 100
      # Uncomment it to store item level
      t.integer :depth
      t.timestamps
    end

    add_index :t_categories, ["name", "parent_id"],
      :name => "index_category_name_pid",
      :unique => false

    root = Category.create!(:name => 'Home', :description => '主目录')
    physics = Category.create!(:name => 'Physics', :description => '物理') 
    physics.move_to_child_of(root)

    a1 = Category.create!(:name => 'a1', :description => '铁牛') 
    a1.move_to_child_of(physics)

    a2 = Category.create!(:name => 'a2', :description => '铝锅') 
    a2.move_to_child_of(physics)

    a3 = Category.create!(:name => 'a3', :description => '中奖') 
    a3.move_to_child_of(physics)

    a4 = Category.create!(:name => 'a4', :description => '涨停') 
    a4.move_to_child_of(physics)


  end

  def self.down
    drop_table 't_categories' 
  end
end
