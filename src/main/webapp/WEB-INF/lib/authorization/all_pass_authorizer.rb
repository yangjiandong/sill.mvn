#

class SonarAuthorizer
  def has_role?(user, role)
    true
  end
  
  def has_role_for_resources?(user, role, resource_ids)
    resource_ids.map{|rid| true}
  end

  def on_logout(user)

  end
end
