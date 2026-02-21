# Code example from 'quickstart' vignette. See references/ for full tutorial.

### R code from vignette source 'quickstart.Rnw'

###################################################
### code chunk number 1: quickstart.Rnw:55-57 (eval = FALSE)
###################################################
## library(CALIB)
## calibReadMe()


###################################################
### code chunk number 2: quickstart.Rnw:97-100
###################################################
library(CALIB)
path<-system.file("arraydata", package="CALIB")
dir(system.file("arraydata", package="CALIB")) 


###################################################
### code chunk number 3: quickstart.Rnw:106-109
###################################################
datapath <- system.file("arraydata", package="CALIB")
targets <- readTargets("targets.txt",path=datapath)
targets


###################################################
### code chunk number 4: quickstart.Rnw:116-117
###################################################
RG <- read.rg(targets$FileName,columns=list(Rf="CH1_NBC_INT",Gf="CH2_NBC_INT",Rb="CH1_SPOT_BKGD",Gb="CH2_SPOT_BKGD",RArea="CH1_SPOT_AREA",GArea="CH2_SPOT_AREA"),path=datapath)


###################################################
### code chunk number 5: quickstart.Rnw:122-126
###################################################
filename <- "annotation.txt"
fullname <- file.path(datapath,filename)
annotation <- read.table(file=fullname,header=T,fill=T,quote="",sep="\t")
RG$genes <- annotation


###################################################
### code chunk number 6: quickstart.Rnw:131-135
###################################################
types<-readSpotTypes(path=datapath)
types
spotstatus<-controlStatus(types,RG$genes)
RG$genes$Status<-spotstatus


###################################################
### code chunk number 7: quickstart.Rnw:140-142
###################################################
concfile<-"conc.txt"
spike<-read.spike(RG,file=concfile,path=datapath)


###################################################
### code chunk number 8: spikeci
###################################################
arraynum <- 1
plotSpikeCI(spike,array=arraynum)


###################################################
### code chunk number 9: quickstart.Rnw:163-164
###################################################
parameter<-estimateParameter(spike,RG,bc=F,area=T,errormodel="M")


###################################################
### code chunk number 10: spikehi
###################################################
plotSpikeHI(spike,parameter,array=arraynum)


###################################################
### code chunk number 11: quickstart.Rnw:185-193
###################################################
array<-c(1,1,2,2)
condition<-c(1,2,2,1)
dye<-c(1,2,1,2)
idcol<-"CLONE_ID"
## here, we normalize the first ten genes as example.
cloneid<-RG$genes[1:10,idcol]
normdata<-normalizeData(RG,parameter,array,condition,dye,idcol=idcol,cloneid=cloneid)
normdata


