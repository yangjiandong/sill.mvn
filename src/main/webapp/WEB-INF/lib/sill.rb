# require "sill/version"
# require "sill/core_ext"
# require "sill/callback"
require "authenticated_system"
require "need_authorization"
require "need_authentication"
#require "slf4j_logger"
require "debug_log"

      # ActionView::Base.send(:include, Sill::Callback::Helper)
# ActionController::Base.send(:include, Sill::Callback::Helper)

ActionController::Base.send(:include, DebugLog)
ActiveRecord::Base.send(:include, DebugLog)

