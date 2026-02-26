# damageprofiler CWL Generation Report

## damageprofiler

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/damageprofiler:1.1--hdfd78af_2
- **Homepage**: https://github.com/Integrative-Transcriptomics/dedup
- **Package**: https://anaconda.org/channels/bioconda/packages/damageprofiler/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/damageprofiler/overview
- **Total Downloads**: 44.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Integrative-Transcriptomics/dedup
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Loading library prism_es2 from resource failed: java.lang.UnsatisfiedLinkError: /root/.openjfx/cache/14/libprism_es2.so: libGL.so.1: cannot open shared object file: No such file or directory
java.lang.UnsatisfiedLinkError: /root/.openjfx/cache/14/libprism_es2.so: libGL.so.1: cannot open shared object file: No such file or directory
	at java.base/java.lang.ClassLoader$NativeLibrary.load0(Native Method)
	at java.base/java.lang.ClassLoader$NativeLibrary.load(ClassLoader.java:2442)
	at java.base/java.lang.ClassLoader$NativeLibrary.loadLibrary(ClassLoader.java:2498)
	at java.base/java.lang.ClassLoader.loadLibrary0(ClassLoader.java:2694)
	at java.base/java.lang.ClassLoader.loadLibrary(ClassLoader.java:2627)
	at java.base/java.lang.Runtime.load0(Runtime.java:768)
	at java.base/java.lang.System.load(System.java:1837)
	at com.sun.glass.utils.NativeLibLoader.installLibraryFromResource(NativeLibLoader.java:214)
	at com.sun.glass.utils.NativeLibLoader.loadLibraryFromResource(NativeLibLoader.java:194)
	at com.sun.glass.utils.NativeLibLoader.loadLibraryInternal(NativeLibLoader.java:135)
	at com.sun.glass.utils.NativeLibLoader.loadLibrary(NativeLibLoader.java:53)
	at com.sun.prism.es2.ES2Pipeline.lambda$static$0(ES2Pipeline.java:68)
	at java.base/java.security.AccessController.doPrivileged(Native Method)
	at com.sun.prism.es2.ES2Pipeline.<clinit>(ES2Pipeline.java:50)
	at java.base/java.lang.Class.forName0(Native Method)
	at java.base/java.lang.Class.forName(Class.java:315)
	at com.sun.prism.GraphicsPipeline.createPipeline(GraphicsPipeline.java:218)
	at com.sun.javafx.tk.quantum.QuantumRenderer$PipelineRunnable.init(QuantumRenderer.java:91)
	at com.sun.javafx.tk.quantum.QuantumRenderer$PipelineRunnable.run(QuantumRenderer.java:124)
	at java.base/java.lang.Thread.run(Thread.java:834)
Exception in thread "Thread-0" java.lang.UnsupportedOperationException: Unable to open DISPLAY
	at com.sun.glass.ui.gtk.GtkApplication.lambda$new$6(GtkApplication.java:173)
	at java.base/java.security.AccessController.doPrivileged(Native Method)
	at com.sun.glass.ui.gtk.GtkApplication.<init>(GtkApplication.java:171)
	at com.sun.glass.ui.gtk.GtkPlatformFactory.createApplication(GtkPlatformFactory.java:41)
	at com.sun.glass.ui.Application.run(Application.java:144)
	at com.sun.javafx.tk.quantum.QuantumToolkit.startup(QuantumToolkit.java:280)
	at com.sun.javafx.application.PlatformImpl.startup(PlatformImpl.java:269)
	at com.sun.javafx.application.PlatformImpl.startup(PlatformImpl.java:158)
	at com.sun.javafx.application.LauncherImpl.startToolkit(LauncherImpl.java:658)
	at com.sun.javafx.application.LauncherImpl.launchApplication1(LauncherImpl.java:678)
	at com.sun.javafx.application.LauncherImpl.lambda$launchApplication$2(LauncherImpl.java:195)
	at java.base/java.lang.Thread.run(Thread.java:834)
```

