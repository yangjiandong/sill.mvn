package org.sill.platform;

import java.io.File;
import java.util.HashMap;

import org.apache.commons.configuration.*;
import org.apache.commons.configuration.interpol.ConfigurationInterpolator;
import org.apache.commons.lang.text.StrLookup;

import javax.servlet.ServletContextEvent;
import java.io.File;
import java.util.HashMap;

public final class ConfigurationFactory {

    public ConfigurationFactory() {
        allowUsingEnvironmentVariables();
    }

    public Configuration getConfiguration(ServletContextEvent sce) {
        CoreConfiguration configuration = new CoreConfiguration();
        // 装载conf/sill.properties 文件
        configuration.addConfiguration(getConfigurationFromPropertiesFile(sce));
        configuration.addConfiguration(new SystemConfiguration());
        configuration.addConfiguration(new EnvironmentConfiguration());
        configuration.addConfiguration(getDirectoriesConfiguration(sce));
        return configuration;
    }

    private void allowUsingEnvironmentVariables() {
        ConfigurationInterpolator.registerGlobalLookup("env", new StrLookup() {
            @Override
            public String lookup(String varName) {
                return System.getenv(varName);
            }
        });
    }

    private Configuration getDirectoriesConfiguration(ServletContextEvent sce) {
        MapConfiguration result = new MapConfiguration(new HashMap());
        String webAppDir = autodetectWebappDeployDirectory(sce);
        // result.setProperty(CoreConfiguration.DEPLOY_DIR, webAppDir);
        return result;
    }

    protected PropertiesConfiguration getConfigurationFromPropertiesFile(
            String filename) throws ConfigurationException {
        try {
            return new PropertiesConfiguration(filename);

                    //ConfigurationFactory.class.getResource(filename));

        } catch (org.apache.commons.configuration.ConfigurationException e) {
            throw new ConfigurationException("can not load the file "
                    + filename + " from classpath", e);
        }
    }

    public PropertiesConfiguration getConfigurationFromPropertiesFile(ServletContextEvent sce)
            throws ConfigurationException {
        String webAppPublicDirPath = sce.getServletContext().getRealPath(
        "/conf");

        return getConfigurationFromPropertiesFile(webAppPublicDirPath+"/sill.properties");
    }

    protected String autodetectWebappDeployDirectory(ServletContextEvent sce) {
        String webAppPublicDirPath = sce.getServletContext().getRealPath(
                "/deploy/");
        if (webAppPublicDirPath == null) {
            throw new ConfigurationException(
                    "Web app directory not found : /deploy/");
        }
        File file = new File(webAppPublicDirPath);
        if (!file.exists()) {
            throw new ConfigurationException("Web app directory not found : "
                    + file);
        }
        return file.toString();
    }

}
