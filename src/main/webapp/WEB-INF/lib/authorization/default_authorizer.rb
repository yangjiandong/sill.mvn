#
#授权

class SonarAuthorizer

  def has_role?(user, role)
    # Rails.logger.info role
    gs = global_roles(user)

    # Rails.logger.info gs
    gs.include?(role)
  end

  # 只对用户组判断
  # role --> group
  def has_role_for_resources?(user, role, resource_ids)
    return [] if resource_ids.empty?

    compacted_resource_ids=resource_ids.compact
    group_ids=user.groups.map(&:id)

    # Oracle is limited to 1000 elements in clause "IN"
    page_size=950
    page_count=(compacted_resource_ids.size/page_size)
    page_count+=1 if (compacted_resource_ids.size % page_size)>0

    group_roles=[]
    if group_ids.empty?
      # Derby bug: does not support empty IN
      page_count.times do |page_index|
        page_rids=compacted_resource_ids[page_index*page_size...(page_index+1)*page_size]
        group_roles.concat(GroupRole.find(:all, 
                                          :select => 'resource_id', 
                                          :conditions => ["resource_id in(?) and role=? and group_id is null", 
                                            page_rids, 
                                            role.to_s]))
      end
    else
      page_count.times do |page_index|
        page_rids=compacted_resource_ids[page_index*page_size...(page_index+1)*page_size]
        group_roles.concat(GroupRole.find(:all, 
                                          :select => 'resource_id', 
                                          :conditions => ["resource_id in (?) and (group_id is null or group_id in(?))", 
                                            page_rids, group_ids]))
      end
    end

    user_roles=[]
    if user.id
      page_count.times do |page_index|
        page_rids=compacted_resource_ids[page_index*page_size...(page_index+1)*page_size]
        user_roles.concat(UserRole.find(:all, 
                                        :select => 'resource_id', 
                                        :conditions => ['user_id=? and resource_id in(?) and role=?', user.id, page_rids, role.to_s]))
      end
    end

    autorized_resource_ids={}
    (group_roles.concat(user_roles)).each do |x|
      autorized_resource_ids[x.resource_id]=true
    end

    result=Array.new(resource_ids.size)
    resource_ids.each_with_index do |rid,index|
      result[index]=((autorized_resource_ids[rid]) || false)
    end
    result
  end

  # old
  def has_role_for_resources_old?(user, role, resource_ids)
    return [] if resource_ids.empty?

    compacted_resource_ids=resource_ids.compact
    group_ids=user.groups.map(&:id)

    # Oracle is limited to 1000 elements in clause "IN"
    page_size=950
    page_count=(compacted_resource_ids.size/page_size)
    page_count+=1 if (compacted_resource_ids.size % page_size)>0

    group_roles=[]
    if group_ids.empty?
      # Derby bug: does not support empty IN
      page_count.times do |page_index|
        page_rids=compacted_resource_ids[page_index*page_size...(page_index+1)*page_size]
        group_roles.concat(GroupRole.find(:all, :select => 'resource_id', :conditions => ["resource_id in(?) and role=? and group_id is null", page_rids, role.to_s]))
      end
    else
      page_count.times do |page_index|
        page_rids=compacted_resource_ids[page_index*page_size...(page_index+1)*page_size]
        group_roles.concat(GroupRole.find(:all, :select => 'resource_id', :conditions => ["resource_id in (?) and role=? and (group_id is null or group_id in(?))", page_rids, role.to_s, group_ids]))
      end
    end

    user_roles=[]
    if user.id
      page_count.times do |page_index|
        page_rids=compacted_resource_ids[page_index*page_size...(page_index+1)*page_size]
        user_roles.concat(UserRole.find(:all, :select => 'resource_id', :conditions => ['user_id=? and resource_id in(?) and role=?', user.id, page_rids, role.to_s]))
      end
    end

    autorized_resource_ids={}
    (group_roles.concat(user_roles)).each do |x|
      autorized_resource_ids[x.resource_id]=true
    end

    result=Array.new(resource_ids.size)
    resource_ids.each_with_index do |rid,index|
      result[index]=((autorized_resource_ids[rid]) || false)
    end
    result
  end

  def on_logout(user)
    # nothing
  end

  private

  # 取出用户角色,group.name 转换成symbol
  def global_roles(user)
    group_ids=user.groups.map(&:id)

    global_groups=Group.find(:all, 
                             :select => 'name', 
                             :conditions => ["id in(?)", group_ids]).map{|gr| gr.name.to_sym}
    # Rails.logger.info global_groups
    global_groups
    # if group_ids.empty?
      # # Derby bug: does not support empty IN
      # global_group_roles=GroupRole.find(:all, :select => 'role', :conditions => ["resource_id is null and group_id is null"]).map{|gr| gr.role.to_sym}
    # else
      # global_group_roles=GroupRole.find(:all, :select => 'role', :conditions => ["resource_id is null and (group_id is null or group_id in(?))", group_ids]).map{|gr| gr.role.to_sym}
    # end
    # global_user_roles=user.user_roles.select{|ur| ur.resource_id.nil?}.map{|ur| ur.role.to_sym}

    # global_roles=(global_group_roles.concat(global_user_roles))
    # global_roles
  end
  
end
