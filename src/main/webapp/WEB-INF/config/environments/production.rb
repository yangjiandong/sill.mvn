Sill::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # The production environment is meant for finished, "live" apps.
  # Code is not reloaded between requests
  config.cache_classes = true

  # dalli
  # config.cache_store = :dalli_store, '127.0.0.1:11211',
      # { :namespace => "NAME_OF_RAILS_APP", :expires_in => 1.day, :compress => true, :compress_threshold => 64*1024 }
  #config.cache_store = :file_store
  #, ::Rails.root.to_s + "/public/cache/"

  
  # http://blog.wpeterson.org/2010/11/23/cache-segmentation-for-rails-apps/
  # revision_file = Rails.root.join('REVISION')
  # Cache Segmentation for Rails Apps 
  # if File.exist?(revision_file)
    # revision = File.read(revision_file).match /[a-f,0-9]{6}$/
  # end
  # config.cache_store = :mem_cache_store, memcache_host, { :namespace => "volatile-#{ revision ? revision[0] : '0' }" }
  # config.action_controller.cache_store = :mem_cache_store, memcache_host, { :namespace => 'stable' }
  # end
 
  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # ActionController::Base.cache_store = :file_store, RAILS_ROOT+"/tmp/cache/"
  # config.action_controller.cache_store = :file_store, RAILS_ROOT+"/tmp/cache/"
  #config.action_controller.page_cache_directory = ::Rails.root_to_s +"/public/cache/"

  # Specifies the header that your server uses for sending files
  config.action_dispatch.x_sendfile_header = "X-Sendfile"

  # For nginx:
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect'

  # If you have no front-end server that supports something like X-Sendfile,
  # just comment this out and Rails will serve the files

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Disable Rails's static asset server
  # In production, Apache or nginx will already do this
  # 最好关掉,production 中会报找不到静态文件  ,如:No route matches "/javascripts/prototip.js"
  #config.serve_static_assets = false

  # Enable serving of images, stylesheets, and javascripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

# 参考sonar
#config.autoload_paths += %W( #{RAILS_ROOT} + "/lib" )
# config.load_paths += %W( #{RAILS_ROOT}/lib )

require File.dirname(__FILE__) + '/../../lib/slf4j_logger.rb'

config.logger = Slf4jLogger.new
ActiveRecord::Base.logger = config.logger

end
