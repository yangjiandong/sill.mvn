package org.sill.platform;

import org.apache.commons.configuration.Configuration;
import org.picocontainer.Characteristics;
import org.picocontainer.MutablePicoContainer;
import org.sill.charts.ChartFactory;
import org.sill.utils.ConfigurationLogger;
import org.sill.utils.TimeProfiler;
import org.slf4j.LoggerFactory;

/**
 * 参考 @since 2.2
 */
public final class Platform {

  private static final Platform INSTANCE = new Platform();

  private MutablePicoContainer rootContainer;//level 1 : only database connectors
  private MutablePicoContainer coreContainer;//level 2 : level 1 + core components
  private MutablePicoContainer servicesContainer;//level 3 : level 2 + plugin extensions + core components that depend on plugin extensions

  private boolean connected = false;
  private boolean started = false;

  public static Platform getInstance() {
    return INSTANCE;
  }

  private Platform() {
  }

  public void init(Configuration conf) {
    if (!connected) {
      try {
        startDatabaseConnectors(conf);
        connected = true;

      } catch (Exception e) {
        LoggerFactory.getLogger(getClass()).error("Can not start Sill Server", e);
      }
    }

    //LoggerFactory.getLogger(getClass()).info("start sill platform...");
  }

  public void start() {
    if (!started
            //&& isConnectedToDatabase()
            ) {
      TimeProfiler profiler = new TimeProfiler().start("Start services");
      startCoreComponents();
      startServiceComponents();
      executeStartupTasks();
      started = true;
      profiler.stop();
    }
  }

  private void startDatabaseConnectors(Configuration configuration) {
    //生成容器
    rootContainer = IocContainer.buildPicoContainer();
    ConfigurationLogger.log(configuration);

    rootContainer.as(Characteristics.CACHE).addComponent(configuration);
//    //嵌入式数据库
//    rootContainer.as(Characteristics.CACHE).addComponent(EmbeddedDatabaseFactory.class);
//    // hibernate 数据库
//    rootContainer.as(Characteristics.CACHE).addComponent(JndiDatabaseConnector.class);
    rootContainer.start();

    // Platform is already starting, so it's registered after the container startup
  }

//  private boolean isConnectedToDatabase() {
//    JndiDatabaseConnector databaseConnector = getContainer().getComponent(JndiDatabaseConnector.class);
//    return databaseConnector.isOperational();
//  }

  private void startCoreComponents() {
    coreContainer = rootContainer.makeChildContainer();
//    coreContainer.as(Characteristics.CACHE).addComponent(Environment.SERVER);
//    coreContainer.as(Characteristics.CACHE).addComponent(PluginClassLoaders.class);
//    coreContainer.as(Characteristics.CACHE).addComponent(PluginDeployer.class);
//    coreContainer.as(Characteristics.CACHE).addComponent(ServerImpl.class);
//    coreContainer.as(Characteristics.CACHE).addComponent(DefaultServerFileSystem.class);
//    coreContainer.as(Characteristics.CACHE).addComponent(JpaPluginDao.class);
//    coreContainer.as(Characteristics.CACHE).addComponent(ServerPluginRepository.class);
//    coreContainer.as(Characteristics.CACHE).addComponent(ThreadLocalDatabaseSessionFactory.class);
//    coreContainer.as(Characteristics.CACHE).addComponent(HttpDownloader.class);
//    coreContainer.as(Characteristics.CACHE).addComponent(UpdateCenterClient.class);
//    coreContainer.as(Characteristics.CACHE).addComponent(UpdateFinderFactory.class);
//    coreContainer.as(Characteristics.CACHE).addComponent(PluginDownloader.class);
//    coreContainer.as(Characteristics.NO_CACHE).addComponent(FilterExecutor.class);
//    coreContainer.as(Characteristics.NO_CACHE).addAdapter(new DatabaseSessionProvider());
    coreContainer.start();
//
//    DatabaseConfiguration dbConfiguration = new DatabaseConfiguration(coreContainer.getComponent(DatabaseSessionFactory.class));
//    coreContainer.getComponent(CompositeConfiguration.class).addConfiguration(dbConfiguration);
  }

  /**
   * plugin extensions + all the components that depend on plugin extensions
   */
  private void startServiceComponents() {
    servicesContainer = coreContainer.makeChildContainer();

    //ServerPluginRepository pluginRepository = servicesContainer.getComponent(ServerPluginRepository.class);
    //pluginRepository.registerPlugins(servicesContainer);

    servicesContainer.as(Characteristics.CACHE).addComponent(ChartFactory.class);

//    servicesContainer.as(Characteristics.CACHE).addComponent(DefaultModelFinder.class); // depends on plugins
//    servicesContainer.as(Characteristics.CACHE).addComponent(DefaultModelManager.class);
//    servicesContainer.as(Characteristics.CACHE).addComponent(Plugins.class);
//    servicesContainer.as(Characteristics.CACHE).addComponent(Languages.class);
//    servicesContainer.as(Characteristics.CACHE).addComponent(Views.class);
//    servicesContainer.as(Characteristics.CACHE).addComponent(CodeColorizers.class);
//    servicesContainer.as(Characteristics.NO_CACHE).addComponent(RulesDao.class);
//    servicesContainer.as(Characteristics.NO_CACHE).addComponent(org.sonar.api.database.daos.RulesDao.class);
//    servicesContainer.as(Characteristics.NO_CACHE).addComponent(MeasuresDao.class);
//    servicesContainer.as(Characteristics.NO_CACHE).addComponent(org.sonar.api.database.daos.MeasuresDao.class);
//    servicesContainer.as(Characteristics.NO_CACHE).addComponent(ProfilesDao.class);
//    servicesContainer.as(Characteristics.NO_CACHE).addComponent(AsyncMeasuresDao.class);
//    servicesContainer.as(Characteristics.NO_CACHE).addComponent(DaoFacade.class);
//    servicesContainer.as(Characteristics.NO_CACHE).addComponent(DefaultRulesManager.class);
//    servicesContainer.as(Characteristics.NO_CACHE).addComponent(ProfilesManager.class);
//    servicesContainer.as(Characteristics.NO_CACHE).addComponent(AsyncMeasuresService.class);
//    servicesContainer.as(Characteristics.NO_CACHE).addComponent(Backup.class);
//    servicesContainer.as(Characteristics.CACHE).addComponent(AuthenticatorFactory.class);
//    servicesContainer.as(Characteristics.CACHE).addComponent(ServerLifecycleNotifier.class);
//    servicesContainer.as(Characteristics.CACHE).addComponent(AnnotationProfileParser.class);
//    servicesContainer.as(Characteristics.CACHE).addComponent(XMLProfileParser.class);
//    servicesContainer.as(Characteristics.CACHE).addComponent(XMLProfileSerializer.class);
//    servicesContainer.as(Characteristics.CACHE).addComponent(XMLRuleParser.class);
//    servicesContainer.as(Characteristics.CACHE).addComponent(DefaultRuleFinder.class);
//    servicesContainer.as(Characteristics.CACHE).addComponent(DeprecatedRuleRepositories.class);
//    servicesContainer.as(Characteristics.CACHE).addComponent(DeprecatedProfiles.class);
//    servicesContainer.as(Characteristics.CACHE).addComponent(DeprecatedProfileExporters.class);
//    servicesContainer.as(Characteristics.CACHE).addComponent(DeprecatedProfileImporters.class);
//    servicesContainer.as(Characteristics.CACHE).addComponent(ProfilesConsole.class);
//    servicesContainer.as(Characteristics.CACHE).addComponent(RulesConsole.class);

    servicesContainer.start();
  }

  private void executeStartupTasks() {
    MutablePicoContainer startupContainer = servicesContainer.makeChildContainer();
    try {
      //startupContainer.as(Characteristics.CACHE).addComponent(MavenRepository.class);
      //startupContainer.as(Characteristics.CACHE).addComponent(GwtPublisher.class);
//      startupContainer.as(Characteristics.CACHE).addComponent(RegisterMetrics.class);
//      startupContainer.as(Characteristics.CACHE).addComponent(RegisterRules.class);
//      startupContainer.as(Characteristics.CACHE).addComponent(RegisterProvidedProfiles.class);
//      startupContainer.as(Characteristics.CACHE).addComponent(ActivateDefaultProfiles.class);
//      startupContainer.as(Characteristics.CACHE).addComponent(JdbcDriverDeployer.class);
//      startupContainer.as(Characteristics.CACHE).addComponent(ServerMetadataPersister.class);
//      startupContainer.as(Characteristics.CACHE).addComponent(RegisterQualityModels.class);
      startupContainer.start();

      //startupContainer.getComponent(ServerLifecycleNotifier.class).notifyStart();

    } finally {
      startupContainer.stop();
      servicesContainer.removeChildContainer(startupContainer);
      startupContainer = null;
      //servicesContainer.getComponent(DatabaseSessionFactory.class).clear();
    }
  }

  public void stop() {
    if (rootContainer != null) {
      try {
        TimeProfiler profiler = new TimeProfiler().start("Stop sonar");
        rootContainer.stop();
        rootContainer = null;
        connected = false;
        started = false;
        profiler.stop();
      } catch (Exception e) {
        LoggerFactory.getLogger(getClass()).debug("Fail to stop Sonar - ignored", e);
      }
    }
  }

  public MutablePicoContainer getContainer() {
    if (servicesContainer != null) {
      return servicesContainer;
    }
    if (coreContainer != null) {
      return coreContainer;
    }
    return rootContainer;
  }

  public Object getComponent(Object key) {
    return getContainer().getComponent(key);
  }

//  /**
//   * shortcut for ruby code
//   */
//  public static Server getServer() {
//    return (Server) getInstance().getComponent(Server.class);
//  }
}
