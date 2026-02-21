# Code example from 'gaia' vignette. See references/ for full tutorial.

### R code from vignette source 'gaia.Rnw'

###################################################
### code chunk number 1: loadGAIA
###################################################
library(gaia)


###################################################
### code chunk number 2: loadMarkersData
###################################################
data(synthMarkers_Matrix)


###################################################
### code chunk number 3: loadCNVData
###################################################
data(synthCNV_Matrix)


###################################################
### code chunk number 4: createMarkersObject
###################################################
markers_obj <- load_markers(synthMarkers_Matrix)


###################################################
### code chunk number 5: createCNVObject
###################################################
cnv_obj <- load_cnv(synthCNV_Matrix, markers_obj, 10)


###################################################
### code chunk number 6: runGAIA_default
###################################################
results <- runGAIA(cnv_obj, markers_obj, "CompleteResults.txt")


###################################################
### code chunk number 7: printResults
###################################################
results[which(results[,6]==min(results[,6])),]


###################################################
### code chunk number 8: runGAIA_notDefault
###################################################
results <- runGAIA(cnv_obj, markers_obj, "Results.txt", aberrations=1, chromosomes=c(10, 11, 14), threshold=0.5)


###################################################
### code chunk number 9: loadCRC
###################################################
data(crc_markers)
data(crc)
crc_markers_obj <- load_markers(crc_markers)
crc_cnv_obj <- load_cnv(crc, crc_markers_obj, 30)


###################################################
### code chunk number 10: runGAIA_on_CRC
###################################################
res <- runGAIA(crc_cnv_obj, crc_markers_obj, "crcResults.txt",  chromosomes=14, hom_threshold=0.12)


###################################################
### code chunk number 11: runGAIA_approx_on_CRC
###################################################
res <- runGAIA(crc_cnv_obj, crc_markers_obj, "crc_approx_Results.txt", hom_threshold=0.12, num_iterations=5000, approximation=TRUE)


