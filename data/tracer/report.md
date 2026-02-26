# tracer CWL Generation Report

## tracer

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/tracer:1.7.2--hdfd78af_0
- **Homepage**: http://beast.community/tracer
- **Package**: https://anaconda.org/channels/bioconda/packages/tracer/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/tracer/overview
- **Total Downloads**: 20.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Exception while loading the ApplicationAdapter:
java.lang.reflect.InvocationTargetException
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.base/java.lang.reflect.Method.invoke(Method.java:566)
	at jam.mac.Utils.registerDesktopApplication(Unknown Source)
	at jam.framework.MultiDocApplication.initialize(Unknown Source)
	at tracer.application.TracerApp.main(Unknown Source)
Caused by: java.awt.HeadlessException: 
No X11 DISPLAY variable was set, but this program performed an operation which requires it.
	at java.desktop/java.awt.Desktop.getDesktop(Desktop.java:301)
	at jam.java9only.ApplicationAdapter.registerApplication(Unknown Source)
	... 7 more
Exception in thread "main" java.awt.HeadlessException: 
No X11 DISPLAY variable was set, but this program performed an operation which requires it.
	at java.desktop/java.awt.GraphicsEnvironment.checkHeadless(GraphicsEnvironment.java:208)
	at java.desktop/java.awt.Window.<init>(Window.java:548)
	at java.desktop/java.awt.Frame.<init>(Frame.java:423)
	at java.desktop/java.awt.Frame.<init>(Frame.java:388)
	at java.desktop/javax.swing.JFrame.<init>(JFrame.java:180)
	at tracer.application.TracerApp.main(Unknown Source)
```

