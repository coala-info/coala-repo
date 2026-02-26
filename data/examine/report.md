# examine CWL Generation Report

## examine

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/examine:1.0.1--hdfd78af_0
- **Homepage**: https://github.com/AlBi-HHU/eXamine-stand-alone
- **Package**: https://anaconda.org/channels/bioconda/packages/examine/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/examine/overview
- **Total Downloads**: 2.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/AlBi-HHU/eXamine-stand-alone
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Feb 24, 2026 9:20:40 PM com.sun.javafx.application.PlatformImpl startup
WARNING: Unsupported JavaFX configuration: classes were loaded from 'unnamed module @5be4cce0'
Loading library prism_es2 from resource failed: java.lang.UnsatisfiedLinkError: /root/.openjfx/cache/17/libprism_es2.so: libGL.so.1: cannot open shared object file: No such file or directory
java.lang.UnsatisfiedLinkError: /root/.openjfx/cache/17/libprism_es2.so: libGL.so.1: cannot open shared object file: No such file or directory
	at java.base/java.lang.ClassLoader$NativeLibrary.load0(Native Method)
	at java.base/java.lang.ClassLoader$NativeLibrary.load(ClassLoader.java:2442)
	at java.base/java.lang.ClassLoader$NativeLibrary.loadLibrary(ClassLoader.java:2498)
	at java.base/java.lang.ClassLoader.loadLibrary0(ClassLoader.java:2694)
	at java.base/java.lang.ClassLoader.loadLibrary(ClassLoader.java:2627)
	at java.base/java.lang.Runtime.load0(Runtime.java:768)
	at java.base/java.lang.System.load(System.java:1837)
	at com.sun.glass.utils.NativeLibLoader.installLibraryFromResource(NativeLibLoader.java:217)
	at com.sun.glass.utils.NativeLibLoader.loadLibraryFromResource(NativeLibLoader.java:197)
	at com.sun.glass.utils.NativeLibLoader.loadLibraryInternal(NativeLibLoader.java:138)
	at com.sun.glass.utils.NativeLibLoader.loadLibrary(NativeLibLoader.java:54)
	at com.sun.prism.es2.ES2Pipeline.lambda$static$0(ES2Pipeline.java:63)
	at java.base/java.security.AccessController.doPrivileged(Native Method)
	at com.sun.prism.es2.ES2Pipeline.<clinit>(ES2Pipeline.java:52)
	at java.base/java.lang.Class.forName0(Native Method)
	at java.base/java.lang.Class.forName(Class.java:315)
	at com.sun.prism.GraphicsPipeline.createPipeline(GraphicsPipeline.java:218)
	at com.sun.javafx.tk.quantum.QuantumRenderer$PipelineRunnable.init(QuantumRenderer.java:92)
	at com.sun.javafx.tk.quantum.QuantumRenderer$PipelineRunnable.run(QuantumRenderer.java:125)
	at java.base/java.lang.Thread.run(Thread.java:834)
Exception in thread "main" java.lang.UnsupportedOperationException: Unable to open DISPLAY
	at com.sun.glass.ui.gtk.GtkApplication.lambda$new$6(GtkApplication.java:181)
	at java.base/java.security.AccessController.doPrivileged(Native Method)
	at com.sun.glass.ui.gtk.GtkApplication.<init>(GtkApplication.java:179)
	at com.sun.glass.ui.gtk.GtkPlatformFactory.createApplication(GtkPlatformFactory.java:41)
	at com.sun.glass.ui.Application.run(Application.java:146)
	at com.sun.javafx.tk.quantum.QuantumToolkit.startup(QuantumToolkit.java:291)
	at com.sun.javafx.application.PlatformImpl.startup(PlatformImpl.java:293)
	at com.sun.javafx.application.PlatformImpl.startup(PlatformImpl.java:163)
	at com.sun.javafx.application.LauncherImpl.startToolkit(LauncherImpl.java:659)
	at com.sun.javafx.application.LauncherImpl.launchApplication1(LauncherImpl.java:679)
	at com.sun.javafx.application.LauncherImpl.lambda$launchApplication$2(LauncherImpl.java:196)
	at java.base/java.lang.Thread.run(Thread.java:834)
```

