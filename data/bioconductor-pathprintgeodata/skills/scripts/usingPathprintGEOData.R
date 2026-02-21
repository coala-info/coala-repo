# Code example from 'usingPathprintGEOData' vignette. See references/ for full tutorial.

### R code from vignette source 'usingPathprintGEOData.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: usingPathprintGEOData.Rnw:61-119
###################################################
# use the pathprint library
library(pathprint)
library(SummarizedExperiment)
library(pathprintGEOData)

# load  the data
data(SummarizedExperimentGEO)

ds = c("chipframe", "genesets","pathprint.Hs.gs","platform.thresholds",
    "pluripotents.frame")
data(list = ds)

# see available platforms
names(chipframe)

# extract GEO.fingerprint.matrix and GEO.metadata.matrix
GEO.fingerprint.matrix = assays(geo_sum_data)$fingerprint
GEO.metadata.matrix = colData(geo_sum_data)

# create consensus fingerprint for pluripotent samples
pluripotent.consensus<-consensusFingerprint(
    GEO.fingerprint.matrix[,pluripotents.frame$GSM],
    threshold=0.9)

# calculate distance from the pluripotent consensus
geo.pluripotentDistance<-consensusDistance(
    pluripotent.consensus, GEO.fingerprint.matrix)

# plot histograms
par(mfcol = c(2,1), mar = c(0, 4, 4, 2))

geo.pluripotentDistance.hist<-hist(
    geo.pluripotentDistance[,"distance"],
    nclass = 50, xlim = c(0,1), 
    main = "Distance from pluripotent consensus")

par(mar = c(7, 4, 4, 2))

hist(geo.pluripotentDistance[
    pluripotents.frame$GSM, "distance"],
    breaks = geo.pluripotentDistance.hist$breaks, 
    xlim = c(0,1), 
    main = "", 
    xlab = "above: all GEO, below: pluripotent samples")

# annotate top 100 matches not in original seed with metadata
geo.pluripotentDistance.noSeed<-geo.pluripotentDistance[
    !(rownames(geo.pluripotentDistance)
    %in% 
    pluripotents.frame$GSM),
    ]

top.noSeed.meta<-GEO.metadata.matrix[
    match(
    head(rownames(geo.pluripotentDistance.noSeed), 100),
                            rownames(GEO.metadata.matrix)),
    ]
print(top.noSeed.meta[, c(1:4)])


