# Code example from 'ITALICS' vignette. See references/ for full tutorial.

### R code from vignette source 'ITALICS.Rnw'

###################################################
### code chunk number 1: ITALICS.Rnw:95-100
###################################################
require(ITALICS)
ITALICSDataPATH <- attr(as.environment(match("package:ITALICSData",search())),"path")
load(paste(ITALICSDataPATH,"/data/snpInfo.RData", sep=""))
load(paste(ITALICSDataPATH,"/data/quartetInfo.RData", sep=""))



###################################################
### code chunk number 2: ITALICS.Rnw:106-114
###################################################
ITALICSDataPATH <- attr(as.environment(match("package:ITALICSData",search())),"path")
filename <- paste(ITALICSDataPATH,"/extdata/HF0844_Xba.CEL", sep="")

headdetails <- readCelHeader(filename[1])
pkgname <- cleanPlatformName(headdetails[["chiptype"]])

quartetEffectFile <- paste(ITALICSDataPATH,"/extdata/Xba.QuartetEffect.csv", sep="")
quartetEffect <- read.table(quartetEffectFile, sep=";", header=TRUE)


###################################################
### code chunk number 3: ITALICS.Rnw:129-132
###################################################
profilSNPXba <- ITALICS(quartet$quartetInfo, snpInfo,
     formule="Smoothing+QuartetEffect+FL+I(FL^2)+I(FL^3)+GC+I(GC^2)+I(GC^3)")



###################################################
### code chunk number 4: ITALICS.Rnw:139-141
###################################################
data(cytoband)
plotProfile(profilSNPXba, Smoothing="Smoothing", cytoband=cytoband)


