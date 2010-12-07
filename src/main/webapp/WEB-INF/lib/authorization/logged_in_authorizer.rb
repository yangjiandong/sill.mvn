#

class SonarAuthorizer

  def has_role?(user, role)
    !user.id.nil?
  end

  def has_role_for_resources?(user, role, resource_ids)
    authorized=has_role?(user, role)
    resource_ids.map{|rid| authorized}
  end

  def on_logout(user)

  end
end
