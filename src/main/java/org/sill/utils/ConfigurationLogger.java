package org.sill.utils;

import org.apache.commons.configuration.Configuration;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Iterator;

public final class ConfigurationLogger {

  private ConfigurationLogger() {
    // only static methods
  }

  public static void log(Configuration configuration) {
    Logger log = LoggerFactory.getLogger(ConfigurationLogger.class);
    if (log.isDebugEnabled()) {
      Iterator<String> keys = configuration.getKeys();
      while (keys.hasNext()) {
        String key = keys.next();
        String property = getTruncatedProperty(configuration, key);
        log.debug("Property: " + key + " is: '" + property + "'");
      }
    }
  }

  static String getTruncatedProperty(Configuration configuration, String key) {
    String property = StringUtils.join(configuration.getStringArray(key), ",");
    return StringUtils.abbreviate(property, 100);
  }

}
