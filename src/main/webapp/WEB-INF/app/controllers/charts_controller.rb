# charts

class ChartsController < ApplicationController

  DEFAULT_TRENDS_WIDTH = 700
  DEFAULT_TRENDS_HEIGHT = 250

  CHART_COLORS = ["4192D9", "800000", "A7B307", "913C9F", "329F4D"]

  def trends
    resource=Project.by_key(params[:id])
    return access_denied unless has_role?(:user, resource)


    metric_keys=params[:metrics]
    metrics=[]
    if metric_keys
      metric_keys.split(',').each do |key|
        metrics<<Metric.by_key(key)
      end
    end
    unless metrics.empty?
      width=(params[:w] ? params[:w].to_i :  DEFAULT_TRENDS_WIDTH)
      height=(params[:h] ? params[:h].to_i :  DEFAULT_TRENDS_HEIGHT)
      display_legend = (params[:legend] ? params[:legend]=='true' : true)

      stream = TrendsChart.png_chart(width, height, resource, metrics, params[:sids], params[:locale] || I18n.locale, display_legend)
      send_data stream, :type => 'image/png', :disposition => 'inline'
    end
  end
end
