# peptide-shaker CWL Generation Report

## peptide-shaker

### Tool Description
PeptideShaker is a search engine independent graphic user interface for interpretation of proteomics identification results from multiple search engines.

### Metadata
- **Docker Image**: quay.io/biocontainers/peptide-shaker:3.0.11--hdfd78af_0
- **Homepage**: https://compomics.github.io/projects/peptide-shaker.html
- **Package**: https://anaconda.org/channels/bioconda/packages/peptide-shaker/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/peptide-shaker/overview
- **Total Downloads**: 1.4M
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/compomics/peptide-shaker
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
java.io.FileNotFoundException: /usr/local/share/peptide-shaker-3.0.11-0/resources/conf/startup.log (Read-only file system)
	at java.base/java.io.FileOutputStream.open0(Native Method)
	at java.base/java.io.FileOutputStream.open(FileOutputStream.java:289)
	at java.base/java.io.FileOutputStream.<init>(FileOutputStream.java:230)
	at java.base/java.io.FileOutputStream.<init>(FileOutputStream.java:179)
	at java.base/java.io.FileWriter.<init>(FileWriter.java:98)
	at com.compomics.software.CompomicsWrapper.launchTool(CompomicsWrapper.java:160)
	at eu.isas.peptideshaker.PeptideShakerWrapper.<init>(PeptideShakerWrapper.java:60)
	at eu.isas.peptideshaker.PeptideShakerZipFileChecker.<init>(PeptideShakerZipFileChecker.java:61)
	at eu.isas.peptideshaker.PeptideShakerZipFileChecker.main(PeptideShakerZipFileChecker.java:71)
Exception in thread "main" java.awt.HeadlessException: 
No X11 DISPLAY variable was set,
or no headful library support was found,
but this program performed an operation which requires it,

	at java.desktop/java.awt.GraphicsEnvironment.checkHeadless(GraphicsEnvironment.java:166)
	at java.desktop/java.awt.Window.<init>(Window.java:553)
	at java.desktop/java.awt.Frame.<init>(Frame.java:428)
	at java.desktop/java.awt.Frame.<init>(Frame.java:393)
	at java.desktop/javax.swing.SwingUtilities$SharedOwnerFrame.<init>(SwingUtilities.java:1925)
	at java.desktop/javax.swing.SwingUtilities.getSharedOwnerFrame(SwingUtilities.java:2001)
	at java.desktop/javax.swing.JOptionPane.getRootFrame(JOptionPane.java:1696)
	at java.desktop/javax.swing.JOptionPane.showOptionDialog(JOptionPane.java:875)
	at java.desktop/javax.swing.JOptionPane.showMessageDialog(JOptionPane.java:677)
	at java.desktop/javax.swing.JOptionPane.showMessageDialog(JOptionPane.java:648)
	at com.compomics.software.CompomicsWrapper.launchTool(CompomicsWrapper.java:214)
	at eu.isas.peptideshaker.PeptideShakerWrapper.<init>(PeptideShakerWrapper.java:60)
	at eu.isas.peptideshaker.PeptideShakerZipFileChecker.<init>(PeptideShakerZipFileChecker.java:61)
	at eu.isas.peptideshaker.PeptideShakerZipFileChecker.main(PeptideShakerZipFileChecker.java:71)
```


## Metadata
- **Skill**: generated
