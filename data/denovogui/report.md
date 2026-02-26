# denovogui CWL Generation Report

## denovogui

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: biocontainers/denovogui:v1.10.4_cv4
- **Homepage**: https://github.com/CompOmics/denovogui
- **Package**: Not found
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/denovogui/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/CompOmics/denovogui
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Exception in thread "main" java.awt.AWTError: Can't connect to X11 window server using ':0' as the value of the DISPLAY variable.
	at sun.awt.X11GraphicsEnvironment.initDisplay(Native Method)
	at sun.awt.X11GraphicsEnvironment.access$200(X11GraphicsEnvironment.java:65)
	at sun.awt.X11GraphicsEnvironment$1.run(X11GraphicsEnvironment.java:115)
	at java.security.AccessController.doPrivileged(Native Method)
	at sun.awt.X11GraphicsEnvironment.<clinit>(X11GraphicsEnvironment.java:74)
	at java.lang.Class.forName0(Native Method)
	at java.lang.Class.forName(Class.java:264)
	at java.awt.GraphicsEnvironment.createGE(GraphicsEnvironment.java:103)
	at java.awt.GraphicsEnvironment.getLocalGraphicsEnvironment(GraphicsEnvironment.java:82)
	at sun.awt.X11.XToolkit.<clinit>(XToolkit.java:126)
	at java.lang.Class.forName0(Native Method)
	at java.lang.Class.forName(Class.java:264)
	at java.awt.Toolkit$2.run(Toolkit.java:860)
	at java.awt.Toolkit$2.run(Toolkit.java:855)
	at java.security.AccessController.doPrivileged(Native Method)
	at java.awt.Toolkit.getDefaultToolkit(Toolkit.java:854)
	at sun.swing.SwingUtilities2.getSystemMnemonicKeyMask(SwingUtilities2.java:2020)
	at javax.swing.plaf.basic.BasicLookAndFeel.initComponentDefaults(BasicLookAndFeel.java:1158)
	at javax.swing.plaf.metal.MetalLookAndFeel.initComponentDefaults(MetalLookAndFeel.java:431)
	at javax.swing.plaf.basic.BasicLookAndFeel.getDefaults(BasicLookAndFeel.java:148)
	at javax.swing.plaf.metal.MetalLookAndFeel.getDefaults(MetalLookAndFeel.java:1577)
	at javax.swing.UIManager.setLookAndFeel(UIManager.java:539)
	at javax.swing.UIManager.setLookAndFeel(UIManager.java:579)
	at javax.swing.UIManager.initializeDefaultLAF(UIManager.java:1349)
	at javax.swing.UIManager.initialize(UIManager.java:1459)
	at javax.swing.UIManager.maybeInitialize(UIManager.java:1426)
	at javax.swing.UIManager.getInstalledLookAndFeels(UIManager.java:419)
	at com.compomics.util.gui.UtilitiesGUIDefaults.setLookAndFeel(UtilitiesGUIDefaults.java:32)
	at com.compomics.software.CompomicsWrapper.launchTool(CompomicsWrapper.java:142)
	at com.compomics.denovogui.DeNovoGUIWrapper.<init>(DeNovoGUIWrapper.java:66)
	at com.compomics.denovogui.DeNovoGUIZipFileChecker.<init>(DeNovoGUIZipFileChecker.java:61)
	at com.compomics.denovogui.DeNovoGUIZipFileChecker.main(DeNovoGUIZipFileChecker.java:71)
```

