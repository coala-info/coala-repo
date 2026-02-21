# Code example from 'CCl4' vignette. See references/ for full tutorial.

### R code from vignette source 'CCl4.Rnw'

###################################################
### code chunk number 1: loadlibs
###################################################
library("Biobase")
library("limma")
library("CCl4")


###################################################
### code chunk number 2: datapath
###################################################
datapath = system.file("extdata", package="CCl4")


###################################################
### code chunk number 3: RGList
###################################################
p = read.AnnotatedDataFrame("samplesInfo.txt", path=datapath)

CCl4_RGList = read.maimages(files=sampleNames(p), 
   path = datapath, 
   source = "genepix", 
   columns = list(R = "F635 Median", Rb = "B635 Median", 
                  G = "F532 Median", Gb = "B532 Median"))


###################################################
### code chunk number 4: outdir
###################################################
outdir = file.path("..", "..", "data")
if(!isTRUE(file.info(outdir)$isdir))
  outdir = tempdir()

save(CCl4_RGList, file = file.path(outdir, "CCl4_RGList.RData"))


###################################################
### code chunk number 5: tempdir
###################################################
outdir


###################################################
### code chunk number 6: CCl4-NChannelSet
###################################################

featureData = new("AnnotatedDataFrame", data = CCl4_RGList$genes)

assayData = with(CCl4_RGList, assayDataNew(R=R, G=G, Rb=Rb, Gb=Gb))

varMetadata(p)$channel=factor(c("G", "R", "G", "R"), 
                    levels=c(ls(assayData), "_ALL_"))

CCl4 <- new("NChannelSet",
              assayData = assayData,
              featureData = featureData,
              phenoData = p)
save(CCl4, file = file.path(outdir, "CCl4.RData"))


###################################################
### code chunk number 7: sessionInfo
###################################################
sessionInfo()


