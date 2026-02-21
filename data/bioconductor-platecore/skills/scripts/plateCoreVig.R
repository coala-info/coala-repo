# Code example from 'plateCoreVig' vignette. See references/ for full tutorial.

### R code from vignette source 'plateCoreVig.Rnw'

###################################################
### code chunk number 1: plateCoreVig.Rnw:16-17
###################################################
library(gplots)


###################################################
### code chunk number 2: loadPacks
###################################################
library(plateCore)
data(plateCore)


###################################################
### code chunk number 3: plateCoreVig.Rnw:98-99
###################################################
ls()


###################################################
### code chunk number 4: plateCoreVig.Rnw:109-110
###################################################
pbmcPlate


###################################################
### code chunk number 5: plateCoreVig.Rnw:120-121
###################################################
head(wellAnnotation)


###################################################
### code chunk number 6: plateCoreVig.Rnw:132-133
###################################################
wellAnnotation[50,]


###################################################
### code chunk number 7: plateCoreVig.Rnw:153-154
###################################################
pbmcFP <- flowPlate(pbmcPlate,wellAnnotation,plateName="PBMC.001")


###################################################
### code chunk number 8: plateCoreVig.Rnw:159-161
###################################################
pData(phenoData(pbmcPlate))[1,]
pData(phenoData(pbmcFP))[1,]


###################################################
### code chunk number 9: plateCoreVig.Rnw:167-170
###################################################
rectGate <- rectangleGate("FSC-H"=c(300,700),"SSC-H"=c(50,400))
normGate <- norm2Filter("SSC-H","FSC-H",scale.factor=2.5)
pbmcFP.lymph <- Subset(pbmcFP, rectGate & normGate)


###################################################
### code chunk number 10: lymphGate
###################################################

print(xyplot(`SSC-H` ~ `FSC-H` | as.factor(Well.Id),pbmcFP[93:96],smooth=FALSE,displayFilter=TRUE,col=c("red","blue"),
filter=rectangleGate("FSC-H"=c(300,700),"SSC-H"=c(50,400)) & norm2Filter("SSC-H","FSC-H",scale.factor=2.5)))	
  


###################################################
### code chunk number 11: plateCoreVig.Rnw:198-200
###################################################
comp.mat <- spillover(x=compensationSet,unstain=sampleNames(compensationSet)[5],
patt=".*H",fsc="FSC-H",ssc="SSC-H",method="median")


###################################################
### code chunk number 12: plateCoreVig.Rnw:209-210 (eval = FALSE)
###################################################
## pbmcFPcomp <- compensate(pbmcFP.lymph,comp.mat)


###################################################
### code chunk number 13: plateCoreVig.Rnw:223-224
###################################################
pbmcFPbgc <- fixAutoFl(pbmcFP.lymph,fsc="FSC-H",chanCols=rownames(comp.mat))


###################################################
### code chunk number 14: bgc1
###################################################
temp <- pbmcFP.lymph[96]
fsMed <- log10(median(exprs(temp[[1]])[,"FSC-H"]))
temp <- fsApply(plateSet(temp),function(x) {
			flVals <- log10(exprs(x)[,"FL1-H"])
			fsc <-  log10(exprs(x)[,"FSC-H"])
			exprs(x)[,"FL1-H"] <- 10^(flVals+4*(fsc-fsMed))
			x
		})
temp2 <- as(list("0877408774.H12"=temp[[1]]),"flowSet")
wellTemp <- subset(wellAnnotation(pbmcFP),Well.Id=="H12")
temp2 <- flowPlate(temp2,wellTemp,plateName="H12")
temp2 <- fixAutoFl(temp2,fsc="FSC-H",chanCols=c("FL1-H","FL2-H"),unstain="0877408774.H12")
temp <- as(list("H11"=temp[[1]],"H11 (corrected)"=temp2[[1]]),"flowSet")
temp <- transform("FL1-H"=log10) %on% temp
print(flowViz::levelplot(`FL1-H` ~ `FSC-H` | as.factor(name),data=temp, ylim=c(0,2.2)))	


###################################################
### code chunk number 15: plateCoreVig.Rnw:265-266
###################################################
fs <- plateSet(pbmcFP)


###################################################
### code chunk number 16: plateCoreVig.Rnw:272-275 (eval = FALSE)
###################################################
## rectGate <- rectangleGate("FSC-H"=c(400,700),"SSC-H"=c(100,300))
## xyplot(`SSC-H` ~ `FSC-H` | as.factor(Well.Id), pbmcFP[1:2], displayFilter=TRUE,
## smooth=FALSE, col=c("red","blue"),filter=rectGate)


###################################################
### code chunk number 17: plateCoreVig.Rnw:281-284 (eval = FALSE)
###################################################
## rectGate <- rectangleGate("FSC-H"=c(300,700),"SSC-H"=c(50,400))
## normGate <- norm2Filter("SSC-H","FSC-H",scale.factor=1.5)
## xyplot(`SSC-H` ~ `FSC-H` | as.factor(Well.Id), pbmcFP[1:4], displayFilter=TRUE, smooth=FALSE, col=c("red","blue"),filter=normGate & rectGate)


###################################################
### code chunk number 18: plateCoreVig.Rnw:293-296 (eval = FALSE)
###################################################
## rectGate <- rectangleGate("FSC-H"=c(300,700),"SSC-H"=c(50,400))
## normGate <- norm2Filter("SSC-H","FSC-H",scale.factor=1.5)
## pbmcFP.lymph <- Subset(pbmcFP, rectGate & normGate)


###################################################
### code chunk number 19: controlGates
###################################################
pbmcFPbgc <- setControlGates(pbmcFPbgc,gateType="Negative.Control",numMads=5)
pbmcFPbgc <- applyControlGates(pbmcFPbgc)


###################################################
### code chunk number 20: plateCoreVig.Rnw:319-322 (eval = FALSE)
###################################################
## xyplot(`FL1-H` ~ `FSC-H` | as.factor(Well.Id), 
## transform("FL1-H"=log10) %on% pbmcFPbgc, displayFilter=TRUE,
## smooth=FALSE,col=c("red","blue"),filter="Negative.Control")


###################################################
### code chunk number 21: isoGate1
###################################################

wells <- unique(subset(pbmcFPbgc@wellAnnotation,Negative.Control=="A03",select="name")[,1])
print(xyplot(`FL1-H` ~ `FSC-H` | as.factor(Well.Id), transform("FL1-H"=log10) %on% pbmcFPbgc[wells], displayFilter=TRUE,smooth=FALSE, col=c("red","blue"),
filter="Negative.Control"))



###################################################
### code chunk number 22: plateCoreVig.Rnw:355-361 (eval = FALSE)
###################################################
## wells <- unique(subset(pbmcFPbgc@wellAnnotation,Negative.Control=="A03",
##   select="name")[,1])
## xyplot(`FL1-H` ~ `FSC-H` | as.factor(Well.Id), 
##   transform("FL1-H"=log10) %on% pbmcFPbgc[wells], 
##   displayFilter=TRUE,smooth=FALSE, col=c("red","blue"),
##   filter="Negative.Control")


###################################################
### code chunk number 23: plateCoreVig.Rnw:373-379 (eval = FALSE)
###################################################
## wells <- unique(subset(pbmcFPbgc@wellAnnotation,Negative.Control=="A06",
##   select="name")[,1])
## xyplot(`FL1-H` ~ `FSC-H` | as.factor(Well.Id), 
##   transform("FL1-H"=log10) %on% pbmcFPbgc[wells], 
##   displayFilter=TRUE,smooth=FALSE, col=c("blue","green"),
##   filter="Negative.Control",filterResults="Negative.Control")


###################################################
### code chunk number 24: plateCoreVig.Rnw:384-387 (eval = FALSE)
###################################################
## xyplot(log10(`FL1-H`) ~ `FSC-H` | as.factor(Well.Id), pbmcFPbgc[wells], 
## displayFilter=TRUE,smooth=FALSE, col=c("blue","green"),
## filter="Negative.Control",filterResults="Negative.Control")


###################################################
### code chunk number 25: isoGate2
###################################################

wells <- unique(subset(pbmcFPbgc@wellAnnotation,Negative.Control=="A06",select="name")[,1])

print(xyplot(`FL1-H` ~ `FSC-H` | as.factor(Well.Id), transform("FL1-H"=log10) %on% pbmcFPbgc[wells], displayFilter=TRUE,smooth=FALSE, col=c("blue","green"),
filter="Negative.Control",filterResults="Negative.Control"))



###################################################
### code chunk number 26: plateCoreVig.Rnw:413-414
###################################################
pbmcFPbgc <- summaryStats(pbmcFPbgc)


###################################################
### code chunk number 27: plateCoreVig.Rnw:417-418
###################################################
colnames(pbmcFPbgc@wellAnnotation)


###################################################
### code chunk number 28: plateCoreVig.Rnw:431-440 (eval = FALSE)
###################################################
## controlGroups <- getGroups(pbmcFPbgc,chan="FL1-H")
## 
## print(xyplot(`FL1-H` ~ `FSC-H` | as.factor(Well.Id),
## 	transform("FL1-H"=log10) %on% pbmcFPbgc[controlGroups[[3]]],
## 	displayFilter=TRUE,
## 	smooth=FALSE,
## 	col=c("red","blue"),
## 	filter="Negative.Control",
## 	flowStrip=c("Well.Id","Ab.Name","Percent.Positive")))


###################################################
### code chunk number 29: plateCoreVig.Rnw:445-446 (eval = FALSE)
###################################################
## write.csv(pbmcFPbgc@wellAnnotation,file="PMBC.001.csv")


###################################################
### code chunk number 30: isoGate3
###################################################
controlGroups <- getGroups(pbmcFPbgc,chan="FL1-H")

print(xyplot(`FL1-H` ~ `FSC-H` | as.factor(Well.Id),
				transform("FL1-H"=log10) %on% pbmcFPbgc[controlGroups[[3]]],
				displayFilter=TRUE,
				smooth=FALSE,
				col=c("red","blue"),
				filter="Negative.Control",
				flowStrip=c("Well.Id","Ab.Name","Percent.Positive")))


###################################################
### code chunk number 31: plateCoreVig.Rnw:485-486
###################################################
summary(wellAnnotation(pbmcFPbgc)$Total.Count)


###################################################
### code chunk number 32: plateCoreVig.Rnw:496-498 (eval = FALSE)
###################################################
## print(flowViz::ecdfplot(~`FSC-H` | as.factor(Column.Id),
##  data=plateSet(pbmcFPbgc), groups=Row.Id, auto.key=TRUE))


###################################################
### code chunk number 33: plateCoreVig.Rnw:515-517 (eval = FALSE)
###################################################
## mfiPlot(fp,thresh=2,xlab="MFI Ratio (Test MFI / Isotype MFI)",xlim=c(0.1,250),
## 		ylab="Percentage of cells above the isotype gate",pch=23)


###################################################
### code chunk number 34: ecdf
###################################################
print(flowViz::ecdfplot(~`FSC-H` | as.factor(Column.Id),
				data=plateSet(pbmcFPbgc), groups=Row.Id, auto.key=TRUE))


###################################################
### code chunk number 35: mfiRatio
###################################################
mfiPlot(pbmcFPbgc,thresh=2,xlab="MFI Ratio (Test MFI / Isotype MFI)",xlim=c(0.1,250),
		ylab="Percentage of cells above the isotype gate",pch=23)


###################################################
### code chunk number 36: plateCoreVig.Rnw:567-586 (eval = FALSE)
###################################################
## plateName <- "lymph08774"
## 
## plateDescription <- read.delim("pmbcPlateLayout.csv",
## 	as.is=TRUE,header=TRUE,stringsAsFactors=FALSE)
## 
## platePBMCraw <- flowPlate(data=read.flowSet(path="data/pbmc/08774"),
## 	plateDescription,plateName=plateName)
## 
## platePBMC <- Subset(platePBMCraw,
## 	rectangleGate("FSC-H"=c(300,700),"SSC-H"=c(50,400)) & 
## 	norm2Filter("SSC-H","FSC-H",scale.factor=1.5))
## 
## platePBMC <- setControlGates(platePBMC,gateType="Negative.Control")
## 
## platePBMC <- applyControlGates(platePBMC)
## 
## platePBMC <- summaryStats(platePBMC)
## 
## save.image(file=paste("pbmcRData/",plateName,".Rdata",sep=""))


###################################################
### code chunk number 37: plateCoreVig.Rnw:593-599 (eval = FALSE)
###################################################
## fileNames <- list.files("pbmcRData",full.names=TRUE)
## plates <- lapply(fileNames,function(x){
## 			load(x)
## 			platePBMC
## 		})
## virtPlate <- fpbind(plates[[1]],plates[[2]],plates[[3]],plates[[4]],plates[[5]])


###################################################
### code chunk number 38: plateCoreVig.Rnw:605-610 (eval = FALSE)
###################################################
## print(densityplot(~ `FL2-H` | as.factor(plateName),
## 	transform("FL2-H"=log10) %on% virtPlate[c("C02","C03","A05")],
## 	layout=c(3,2),xlim=c(-0.2,2.5),
## 	filterResult="Negative.Control",lty=c(1,2,3,4),
## 	col=c('blue','black','red')))


