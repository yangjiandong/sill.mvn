# metal
# http://ihower.tw/blog/archives/4561
class StaticController < ActionController::Metal
  include ActionController::Rendering

  append_view_path "{Rails.root}/app/views"

  def about
    render "about"
  end

end

