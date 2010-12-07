require File.expand_path('../active_record/acts/tree', __FILE__)
ActiveRecord::Base.send :include, ActiveRecord::Acts::Tree
