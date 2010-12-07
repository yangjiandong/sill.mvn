#
class GroupsController < ApplicationController

  SECTION=Navigation::SECTION_CONFIGURATION
  before_filter :admin_required

  def index
    @groups = Group.find(:all, :order => 'name')
    if params[:id]
      @group = Group.find(params[:id])
    else
      @group = Group.new
    end
  end
  
  def create
	  group = Group.new(params[:group])
	  if group.save
      flash[:notice] = 'Group is created.'
    end
    
	  to_index(group.errors, nil)
  end

  def update
    group = Group.find(params[:id])
    if group.update_attributes(params[:group])
      flash[:notice] = 'Group is updated.'
    end
	
    to_index(group.errors, nil)
  end

  def destroy
    group = Group.find(params[:id])
    if group.destroy
      flash[:notice] = 'Group is deleted.'
    end
	
    to_index(group.errors, nil)
  end
  
  def select_user
    @group = Group.find(params[:id])
  end
  
  def set_users
    @group = Group.find(params[:id])
    if  @group.set_users(params[:users])
      flash[:notice] = 'Group is updated.'
    end
  
    redirect_to(:action => 'index')
  end

  def to_index(errors, id)
    if !errors.empty?
      flash[:error] = errors.full_messages.join("<br/>\n")
    end

    redirect_to(:action => 'index', :id => id)
  end

end
