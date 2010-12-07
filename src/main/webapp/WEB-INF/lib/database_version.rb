#
# 参考 Sonar
#

require 'java'

class DatabaseVersion

  class DeprecatedSchemaInfo < ActiveRecord::Base
    set_table_name 'schema_migrations'
  end

  def self.current_version
    result=0
    begin
      result=ActiveRecord::Migrator.current_version
    rescue
    end

    if result==0
      begin
        result=DeprecatedSchemaInfo.find(:first).version
      rescue
      end
    end
    result
  end

  # 列出升级文件,取出最大标示
  def self.target_version
    files = Dir["#{migrations_path}/[0-9]*_*.rb"].sort
    files.last.scan(/([0-9]+)_[_a-z0-9]*.rb/).first[0].to_i
  end

  def self.migrations_path
    File.dirname(__FILE__).to_s + "/../db/migrate/"
  end

  $uptodate = false

  def self.uptodate?
    unless $uptodate
      $uptodate = (current_version>=target_version)
    end
    $uptodate
  end

  def self.setup
    ActiveRecord::Migrator.migrate(migrations_path)
#    Java::OrgSonarServerPlatform::Platform.getInstance().start()
#    load_plugin_webservices()
  end

#  def self.load_plugin_webservices
#    ActionController::Routing::Routes.load_sonar_plugins_routes
#  end

  def self.automatic_setup
    if current_version<=0
      setup
    end
#    if uptodate?
#      load_plugin_webservices()
#    end
    uptodate?
  end

  def self.connected?
    ActiveRecord::Base.connected?
  end
end
