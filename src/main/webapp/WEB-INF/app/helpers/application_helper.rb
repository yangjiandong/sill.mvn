module ApplicationHelper

  # hack for firefox. The 'alt' parameter on images does not work. Firefox uses 'title' instead.
  # http://snippets.dzone.com/posts/show/2917
  def image_tag(location, options={})
    options[:title] ||= options[:alt]
    super(location, options)
  end

  def sill_version
    #Java::OrgSonarServerPlatform::Platform.getServer().getVersion()
    '1.0.0'
  end

  #i 原始数 n 要保留的小数位数，flag=1 四舍五入 flag=0 不四舍五入
  def num_f(i,n,flag)
    y = 1
    n.times do |x|
      y = y*10
    end
    if flag==1
     (i*y).round/(y*1.0)
    else
     (i*y).floor/(y*1.0)
    end
  end

  def tabs(tabs = nil)
    tabs ||= controller_path =~ /admin/ ? FatFreeCRM::Tabs.admin : FatFreeCRM::Tabs.main
    if tabs
      @current_tab ||= tabs.first[:text] # Select first tab by default.
      tabs.each { |tab| tab[:active] = (@current_tab == tab[:text] || @current_tab == tab[:url][:controller]) }
    else
      raise FatFreeCRM::MissingSettings, "Tab settings are missing, please run <b>rake crm:setup</b> command."
    end
  end

  #----------------------------------------------------------------------------
  def tabless_layout?
    #%w(authentications passwords).include?(controller.controller_name) ||
    #((controller.controller_name == "users") && (%w(create new).include?(controller.action_name)))
    return false
  end

  # Show existing flash or embed hidden paragraph ready for flash[:notice]
  #----------------------------------------------------------------------------
  def show_flash(options = { :sticky => false })
    [:error, :warning, :info, :notice].each do |type|
      if flash[type]
        html = content_tag(:p, h(flash[type]), :id => "flash")
        return html << content_tag(:script, "crm.flash('#{type}', #{options[:sticky]})", :type => "text/javascript")
      end
    end
    content_tag(:p, nil, :id => "flash", :style => "display:none;")
  end

  #----------------------------------------------------------------------------
  def subtitle(id, hidden = true, text = id.to_s.split("_").last.capitalize)
    content_tag("div",
      link_to_remote("<small>#{ hidden ? "&#9658;" : "&#9660;" }</small> #{text}".html_safe,
        :url    => url_for(:controller => :home, :action => :toggle, :id => id),
        :before => "crm.flip_subtitle(this)"
      ), :class => "subtitle")
  end

  #----------------------------------------------------------------------------
  def one_submit_only(form)
    { :onsubmit => "$('#{form}_submit').disabled = true" }
  end

  #----------------------------------------------------------------------------
  def hidden;    { :style => "display:none;"       }; end
  def exposed;   { :style => "display:block;"      }; end
  def invisible; { :style => "visibility:hidden;"  }; end
  def visible;   { :style => "visibility:visible;" }; end

  # Ajax helper to pass browser timezone offset to the server.
  #----------------------------------------------------------------------------
  def get_browser_timezone_offset
    unless session[:timezone_offset]
      remote_function(
        :url  => timezone_path,
        :with => "'offset='+(new Date()).getTimezoneOffset()"
      )
    end
  end

end
