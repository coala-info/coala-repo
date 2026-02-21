# Code example from 'SwathXtend_vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'SwathXtend_vignette.Rnw'

###################################################
### code chunk number 1: SwathXtend_vignette.Rnw:49-52 (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("SwathXtend")


###################################################
### code chunk number 2: 1
###################################################
rm(list=ls())
library(SwathXtend)


###################################################
### code chunk number 3: 2
###################################################
filenames <- c("Lib2.txt", "Lib3.txt") 
libfiles <- paste(system.file("files",package="SwathXtend"),
	filenames,sep="/")
Lib2 <- readLibFile(libfiles[1], clean=TRUE)
Lib3 <- readLibFile(libfiles[2], clean=TRUE)


###################################################
### code chunk number 4: SwathXtend_vignette.Rnw:140-144 (eval = FALSE)
###################################################
## Lib2 <- cleanLib(Lib2, intensity.cutoff = 5, conf.cutoff = 0.99, 
## 			nomod = FALSE, nomc = FALSE)
## Lib3 <- cleanLib(Lib3, intensity.cutoff = 5, conf.cutoff = 0.99, 
## 			nomod = FALSE, nomc = FALSE)


###################################################
### code chunk number 5: 3
###################################################
checkQuality(Lib2, Lib3)


###################################################
### code chunk number 6: SwathXtend_vignette.Rnw:166-167
###################################################
plotRTCor(Lib2, Lib3, "Lib2", "Lib3")


###################################################
### code chunk number 7: SwathXtend_vignette.Rnw:170-171
###################################################
plotRTResd(Lib2, Lib3)


###################################################
### code chunk number 8: SwathXtend_vignette.Rnw:174-175
###################################################
plotRIICor(Lib2, Lib3)


###################################################
### code chunk number 9: c
###################################################
plotAll(Lib2, Lib3, file="allplots.xlsx")


###################################################
### code chunk number 10: 4 (eval = FALSE)
###################################################
## Lib2_3 <- buildSpectraLibPair(libfiles[1], libfiles[2], clean=T, 
## 				nomc=T, nomod=T, plot=F, 
## 				outputFormat = "peakview",
## 				outputFile = "Lib2_3.txt")	


###################################################
### code chunk number 11: SwathXtend_vignette.Rnw:202-206
###################################################
hydroFile <- paste(system.file("files",package="SwathXtend"),
				"hydroIndex.txt",sep="/")
hydro <- readLibFile(hydroFile, type="hydro")
head(hydro)					


###################################################
### code chunk number 12: SwathXtend_vignette.Rnw:212-218 (eval = FALSE)
###################################################
## Lib2_3.hydro <- buildSpectraLibPair(libfiles[1], libfiles[2], hydro, 
## 				clean=T, 
## 				nomc=T, nomod=T, plot=F, 
## 				method="hydro",
## 				outputFormat = "peakview",
## 				outputFile = "Lib2_3.txt")	


###################################################
### code chunk number 13: SwathXtend_vignette.Rnw:224-225 (eval = FALSE)
###################################################
## outputLib(Lib2_3, filename="Lib2_3.txt", format="peakview")


###################################################
### code chunk number 14: SwathXtend_vignette.Rnw:240-243 (eval = FALSE)
###################################################
## libfiles <- paste(system.file("files",package="SwathXtend"),
## 		c("Lib2.txt", "Lib2_3.txt"),sep="/")
## res = reliabilityCheckLibrary(libfiles[1], libfiles[2])


###################################################
### code chunk number 15: SwathXtend_vignette.Rnw:256-261
###################################################
fswaths = paste(system.file("files",package="SwathXtend"),
	c("Swath_result_seed.xlsx", "Swath_result_ext.xlsx"), 
	sep="/")
res = reliabilityCheckSwath(fswaths[1], fswaths[2], max.fdrpass=8, 
	max.peptide=2)


###################################################
### code chunk number 16: SwathXtend_vignette.Rnw:298-300
###################################################
fdr.seed = readWorkbook(fswaths[1], sheet='FDR')
fdr.ext = readWorkbook(fswaths[2], sheet='FDR')


###################################################
### code chunk number 17: SwathXtend_vignette.Rnw:306-309
###################################################
fdr.seed = fdr.crit(fdr.seed)
fdr.ext = fdr.crit(fdr.ext)
head(fdr.ext[,c(1:2,ncol(fdr.ext))])


###################################################
### code chunk number 18: SwathXtend_vignette.Rnw:315-317 (eval = FALSE)
###################################################
## swa.seed = readWorkbook(fswaths[1], 2)
## swa.ext = readWorkbook(fswaths[2], 2)


###################################################
### code chunk number 19: SwathXtend_vignette.Rnw:325-330 (eval = FALSE)
###################################################
## fdr.seed = fdr.seed[fdr.seed$nfdr.pass > 0,]
## fdr.ext = fdr.ext[fdr.ext$nfdr.pass > 0,]
## 
## res = quantification.accuracy(swa.seed[fdr.seed$nfdr.pass >= 1,], 
## 	swa.ext[fdr.ext$nfdr.pass >= 1,], method="cv")[[1]]


