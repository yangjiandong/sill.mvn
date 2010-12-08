package org.sill.platform;

import org.apache.commons.configuration.CompositeConfiguration;

public class CoreConfiguration extends CompositeConfiguration {
  public static final String DEPLOY_DIR = "sonar.web.deployDir";

//  public DatabaseConfiguration getDatabaseConfiguration() {
//    int total = getNumberOfConfigurations();
//    for (int i = 0; i < total; i++) {
//      if (getConfiguration(i) instanceof DatabaseConfiguration) {
//        return (DatabaseConfiguration) getConfiguration(i);
//      }
//    }
//    return null;
//  }
//
//  public void reload() {
//    DatabaseConfiguration dbConfig = getDatabaseConfiguration();
//    if (dbConfig != null) {
//      dbConfig.load();
//    }
//  }
}
