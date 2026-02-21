# Code example from 'CreateAHubPackage' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# .onLoad <- function(libname, pkgname) {
#    fl <- system.file("extdata", "metadata.csv", package=pkgname)
#    titles <- read.csv(fl, stringsAsFactors=FALSE)$Title
#    createHubAccessors(pkgname, titles)
# }

## ----eval=FALSE---------------------------------------------------------------
# library(ExperimentHub)
# eh <- ExperimentHub()
# myfiles <- query(eh, "PACKAGENAME")
# myfiles[[1]]        ## load the first resource in the list
# myfiles[["EH123"]]  ## load by EH id

## ----eval=FALSE---------------------------------------------------------------
# resourceA(metadata = FALSE) ## data are loaded
# resourceA(metadata = TRUE)  ## metadata are displayed

