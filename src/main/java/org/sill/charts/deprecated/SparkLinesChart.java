package org.sill.charts.deprecated;

import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.DateAxis;
import org.jfree.chart.axis.DateTickUnit;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.plot.XYPlot;
import org.jfree.chart.renderer.xy.StandardXYItemRenderer;
import org.jfree.chart.title.TextTitle;
import org.jfree.data.xy.XYSeries;
import org.jfree.data.xy.XYSeriesCollection;
import org.jfree.ui.RectangleInsets;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Map;
import java.util.StringTokenizer;

public class SparkLinesChart extends BaseChartWeb implements DeprecatedChart {

  private XYSeriesCollection dataset = null;
  private DateAxis x = null;
  private NumberAxis y = null;
  private StandardXYItemRenderer renderer = null;

  public SparkLinesChart(Map<String, String> params) {
    super(params);
    jfreechart = new JFreeChart(null, TextTitle.DEFAULT_FONT, new XYPlot(), false);
  }

  @Override
  protected BufferedImage getChartImage() throws IOException {
    configure();
    return getBufferedImage(jfreechart);
  }

  private void configure() {
    configureChart(jfreechart, false);
    configureXAxis();
    configureYAxis();
    configureRenderer();
    configureDataset();
    configurePlot();
    applyParams();
  }

  private void configureRenderer() {
    renderer = new StandardXYItemRenderer(StandardXYItemRenderer.LINES);
  }

  private void configureYAxis() {
    y = new NumberAxis();
    y.setTickLabelsVisible(false);
    y.setTickMarksVisible(false);
    y.setAxisLineVisible(false);
    y.setNegativeArrowVisible(false);
    y.setPositiveArrowVisible(false);
    y.setVisible(false);
  }

  private void configureXAxis() {
    x = new DateAxis();
    x.setTickUnit(new DateTickUnit(DateTickUnit.MONTH, 1));
    x.setTickLabelsVisible(false);
    x.setTickMarksVisible(false);
    x.setAxisLineVisible(false);
    x.setNegativeArrowVisible(false);
    x.setPositiveArrowVisible(false);
    x.setVisible(false);
  }

  private void configureDataset() {
    dataset = new XYSeriesCollection();
  }

  private void configurePlot() {
    XYPlot plot = (XYPlot) jfreechart.getPlot();
    plot.setInsets(RectangleInsets.ZERO_INSETS);
    plot.setDataset(dataset);
    plot.setDomainAxis(x);
    plot.setDomainGridlinesVisible(false);
    plot.setDomainCrosshairVisible(false);
    plot.setRangeGridlinesVisible(false);
    plot.setRangeCrosshairVisible(false);
    plot.setRangeAxis(y);
    plot.setRenderer(renderer);
    plot.setBackgroundAlpha(0.0f);
  }

  private void applyParams() {
    applyCommonParams();

    configureColors(params.get(CHART_PARAM_COLORS), renderer);
    addMeasures(params.get(CHART_PARAM_VALUES));

    // -- Plot
    XYPlot plot = (XYPlot) jfreechart.getPlot();
    plot.setOutlineVisible(isParamValueValid(params.get(CHART_PARAM_OUTLINE_VISIBLE)) && Boolean.getBoolean(params.get(CHART_PARAM_OUTLINE_VISIBLE)));
  }

  private void addMeasures(String values) {
    double min = Double.MAX_VALUE;
    double max = Double.MIN_VALUE;
    XYSeries series1 = new XYSeries("");
    if (values != null && values.length() > 0) {
      StringTokenizer st = new StringTokenizer(values, ",");
      while (st.hasMoreTokens()) {
        double v_x = convertParamToDouble(st.nextToken());
        double v_y = 0.0;
        if (st.hasMoreTokens()) {
          v_y = convertParamToDouble(st.nextToken());
        }
        series1.add(v_x, v_y);

        min = (v_y < min ? v_y : min);
        max = (v_y > max ? v_y : max);
      }
      dataset.addSeries(series1);
      y.setRange(min-1, max+1);
    }
  }

}