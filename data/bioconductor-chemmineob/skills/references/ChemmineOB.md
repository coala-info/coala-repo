# *ChemmineOB*: Interface to a Subset of OpenBabel Functionalities

Authors: Kevin Horan, [Thomas Girke](mailto:thomas.girke@ucr.edu)

#### Last update: 29 October, 2025

#### Package

ChemmineOB 1.48.0

Note: the most recent version of this tutorial can be found [here](https://htmlpreview.github.io/?https://github.com/girke-lab/ChemmineOB/blob/master/vignettes/ChemmineOB.html) and a short overview slide show [here](http://faculty.ucr.edu/~tgirke/HTML_Presentations/Manuals/Workshop_Dec_5_8_2014/Rcheminfo/Cheminfo.pdf).

# 1 Introduction

`ChemmineOB` provides an R interface to a subset of
cheminformatics functionalities implemented by the OpelBabel C++ project
(O’Boyle, Morley, and Hutchison [2008](#ref-18328109); O’Boyle et al. [2011](#ref-21982300)). OpenBabel is an open source
cheminformatics toolbox that includes utilities for structure format
interconversions, descriptor calculations, compound similarity searching
and more. `ChemineOB` aims to make a subset of these
utilities available from within R. For non-developers,
`ChemineOB` is primarily intended to be used from
`ChemmineR` (Cao et al. [2008](#ref-Cao2008c); Backman, Cao, and Girke [2011](#ref-Backman2011a); Wang et al. [2013](#ref-Wang2013a)) as an add-on package
rather than used directly.

# 2 Installation

To use the `ChemmineOB` package on Linux or Mac, OpenBabel
2.3.0 or greater needs to be installed on a system. On Linux systems,
the OpenBabel header files are also required in order to compile `ChemmineOB`. The windows distribution
will include its own version of OpenBabel. The OpenBabel site
(<http://openbabel.org/wiki/Get_Open_Babel>) provides excellent
instructions for installing the OpenBabel software on Mac or Linux
systems. The `ChemmineR` and `ChemmineOB`
packages can be installed from within R with:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install(c("ChemmineR", "ChemmineOB"))
library("ChemmineR")
library("ChemmineOB")
```

If the installation fails on Linux, you may need to manually set the
locations of the open babel libraries and header files. This is best
done through configure flags. For example, at the command prompt do:

```
$ R CMD INSTALL --configure-args='--with-openbabel-include=...  --with-openbabel-lib=...' <ChemmineOB package file>
```

where the ‘…’ are replaced by the relevant paths. See the README file
for more details.

# 3 Limitations on Windows

Some OpenBabel modules are not avaible through ChemmineOB on windows. These currently include
“MACCS” and “InChi”.

# 4 User Manual in ChemmineR Vignette

Detailed instructions for using `ChemmineOB` are provided
in the vignette of the `ChemmineR` package instead of this
document. The main reason for consolidating the documentation in one
central document rather than distributing it across several vignettes is
that it helps minimizing duplications and inconsistencies. It also is
the more suitable format for providing a task-oriented description of
functionalities for users. To obtain an overview of the OpenBabel
utilities supported by `ChemmineOB`, we recommend
consulting the *OpenBabel Functions* section of the
`ChemmineR` vignette. To open the `ChemmineR`
vignette from R, one can use the following command.

```
 vignette("ChemmineR")
```

# 5 SWIG Interface (For R developers)

`ChemmineOB` now includes wrapper functions for all of OpenBabel, as genereted by
[SWIG](http://www.swig.org). We still maintain our own set of functions to provide
better integration with R in general and `ChemmineR` specifically.

If you are familiar with the [Open Babel API](http://openbabel.org/api/2.3/), using the SWIG wrapper should be
similar, once you know a few conventions used. You can look at the R code in this
package to see examples of these.

* New objects are created with a function with the same name as the object you
  want to construct. So instead of

```
OBConversion *x = new OBConversion(...)
```

in R you would have:

```
x = OBConversion(...)
```

* Methods on objects are called through a function whose name is the name of the
  object type concatenated with the method name, separated by an underscore. Then the
  first argument of this method is the instance of the object. For example,
  instead of:

```
x->AddOption(...)
```

we have:

```
OBConversion_AddOption(x,...)
```

* If you need a char\* you can create one in R with the `stringp` function.
  The char\* pointer can be accessed with the `cast` slot. The value can
  be retrieved from the `value` slot. For example:

```
result = stringp()
OBDescriptor_GetStringValue(... , result$cast())
stringValue = result$value()
```

* STL vectors of various types are available via functions named as “vector{TYPE NAME}”. For example,
  a vector of unsigned int is created wit the function “vectorUnsignedInt”. You can get the size of
  this vector with “vectorUnsignedInt\_size(vectorVariable)”.

There are still many special cases however. The [SWIG documentation](http://www.swig.org/Doc2.0/SWIGDocumentation.html)
can help, as well as browsing the generated R code in R/ChemmineOB.R.

# 6 Version Information

```
sessionInfo()
```

R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86\_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
LAPACK: /usr/lib/x86\_64-linux-gnu/lapack/liblapack.so.3.12.0 LAPACK version 3.12.0

locale:
[1] LC\_CTYPE=en\_US.UTF-8 LC\_NUMERIC=C LC\_TIME=en\_GB
[4] LC\_COLLATE=C LC\_MONETARY=en\_US.UTF-8 LC\_MESSAGES=en\_US.UTF-8
[7] LC\_PAPER=en\_US.UTF-8 LC\_NAME=C LC\_ADDRESS=C
[10] LC\_TELEPHONE=C LC\_MEASUREMENT=en\_US.UTF-8 LC\_IDENTIFICATION=C

time zone: America/New\_York
tzcode source: system (glibc)

attached base packages:
[1] stats graphics grDevices utils datasets methods base

other attached packages:
[1] ChemmineOB\_1.48.0 BiocStyle\_2.38.0

loaded via a namespace (and not attached):
[1] digest\_0.6.37 R6\_2.6.1 codetools\_0.2-20 bookdown\_0.45
[5] fastmap\_1.2.0 xfun\_0.53 cachem\_1.1.0 knitr\_1.50
[9] htmltools\_0.5.8.1 rmarkdown\_2.30 lifecycle\_1.0.4 cli\_3.6.5
[13] sass\_0.4.10 jquerylib\_0.1.4 compiler\_4.5.1 tools\_4.5.1
[17] evaluate\_1.0.5 bslib\_0.9.0 yaml\_2.3.10 BiocManager\_1.30.26
[21] jsonlite\_2.0.0 rlang\_1.1.6

# 7 Funding

This software was developed with funding from the National Science
Foundation:
[ABI-0957099](http://www.nsf.gov/awardsearch/showAward.do?AwardNumber=0957099),
2010-0520325 and IGERT-0504249.

# References

Backman, T W, Y Cao, and T Girke. 2011. “ChemMine tools: an online service for analyzing and clustering small molecules.” *Nucleic Acids Res* 39 (Web Server issue): 486–91. <https://doi.org/10.1093/nar/gkr320>.

Cao, Y, A Charisi, L C Cheng, T Jiang, and T Girke. 2008. “ChemmineR: a compound mining framework for R.” *Bioinformatics* 24 (15): 1733–4. <https://doi.org/10.1093/bioinformatics/btn307>.

O’Boyle, Noel, Michael Banck, Craig James, Chris Morley, Tim Vandermeersch, and Geoffrey Hutchison. 2011. “Open Babel: An Open Chemical Toolbox.” *Journal of Cheminformatics* 3 (1): 33. <https://doi.org/10.1186/1758-2946-3-33>.

O’Boyle, Noel, Chris Morley, and Geoffrey Hutchison. 2008. “Pybel: A Python Wrapper for the Openbabel Cheminformatics Toolkit.” *Chemistry Central Journal* 2 (1): 5. <https://doi.org/10.1186/1752-153X-2-5>.

Wang, Y, T W Backman, K Horan, and T Girke. 2013. “fmcsR: Mismatch Tolerant Maximum Common Substructure Searching in R.” *Bioinformatics*, August. <https://doi.org/10.1093/bioinformatics/btt475>.