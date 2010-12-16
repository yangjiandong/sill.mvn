class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table 't_categories' do |t|
      t.string :name, :limit => 40, :null => true
      t.integer :parent_id
      t.integer :tree_id
      t.integer :lft
      t.integer :rgt

      t.string :description, :limit => 100
      t.timestamps
    end

  end

  def self.down
    drop_table 't_categories' 
  end
end
