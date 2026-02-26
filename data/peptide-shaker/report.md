# peptide-shaker CWL Generation Report

## peptide-shaker

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/peptide-shaker:3.0.11--hdfd78af_0
- **Homepage**: https://compomics.github.io/projects/peptide-shaker.html
- **Package**: https://anaconda.org/channels/bioconda/packages/peptide-shaker/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/peptide-shaker/overview
- **Total Downloads**: 1.4M
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/compomics/peptide-shaker
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Command line: 
/usr/local/lib/jvm/bin/java -splash:resources/conf/peptide-shaker-splash.png -Xms128M -Xmx4096M -cp /usr/local/share/peptide-shaker-3.0.11-0/PeptideShaker-3.0.11.jar eu.isas.peptideshaker.gui.PeptideShakerGUI --help 

Exception in thread "main" java.awt.HeadlessException: 
No X11 DISPLAY variable was set,
or no headful library support was found,
but this program performed an operation which requires it,

	at java.desktop/java.awt.GraphicsEnvironment.checkHeadless(GraphicsEnvironment.java:166)
	at java.desktop/java.awt.Window.<init>(Window.java:553)
	at java.desktop/java.awt.Frame.<init>(Frame.java:428)
	at java.desktop/java.awt.Frame.<init>(Frame.java:393)
	at java.desktop/javax.swing.JFrame.<init>(JFrame.java:180)
	at eu.isas.peptideshaker.gui.PeptideShakerGUI.<init>(PeptideShakerGUI.java:592)
	at eu.isas.peptideshaker.gui.PeptideShakerGUI.main(PeptideShakerGUI.java:539)
Process exitValue: 1

Unknown error: exception in thread "main" java.awt.headlessexception: no x11 display variable was set,or no headful library support was found,but this program performed an operation which requires it,	at java.desktop/java.awt.graphicsenvironment.checkheadless(graphicsenvironment.java:166)	at java.desktop/java.awt.window.<init>(window.java:553)	at java.desktop/java.awt.frame.<init>(frame.java:428)	at java.desktop/java.awt.frame.<init>(frame.java:393)	at java.desktop/javax.swing.jframe.<init>(jframe.java:180)	at eu.isas.peptideshaker.gui.peptideshakergui.<init>(peptideshakergui.java:592)	at eu.isas.peptideshaker.gui.peptideshakergui.main(peptideshakergui.java:539)
```

