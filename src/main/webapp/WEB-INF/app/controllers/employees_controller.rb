# extjs json
class EmployeesController < ApplicationController

  def index
    start = (params[:start] || 0).to_i
    size = (params[:limit] || 20).to_i
    page = ((start/size).to_i) + 1
    sort = "#{params[:sort]} #{params[:dir]}" || "id asc"

    @employees = Employee.find(:all,
                               :page => page,
                               :per_page => size,
                               :order => sort
    )

    rtndata = {}
    rtndata[:total] = @employees.total_entries
    rtndata[:employees] = @employees.collect {|e| {
        :id => e.id,
        :last_name => e.last_name,
        :first_name => e.first_name,
        :department => e.department,
        :designation => e.designation
      }}

    respond_to do |format|
      format.json { render :json => rtndata.to_json }
    end
  end

end