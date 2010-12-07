#
# Use Sonar database (table USERS) to authenticate users.
# 将认证部分从User 中分离
#
class DefaultAuthenticator
  def authenticate?(login, password)
    return false if login.blank? || password.blank?
    user=User.find_by_login(login)
    user && user.authenticated?(password)
  end

  def editable_password?
    true
  end
end

#
# Load the authentication system to use. The server must be restarted when configuration is changed.
#
class AuthenticatorFactory
  @@authenticator = nil

  def self.authenticator
    if @@authenticator.nil?
      @@authenticator= DefaultAuthenticator.new
    end
    @@authenticator
  end
end


module NeedAuthentication

  # ForUser module is included by the class User. It redirects authentication to the selected Authenticator.
  module ForUser

    # Stuff directives into including module
    # http://www.javaeye.com/topic/470421 
    # 扩展类方法
    def self.included(recipient)
      recipient.extend(ModelClassMethods)
    end

    module ModelClassMethods
      # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
      #
      # uff.  this is really an authorization, not authentication routine.
      # We really need a Dispatch Chain here or something.
      # This will also let us return a human error message.
      #
      def authenticate(login, password)
        return nil if login.blank?
        return nil if !AuthenticatorFactory.authenticator.authenticate?(login, password)
        user = User.find_by_login(login)

        # Automatically create a user in the sonar db if authentication has been successfully done
        #java_facade = Java::OrgSonarServerUi::JRubyFacade.new
        #create_user = java_facade.getConfigurationValue('sonar.authenticator.createUsers');
        create_user = "false"
        # 可自动新建用户
        if !user && create_user=='true'
          user=User.new(:login => login, :name => login, :email => '', :password => password, :password_confirmation => password)
          user.save!

          # default_group_name = java_facade.getConfigurationValue('sonar.defaultGroup') || 'sonar-users';
          default_group_name = 'users'
          default_group=Group.find_by_name(default_group_name)
          if default_group
            user.groups<<default_group
            user.save
          else
            logger.error("The default user group does not exist: #{default_group_name}. Please check the parameter 'Default user group' in general settings.")
          end
        end

        user
      end

      def editable_password?
        AuthenticatorFactory.authenticator.editable_password?
      end
    end
  end
end
