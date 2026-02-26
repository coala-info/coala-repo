# gepard CWL Generation Report

## gepard

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/gepard:2.1.0--hdfd78af_1
- **Homepage**: https://cube.univie.ac.at/gepard
- **Package**: https://anaconda.org/channels/bioconda/packages/gepard/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/gepard/overview
- **Total Downloads**: 7.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/univieCUBE/gepard
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
java.awt.HeadlessException: 
No X11 DISPLAY variable was set, but this program performed an operation which requires it.
	at java.desktop/java.awt.GraphicsEnvironment.checkHeadless(GraphicsEnvironment.java:208)
	at java.desktop/java.awt.Window.<init>(Window.java:548)
	at java.desktop/java.awt.Frame.<init>(Frame.java:423)
	at java.desktop/java.awt.Frame.<init>(Frame.java:388)
	at java.desktop/javax.swing.JFrame.<init>(JFrame.java:180)
	at org.gepard.client.userinterface.ContainerWindow.<init>(ContainerWindow.java:22)
	at org.gepard.client.Controller.<init>(Controller.java:126)
	at org.gepard.client.Start.main(Start.java:8)
Exception in thread "main" java.lang.NullPointerException
	at org.gepard.client.Controller.getGUIDump(Controller.java:1471)
	at org.gepard.client.ClientGlobals.unexpectedError(ClientGlobals.java:145)
	at org.gepard.client.Controller.<init>(Controller.java:146)
	at org.gepard.client.Start.main(Start.java:8)
```

