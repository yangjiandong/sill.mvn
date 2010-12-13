class PropertyClassesController < ApplicationController

  respond_to :json

  def index
    @property_classes = PropertyClass.all
    respond_with(@property_classes)
  end

  def new
  end

  def edit
  end

  def create
    @property_class = PropertyClass.new(ActiveSupport::JSON.decode(params[:data]))
    if @property_class.save
      render :json => { :success => true, :message => "Created new property class #{@property_class.id}", \
                        :data => @property_class }
    else
      render :json => { :message => "Failed to create new property class"}
    end
  end

  def show
    @property_class = PropertyClass.find(params[:id])
    respond_with(@property_class)
  end

  def update
    @property_class = PropertyClass.find(params[:id])
    if @property_class.update_attributes(ActiveSupport::JSON.decode(params[:data]))
      render :json => { :success => true, :message => "Updated property class #{@property_class.id}", \
                        :data => @property_class }
    else
      render :json => { :message => "Failed to update property class"}
    end
  end

  def delete
    @property_class = PropertyClass.find(params[:id])
    if @property_class.destroy
      render :json => { :success => true, :message => "Deleted property class #{@property_class.id}" }
    else
      render :json => { :message => "Failed to delete property class" }
    end
  end

end