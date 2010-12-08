package org.sill.charts.deprecated;

import org.junit.Test;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class SparkLinesChartTest extends BaseChartWebTest {

  @Test
  public void testSparkLinesChartDefaultDimensions() throws IOException {
    Map<String, String> params = getDefaultParams();
    SparkLinesChart chart = new SparkLinesChart(params);
    BufferedImage img = chart.getChartImage();
    saveChart(img, "sparklines-chart-default.png");
    assertChartSizeGreaterThan(img, 50);
  }

  @Test
  public void testSparklinesChartSpecificDimensions() throws IOException {
    Map<String, String> params = getDefaultParams();
    params.put(BaseChartWeb.CHART_PARAM_DIMENSIONS, "200x200");
    SparkLinesChart chart = new SparkLinesChart(params);
    BufferedImage img = chart.getChartImage();
    saveChart(img, "sparklines-chart-specific-dimensions.png");
    assertChartSizeGreaterThan(img, 50);
  }

  @Test
  public void testSparklinesChartOneValue() throws IOException {
    Map<String, String> params = getDefaultParams();
    params.put(BaseChartWeb.CHART_PARAM_VALUES, "100,100");
    SparkLinesChart chart = new SparkLinesChart(params);
    BufferedImage img = chart.getChartImage();
    saveChart(img, "sparklines-chart-one-value.png");
    assertChartSizeGreaterThan(img, 50);
  }

  @Test
  public void testSparklinesChartOthersColors() throws IOException {
    Map<String, String> params = getDefaultParams();
    params.put(BaseChartWeb.CHART_PARAM_COLORS, "9900FF");
    SparkLinesChart chart = new SparkLinesChart(params);
    BufferedImage img = chart.getChartImage();
    saveChart(img, "sparklines-chart-others-colors.png");
    assertChartSizeGreaterThan(img, 50);
  }

  @Test
  public void testSparklinesChartNullValues() throws IOException {
    Map<String, String> params = getDefaultParams();
    params.put(BaseChartWeb.CHART_PARAM_VALUES, null);
    SparkLinesChart chart = new SparkLinesChart(params);
    BufferedImage img = chart.getChartImage();
    saveChart(img, "sparklines-chart-null-values.png");
    assertChartSizeGreaterThan(img, 50);
  }

  @Test
  public void testSparklinesChartWrongValues() throws IOException {
    Map<String, String> params = getDefaultParams();
    params.put(BaseChartWeb.CHART_PARAM_VALUES, "wrong,value");
    SparkLinesChart chart = new SparkLinesChart(params);
    BufferedImage img = chart.getChartImage();
    saveChart(img, "sparklines-chart-wrong-values.png");
    assertChartSizeGreaterThan(img, 50);
  }

  @Test
  public void testSparklinesChartTitle() throws IOException {
    Map<String, String> params = getDefaultParams();
    params.put(BaseChartWeb.CHART_PARAM_TITLE, "JFreeChart by Servlet");
    params.put(BaseChartWeb.CHART_PARAM_DIMENSIONS, "200x200");
    SparkLinesChart chart = new SparkLinesChart(params);
    BufferedImage img = chart.getChartImage();
    saveChart(img, "sparklines-chart-title.png");
    assertChartSizeGreaterThan(img, 50);
  }

  @Test
  public void testSparklinesChartDates() throws IOException {
    Map<String, String> params = getDefaultParams();
    params.put(BaseChartWeb.CHART_PARAM_VALUES, "20080101,1,20080201,4,20080301,3,20080401,5,20080501,5,20080601,7,20080701,7,20080801,8");
    params.put(BaseChartWeb.CHART_PARAM_DIMENSIONS, "200x200");
    SparkLinesChart chart = new SparkLinesChart(params);
    BufferedImage img = chart.getChartImage();
    saveChart(img, "sparklines-chart-dates.png");
    assertChartSizeGreaterThan(img, 50);
  }

  private Map<String, String> getDefaultParams() {
    Map<String, String> params = new HashMap<String, String>();
    params.put(BaseChartWeb.CHART_PARAM_TYPE, BaseChartWeb.SPARKLINES_CHART);
    params.put(BaseChartWeb.CHART_PARAM_VALUES, "1,1,2,4,3,3,4,5,5,5,6,7,7,7,8,8");
    return params;
  }

}