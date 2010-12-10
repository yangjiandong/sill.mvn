package org.sill.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Predefined SLF4j loggers
 *
 * 可直接用的log,一般用于提示信息,级别为info
 * Logs.INFO.info("Embedded database started. Data stored in: " + dbHome.getAbsolutePath());
 */
public final class Logs {

  private Logs() {
  }

  /**
   * This logger is always activated with level INFO
   */
  public static final Logger INFO = LoggerFactory.getLogger("org.sill.INFO");
}
