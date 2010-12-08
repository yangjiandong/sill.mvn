package org.sill.charts.deprecated;

import org.junit.Test;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class PieChartTest extends BaseChartWebTest {

  @Test
  public void testPieChartDefaultDimensions() throws IOException {
    Map<String, String> params = getDefaultParams();
    PieChart chart = new PieChart(params);
    BufferedImage img = chart.getChartImage();
    saveChart(img, "pie-chart-default.png");
    assertChartSizeGreaterThan(img, 50);
  }

  @Test
  public void testPieChartSpecificDimensions() throws IOException {
    Map<String, String> params = getDefaultParams();
    params.put(BaseChartWeb.CHART_PARAM_DIMENSIONS, "200x200");
    PieChart chart = new PieChart(params);
    BufferedImage img = chart.getChartImage();
    saveChart(img, "pie-chart-specific-dimensions.png");
    assertChartSizeGreaterThan(img, 50);
  }

  @Test
  public void testPieChartOneValue() throws IOException {
    Map<String, String> params = getDefaultParams();
    params.put(BaseChartWeb.CHART_PARAM_VALUES, "100");
    PieChart chart = new PieChart(params);
    BufferedImage img = chart.getChartImage();
    saveChart(img, "pie-chart-one-value.png");
    assertChartSizeGreaterThan(img, 50);
  }

  @Test
  public void testPieChartOthersColors() throws IOException {
    Map<String, String> params = getDefaultParams();
    params.put(BaseChartWeb.CHART_PARAM_COLORS, "FFFF00,9900FF");
    PieChart chart = new PieChart(params);
    BufferedImage img = chart.getChartImage();
    saveChart(img, "pie-chart-others-colors.png");
    assertChartSizeGreaterThan(img, 50);
  }

  @Test
  public void testPieChartNullValues() throws IOException {
    Map<String, String> params = getDefaultParams();
    params.put(BaseChartWeb.CHART_PARAM_VALUES, null);
    PieChart chart = new PieChart(params);
    BufferedImage img = chart.getChartImage();
    saveChart(img, "pie-chart-null-values.png");
    assertChartSizeGreaterThan(img, 50);
  }

  @Test
  public void testPieChartWrongValues() throws IOException {
    Map<String, String> params = getDefaultParams();
    params.put(BaseChartWeb.CHART_PARAM_VALUES, "wrong,value");
    PieChart chart = new PieChart(params);
    BufferedImage img = chart.getChartImage();
    saveChart(img, "pie-chart-wrong-values.png");
    assertChartSizeGreaterThan(img, 50);
  }

  @Test
  public void testPieChartTitle() throws IOException {
    Map<String, String> params = getDefaultParams();
    params.put(BaseChartWeb.CHART_PARAM_TITLE, "JFreeChart by Servlet");
    params.put(BaseChartWeb.CHART_PARAM_DIMENSIONS, "200x200");
    PieChart chart = new PieChart(params);
    BufferedImage img = chart.getChartImage();
    saveChart(img, "pie-chart-title.png");
    assertChartSizeGreaterThan(img, 50);
  }

  private Map<String, String> getDefaultParams() {
    Map<String, String> params = new HashMap<String, String>();
    params.put(BaseChartWeb.CHART_PARAM_TYPE, BaseChartWeb.PIE_CHART);
    params.put(BaseChartWeb.CHART_PARAM_VALUES, "100,50");
    params.put(BaseChartWeb.CHART_PARAM_DIMENSIONS, "50x50");
    return params;
  }

}