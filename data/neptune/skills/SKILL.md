---
name: neptune
description: Neptune is a lightweight and stable Android plugin framework designed to support dynamic loading of APKs.
homepage: https://github.com/iqiyi/Neptune
---

# neptune

## Overview

Neptune is a lightweight and stable Android plugin framework designed to support dynamic loading of APKs. It is particularly noted for its compatibility with modern Android versions (including Android P and above) by minimizing the use of restricted APIs. Use this skill to implement a modular architecture where business units (plugins) can be developed, updated, and run independently of the main application (host), while still being able to share code and resources when necessary.

## Host Application Integration

To enable plugin support in your main application, follow these implementation patterns:

### 1. Dependency Configuration
Add the Neptune SDK to your application-level `build.gradle`:

```groovy
implementation 'org.qiyi.video:neptune:2.7.0'
```

### 2. SDK Initialization
Initialize the framework within your `Application#onCreate()` method. Use the `NeptuneConfigBuilder` to define the operational mode:

```java
public class MyApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        NeptuneConfig config = new NeptuneConfig.NeptuneConfigBuilder()
            .configSdkMode(NeptuneConfig.INSTRUMENTATION_MODE)
            .enableDebug(BuildConfig.DEBUG)
            .build();
        Neptune.init(this, config);
    }
}
```

## Plugin Project Configuration

Plugins are developed like normal Android apps but require specific Gradle configurations to ensure they can be loaded by the host.

### 1. Buildscript Setup
In the root `build.gradle` of the plugin project, include the Neptune Gradle plugin:

```groovy
dependencies {
    classpath 'com.iqiyi.tools.build:neptune-gradle:1.4.0'
}
```

### 2. Plugin Application and Parameters
Apply the plugin in the application module's `build.gradle` and configure the `neptune` block:

```groovy
apply plugin: 'com.qiyi.neptune.plugin'

neptune {
    pluginMode = true           // Enables plugin APK build mode
    packageId = 0x30            // Unique Resource Package ID to prevent collisions
    hostDependencies = "group:artifact;group2:artifact2" // Shared host resources
}
```

## Best Practices and Expert Tips

- **Resource Isolation**: Always assign a unique `packageId` (e.g., `0x30`, `0x40`) in the plugin's `neptune` configuration. This prevents resource ID conflicts between the host and multiple plugins.
- **Component Registration**: Unlike standard Android development, plugin components (Activities, Services, Receivers) do **not** need to be registered in the Host's `AndroidManifest.xml`. Neptune handles their lifecycle via proxy mechanisms.
- **Class Loading**: Neptune uses a custom `PluginClassLoader`. If you encounter `ClassCastException` when sharing objects between host and plugin, ensure the shared classes are loaded by the host's ClassLoader.
- **Process Isolation**: For heavy business modules, consider running the plugin in a separate process to improve host stability.
- **Debugging**: Enable `enableDebug(true)` during development to get detailed logs regarding plugin loading failures or resource resolution issues.

## Reference documentation
- [Neptune Wiki](./references/github_com_iqiyi_Neptune_wiki.md)
- [Main Repository README](./references/github_com_iqiyi_Neptune.md)