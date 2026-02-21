# Code example from 'HD2013SGI' vignette. See references/ for full tutorial.

### R code from vignette source 'HD2013SGI.Rnw'

###################################################
### code chunk number 1: style
###################################################
  BiocStyle::latex()


###################################################
### code chunk number 2: installation (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("HD2013SGI")


###################################################
### code chunk number 3: moreSourceFiles (eval = FALSE)
###################################################
## # the source files for single sections are in the folder:
## system.file(file.path("doc","src"),package="HD2013SGI")
## # the R scripts for single sections are in the folder:
## system.file(file.path("doc"),package="HD2013SGI")


###################################################
### code chunk number 4: installation2
###################################################
library("HD2013SGI")


###################################################
### code chunk number 5: sessioninfo
###################################################
toLatex(sessionInfo())


###################################################
### code chunk number 6: bibstyle
###################################################
if ((R.version$major <= 3) & (R.version$minor < 1.0)) {
  cat("\\bibliographystyle{unsrt}\n")
}


