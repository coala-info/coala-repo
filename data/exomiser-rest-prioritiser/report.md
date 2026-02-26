# exomiser-rest-prioritiser CWL Generation Report

## exomiser-rest-prioritiser

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/exomiser-rest-prioritiser:14.1.0--hdfd78af_0
- **Homepage**: https://github.com/exomiser/Exomiser
- **Package**: https://anaconda.org/channels/bioconda/packages/exomiser-rest-prioritiser/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/exomiser-rest-prioritiser/overview
- **Total Downloads**: 10.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/exomiser/Exomiser
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
_____ _            _____                     _
 |_   _| |__   ___  | ____|_  _____  _ __ ___ (_)___  ___ _ __
   | | | '_ \ / _ \ |  _| \ \/ / _ \| '_ ` _ \| / __|/ _ \ '__|
   | | | | | |  __/ | |___ >  < (_) | | | | | | \__ \  __/ |
   |_| |_| |_|\___| |_____/_/\_\___/|_| |_| |_|_|___/\___|_|

 === Prioritiser Server ===                              v14.1.0

[2m2026-02-24T21:22:18.648Z[0;39m [32m INFO[0;39m [35m12[0;39m [2m---[0;39m [2m[exomiser-prioritiser-service] [           main][0;39m [2m[0;39m[36mo.m.e.r.p.ExomiserPrioritiserServer     [0;39m [2m:[0;39m Starting ExomiserPrioritiserServer using Java 23.0.1-internal with PID 12 (/usr/local/share/exomiser-rest-prioritiser-14.1.0-0/exomiser-rest-prioritiser-14.1.0.jar started by root in /)
[2m2026-02-24T21:22:18.655Z[0;39m [32m INFO[0;39m [35m12[0;39m [2m---[0;39m [2m[exomiser-prioritiser-service] [           main][0;39m [2m[0;39m[36mo.m.e.r.p.ExomiserPrioritiserServer     [0;39m [2m:[0;39m No active profile set, falling back to 1 default profile: "default"
[2m2026-02-24T21:22:20.076Z[0;39m [32m INFO[0;39m [35m12[0;39m [2m---[0;39m [2m[exomiser-prioritiser-service] [           main][0;39m [2m[0;39m[36mo.s.b.w.embedded.tomcat.TomcatWebServer [0;39m [2m:[0;39m Tomcat initialized with port 8085 (http)
[2m2026-02-24T21:22:20.085Z[0;39m [32m INFO[0;39m [35m12[0;39m [2m---[0;39m [2m[exomiser-prioritiser-service] [           main][0;39m [2m[0;39m[36mo.apache.catalina.core.StandardService  [0;39m [2m:[0;39m Starting service [Tomcat]
[2m2026-02-24T21:22:20.085Z[0;39m [32m INFO[0;39m [35m12[0;39m [2m---[0;39m [2m[exomiser-prioritiser-service] [           main][0;39m [2m[0;39m[36mo.apache.catalina.core.StandardEngine   [0;39m [2m:[0;39m Starting Servlet engine: [Apache Tomcat/10.1.19]
[2m2026-02-24T21:22:20.111Z[0;39m [32m INFO[0;39m [35m12[0;39m [2m---[0;39m [2m[exomiser-prioritiser-service] [           main][0;39m [2m[0;39m[36mo.a.c.c.C.[.[.[/exomiser/api/prioritise][0;39m [2m:[0;39m Initializing Spring embedded WebApplicationContext
[2m2026-02-24T21:22:20.112Z[0;39m [32m INFO[0;39m [35m12[0;39m [2m---[0;39m [2m[exomiser-prioritiser-service] [           main][0;39m [2m[0;39m[36mw.s.c.ServletWebServerApplicationContext[0;39m [2m:[0;39m Root WebApplicationContext: initialization completed in 1357 ms
[2m2026-02-24T21:22:20.304Z[0;39m [32m INFO[0;39m [35m12[0;39m [2m---[0;39m [2m[exomiser-prioritiser-service] [           main][0;39m [2m[0;39m[36mo.m.e.r.p.config.ControllerConfig       [0;39m [2m:[0;39m Loading gene identifiers...
[2m2026-02-24T21:22:21.369Z[0;39m [31mERROR[0;39m [35m12[0;39m [2m---[0;39m [2m[exomiser-prioritiser-service] [           main][0;39m [2m[0;39m[36mcom.zaxxer.hikari.pool.HikariPool       [0;39m [2m:[0;39m 2410_phenotype - Exception during pool initialization.

org.h2.jdbc.JdbcSQLNonTransientConnectionException: Database "/home/circleci/exomiser/exomiser-rest-prioritiser/target/test-classes/2410_phenotype/2410_phenotype" not found, and IFEXISTS=true, so we cant auto-create it [90146-224]
	at org.h2.message.DbException.getJdbcSQLException(DbException.java:690) ~[h2-2.2.224.jar!/:na]
	at org.h2.message.DbException.getJdbcSQLException(DbException.java:489) ~[h2-2.2.224.jar!/:na]
	at org.h2.message.DbException.get(DbException.java:223) ~[h2-2.2.224.jar!/:na]
	at org.h2.message.DbException.get(DbException.java:199) ~[h2-2.2.224.jar!/:na]
	at org.h2.engine.Engine.throwNotFound(Engine.java:186) ~[h2-2.2.224.jar!/:na]
	at org.h2.engine.Engine.openSession(Engine.java:72) ~[h2-2.2.224.jar!/:na]
	at org.h2.engine.Engine.openSession(Engine.java:222) ~[h2-2.2.224.jar!/:na]
	at org.h2.engine.Engine.createSession(Engine.java:201) ~[h2-2.2.224.jar!/:na]
	at org.h2.engine.SessionRemote.connectEmbeddedOrServer(SessionRemote.java:343) ~[h2-2.2.224.jar!/:na]
	at org.h2.jdbc.JdbcConnection.<init>(JdbcConnection.java:125) ~[h2-2.2.224.jar!/:na]
	at org.h2.Driver.connect(Driver.java:59) ~[h2-2.2.224.jar!/:na]
	at com.zaxxer.hikari.util.DriverDataSource.getConnection(DriverDataSource.java:138) ~[HikariCP-5.0.1.jar!/:na]
	at com.zaxxer.hikari.pool.PoolBase.newConnection(PoolBase.java:359) ~[HikariCP-5.0.1.jar!/:na]
	at com.zaxxer.hikari.pool.PoolBase.newPoolEntry(PoolBase.java:201) ~[HikariCP-5.0.1.jar!/:na]
	at com.zaxxer.hikari.pool.HikariPool.createPoolEntry(HikariPool.java:470) ~[HikariCP-5.0.1.jar!/:na]
	at com.zaxxer.hikari.pool.HikariPool.checkFailFast(HikariPool.java:561) ~[HikariCP-5.0.1.jar!/:na]
	at com.zaxxer.hikari.pool.HikariPool.<init>(HikariPool.java:100) ~[HikariCP-5.0.1.jar!/:na]
	at com.zaxxer.hikari.HikariDataSource.getConnection(HikariDataSource.java:112) ~[HikariCP-5.0.1.jar!/:na]
	at org.monarchinitiative.exomiser.rest.prioritiser.config.ControllerConfig.getGeneIdentifiers(ControllerConfig.java:59) ~[!/:na]
	at org.monarchinitiative.exomiser.rest.prioritiser.config.ControllerConfig$$SpringCGLIB$$0.CGLIB$getGeneIdentifiers$0(<generated>) ~[!/:na]
	at org.monarchinitiative.exomiser.rest.prioritiser.config.ControllerConfig$$SpringCGLIB$$FastClass$$1.invoke(<generated>) ~[!/:na]
	at org.springframework.cglib.proxy.MethodProxy.invokeSuper(MethodProxy.java:258) ~[spring-core-6.1.4.jar!/:6.1.4]
	at org.springframework.context.annotation.ConfigurationClassEnhancer$BeanMethodInterceptor.intercept(ConfigurationClassEnhancer.java:331) ~[spring-context-6.1.4.jar!/:6.1.4]
	at org.monarchinitiative.exomiser.rest.prioritiser.config.ControllerConfig$$SpringCGLIB$$0.getGeneIdentifiers(<generated>) ~[!/:na]
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103) ~[na:na]
	at java.base/java.lang.reflect.Method.invoke(Method.java:580) ~[na:na]
	at org.springframework.beans.factory.support.SimpleInstantiationStrategy.instantiate(SimpleInstantiationStrategy.java:140) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.ConstructorResolver.instantiate(ConstructorResolver.java:647) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.ConstructorResolver.instantiateUsingFactoryMethod(ConstructorResolver.java:485) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.instantiateUsingFactoryMethod(AbstractAutowireCapableBeanFactory.java:1335) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBeanInstance(AbstractAutowireCapableBeanFactory.java:1165) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.doCreateBean(AbstractAutowireCapableBeanFactory.java:562) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBean(AbstractAutowireCapableBeanFactory.java:522) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractBeanFactory.lambda$doGetBean$0(AbstractBeanFactory.java:325) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.DefaultSingletonBeanRegistry.getSingleton(DefaultSingletonBeanRegistry.java:234) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:323) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:199) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.config.DependencyDescriptor.resolveCandidate(DependencyDescriptor.java:254) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.DefaultListableBeanFactory.doResolveDependency(DefaultListableBeanFactory.java:1443) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.DefaultListableBeanFactory.resolveDependency(DefaultListableBeanFactory.java:1353) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.ConstructorResolver.resolveAutowiredArgument(ConstructorResolver.java:907) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.ConstructorResolver.createArgumentArray(ConstructorResolver.java:785) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.ConstructorResolver.autowireConstructor(ConstructorResolver.java:237) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.autowireConstructor(AbstractAutowireCapableBeanFactory.java:1355) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBeanInstance(AbstractAutowireCapableBeanFactory.java:1192) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.doCreateBean(AbstractAutowireCapableBeanFactory.java:562) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBean(AbstractAutowireCapableBeanFactory.java:522) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractBeanFactory.lambda$doGetBean$0(AbstractBeanFactory.java:325) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.DefaultSingletonBeanRegistry.getSingleton(DefaultSingletonBeanRegistry.java:234) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:323) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:199) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.DefaultListableBeanFactory.preInstantiateSingletons(DefaultListableBeanFactory.java:975) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.context.support.AbstractApplicationContext.finishBeanFactoryInitialization(AbstractApplicationContext.java:959) ~[spring-context-6.1.4.jar!/:6.1.4]
	at org.springframework.context.support.AbstractApplicationContext.refresh(AbstractApplicationContext.java:624) ~[spring-context-6.1.4.jar!/:6.1.4]
	at org.springframework.boot.web.servlet.context.ServletWebServerApplicationContext.refresh(ServletWebServerApplicationContext.java:146) ~[spring-boot-3.2.3.jar!/:3.2.3]
	at org.springframework.boot.SpringApplication.refresh(SpringApplication.java:754) ~[spring-boot-3.2.3.jar!/:3.2.3]
	at org.springframework.boot.SpringApplication.refreshContext(SpringApplication.java:456) ~[spring-boot-3.2.3.jar!/:3.2.3]
	at org.springframework.boot.SpringApplication.run(SpringApplication.java:334) ~[spring-boot-3.2.3.jar!/:3.2.3]
	at org.springframework.boot.SpringApplication.run(SpringApplication.java:1354) ~[spring-boot-3.2.3.jar!/:3.2.3]
	at org.springframework.boot.SpringApplication.run(SpringApplication.java:1343) ~[spring-boot-3.2.3.jar!/:3.2.3]
	at org.monarchinitiative.exomiser.rest.prioritiser.ExomiserPrioritiserServer.main(ExomiserPrioritiserServer.java:40) ~[!/:na]
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103) ~[na:na]
	at java.base/java.lang.reflect.Method.invoke(Method.java:580) ~[na:na]
	at org.springframework.boot.loader.launch.Launcher.launch(Launcher.java:91) ~[exomiser-rest-prioritiser-14.1.0.jar:na]
	at org.springframework.boot.loader.launch.Launcher.launch(Launcher.java:53) ~[exomiser-rest-prioritiser-14.1.0.jar:na]
	at org.springframework.boot.loader.launch.JarLauncher.main(JarLauncher.java:58) ~[exomiser-rest-prioritiser-14.1.0.jar:na]

[2m2026-02-24T21:22:21.592Z[0;39m [31mERROR[0;39m [35m12[0;39m [2m---[0;39m [2m[exomiser-prioritiser-service] [           main][0;39m [2m[0;39m[36mo.m.e.r.p.config.ControllerConfig       [0;39m [2m:[0;39m Error executing getGenes query: 

org.h2.jdbc.JdbcSQLNonTransientConnectionException: Database "/home/circleci/exomiser/exomiser-rest-prioritiser/target/test-classes/2410_phenotype/2410_phenotype" not found, and IFEXISTS=true, so we cant auto-create it [90146-224]
	at org.h2.message.DbException.getJdbcSQLException(DbException.java:690) ~[h2-2.2.224.jar!/:na]
	at org.h2.message.DbException.getJdbcSQLException(DbException.java:489) ~[h2-2.2.224.jar!/:na]
	at org.h2.message.DbException.get(DbException.java:223) ~[h2-2.2.224.jar!/:na]
	at org.h2.message.DbException.get(DbException.java:199) ~[h2-2.2.224.jar!/:na]
	at org.h2.engine.Engine.throwNotFound(Engine.java:186) ~[h2-2.2.224.jar!/:na]
	at org.h2.engine.Engine.openSession(Engine.java:72) ~[h2-2.2.224.jar!/:na]
	at org.h2.engine.Engine.openSession(Engine.java:222) ~[h2-2.2.224.jar!/:na]
	at org.h2.engine.Engine.createSession(Engine.java:201) ~[h2-2.2.224.jar!/:na]
	at org.h2.engine.SessionRemote.connectEmbeddedOrServer(SessionRemote.java:343) ~[h2-2.2.224.jar!/:na]
	at org.h2.jdbc.JdbcConnection.<init>(JdbcConnection.java:125) ~[h2-2.2.224.jar!/:na]
	at org.h2.Driver.connect(Driver.java:59) ~[h2-2.2.224.jar!/:na]
	at com.zaxxer.hikari.util.DriverDataSource.getConnection(DriverDataSource.java:138) ~[HikariCP-5.0.1.jar!/:na]
	at com.zaxxer.hikari.pool.PoolBase.newConnection(PoolBase.java:359) ~[HikariCP-5.0.1.jar!/:na]
	at com.zaxxer.hikari.pool.PoolBase.newPoolEntry(PoolBase.java:201) ~[HikariCP-5.0.1.jar!/:na]
	at com.zaxxer.hikari.pool.HikariPool.createPoolEntry(HikariPool.java:470) ~[HikariCP-5.0.1.jar!/:na]
	at com.zaxxer.hikari.pool.HikariPool.checkFailFast(HikariPool.java:561) ~[HikariCP-5.0.1.jar!/:na]
	at com.zaxxer.hikari.pool.HikariPool.<init>(HikariPool.java:100) ~[HikariCP-5.0.1.jar!/:na]
	at com.zaxxer.hikari.HikariDataSource.getConnection(HikariDataSource.java:112) ~[HikariCP-5.0.1.jar!/:na]
	at org.monarchinitiative.exomiser.rest.prioritiser.config.ControllerConfig.getGeneIdentifiers(ControllerConfig.java:59) ~[!/:na]
	at org.monarchinitiative.exomiser.rest.prioritiser.config.ControllerConfig$$SpringCGLIB$$0.CGLIB$getGeneIdentifiers$0(<generated>) ~[!/:na]
	at org.monarchinitiative.exomiser.rest.prioritiser.config.ControllerConfig$$SpringCGLIB$$FastClass$$1.invoke(<generated>) ~[!/:na]
	at org.springframework.cglib.proxy.MethodProxy.invokeSuper(MethodProxy.java:258) ~[spring-core-6.1.4.jar!/:6.1.4]
	at org.springframework.context.annotation.ConfigurationClassEnhancer$BeanMethodInterceptor.intercept(ConfigurationClassEnhancer.java:331) ~[spring-context-6.1.4.jar!/:6.1.4]
	at org.monarchinitiative.exomiser.rest.prioritiser.config.ControllerConfig$$SpringCGLIB$$0.getGeneIdentifiers(<generated>) ~[!/:na]
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103) ~[na:na]
	at java.base/java.lang.reflect.Method.invoke(Method.java:580) ~[na:na]
	at org.springframework.beans.factory.support.SimpleInstantiationStrategy.instantiate(SimpleInstantiationStrategy.java:140) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.ConstructorResolver.instantiate(ConstructorResolver.java:647) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.ConstructorResolver.instantiateUsingFactoryMethod(ConstructorResolver.java:485) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.instantiateUsingFactoryMethod(AbstractAutowireCapableBeanFactory.java:1335) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBeanInstance(AbstractAutowireCapableBeanFactory.java:1165) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.doCreateBean(AbstractAutowireCapableBeanFactory.java:562) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBean(AbstractAutowireCapableBeanFactory.java:522) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractBeanFactory.lambda$doGetBean$0(AbstractBeanFactory.java:325) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.DefaultSingletonBeanRegistry.getSingleton(DefaultSingletonBeanRegistry.java:234) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:323) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:199) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.config.DependencyDescriptor.resolveCandidate(DependencyDescriptor.java:254) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.DefaultListableBeanFactory.doResolveDependency(DefaultListableBeanFactory.java:1443) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.DefaultListableBeanFactory.resolveDependency(DefaultListableBeanFactory.java:1353) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.ConstructorResolver.resolveAutowiredArgument(ConstructorResolver.java:907) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.ConstructorResolver.createArgumentArray(ConstructorResolver.java:785) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.ConstructorResolver.autowireConstructor(ConstructorResolver.java:237) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.autowireConstructor(AbstractAutowireCapableBeanFactory.java:1355) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBeanInstance(AbstractAutowireCapableBeanFactory.java:1192) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.doCreateBean(AbstractAutowireCapableBeanFactory.java:562) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBean(AbstractAutowireCapableBeanFactory.java:522) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractBeanFactory.lambda$doGetBean$0(AbstractBeanFactory.java:325) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.DefaultSingletonBeanRegistry.getSingleton(DefaultSingletonBeanRegistry.java:234) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:323) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:199) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.DefaultListableBeanFactory.preInstantiateSingletons(DefaultListableBeanFactory.java:975) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.context.support.AbstractApplicationContext.finishBeanFactoryInitialization(AbstractApplicationContext.java:959) ~[spring-context-6.1.4.jar!/:6.1.4]
	at org.springframework.context.support.AbstractApplicationContext.refresh(AbstractApplicationContext.java:624) ~[spring-context-6.1.4.jar!/:6.1.4]
	at org.springframework.boot.web.servlet.context.ServletWebServerApplicationContext.refresh(ServletWebServerApplicationContext.java:146) ~[spring-boot-3.2.3.jar!/:3.2.3]
	at org.springframework.boot.SpringApplication.refresh(SpringApplication.java:754) ~[spring-boot-3.2.3.jar!/:3.2.3]
	at org.springframework.boot.SpringApplication.refreshContext(SpringApplication.java:456) ~[spring-boot-3.2.3.jar!/:3.2.3]
	at org.springframework.boot.SpringApplication.run(SpringApplication.java:334) ~[spring-boot-3.2.3.jar!/:3.2.3]
	at org.springframework.boot.SpringApplication.run(SpringApplication.java:1354) ~[spring-boot-3.2.3.jar!/:3.2.3]
	at org.springframework.boot.SpringApplication.run(SpringApplication.java:1343) ~[spring-boot-3.2.3.jar!/:3.2.3]
	at org.monarchinitiative.exomiser.rest.prioritiser.ExomiserPrioritiserServer.main(ExomiserPrioritiserServer.java:40) ~[!/:na]
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103) ~[na:na]
	at java.base/java.lang.reflect.Method.invoke(Method.java:580) ~[na:na]
	at org.springframework.boot.loader.launch.Launcher.launch(Launcher.java:91) ~[exomiser-rest-prioritiser-14.1.0.jar:na]
	at org.springframework.boot.loader.launch.Launcher.launch(Launcher.java:53) ~[exomiser-rest-prioritiser-14.1.0.jar:na]
	at org.springframework.boot.loader.launch.JarLauncher.main(JarLauncher.java:58) ~[exomiser-rest-prioritiser-14.1.0.jar:na]

[2m2026-02-24T21:22:21.594Z[0;39m [33m WARN[0;39m [35m12[0;39m [2m---[0;39m [2m[exomiser-prioritiser-service] [           main][0;39m [2m[0;39m[36mConfigServletWebServerApplicationContext[0;39m [2m:[0;39m Exception encountered during context initialization - cancelling refresh attempt: org.springframework.beans.factory.UnsatisfiedDependencyException: Error creating bean with name 'prioritiserController' defined in URL [jar:nested:/usr/local/share/exomiser-rest-prioritiser-14.1.0-0/exomiser-rest-prioritiser-14.1.0.jar/!BOOT-INF/classes/!/org/monarchinitiative/exomiser/rest/prioritiser/api/PrioritiserController.class]: Unsatisfied dependency expressed through constructor parameter 0: Error creating bean with name 'getGeneIdentifiers' defined in class path resource [org/monarchinitiative/exomiser/rest/prioritiser/config/ControllerConfig.class]: Failed to instantiate [java.util.Map]: Factory method 'getGeneIdentifiers' threw exception with message: Unable to retrieve gene identifiers
[2m2026-02-24T21:22:21.598Z[0;39m [32m INFO[0;39m [35m12[0;39m [2m---[0;39m [2m[exomiser-prioritiser-service] [           main][0;39m [2m[0;39m[36mo.apache.catalina.core.StandardService  [0;39m [2m:[0;39m Stopping service [Tomcat]
[2m2026-02-24T21:22:21.621Z[0;39m [32m INFO[0;39m [35m12[0;39m [2m---[0;39m [2m[exomiser-prioritiser-service] [           main][0;39m [2m[0;39m[36m.s.b.a.l.ConditionEvaluationReportLogger[0;39m [2m:[0;39m 

Error starting ApplicationContext. To display the condition evaluation report re-run your application with 'debug' enabled.
[2m2026-02-24T21:22:21.643Z[0;39m [31mERROR[0;39m [35m12[0;39m [2m---[0;39m [2m[exomiser-prioritiser-service] [           main][0;39m [2m[0;39m[36mo.s.boot.SpringApplication              [0;39m [2m:[0;39m Application run failed

org.springframework.beans.factory.UnsatisfiedDependencyException: Error creating bean with name 'prioritiserController' defined in URL [jar:nested:/usr/local/share/exomiser-rest-prioritiser-14.1.0-0/exomiser-rest-prioritiser-14.1.0.jar/!BOOT-INF/classes/!/org/monarchinitiative/exomiser/rest/prioritiser/api/PrioritiserController.class]: Unsatisfied dependency expressed through constructor parameter 0: Error creating bean with name 'getGeneIdentifiers' defined in class path resource [org/monarchinitiative/exomiser/rest/prioritiser/config/ControllerConfig.class]: Failed to instantiate [java.util.Map]: Factory method 'getGeneIdentifiers' threw exception with message: Unable to retrieve gene identifiers
	at org.springframework.beans.factory.support.ConstructorResolver.createArgumentArray(ConstructorResolver.java:798) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.ConstructorResolver.autowireConstructor(ConstructorResolver.java:237) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.autowireConstructor(AbstractAutowireCapableBeanFactory.java:1355) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBeanInstance(AbstractAutowireCapableBeanFactory.java:1192) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.doCreateBean(AbstractAutowireCapableBeanFactory.java:562) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBean(AbstractAutowireCapableBeanFactory.java:522) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractBeanFactory.lambda$doGetBean$0(AbstractBeanFactory.java:325) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.DefaultSingletonBeanRegistry.getSingleton(DefaultSingletonBeanRegistry.java:234) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:323) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:199) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.DefaultListableBeanFactory.preInstantiateSingletons(DefaultListableBeanFactory.java:975) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.context.support.AbstractApplicationContext.finishBeanFactoryInitialization(AbstractApplicationContext.java:959) ~[spring-context-6.1.4.jar!/:6.1.4]
	at org.springframework.context.support.AbstractApplicationContext.refresh(AbstractApplicationContext.java:624) ~[spring-context-6.1.4.jar!/:6.1.4]
	at org.springframework.boot.web.servlet.context.ServletWebServerApplicationContext.refresh(ServletWebServerApplicationContext.java:146) ~[spring-boot-3.2.3.jar!/:3.2.3]
	at org.springframework.boot.SpringApplication.refresh(SpringApplication.java:754) ~[spring-boot-3.2.3.jar!/:3.2.3]
	at org.springframework.boot.SpringApplication.refreshContext(SpringApplication.java:456) ~[spring-boot-3.2.3.jar!/:3.2.3]
	at org.springframework.boot.SpringApplication.run(SpringApplication.java:334) ~[spring-boot-3.2.3.jar!/:3.2.3]
	at org.springframework.boot.SpringApplication.run(SpringApplication.java:1354) ~[spring-boot-3.2.3.jar!/:3.2.3]
	at org.springframework.boot.SpringApplication.run(SpringApplication.java:1343) ~[spring-boot-3.2.3.jar!/:3.2.3]
	at org.monarchinitiative.exomiser.rest.prioritiser.ExomiserPrioritiserServer.main(ExomiserPrioritiserServer.java:40) ~[!/:na]
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103) ~[na:na]
	at java.base/java.lang.reflect.Method.invoke(Method.java:580) ~[na:na]
	at org.springframework.boot.loader.launch.Launcher.launch(Launcher.java:91) ~[exomiser-rest-prioritiser-14.1.0.jar:na]
	at org.springframework.boot.loader.launch.Launcher.launch(Launcher.java:53) ~[exomiser-rest-prioritiser-14.1.0.jar:na]
	at org.springframework.boot.loader.launch.JarLauncher.main(JarLauncher.java:58) ~[exomiser-rest-prioritiser-14.1.0.jar:na]
Caused by: org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'getGeneIdentifiers' defined in class path resource [org/monarchinitiative/exomiser/rest/prioritiser/config/ControllerConfig.class]: Failed to instantiate [java.util.Map]: Factory method 'getGeneIdentifiers' threw exception with message: Unable to retrieve gene identifiers
	at org.springframework.beans.factory.support.ConstructorResolver.instantiate(ConstructorResolver.java:651) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.ConstructorResolver.instantiateUsingFactoryMethod(ConstructorResolver.java:485) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.instantiateUsingFactoryMethod(AbstractAutowireCapableBeanFactory.java:1335) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBeanInstance(AbstractAutowireCapableBeanFactory.java:1165) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.doCreateBean(AbstractAutowireCapableBeanFactory.java:562) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBean(AbstractAutowireCapableBeanFactory.java:522) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractBeanFactory.lambda$doGetBean$0(AbstractBeanFactory.java:325) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.DefaultSingletonBeanRegistry.getSingleton(DefaultSingletonBeanRegistry.java:234) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:323) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:199) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.config.DependencyDescriptor.resolveCandidate(DependencyDescriptor.java:254) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.DefaultListableBeanFactory.doResolveDependency(DefaultListableBeanFactory.java:1443) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.DefaultListableBeanFactory.resolveDependency(DefaultListableBeanFactory.java:1353) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.ConstructorResolver.resolveAutowiredArgument(ConstructorResolver.java:907) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.ConstructorResolver.createArgumentArray(ConstructorResolver.java:785) ~[spring-beans-6.1.4.jar!/:6.1.4]
	... 24 common frames omitted
Caused by: org.springframework.beans.BeanInstantiationException: Failed to instantiate [java.util.Map]: Factory method 'getGeneIdentifiers' threw exception with message: Unable to retrieve gene identifiers
	at org.springframework.beans.factory.support.SimpleInstantiationStrategy.instantiate(SimpleInstantiationStrategy.java:177) ~[spring-beans-6.1.4.jar!/:6.1.4]
	at org.springframework.beans.factory.support.ConstructorResolver.instantiate(ConstructorResolver.java:647) ~[spring-beans-6.1.4.jar!/:6.1.4]
	... 38 common frames omitted
Caused by: java.lang.RuntimeException: Unable to retrieve gene identifiers
	at org.monarchinitiative.exomiser.rest.prioritiser.config.ControllerConfig.getGeneIdentifiers(ControllerConfig.java:79) ~[!/:na]
	at org.monarchinitiative.exomiser.rest.prioritiser.config.ControllerConfig$$SpringCGLIB$$0.CGLIB$getGeneIdentifiers$0(<generated>) ~[!/:na]
	at org.monarchinitiative.exomiser.rest.prioritiser.config.ControllerConfig$$SpringCGLIB$$FastClass$$1.invoke(<generated>) ~[!/:na]
	at org.springframework.cglib.proxy.MethodProxy.invokeSuper(MethodProxy.java:258) ~[spring-core-6.1.4.jar!/:6.1.4]
	at org.springframework.context.annotation.ConfigurationClassEnhancer$BeanMethodInterceptor.intercept(ConfigurationClassEnhancer.java:331) ~[spring-context-6.1.4.jar!/:6.1.4]
	at org.monarchinitiative.exomiser.rest.prioritiser.config.ControllerConfig$$SpringCGLIB$$0.getGeneIdentifiers(<generated>) ~[!/:na]
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103) ~[na:na]
	at java.base/java.lang.reflect.Method.invoke(Method.java:580) ~[na:na]
	at org.springframework.beans.factory.support.SimpleInstantiationStrategy.instantiate(SimpleInstantiationStrategy.java:140) ~[spring-beans-6.1.4.jar!/:6.1.4]
	... 39 common frames omitted
```

