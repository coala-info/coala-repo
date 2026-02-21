# Code example from 'Risa' vignette. See references/ for full tutorial.

### R code from vignette source 'Risa.Rnw'

###################################################
### code chunk number 1: LibraryPreload
###################################################
library(Risa)
require(faahKO)


###################################################
### code chunk number 2: Risa-readISAtab
###################################################
faahkoISA <- readISAtab(find.package("faahKO"))


###################################################
### code chunk number 3: Risa-processXcmsSet
###################################################
 assay.filename <- faahkoISA["assay.filenames"][1]
 faahkoXset <- processAssayXcmsSet(faahkoISA, assay.filename)


###################################################
### code chunk number 4: Risa-update
###################################################
updateAssayMetadata(faahkoISA, assay.filename,"Derived Spectral Data File","faahkoDSDF.txt" )


###################################################
### code chunk number 5: Risa-write.assay.file
###################################################
 temp = tempdir()
 write.ISAtab(faahkoISA, temp)
 #write.assay.file(faahkoISA, assay.filename, temp)


###################################################
### code chunk number 6: pkgs
###################################################
toLatex(sessionInfo())


