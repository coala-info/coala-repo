# searchgui CWL Generation Report

## searchgui

### Tool Description
SearchGUI is a graphical user interface for the PeptideShaker software suite, designed to facilitate the analysis of mass spectrometry data.

### Metadata
- **Docker Image**: quay.io/biocontainers/searchgui:4.3.15--hdfd78af_0
- **Homepage**: https://github.com/compomics/searchgui
- **Package**: https://anaconda.org/channels/bioconda/packages/searchgui/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/searchgui/overview
- **Total Downloads**: 751.5K
- **Last updated**: 2025-07-16
- **GitHub**: https://github.com/compomics/searchgui
- **Stars**: N/A
### Original Help Text
```text
Command line: 
/usr/local/lib/jvm/bin/java -splash:resources/conf/searchgui-splash.png -Xms128M -Xmx4096M -cp /usr/local/share/searchgui-4.3.15-0/SearchGUI-4.3.15.jar eu.isas.searchgui.gui.SearchGUI --help 

Exception in thread "main" java.awt.HeadlessException: 
No X11 DISPLAY variable was set,
or no headful library support was found,
but this program performed an operation which requires it,

	at java.desktop/java.awt.GraphicsEnvironment.checkHeadless(GraphicsEnvironment.java:164)
	at java.desktop/java.awt.Window.<init>(Window.java:553)
	at java.desktop/java.awt.Frame.<init>(Frame.java:428)
	at java.desktop/java.awt.Frame.<init>(Frame.java:393)
	at java.desktop/javax.swing.JFrame.<init>(JFrame.java:180)
	at eu.isas.searchgui.gui.SearchGUI.<init>(SearchGUI.java:268)
	at eu.isas.searchgui.gui.SearchGUI.main(SearchGUI.java:7691)
Process exitValue: 1

Unknown error: exception in thread "main" java.awt.headlessexception: no x11 display variable was set,or no headful library support was found,but this program performed an operation which requires it,	at java.desktop/java.awt.graphicsenvironment.checkheadless(graphicsenvironment.java:164)	at java.desktop/java.awt.window.<init>(window.java:553)	at java.desktop/java.awt.frame.<init>(frame.java:428)	at java.desktop/java.awt.frame.<init>(frame.java:393)	at java.desktop/javax.swing.jframe.<init>(jframe.java:180)	at eu.isas.searchgui.gui.searchgui.<init>(searchgui.java:268)	at eu.isas.searchgui.gui.searchgui.main(searchgui.java:7691)
```

