package org.sill.charts.plugin;

import java.awt.image.BufferedImage;
import java.io.IOException;

import org.junit.Test;
import org.sill.charts.ChartParameters;

public class DistributionBarChartTest extends AbstractChartTest {

  @Test
  public void simpleSample() throws IOException {
    DistributionBarChart chart = new DistributionBarChart();
    BufferedImage image = chart.generateImage(new ChartParameters("v=0%3D5%3B1%3D22%3B2%3D2"));
    assertChartSizeGreaterThan(image, 1000);
    saveChart(image, "DistributionBarChartTest/simpleSample.png");
  }

  @Test
  public void addXSuffix() throws IOException {
    DistributionBarChart chart = new DistributionBarChart();
    // should suffix x labels with +
    BufferedImage image = chart.generateImage(new ChartParameters("v=0%3D5%3B1%3D22%3B2%3D2&xsuf=%2B"));
    assertChartSizeGreaterThan(image, 1000);
    saveChart(image, "DistributionBarChartTest/addXSuffix.png");
  }

  @Test
  public void addYSuffix() throws IOException {
    DistributionBarChart chart = new DistributionBarChart();
    // should suffix y labels with %
    BufferedImage image = chart.generateImage(new ChartParameters("v=0%3D5%3B1%3D22%3B2%3D2&ysuf=%25"));
    assertChartSizeGreaterThan(image, 1000);
    saveChart(image, "DistributionBarChartTest/addYSuffix.png");
  }

  @Test
  public void manySeries() throws IOException {
    DistributionBarChart chart = new DistributionBarChart();
    BufferedImage image = chart.generateImage(new ChartParameters("v=0%3D5%3B1%3D22%3B2%3D2|0%3D7%3B1%3D15%3B2%3D4"));
    assertChartSizeGreaterThan(image, 1000);
    saveChart(image, "DistributionBarChartTest/manySeries.png");
  }

  @Test
  public void manySeriesIncludingAnEmptySerie() throws IOException {
    DistributionBarChart chart = new DistributionBarChart();
    // the third serie should not have the second default color, but the third one !
    BufferedImage image = chart.generateImage(new ChartParameters("v=0%3D5%3B1%3D22%3B2%3D2||0%3D7%3B1%3D15%3B2%3D4"));
    assertChartSizeGreaterThan(image, 1000);
    saveChart(image, "DistributionBarChartTest/manySeriesIncludingAnEmptySerie.png");
  }

  @Test
  public void overridenSize() throws IOException {
    DistributionBarChart chart = new DistributionBarChart();
    BufferedImage image = chart.generateImage(new ChartParameters("v=0%3D5%3B1%3D22%3B2%3D2|0%3D7%3B1%3D15%3B2%3D4&w=500&h=200"));
    assertChartSizeGreaterThan(image, 1000);
    saveChart(image, "DistributionBarChartTest/overridenSize.png");
  }

  @Test
  public void changeColor() throws IOException {
    DistributionBarChart chart = new DistributionBarChart();
    BufferedImage image = chart.generateImage(new ChartParameters("v=0%3D5%3B1%3D22%3B2%3D2&c=777777&bgc=777777"));
    assertChartSizeGreaterThan(image, 1000);
    saveChart(image, "DistributionBarChartTest/changeColor.png");
  }

  @Test
  public void smallSize() throws IOException {
    DistributionBarChart chart = new DistributionBarChart();
    BufferedImage image = chart.generateImage(new ChartParameters("v=0%3D5%3B1%3D22%3B2%3D2%3B4%3D22%3B5%3D22%3B6%3D22&c=777777&w=120&h=80&fs=8"));
    assertChartSizeGreaterThan(image, 500);
    saveChart(image, "DistributionBarChartTest/smallSize.png");
  }
}
