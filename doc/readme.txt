Sill - rails3
=============

2010.12.20
----------

   1. 另一个高并发项目 ,采用了akka
    https://github.com/danielribeiro/RubyOnAkka
    -- 没成功

   2. 项目:https://github.com/flyerhzm/rails-bestpractices.com
    -- 环境为linux,

   3. bullet
    开发过程中收集query,提供改进信息
    https://github.com/flyerhzm/bullet
    -- mvn 环境下不能正常运行,jruby on rails下能运行.

   4. 采用jruby1.5.6 + jruby rack 1.0.4

   5.  Can restful authentication work with Cookies Disabled? 
   http://stackoverflow.com/questions/1514774/can-restful-authentication-work-with-cookies-disabled 

   add to lib\authenticate_system.rb
   --好像多余,已实现

2010.12.18
----------

   1. 另一种debug 方法

   lib/debug_log, sill.rb增加设置:
   ActionController::Base.send(:include, DebugLog)
   ActiveRecord::Base.send(:include, DebugLog)

   Based on the code above, made the plugin debug_logger.
   How to use:
   in model or controller
   debug_log("anything")

   log文件存放在log/debug.log
   tail debug.log 可跟踪显示.

   2. rspec

   save/rspec.txt

   3. 后台任务
   https://github.com/ncr/background-fu
   采用plugin 方式,
   save\background.txt

   rails plugin install git://github.com/ncr/background-fu.git
   rails g background
   --需修改下background-fu/rails/init.rb
   --jruby script/background start 不成功

   另一个方案
   http://github.com/collectiveidea/delayed_job
   gem 'delayed_job'

   jruby script/rails generate delayed_job
   rake db:migrate
   --run
   rake jobs:work

   相关信息:
   http://asciicasts.com/episodes/171-delayed-job
   http://blog.plataformatec.com.br/2010/02/monitoring-delayed-job-with-bluepill-and-capistrano/

   4. 如何格式化"12345"为"12,345"
javascript:
Js代码
string.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, function(s){return s+","})

ruby:
Ruby代码
string.gsub(/(\d)(?=(\d\d\d)+(?!\d))/) { |match| match + ',' }


2010.12.17
----------

   1. production log 采用 log4j

   production.rb:

   require File.dirname(__FILE__) + '/../../lib/slf4j_logger.rb'
   config.logger = Slf4jLogger.new
   ActiveRecord::Base.logger = config.logger

   logback.xml:
  <!-- JRuby on Rails. Uncomment in order to log HTTP and SQL requests -->
  <logger name="rails">
    <level value="ERROR"/>
  </logger>

2010.12.16
----------

   1. chart - highcharts
   https://github.com/stonegao/lazy_high_charts

2010.12.15
----------

   1. extjs/direct
   https://github.com/extjs/direct-rails.git
   or
   https://github.com/stonegao/active-direct

   2. acts_as_nested_set
   http://www.javaeye.com/topic/76860
   改用: rails plugin install git://github.com/galetahub/awesome_nested_set.git
   save/ Awesome Nested Set Cheat Sheet.txt

   cd src\main\webapp\WEB-INF
   rails generate migration create_categories
   rake db:migrate

2010.12.14
----------

   1. 采用页面缓存时,由于jetty运行配置中设置了webpath 为 dev,所以统一放到webapp/dev下

2010.12.13
----------

   1. 感觉还是要用extjs,倒底它提供了全套的界面解决方案,不像jquery,prototype,只是个框架,并且应用起来还要考虑插件所依靠的版本问题.

   2. 建立branch use.prototype.js
   git branch use.prototype.js
   git push origin use.prototype.js

   3. 引入ext3.3.0
   public/javascripts/ext

   4. name shrek
   http://www.google.com/images?hl=en&q=shrek&um=1&ie=UTF-8&source=univ&ei=gQIGTZGWBYOsrAezhPmQDw&sa=X&oi=image_result_group&ct=title&resnum=8&ved=0CHsQsAQwBw&biw=1239&bih=754

   5. 参考 extrails,
   http://sourceforge.net/projects/extrails/

2010.12.12
----------

   1. jetty 运行时,html,js文件不能编辑
http://www.assembla.com/wiki/show/liftweb/Fix_file_locking_problem_with_jettyrun
Files are locked on Windows and can't be replaced
old:http://docs.codehaus.org/display/JETTY/Files+locked+on+Windows

   <servlet>
    <servlet-name>default</servlet-name>
    <init-param>
      <param-name>useFileMappedBuffer</param-name>
      <param-value>false</param-value>
    </init-param>
  </servlet>

  或采用webdefault.xml,pom.xml设置
  <webDefaultXml>${basedir}/src/dev/webdefault.xml</webDefaultXml>
  --没效果,在sshapp项目上用时起作用

   2. prototip 1.0.2 在 rails3 自带prototype 1.7.2 的环境中不能运行

   prototip最新版2.2.2在ie8,chrome下不能正常显示
   暂时用1.3.5
   http://www.nickstakenburg.com/projects/prototip/
   --也有问题,显示不完整

   3. 简单 tooltip
   http://rafael.adm.br/p/simple-tooltip-helper-for-ruby-on-rails/

   4. How to enable multi-threading in rails
To enable thread-safe (multi-threaded) mode in Rails when running with a warbler-generated WAR file:

set min/max runtimes in warble.rb to 1/1 respectively
in config/environment.rb put the line config.threadsafe!
When running with the GlassFish gem, threadsafe mode will be detected automatically and GlassFish will use only a single JRuby instance. As a result only step 2 above is necessary.

   http://kenai.com/projects/jruby/pages/RailsMulti-ThreadingBestPractices/revisions/2

2010.12.10
----------

   1. 在ChartsServlet中硬编码charts

2010.12.09
----------

   1. 加入sonar项目中platform概念

   pom.xml
   replace commons-logging by jcl-over-slf4j

2010.12.08
----------

   1. 怪异现象,用mvn jetty:run 报:
   org.jruby.rack.RackInitializationException: No such file or directory - D:/workspace/jruby/config/database.yml|...

   打包生成war,放到tomcat,运行正常.
   将整个项目移到其它地方d:\a\sill.mvn,配置下config/database.yml development数据源,就能正常.
   原来目录为 d:\workspace\jruby\workspace\sill.mvn\

2010.12.07
----------

   1.  采用mvn.
      cd parent
      mvn install
      cd ..
      mv eclipse:eclipse

      jruby-rack 暂时用1.0.1, 1.0.3 有bug,jetty下不能显示,首页为浏览目录.
      --可采用index.html解决
      --现采用jruby 1.5.6, jruby-rack 1.3.0

   2. webapp/WEB-INF/gems 不加入版本

   3、手工建立eclipse项目

   a、建立m2_home变量
     mvn -Declipse.workspace=<path-to-eclipse-workspace> eclipse:add-maven-repo
   b、生成eclipse项目
     mvn eclipse:eclipse
     bin/eclipse.bat

   4. 生成演示数据
   --yaml_db 在rails2.3 中有点问题,具体看jrails/doc/readme.txt

   拷贝yaml_db到lib下
   rake db:dump --> db/data.yml

2010.12.06
----------

   1. 性能

   d:\xampp1.6.8\apache\bin\ab -n 10 -c 5 http://127.0.0.1:8080/sill/login
   --5 个并发,10个请求
   --与jruby.min.runtimes 设置有关,min,max全为1时,时间最短,max 10 ,时间很慢
   --2,4 也还行.但还找不到规律,时快时慢,最后能稳定到300多
   https://github.com/nicksieger/jruby-rack
   For multi-threaded Rails with a single runtime, set min/max both to 1

   2. User

    include NeedAuthentication::ForUser

    def self.included(recipient)
      recipient.extend(ModelClassMethods)
    end

    扩展类方法(class method),这样User可直接用authenticate(login,password), editable_password? 方法
    --具体参考 http://www.javaeye.com/topic/470421

    sessions_controller.login
    ..
      User.authenticate(login, password)
    ..

   3. simple-navigation
   gem "simple-navigation"
   and run
   bundle install

   rails generate navigation_config

2010.12.05
----------

   1. cache
   production.rb文件中添加下面的代码：

config.action_controller.perform_caching = true
config.action_controller.cache_store = :file_store, RAILS_ROOT+"/tmp/cache/"
config.action_controller.page_cache_directory = RAILS_ROOT+"/public/cache/"

   然后在控制器中定义你要缓存的页面

caches_page :index, :help, :home, :faq
   这样就可以了， 下一次你不用请求rails服务器就能访问到这些页面了

   这只是一个基本用法， 更多信息请移步：
http://guides.rubyonrails.org/caching_with_rails.html

   --经试验
config.action_controller.cache_store = :file_store, RAILS_ROOT+"/tmp/cache/"
config.action_controller.page_cache_directory = RAILS_ROOT+"/public/cache/"
没效果,产生的文件一直放在public/下

   --总结,程序对关键数据少用cache,自定义APP_CACHE,通过程序来读写,另一类是rails设置的cache,
   通过development,production环境中设置,建议只对静态文件设置cache

   2. Users Delete 连接,页面必须增加
   <%= csrf_meta_tag %>,
   并且增加rails3其他js类库

2010.12.04
----------

   1. 教训,rails3中route采用restful,必须用
   resources :users
   以前参考sonar,用了resource :users,rake routes时,不显示index,并且edit路径为edit_users

   2. warble

   bundle unlock
   bundle install
   bundle update
   bundle lock

   warble config
   warble

   注意,bundle一般bundle install即可,Gemfile改动后才bundle update

2010.12.02
-----------

   1. haml
   ren _info.html.erb to _info.html.haml
   -- 参考 html2haml _info.html.erb

   2. multi database
   model:
   establish_connection "oracle_#{RAILS_ENV}"
   establish_connection :oracle_development

   3. ruby map(&:id)
   --http://stackoverflow.com/questions/1217088/what-does-mapname-mean-in-ruby
/* tags.map(&:name).join(' ') */
/* def tag_names */
/* @tag_names || tags.map { |tag| tag.name }.join(' ') */
/* end */

   4. symbol 操作
   include? 是否包含指定的symbol
   contact  连接指定的symbol

2010.11.30
-----------

   1. 数据导入、导出
   rake db:data dump
   rake db:data load

   2. 新增表 t_properties
   rails generate migration create_properties_table
   rake db:migrate
   --新增字段resource_id,重新做
   --rake db:migrate version=20101128123131

2010.11.28
-----------

   1. peepcode-code-review.pdf
   session in db
   # (create the session table with "rake db:sessions:create")
   Sill::Application.config.session_store :active_record_store

   自定义lib/tasks/sessions.rake
   两个任务,
   rake sessions:count
   rake sessions:prune RAILS_ENV=production

   2. add plugin :acts_as_tree

   https://github.com/parndt/acts_as_tree

   3. add group model
   rails generate migration create_group

2010.11.27
-----------

   1. jruby-memcache-client change to dalli

2010.11.22
-----------

   1. rails3 route
   match "/about" => "info#about", :as => :about
   没有:as参数，这个路由就是单纯的转向"/about", 加了:as 之后，在我们的应用里面可以使用about_path或者about_url

2010.11.20
-----------

   1. haml 掌握有难度,暂时用erb,参考images,javascripts,stylesheets

2010.11.15
-----------

   1. sqlite3 -line db/development.sqlite3
   会以比较优雅的格式显示查询

   2. haml form example
#login_format
  - form_tag session_path do
    %p= label_tag 'login'
    %br
    = text_field_tag 'login', @login
    %p= label_tag 'password'
    %br/
    = password_field_tag 'password', nil
    %p= label_tag 'remember_me', 'Remember me'
    = check_box_tag 'remember_me', '1', @remember_me
    %p= submit_tag 'Log in'

- form_tag('/') do
  - [1, 2, 3].each do |i|
    = check_box_tag "accept#{i}"
  = submit_tag

-- login
  %form{:controller =>'sessions',:action => 'login', :method =>"post", :html => "onsubmit$('commit').disabled = true"}
    .title= '::登录'
    .section
      .label= '登录名:'
      = text_field_tag :login
      .label= '密码:'
      = password_field_tag :password

    %div(style="margin-left:12px") #{check_box_tag(:remember_me)} #{'记忆密码'}
    %br
    .buttonbar
      = submit_tag ' 登录'

2010.11.14
-----------

   1. 格式化输出信息,ap,参考fat_crm,增加awesome_print
   https://github.com/michaeldv/awesome_print

2010.11.12
-----------

   1. rails new sill -T
   --跳过测试

   2. 产生第一个后台表
   rails generate migration create_user

   3. 增加git仓库 http://github.com/yangjiandong/sill

   git remote add origin git@github.com:yangjiandong/sill.git

   git push origin master:refs/heads/master

   $ ssh-keygen
    (ssh-keygen -C "你的email地址" -t rsa)
    Generating public/private rsa key pair.
    Enter file in which to save the key (/Users/schacon/.ssh/id_rsa):
    Enter passphrase (empty for no passphrase):
    Enter same passphrase again:
    Your identification has been saved in /Users/schacon/.ssh/id_rsa.
    Your public key has been saved in /Users/schacon/.ssh/id_rsa.pub.
    The key fingerprint is:
    43:c5:5b:5f:b1:f1:50:43:ad:20:a6:92:6a:1f:9a:3a schacon@agadorlaptop.local

   提交时，需将ssh-key 加到 github

   4. 参考 sonar 采用

   https://github.com/Satish/restful-authentication
   (https://github.com/technoweenie/restful-authentication)
   vendor/plugins/restful_authentication
   initializers/site_keys.rb

   5. 显示本地时间
   rake time:zones:local

   数据库:
config.active_record.default_timezone = :local
config.active_record.time_zone_aware_attributes = false
config.time_zone = nil

   --END
