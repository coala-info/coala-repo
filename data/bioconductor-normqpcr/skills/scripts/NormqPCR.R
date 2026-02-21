# Code example from 'NormqPCR' vignette. See references/ for full tutorial.

### R code from vignette source 'NormqPCR.Rnw'

###################################################
### code chunk number 1: read.qPCR.tech.reps
###################################################
library(ReadqPCR) # load the ReadqPCR library
library(NormqPCR)
path <- system.file("exData", package = "NormqPCR")
qPCR.example.techReps <- file.path(path, "qPCR.techReps.txt")
qPCRBatch.qPCR.techReps <- read.qPCR(qPCR.example.techReps)
rownames(exprs(qPCRBatch.qPCR.techReps))[1:8]


###################################################
### code chunk number 2: combine read.qPCR.tech.reps
###################################################
combinedTechReps <- combineTechReps(qPCRBatch.qPCR.techReps)
combinedTechReps


###################################################
### code chunk number 3: taqman read
###################################################
path <- system.file("exData", package = "NormqPCR")
taqman.example <- file.path(path, "/example.txt")
qPCRBatch.taqman <- read.taqman(taqman.example)


###################################################
### code chunk number 4: taqman detector example
###################################################
exprs(qPCRBatch.taqman)["Ccl20.Rn00570287_m1",]


###################################################
### code chunk number 5: replace above cutoff
###################################################
qPCRBatch.taqman.replaced <- replaceAboveCutOff(qPCRBatch.taqman, 
                                                newVal = NA, cutOff = 35)
exprs(qPCRBatch.taqman.replaced)["Ccl20.Rn00570287_m1",]


###################################################
### code chunk number 6: replace NAs with 40
###################################################
qPCRBatch.taqman.replaced <- replaceNAs(qPCRBatch.taqman, newNA = 40)
exprs(qPCRBatch.taqman.replaced)["Ccl20.Rn00570287_m1",]


###################################################
### code chunk number 7: construct contrast matrix
###################################################
sampleNames(qPCRBatch.taqman)
a <- c(0,0,1,1,0,0,1,1) # one for each sample type, with 1 representing
b <- c(1,1,0,0,1,1,0,0) # position of sample type in samplenames vector 
contM <- cbind(a,b)
colnames(contM) <- c("case","control") # set the names of each sample type
rownames(contM) <- sampleNames(qPCRBatch.taqman) # set row names
contM
sMaxM <- t(as.matrix(c(3,3))) # now make the contrast matrix
colnames(sMaxM) <- c("case","control") # make sure these line up with samples
sMaxM


###################################################
### code chunk number 8: replace 3 or more NAs with all NAs
###################################################
qPCRBatch.taqman.replaced <- makeAllNewVal(qPCRBatch.taqman, contM, 
                                           sMaxM, newVal=NA)


###################################################
### code chunk number 9: ccl20 is now all NAs
###################################################
exprs(qPCRBatch.taqman.replaced)["Ccl20.Rn00570287_m1",]


###################################################
### code chunk number 10: NormqPCR
###################################################
options(width = 68)
data(geNorm)
str(exprs(geNorm.qPCRBatch))


###################################################
### code chunk number 11: geNorm
###################################################
tissue <- as.factor(c(rep("BM", 9),  rep("FIB", 20), rep("LEU", 13),
                    rep("NB", 34), rep("POOL", 9)))
res.BM <- selectHKs(geNorm.qPCRBatch[,tissue == "BM"], method = "geNorm", 
                    Symbols = featureNames(geNorm.qPCRBatch), 
                    minNrHK = 2, log = FALSE)
res.POOL <- selectHKs(geNorm.qPCRBatch[,tissue == "POOL"], 
                      method = "geNorm", 
                      Symbols = featureNames(geNorm.qPCRBatch), 
                      minNrHK = 2, trace = FALSE, log = FALSE)
res.FIB <- selectHKs(geNorm.qPCRBatch[,tissue == "FIB"], 
                     method = "geNorm", 
                     Symbols = featureNames(geNorm.qPCRBatch), 
                     minNrHK = 2, trace = FALSE, log = FALSE)
res.LEU <- selectHKs(geNorm.qPCRBatch[,tissue == "LEU"], 
                     method = "geNorm", 
                     Symbols = featureNames(geNorm.qPCRBatch), 
                     minNrHK = 2, trace = FALSE, log = FALSE)
res.NB <- selectHKs(geNorm.qPCRBatch[,tissue == "NB"], 
                    method = "geNorm", 
                    Symbols = featureNames(geNorm.qPCRBatch), 
                    minNrHK = 2, trace = FALSE, log = FALSE)


###################################################
### code chunk number 12: table3
###################################################
ranks <- data.frame(c(1, 1:9), res.BM$ranking, res.POOL$ranking, 
                    res.FIB$ranking, res.LEU$ranking, 
                    res.NB$ranking)
names(ranks) <- c("rank", "BM", "POOL", "FIB", "LEU", "NB")
ranks


###################################################
### code chunk number 13: fig2
###################################################
library(RColorBrewer)
mypalette <- brewer.pal(5, "Set1")
matplot(cbind(res.BM$meanM, res.POOL$meanM, res.FIB$meanM, 
              res.LEU$meanM, res.NB$meanM), type = "b", 
        ylab = "Average expression stability M", 
        xlab = "Number of remaining control genes", 
        axes = FALSE, pch = 19, col = mypalette, 
        ylim = c(0.2, 1.22), lty = 1, lwd = 2, 
        main = "Figure 2 in Vandesompele et al. (2002)")
axis(1, at = 1:9, labels = as.character(10:2))
axis(2, at = seq(0.2, 1.2, by = 0.2), labels = seq(0.2, 1.2, by = 0.2))
box()
abline(h = seq(0.2, 1.2, by = 0.2), lty = 2, lwd = 1, col = "grey")
legend("topright", legend = c("BM", "POOL", "FIB", "LEU", "NB"), 
       fill = mypalette)


###################################################
### code chunk number 14: fig3a
###################################################
mypalette <- brewer.pal(8, "YlGnBu")
barplot(cbind(res.POOL$variation, res.LEU$variation, res.NB$variation, 
              res.FIB$variation, res.BM$variation), beside = TRUE, 
        col = mypalette, space = c(0, 2), 
        names.arg = c("POOL", "LEU", "NB", "FIB", "BM"),
        ylab = "Pairwise variation V",
        main = "Figure 3(a) in Vandesompele et al. (2002)")
legend("topright", legend = c("V9/10", "V8/9", "V7/8", "V6/7", 
                              "V5/6", "V4/5", "V3/4", "V2/3"), 
       fill = mypalette, ncol = 2)
abline(h = seq(0.05, 0.25, by = 0.05), lty = 2, col = "grey")
abline(h = 0.15, lty = 1, col = "black")


###################################################
### code chunk number 15: NormFinder
###################################################
data(Colon)
Colon
Class <- pData(Colon)[,"Classification"]
res.Colon <- stabMeasureRho(Colon, group = Class, log = FALSE)
sort(res.Colon) # see Table 3 in Andersen et al (2004)

data(Bladder)
Bladder
grade <- pData(Bladder)[,"Grade"]
res.Bladder <- stabMeasureRho(Bladder, group = grade,
                              log = FALSE)
sort(res.Bladder)


###################################################
### code chunk number 16: NormFinder1
###################################################
selectHKs(Colon, log = FALSE, trace = FALSE, 
          Symbols = featureNames(Colon))$ranking
selectHKs(Bladder, log = FALSE, trace = FALSE, 
          Symbols = featureNames(Bladder))$ranking


###################################################
### code chunk number 17: NormFinder2
###################################################
Class <- pData(Colon)[,"Classification"]
selectHKs(Colon, group = Class, log = FALSE, trace = TRUE,
          Symbols = featureNames(Colon), minNrHKs = 12,
          method = "NormFinder")$ranking


###################################################
### code chunk number 18: NormFinder3
###################################################
grade <- pData(Bladder)[,"Grade"]
selectHKs(Bladder, group = grade, log = FALSE, trace = FALSE, 
          Symbols = featureNames(Bladder), minNrHKs = 13,
          method = "NormFinder")$ranking


###################################################
### code chunk number 19: taqman read dCq
###################################################
path <- system.file("exData", package = "NormqPCR")
taqman.example <- file.path(path, "example.txt")
qPCR.example <- file.path(path, "qPCR.example.txt")
qPCRBatch.taqman <- read.taqman(taqman.example)


###################################################
### code chunk number 20: dCq
###################################################
hkgs<-"Actb-Rn00667869_m1"
qPCRBatch.norm <- deltaCq(qPCRBatch =  qPCRBatch.taqman, hkgs = hkgs, calc="arith")
head(exprs(qPCRBatch.norm))


###################################################
### code chunk number 21: dCq many genes
###################################################
hkgs<-c("Actb-Rn00667869_m1", "B2m-Rn00560865_m1", "Gapdh-Rn99999916_s1")
qPCRBatch.norm <- deltaCq(qPCRBatch =  qPCRBatch.taqman, hkgs = hkgs, calc="arith")
head(exprs(qPCRBatch.norm))


###################################################
### code chunk number 22: taqman read
###################################################
path <- system.file("exData", package = "NormqPCR")
taqman.example <- file.path(path, "example.txt")
qPCR.example <- file.path(path, "qPCR.example.txt")
qPCRBatch.taqman <- read.taqman(taqman.example)


###################################################
### code chunk number 23: contrast
###################################################
contM <- cbind(c(0,0,1,1,0,0,1,1),c(1,1,0,0,1,1,0,0))
colnames(contM) <- c("interestingPhenotype","wildTypePhenotype")
rownames(contM) <- sampleNames(qPCRBatch.taqman)
contM


###################################################
### code chunk number 24: ddCq
###################################################
hkg <- "Actb-Rn00667869_m1"
ddCq.taqman <- deltaDeltaCq(qPCRBatch = qPCRBatch.taqman, maxNACase=1, maxNAControl=1, 
                            hkg=hkg, contrastM=contM, case="interestingPhenotype", 
                            control="wildTypePhenotype", statCalc="geom", hkgCalc="arith")
head(ddCq.taqman)


###################################################
### code chunk number 25: ddCq Avg
###################################################
hkg <- "Actb-Rn00667869_m1"
ddCqAvg.taqman <- deltaDeltaCq(qPCRBatch = qPCRBatch.taqman, maxNACase=1, maxNAControl=1, 
                               hkg=hkg, contrastM=contM, case="interestingPhenotype", 
                               control="wildTypePhenotype", paired=FALSE, statCalc="geom", 
                               hkgCalc="arith")
head(ddCqAvg.taqman)


###################################################
### code chunk number 26: taqman gM
###################################################
qPCRBatch.taqman <- read.taqman(taqman.example)
contM <- cbind(c(0,0,1,1,0,0,1,1),c(1,1,0,0,1,1,0,0))
colnames(contM) <- c("interestingPhenotype","wildTypePhenotype")
rownames(contM) <- sampleNames(qPCRBatch.taqman)
hkgs<-c("Actb-Rn00667869_m1", "B2m-Rn00560865_m1", "Gapdh-Rn99999916_s1")
ddCq.gM.taqman <- deltaDeltaCq(qPCRBatch = qPCRBatch.taqman, maxNACase=1, maxNAControl=1, 
                               hkgs=hkgs, contrastM=contM, case="interestingPhenotype", 
                               control="wildTypePhenotype", statCalc="arith", hkgCalc="arith")
head(ddCq.gM.taqman)


###################################################
### code chunk number 27: taqman gM Avg
###################################################
qPCRBatch.taqman <- read.taqman(taqman.example)
contM <- cbind(c(0,0,1,1,0,0,1,1),c(1,1,0,0,1,1,0,0))
colnames(contM) <- c("interestingPhenotype","wildTypePhenotype")
rownames(contM) <- sampleNames(qPCRBatch.taqman)
hkgs<-c("Actb-Rn00667869_m1", "B2m-Rn00560865_m1", "Gapdh-Rn99999916_s1")
ddAvgCq.gM.taqman <-deltaDeltaCq(qPCRBatch = qPCRBatch.taqman, maxNACase=1, maxNAControl=1, 
                                 hkgs=hkgs, contrastM=contM, case="interestingPhenotype", 
                                 control="wildTypePhenotype", paired=FALSE, statCalc="arith", 
                                 hkgCalc="arith")
head(ddAvgCq.gM.taqman)


###################################################
### code chunk number 28: ComputeNRQs1
###################################################
path <- system.file("exData", package = "ReadqPCR")
qPCR.example <- file.path(path, "qPCR.example.txt")
Cq.data <- read.qPCR(qPCR.example)


###################################################
### code chunk number 29: ComputeNRQs2
###################################################
Cq.data1 <- combineTechRepsWithSD(Cq.data)


###################################################
### code chunk number 30: ComputeNRQs3
###################################################
Effs <- file.path(path, "Efficiencies.txt")
Cq.effs <- read.table(file = Effs, row.names = 1, header = TRUE)
rownames(Cq.effs) <- featureNames(Cq.data1)
effs(Cq.data1) <- as.matrix(Cq.effs[,"efficiency",drop = FALSE])
se.effs(Cq.data1) <- as.matrix(Cq.effs[,"SD.efficiency",drop = FALSE])


###################################################
### code chunk number 31: ComputeNRQs4
###################################################
res <- ComputeNRQs(Cq.data1, hkgs = c("gene_az", "gene_gx"))
## NRQs
exprs(res)
## SD of NRQs
se.exprs(res)


