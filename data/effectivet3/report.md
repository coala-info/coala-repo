# effectivet3 CWL Generation Report

## effectivet3

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/effectivet3:1.0.1--py36_0
- **Homepage**: https://github.com/nicolasrnemeth/EffectiveT3
- **Package**: Not found
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/effectivet3/overview
- **Total Downloads**: 8.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/nicolasrnemeth/EffectiveT3
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Exception in thread "main" java.lang.reflect.InvocationTargetException
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at com.simontuffs.onejar.Boot.run(Boot.java:243)
	at com.simontuffs.onejar.Boot.main(Boot.java:89)
Caused by: java.awt.HeadlessException: 
No X11 DISPLAY variable was set, but this program performed an operation which requires it.
	at java.awt.GraphicsEnvironment.checkHeadless(GraphicsEnvironment.java:204)
	at java.awt.Window.<init>(Window.java:536)
	at java.awt.Frame.<init>(Frame.java:420)
	at java.awt.Frame.<init>(Frame.java:385)
	at javax.swing.JFrame.<init>(JFrame.java:189)
	at de.tum.wzw.gui.GUIFrame.<init>(GUIFrame.java:47)
	at de.tum.wzw.controller.MainController.main(MainController.java:143)
	... 6 more
```

