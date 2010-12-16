class CategoriesController < ApplicationController
  skip_before_filter :check_authentication

  def index

  end

  def category_tree
    categories = Category.find_by_sql("select * from t_categories where parent_id is null")
    data = get_tree(categories, nil)
    Rails.logger.info("category_tree: #{data.to_json}")
    render :text => data.to_json, :layout => false

  end

  def get_tree(categories, parent)
    data = Array.new

    categories.each { |category|
      if !category.leaf?
        if data.empty?
          data = [{"text" => category.name,
          "id" => category.id,
          "cls" => "folder",
          "leaf" => false,
          "children" => get_tree(category.children, category)
          }]
        else
          data.concat([{"text" => category.name,
                      "id" => category.id,
                      "cls" => "folder",
                      "leaf" => false,
                      "children" => get_tree(category.children, category)}])
        end

      else

        data.concat([{"test" => category.name,
                    "id" => category.id,
                    "cls" => "file",
                    "leaf" => true}])

      end
    }
    return data
  end
end
