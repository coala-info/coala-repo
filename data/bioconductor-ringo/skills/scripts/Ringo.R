# Code example from 'Ringo' vignette. See references/ for full tutorial.

### R code from vignette source 'Ringo.Rnw'

###################################################
### code chunk number 1: prepare
###################################################
options(length=60, stringsAsFactors=FALSE)
set.seed(123)
options(SweaveHooks=list(
   along=function() par(mar=c(2.5,4.2,4,1.5), font.lab=2),
   boxplot=function() par(mar=c(5,5,1,1), font.lab=4),
   dens=function() par(mar=c(4.1, 4.1, 0.1, 0.1), font.lab=2)))


###################################################
### code chunk number 2: loadpackage
###################################################
library("Ringo")


###################################################
### code chunk number 3: locateData
###################################################
exDir <- system.file("exData",package="Ringo")
list.files(exDir, pattern="pair.txt")
head(read.delim(file.path(exDir,"MOD_20551_PMT1_pair.txt"),
                skip=1))[,c(1,4:7,9)]


###################################################
### code chunk number 4: exampleFilesTxt
###################################################
read.delim(file.path(exDir,"example_targets.txt"), header=TRUE)


###################################################
### code chunk number 5: spottypes
###################################################
read.delim(file.path(exDir,"spottypes.txt"), header=TRUE)


###################################################
### code chunk number 6: readNimblegen
###################################################
exRG <- readNimblegen("example_targets.txt","spottypes.txt",path=exDir)


###################################################
### code chunk number 7: showRG
###################################################
head(exRG$R)
head(exRG$G)
head(exRG$genes)
exRG$targets


###################################################
### code chunk number 8: loadProbeAnno
###################################################
load(file.path(exDir,"exampleProbeAnno.rda"))
ls(exProbeAnno)
show(exProbeAnno)
head(exProbeAnno["9.start"])
head(exProbeAnno["9.end"])


###################################################
### code chunk number 9: imageRG0 (eval = FALSE)
###################################################
## par(mar=c(0.01,0.01,0.01,0.01), bg="black")
## image(exRG, 1, channel="green", mycols=c("black","green4","springgreen"))


###################################################
### code chunk number 10: imageRG
###################################################
#jpeg("Ringo-imageRG.jpg", quality=100, height=400, width=360)
png("Ringo-imageRG.png", units="in", res=200, height=4, width=3.5)
par(mar=c(0.01,0.01,0.01,0.01), bg="black")
image(exRG, 1, channel="green", mycols=c("black","green4","springgreen"))
dev.off()


###################################################
### code chunk number 11: plotDensities
###################################################
plotDensities(exRG)


###################################################
### code chunk number 12: showGFF
###################################################
head(exGFF[,c("name","symbol","chr","strand","start","end")])


###################################################
### code chunk number 13: autocorRG0
###################################################
exAc <- autocor(exRG, probeAnno=exProbeAnno, chrom="9", lag.max=1000)
plot(exAc)


###################################################
### code chunk number 14: preprocess (eval = FALSE)
###################################################
## exampleX <- preprocess(exRG)
## sampleNames(exampleX) <-
##  with(exRG$targets, paste(Cy5,"vs",Cy3,sep="_"))
## print(exampleX)


###################################################
### code chunk number 15: loadExampleX
###################################################
load(file.path(exDir,"exampleX.rda"))
print(exampleX)


###################################################
### code chunk number 16: preprocessNG
###################################################
exampleX.NG <- preprocess(exRG, method="nimblegen")
sampleNames(exampleX.NG) <- sampleNames(exampleX)


###################################################
### code chunk number 17: comparePreprocessings
###################################################
corPlot(cbind(exprs(exampleX),exprs(exampleX.NG)),
        grouping=c("VSN normalized","Tukey-biweight scaled"))


###################################################
### code chunk number 18: chipAlongChrom
###################################################
getOption("SweaveHooks")[["along"]]()
plot(exampleX, exProbeAnno, chrom="9", xlim=c(34318000,34321000),
     ylim=c(-2,4), gff=exGFF, colPal=c("skyblue", "darkblue"))


###################################################
### code chunk number 19: smoothing
###################################################
smoothX <- computeRunningMedians(exampleX, probeAnno=exProbeAnno,
modColumn = "Cy5", allChr = "9", winHalfSize = 400)
sampleNames(smoothX) <- paste(sampleNames(exampleX),"smoothed")


###################################################
### code chunk number 20: smoothAlongChrom
###################################################
getOption("SweaveHooks")[["along"]]()
combX <- combine(exampleX, smoothX)
plot(combX, exProbeAnno, chrom="9", xlim=c(34318000,34321000), 
     ylim=c(-2,4), gff=exGFF, colPal=c("skyblue", "steelblue"))


###################################################
### code chunk number 21: setY0
###################################################
(y0 <- apply(exprs(smoothX),2,upperBoundNull))


###################################################
### code chunk number 22: histogramSmoothed
###################################################
getOption("SweaveHooks")[["dens"]]()
h1 <- hist(exprs(smoothX)[,1], n=50, xlim=c(-1.25,2.25), main=NA,
           xlab="Smoothed reporter intensities [log]")
abline(v=y0[1], col="red")


###################################################
### code chunk number 23: cherFinding
###################################################
chersX <- findChersOnSmoothed(smoothX, probeAnno=exProbeAnno, thresholds=y0,
   allChr="9", distCutOff=600, cellType="human")
chersX <- relateChers(chersX, exGFF)
chersXD <- as.data.frame.cherList(chersX)


###################################################
### code chunk number 24: showChers
###################################################
chersXD[order(chersXD$maxLevel, decreasing=TRUE),]


###################################################
### code chunk number 25: plotCher
###################################################
getOption("SweaveHooks")[["along"]]()
plot(chersX[[1]], smoothX, probeAnno=exProbeAnno, gff=exGFF,
     paletteName="Spectral")


###################################################
### code chunk number 26: readAgilentData
###################################################
agiDir <- system.file("agilentData", package="Ringo")
arrayfiles <- list.files(path=agiDir,
 pattern="H3K4Me3_Tc1Liver_sol1_mmChr17_part.txt")
RG <- read.maimages(arrayfiles, source="agilent", path=agiDir)


###################################################
### code chunk number 27: readAgiTargets
###################################################
at <- readTargets(file.path(agiDir,"targets.txt"))
RG$targets <- at


###################################################
### code chunk number 28: showAgilentRG
###################################################
show(RG)


###################################################
### code chunk number 29: imageAgiRG0 (eval = FALSE)
###################################################
## par(mar=c(0.01,0.01,0.01,0.01), bg="black")
## image(RG, 1, channel="red", dim1="Col", dim2="Row",
##       mycols=c("sienna","darkred","orangered"))


###################################################
### code chunk number 30: imageAgiRG
###################################################
#jpeg("Ringo-imageAgiRG.jpg", quality=100, height=455, width=534)
png("Ringo-imageAgiRG.png", res=200, units="in", height=4.55, width=5.34)
par(mar=c(0.01,0.01,0.01,0.01), bg="black")
image(RG, 1, channel="red", dim1="Row", dim2="Col",
      mycols=c("sienna","darkred","orangered"))
dev.off()


###################################################
### code chunk number 31: makeAgilentProbeAnno
###################################################
pA <- extractProbeAnno(RG, "agilent", genome="mouse", 
   microarray="Agilent Tiling Chr17")


###################################################
### code chunk number 32: agiLoadGenomeAnno
###################################################
load(file=file.path(agiDir,"mm9chr17.RData"))


###################################################
### code chunk number 33: preprocessAgilentData
###################################################
X <- preprocess(RG[RG$genes$ControlType==0,], method="nimblegen", 
                idColumn="ProbeName")
sampleNames(X) <- X$SlideNumber


###################################################
### code chunk number 34: agiProbeDistances
###################################################
probeDists <- diff(pA["17.start"])
br <- c(0, 100, 200, 300, 500, 1000, 10000, max(probeDists))
table(cut(probeDists, br))


###################################################
### code chunk number 35: agiSmoothing
###################################################
smoothX <- computeRunningMedians(X, modColumn="Antibody",
              winHalfSize=500, min.probes=3, probeAnno=pA)
sampleNames(smoothX) <- paste(sampleNames(X),"smooth",sep=".")


###################################################
### code chunk number 36: agiSmoothAlongChrom
###################################################
getOption("SweaveHooks")[["along"]]()
combX <- combine(X, smoothX)
plot(combX, pA, chr="17", coord=33887000+c(0, 13000),
     gff=mm9chr17, maxInterDistance=450, paletteName="Paired")


###################################################
### code chunk number 37: agiGetTwoThresholds
###################################################
y0  <- upperBoundNull(exprs(smoothX))
y0G <- twoGaussiansNull(exprs(smoothX))


###################################################
### code chunk number 38: agiShowHistogram
###################################################
getOption("SweaveHooks")[["dens"]]()
hist(exprs(smoothX), n=100, main=NA, 
     xlab="Smoothed expression level [log2]")
abline(v=y0, col="red", lwd=2)
abline(v=y0G, col="blue", lwd=2)
legend(x="topright", lwd=2, col=c("red","blue"),
       legend=c("Non-parametric symmetric Null", "Gaussian Null"))


###################################################
### code chunk number 39: agiFindChers
###################################################
chersX <- findChersOnSmoothed(smoothX, probeAnno=pA, threshold=y0G,
                              cellType="Tc1Liver")
chersX <- relateChers(chersX, gff=mm9chr17, upstream=5000)


###################################################
### code chunk number 40: agiShowChers
###################################################
chersXD <- as.data.frame(chersX)
head(chersXD[order(chersXD$maxLevel, decreasing=TRUE),])


###################################################
### code chunk number 41: sessionInfo
###################################################
toLatex(sessionInfo(), locale=FALSE)


