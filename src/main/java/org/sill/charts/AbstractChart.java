package org.sill.charts;

import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.Plot;
import org.jfree.chart.renderer.AbstractRenderer;
import org.jfree.chart.title.TextTitle;
import org.jfree.data.Values2D;

import java.awt.*;
import java.awt.image.BufferedImage;

/**
 * An extension point to generate JFreeChart charts
 * @since 1.10
 */
public abstract class AbstractChart implements Chart {

  public static final int FONT_SIZE = 13;
  public static final Color OUTLINE_COLOR = new Color(51, 51, 51);
  public static final Color GRID_COLOR = new Color(204, 204, 204);
  public static final Color[] COLORS = new Color[]{Color.decode("#4192D9"), Color.decode("#800000"), Color.decode("#A7B307"), Color.decode("#913C9F"), Color.decode("#329F4D")};


  protected abstract Plot getPlot(ChartParameters params);

  protected boolean hasLegend() {
    return false;
  }

  /**
   * Generates a JFreeChart chart using a set of parameters
   *
   * @param params the chart parameters
   * @return the generated chart
   */
  public BufferedImage generateImage(ChartParameters params) {
    JFreeChart chart = new JFreeChart(null, TextTitle.DEFAULT_FONT, getPlot(params), hasLegend());
    improveChart(chart, params);
    return chart.createBufferedImage(params.getWidth(), params.getHeight());
  }

  private void improveChart(JFreeChart jfrechart, ChartParameters params) {
    Color background = Color.decode("#" + params.getValue(ChartParameters.PARAM_BACKGROUND_COLOR, "FFFFFF", false));
    jfrechart.setBackgroundPaint(background);

    jfrechart.setBorderVisible(false);
    jfrechart.setAntiAlias(true);
    jfrechart.setTextAntiAlias(true);
    jfrechart.removeLegend();
  }

  @Override
  public String toString() {
    return getKey();
  }


  /**
   * Helper to set color of series. If the parameter colorsHex is null, then default Sonar colors are used.
   */
  protected void configureColors(Values2D dataset, CategoryPlot plot, String[] colorsHex) {
    Color[] colors = COLORS;
    if (colorsHex != null && colorsHex.length > 0) {
      colors = new Color[colorsHex.length];
      for (int i = 0; i < colorsHex.length; i++) {
        colors[i] = Color.decode("#" + colorsHex[i]);
      }
    }

    dataset.getColumnCount();
    AbstractRenderer renderer = (AbstractRenderer) plot.getRenderer();
    for (int i = 0; i < dataset.getColumnCount(); i++) {
      renderer.setSeriesPaint(i, colors[i % colors.length]);

    }
  }
}
