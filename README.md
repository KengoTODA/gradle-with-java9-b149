# Minimal project to reproduce problem with Java9 b149

[![Build Status](https://travis-ci.org/KengoTODA/gradle-with-java9-b149.svg?branch=master)](https://travis-ci.org/KengoTODA/gradle-with-java9-b149)

## How to reproduce

```sh
$ docker build -t gradle-with-java9 .
$ docker run -it -v $(pwd):/gradle -w /gradle gradle-with-java9 ./gradlew tasks --debug
```

## Exception

If we have no `--add-opens` option, we face following `InaccessibleObjectException`:

```sh
FAILURE: Build failed with an exception.

* What went wrong:
java.lang.ExceptionInInitializerError (no error message)

* Try:
Run with --info or --debug option to get more log output.

* Exception is:
java.lang.ExceptionInInitializerError
	at org.gradle.initialization.DefaultClassLoaderRegistry.restrictTo(DefaultClassLoaderRegistry.java:40)
	at org.gradle.initialization.DefaultClassLoaderRegistry.restrictToGradleApi(DefaultClassLoaderRegistry.java:36)
	at org.gradle.initialization.DefaultClassLoaderRegistry.<init>(DefaultClassLoaderRegistry.java:30)
	at org.gradle.internal.service.scopes.GlobalScopeServices.createClassLoaderRegistry(GlobalScopeServices.java:215)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.base/java.lang.reflect.Method.invoke(Method.java:538)
	at org.gradle.internal.reflect.JavaMethod.invoke(JavaMethod.java:73)
	at org.gradle.internal.service.DefaultServiceRegistry.invoke(DefaultServiceRegistry.java:462)
	at org.gradle.internal.service.DefaultServiceRegistry.access$1200(DefaultServiceRegistry.java:84)
	at org.gradle.internal.service.DefaultServiceRegistry$FactoryMethodService.invokeMethod(DefaultServiceRegistry.java:796)
	at org.gradle.internal.service.DefaultServiceRegistry$FactoryService.create(DefaultServiceRegistry.java:752)
	at org.gradle.internal.service.DefaultServiceRegistry$ManagedObjectProvider.getInstance(DefaultServiceRegistry.java:589)
	at org.gradle.internal.service.DefaultServiceRegistry$SingletonService.get(DefaultServiceRegistry.java:634)
	at org.gradle.internal.service.DefaultServiceRegistry.applyConfigureMethod(DefaultServiceRegistry.java:253)
	at org.gradle.internal.service.DefaultServiceRegistry.findProviderMethods(DefaultServiceRegistry.java:214)
	at org.gradle.internal.service.DefaultServiceRegistry.addProvider(DefaultServiceRegistry.java:352)
	at org.gradle.internal.service.ServiceRegistryBuilder.build(ServiceRegistryBuilder.java:52)
	at org.gradle.launcher.cli.BuildActionsFactory.createGlobalClientServices(BuildActionsFactory.java:148)
	at org.gradle.launcher.cli.BuildActionsFactory.runBuildWithDaemon(BuildActionsFactory.java:108)
	at org.gradle.launcher.cli.BuildActionsFactory.createAction(BuildActionsFactory.java:83)
	at org.gradle.launcher.cli.CommandLineActionFactory$ParseAndBuildAction.createAction(CommandLineActionFactory.java:249)
	at org.gradle.launcher.cli.CommandLineActionFactory$ParseAndBuildAction.execute(CommandLineActionFactory.java:239)
	at org.gradle.launcher.cli.CommandLineActionFactory$ParseAndBuildAction.execute(CommandLineActionFactory.java:217)
	at org.gradle.launcher.cli.JavaRuntimeValidationAction.execute(JavaRuntimeValidationAction.java:33)
	at org.gradle.launcher.cli.JavaRuntimeValidationAction.execute(JavaRuntimeValidationAction.java:24)
	at org.gradle.launcher.cli.ExceptionReportingAction.execute(ExceptionReportingAction.java:33)
	at org.gradle.launcher.cli.ExceptionReportingAction.execute(ExceptionReportingAction.java:22)
	at org.gradle.launcher.cli.CommandLineActionFactory$WithLogging.execute(CommandLineActionFactory.java:210)
	at org.gradle.launcher.cli.CommandLineActionFactory$WithLogging.execute(CommandLineActionFactory.java:174)
	at org.gradle.launcher.Main.doAction(Main.java:33)
	at org.gradle.launcher.bootstrap.EntryPoint.run(EntryPoint.java:45)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.base/java.lang.reflect.Method.invoke(Method.java:538)
	at org.gradle.launcher.bootstrap.ProcessBootstrap.runNoExit(ProcessBootstrap.java:60)
	at org.gradle.launcher.bootstrap.ProcessBootstrap.run(ProcessBootstrap.java:37)
	at org.gradle.launcher.GradleMain.main(GradleMain.java:23)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.base/java.lang.reflect.Method.invoke(Method.java:538)
	at org.gradle.wrapper.BootstrapMainStarter.start(BootstrapMainStarter.java:31)
	at org.gradle.wrapper.WrapperExecutor.execute(WrapperExecutor.java:108)
	at org.gradle.wrapper.GradleWrapperMain.main(GradleWrapperMain.java:61)
Caused by: java.lang.reflect.InaccessibleObjectException: Unable to make protected java.lang.Package[] java.lang.ClassLoader.getPackages() accessible: module java.base does not "opens java.lang" to unnamed module @43599640
	at java.base/jdk.internal.reflect.Reflection.throwInaccessibleObjectException(Reflection.java:427)
	at java.base/java.lang.reflect.AccessibleObject.checkCanSetAccessible(AccessibleObject.java:201)
	at java.base/java.lang.reflect.Method.checkCanSetAccessible(Method.java:192)
	at java.base/java.lang.reflect.Method.setAccessible(Method.java:186)
	at org.gradle.internal.reflect.JavaMethod.<init>(JavaMethod.java:42)
	at org.gradle.internal.reflect.JavaMethod.<init>(JavaMethod.java:32)
	at org.gradle.internal.reflect.JavaMethod.<init>(JavaMethod.java:36)
	at org.gradle.internal.reflect.JavaReflectionUtil.method(JavaReflectionUtil.java:223)
	at org.gradle.internal.classloader.FilteringClassLoader.<clinit>(FilteringClassLoader.java:48)
	... 47 more
```

And if we use `--add-opens` option, we face following `ExceptionInInitializerError`. See [Travis CI build result](https://travis-ci.org/KengoTODA/gradle-with-java9-b149/builds/190261753) for detail.

```sh
14:21:20.234 [DEBUG] [org.gradle.launcher.daemon.bootstrap.DaemonOutputConsumer] daemon out: FAILURE: Build failed with an exception.
14:21:20.235 [DEBUG] [org.gradle.launcher.daemon.bootstrap.DaemonOutputConsumer] daemon out:
14:21:20.236 [DEBUG] [org.gradle.launcher.daemon.bootstrap.DaemonOutputConsumer] daemon out: * What went wrong:
14:21:20.237 [DEBUG] [org.gradle.launcher.daemon.bootstrap.DaemonOutputConsumer] daemon out: java.lang.ExceptionInInitializerError (no error message)
14:21:20.240 [DEBUG] [org.gradle.launcher.daemon.bootstrap.DaemonOutputConsumer] daemon out:
14:21:20.240 [DEBUG] [org.gradle.launcher.daemon.bootstrap.DaemonOutputConsumer] daemon out: * Try:
14:21:20.242 [DEBUG] [org.gradle.launcher.daemon.bootstrap.DaemonOutputConsumer] daemon out: Run with --stacktrace option to get the stack trace. Run with --info or --debug option to get more log output.
14:21:20.247 [DEBUG] [org.gradle.process.internal.DefaultExecHandle] Changing state to: DETACHED
14:21:20.249 [DEBUG] [org.gradle.process.internal.DefaultExecHandle] Process 'Gradle build daemon' finished with exit value 0 (state: DETACHED)
14:21:20.249 [DEBUG] [org.gradle.launcher.daemon.client.DefaultDaemonStarter] Gradle daemon process is now detached.
14:21:20.250 [INFO] [org.gradle.launcher.daemon.client.DefaultDaemonStarter] An attempt to start the daemon took 0.864 secs.
14:21:20.256 [ERROR] [org.gradle.internal.buildevents.BuildExceptionReporter]
14:21:20.257 [ERROR] [org.gradle.internal.buildevents.BuildExceptionReporter] [31mFAILURE: [39m[31mBuild failed with an exception.[39m
14:21:20.257 [ERROR] [org.gradle.internal.buildevents.BuildExceptionReporter]
14:21:20.257 [ERROR] [org.gradle.internal.buildevents.BuildExceptionReporter] * What went wrong:
14:21:20.257 [ERROR] [org.gradle.internal.buildevents.BuildExceptionReporter] Unable to start the daemon process.
14:21:20.257 [ERROR] [org.gradle.internal.buildevents.BuildExceptionReporter] This problem might be caused by incorrect configuration of the daemon.
14:21:20.257 [ERROR] [org.gradle.internal.buildevents.BuildExceptionReporter] For example, an unrecognized jvm option is used.
14:21:20.257 [ERROR] [org.gradle.internal.buildevents.BuildExceptionReporter] Please refer to the user guide chapter on the daemon at https://docs.gradle.org/3.3/userguide/gradle_daemon.html
14:21:20.257 [ERROR] [org.gradle.internal.buildevents.BuildExceptionReporter] Please read the following process output to find out more:
14:21:20.257 [ERROR] [org.gradle.internal.buildevents.BuildExceptionReporter] -----------------------
14:21:20.257 [ERROR] [org.gradle.internal.buildevents.BuildExceptionReporter]
14:21:20.257 [ERROR] [org.gradle.internal.buildevents.BuildExceptionReporter] FAILURE: Build failed with an exception.
14:21:20.257 [ERROR] [org.gradle.internal.buildevents.BuildExceptionReporter]
14:21:20.257 [ERROR] [org.gradle.internal.buildevents.BuildExceptionReporter] * What went wrong:
14:21:20.257 [ERROR] [org.gradle.internal.buildevents.BuildExceptionReporter] java.lang.ExceptionInInitializerError (no error message)
```
