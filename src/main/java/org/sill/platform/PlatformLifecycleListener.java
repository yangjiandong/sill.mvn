package org.sill.platform;

import org.apache.commons.configuration.Configuration;
import org.apache.commons.lang.StringUtils;
import org.jruby.rack.rails.RailsServletContextListener;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;

public final class PlatformLifecycleListener extends RailsServletContextListener {

  private static final Logger LOG = LoggerFactory.getLogger(PlatformLifecycleListener.class);

  @Override
  public void contextInitialized(ServletContextEvent event) {
    Configuration configuration = new ConfigurationFactory().getConfiguration(event);
    Platform.getInstance().init(configuration);
    Platform.getInstance().start();

    Enumeration parameters =  event.getServletContext().getInitParameterNames();

    while(parameters.hasMoreElements()){
       String name =  (String) parameters.nextElement();

       if (StringUtils.equals("rails.env", name)){
           if (LOG.isDebugEnabled()) {
             LOG.debug("rails.env to {}", event.getServletContext().getInitParameter(name));
           }
           LOG.info("rails.env to {}", event.getServletContext().getInitParameter(name));
       }
    }

    ServletContextHandler handler = new ServletContextHandler(event.getServletContext(), configuration);
    ServletContext ctxProxy = (ServletContext) Proxy.newProxyInstance(getClass().getClassLoader(),
        new Class[]{ServletContext.class}, handler);
    super.contextInitialized(new ServletContextEvent(ctxProxy));
  }

  @Override
  public void contextDestroyed(ServletContextEvent event) {
    Platform.getInstance().stop();
    super.contextDestroyed(event);
  }

  private static final class ServletContextHandler implements InvocationHandler {

    private ServletContext context;
    //private String runtimeMode;

    private ServletContextHandler(ServletContext context, Configuration config) {
      this.context = context;
      //runtimeMode = config.getString("sonar.runtime.mode", "production");
    }

    public Object invoke(Object proxy, Method method, Object[] args) throws InvocationTargetException, IllegalAccessException {
      Object value = method.invoke(context, args);
      if (StringUtils.equals("getInitParameter", method.getName())) {
        String attrName = (String) args[0];
        if (LOG.isDebugEnabled()) {
          LOG.debug("Ctx init param {}={}", attrName, value);
        }
        //直接在web.xml 中定义rails.env
//        if (StringUtils.equals("rails.env", attrName)) {
//          if (LOG.isDebugEnabled()) {
//            LOG.debug("Override rails.env to {}", runtimeMode);
//          }
//          LOG.info("Runtime mode set to {}", runtimeMode);
//          return runtimeMode;
//        }
      }
      return value;
    }
  }

}
