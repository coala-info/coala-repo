# Code example from 'TCseq' vignette. See references/ for full tutorial.

### R code from vignette source 'TCseq.Rnw'

###################################################
### code chunk number 1: TCseq.Rnw:32-33
###################################################
library(TCseq)


###################################################
### code chunk number 2: TCseq.Rnw:36-38 (eval = FALSE)
###################################################
## dir <- dir.peaks
## gf <- peakreference(dir = dir, pattern = "narrowpeaks")


###################################################
### code chunk number 3: TCseq.Rnw:41-43
###################################################
data("genomicIntervals")
head(genomicIntervals)


###################################################
### code chunk number 4: TCseq.Rnw:48-54
###################################################
# Experiment design
data("experiment_BAMfile")
head(experiment_BAMfile)
# create a TCA object
tca <- TCA(design = experiment_BAMfile, genomicFeature = genomicIntervals)
tca


###################################################
### code chunk number 5: TCseq.Rnw:57-58 (eval = FALSE)
###################################################
## tca <- countReads(tca, dir = dir.BAM)


###################################################
### code chunk number 6: TCseq.Rnw:61-68
###################################################
#Experiment design without BAM file information
data("experiment")
#Counts table
data("countsTable")
tca <- TCA(design = experiment, genomicFeature = genomicIntervals,
           counts = countsTable)
tca


###################################################
### code chunk number 7: TCseq.Rnw:71-72 (eval = FALSE)
###################################################
## counts(tca) <- countsTable


###################################################
### code chunk number 8: TCseq.Rnw:76-79
###################################################
suppressWarnings(library(SummarizedExperiment))
se <- SummarizedExperiment(assays=list(counts = countsTable), colData = experiment)
tca <- TCAFromSummarizedExperiment(se = se, genomicFeature = genomicIntervals)


###################################################
### code chunk number 9: TCseq.Rnw:86-87
###################################################
tca <- DBanalysis(tca)


###################################################
### code chunk number 10: TCseq.Rnw:90-91
###################################################
tca <- DBanalysis(tca, filter.type = "raw", filter.value = 10, samplePassfilter = 2)


###################################################
### code chunk number 11: TCseq.Rnw:94-97
###################################################
DBres <- DBresult(tca, group1 = "0h", group2 = c("24h","40h","72h"))
str(DBres, strict.width =  "cut")
head(DBres$`24hvs0h`)


###################################################
### code chunk number 12: TCseq.Rnw:100-102
###################################################
DBres.sig <- DBresult(tca, group1 = "0h", group2 = c("24h","40h","72h"), top.sig = TRUE)
str(DBres.sig, strict.width =  "cut")


###################################################
### code chunk number 13: TCseq.Rnw:108-110
###################################################
# values are logFC
tca <- timecourseTable(tca, value = "FC", control.group = "0h", norm.method = "rpkm", filter = TRUE)


###################################################
### code chunk number 14: TCseq.Rnw:113-115
###################################################
# values are normalized read counts
tca <- timecourseTable(tca, value = "expression", norm.method = "rpkm", filter = TRUE)


###################################################
### code chunk number 15: TCseq.Rnw:118-120
###################################################
t <- tcTable(tca)
head(t)


###################################################
### code chunk number 16: TCseq.Rnw:124-125
###################################################
tca <- timeclust(tca, algo = "cm", k = 6, standardize = TRUE)


###################################################
### code chunk number 17: TCseq.Rnw:131-132 (eval = FALSE)
###################################################
## p <- timeclustplot(tca, value = "z-score(PRKM)", cols = 3)


###################################################
### code chunk number 18: TCseq.Rnw:142-144 (eval = FALSE)
###################################################
## #plot cluster 1:
## print(p[[1]])


