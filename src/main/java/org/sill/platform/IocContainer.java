package org.sill.platform;

import org.picocontainer.Characteristics;
import org.picocontainer.DefaultPicoContainer;
import org.picocontainer.MutablePicoContainer;
import org.picocontainer.behaviors.OptInCaching;
import org.picocontainer.lifecycle.ReflectionLifecycleStrategy;
import org.picocontainer.monitors.NullComponentMonitor;


/**
 * Proxy to inject the container as a component$
 *
 * @since 1.10
 */
public class IocContainer {
  private final MutablePicoContainer pico;

  public IocContainer(MutablePicoContainer pico) {
    this.pico = pico;
  }

  public MutablePicoContainer getPicoContainer() {
    return pico;
  }

  public static MutablePicoContainer buildPicoContainer() {
    ReflectionLifecycleStrategy lifecycleStrategy = new ReflectionLifecycleStrategy(new
        NullComponentMonitor(), "start", "stop", "dispose");

    DefaultPicoContainer result = new DefaultPicoContainer(new OptInCaching(), lifecycleStrategy, null);
    result.as(Characteristics.CACHE).addComponent(new IocContainer(result)); // for components that directly inject other components (eg Plugins)
    return result;
  }
}
