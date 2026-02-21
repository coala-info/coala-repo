# About limmaGUI

limmaGUI is a Graphical User Interface for Gordon Smyth's [limma](http://bioinf.wehi.edu.au/limma/) package (Linear
Models for MicroArray data). It uses state-of-the-art statistical
techniques to normalize microarray data, perform diagnostic plots
and to find differentially expressed genes in complex
experimental designs. limma and limmaGUI are both [R](http://www.r-project.org/) packages. The [limma](http://bioinf.wehi.edu.au/limma/) package offers R
users a command-line interface. The limmaGUI package, while not as
powerful as limma to the expert user, offers a simple
point-and-click interface to many of the commonly-used limma
functions.

In order to use limmaGUI, you need to have [R 2.10.0](http://www.r-project.org/) or later,
[Tcl/Tk](http://www.tcl.tk) 8.3 or
later ([ActiveTcl for
Windows](http://www.activestate.com/Products/ActiveTcl/) or [Fink
Tcl/Tk for MacOSX (X11)](http://fink.sourceforge.net/pdb/search.php?s=tcltk) or an appropriate Linux
[Tcl/Tk](http://www.tcl.tk) installed
either from source or by a package manager e.g. RPM)
You also need the
[limma](http://bioinf.wehi.edu.au/limma), limmaGUI,
tkrplot, R2HTML and xtable R packages.
Install all required packages using biocLite as explained on the
 [Bioconductor site](http://bioconductor.org/docs/install/).
limmaGUI has been
succesfully tested on Windows 2000, Windows XP, and Red Hat Linux,
and on Mac OSX with X11.

## Some screenshots from limmaGUI

### The Weaver data set...

![](about_files/WeaverMtMMPlotSelected.jpg)

![](about_files/Mutant11vsMutant21ScatterPlot.jpg)

### Differentially Expressed Genes from the Swirl Data Set...

![](about_files/SwirlToptable.jpg)

## [limmaGUI Home](http://bioinf.wehi.edu.au/limmaGUI/index.html)