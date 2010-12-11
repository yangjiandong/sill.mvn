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

  # shortcut for the method is_admin?() without parameters. Result is kept in cache.
  def administrator?
    @is_administrator ||=
    begin
      is_admin?
    end
  end

  # JFree Eastwood is a partial implementation of Google Chart Api
  def gchart(parameters, options={})
    image_tag("#{ApplicationController.root_context}/gchart?#{parameters}", options)
  end

  # Piechart for a distribution string or measure (foo=1;bar=2)
  def piechart(distribution, options={})
    chart = ""
    data=nil
    if distribution
      data=(distribution.kind_of? ProjectMeasure) ? distribution.data : distribution
    end

    if data && data.size > 0
      labels = []
      values = []
      skipZeros = options[:skipZeros].nil? ? true : options[:skipZeros]
      options[:skipZeros] = nil
      data.split(';').each do |pair|
        splitted = pair.split('=')
        value = splitted[1]
        next if skipZeros && value.to_i == 0
        labels << splitted[0]
        values << value
      end
      if labels.size > 0
        options[:alt] ||= ""
        chart = gchart("chs=#{options[:size] || '250x90'}&chd=t:#{values.join(',')}&cht=p&chl=#{labels.join('|')}", options)
      end
    end
    chart
  end

  def barchart(options)
    percent = (options[:percent] || 100).to_i
    return '' if percent<=0

    width = (options[:width] || 150).to_i
    color = (options[:color] ? "background-color: #{options[:color]};" : '')
    "<div class='barchart' style='width: #{width}px'><div style='width: #{percent}%;#{color}'></div></div>"
  end

  def chart(parameters, options={})
    image_tag("#{ApplicationController.root_context}/chart?#{parameters}", options)
  end

  #----------------------------------------------------------------------------
  def one_submit_only(form)
    { :onsubmit => "$('#{form}_submit').disabled = true" }
  end

  # Leia mais: http://rafael.adm.br/p/simple-tooltip-helper-for-ruby-on-rails/#ixzz17nyhRSDo
  def my_tooltip(content, options = {}, html_options = {}, *parameters_for_method_reference)
    html_options[:title] = options[:tooltip]
    html_options[:class] = html_options[:class] || 'tooltip'
    content_tag("span", content, html_options)
  end


end
