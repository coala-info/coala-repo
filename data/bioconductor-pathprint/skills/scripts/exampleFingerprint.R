# Code example from 'exampleFingerprint' vignette. See references/ for full tutorial.

### R code from vignette source 'exampleFingerprint.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: exampleFingerprint.Rnw:25-30
###################################################
options(width=60, stringsAsFactors = FALSE)
options(continue=" ")
tpbEnv <- new.env()
assign("cat", function(file,...) cat(file=stderr(),...), tpbEnv)
environment(txtProgressBar) <- tpbEnv


###################################################
### code chunk number 2: data
###################################################
library(GEOquery)
GSE26946 <- getGEO("GSE26946")
GSE26946.exprs <- exprs(GSE26946[[1]])
GSE26946.exprs[1:5, 1:3]
GSE26946.platform <- annotation(GSE26946[[1]])
GSE26946.species <- as.character(unique(phenoData(GSE26946[[1]])$organism_ch1))
GSE26946.names <- as.character(phenoData(GSE26946[[1]])$title)


###################################################
### code chunk number 3: fingerprint
###################################################
library(pathprint)
library(SummarizedExperiment)
library(pathprintGEOData)

# load  the data
data(compressed_result)

# load("chipframe.rda")
ds = c("chipframe", "genesets","pathprint.Hs.gs","platform.thresholds", "pluripotents.frame")
data(list = ds)

# extract GEO.fingerprint.matrix and GEO.metadata.matrix
GEO.fingerprint.matrix = assays(result)$fingerprint
GEO.metadata.matrix = colData(result)

GSE26946.fingerprint <- exprs2fingerprint(exprs = GSE26946.exprs,
                                          platform = GSE26946.platform,
                                          species = GSE26946.species,
                                          progressBar = FALSE
                                          )

GSE26946.fingerprint[1:5, 1:3]


###################################################
### code chunk number 4: existingFingerprint
###################################################
colnames(GSE26946.exprs) %in% colnames(GEO.fingerprint.matrix)
GSE26946.existing <- GEO.fingerprint.matrix[,colnames(GSE26946.exprs)]
all.equal(GSE26946.existing, GSE26946.fingerprint)


###################################################
### code chunk number 5: heatmap
###################################################
heatmap(GSE26946.fingerprint[apply(GSE26946.fingerprint, 1, sd) > 0, ],
        labCol = GSE26946.names,
        mar = c(10,10),
        col = c("blue", "white", "red"))


###################################################
### code chunk number 6: plotheatmap
###################################################
heatmap(GSE26946.fingerprint[apply(GSE26946.fingerprint, 1, sd) > 0, ],
        labCol = GSE26946.names,
        mar = c(10,10),
        col = c("blue", "white", "red"))


###################################################
### code chunk number 7: pluripotent
###################################################
# construct pluripotent consensus
pluripotent.consensus<-consensusFingerprint(
  GEO.fingerprint.matrix[,pluripotents.frame$GSM], threshold=0.9)

# calculate distance from the pluripotent consensus for all arrays
geo.pluripotentDistance<-consensusDistance(
	pluripotent.consensus, GEO.fingerprint.matrix)

# calculate distance from pluripotent consensus for GSE26946 arrays
GSE26946.pluripotentDistance<-consensusDistance(
  pluripotent.consensus, GSE26946.fingerprint)



###################################################
### code chunk number 8: histogram
###################################################
par(mfcol = c(2,1), mar = c(0, 4, 4, 2))
geo.pluripotentDistance.hist<-hist(geo.pluripotentDistance[,"distance"],
	nclass = 50, xlim = c(0,1), main = "Distance from pluripotent consensus")
par(mar = c(7, 4, 4, 2))
hist(geo.pluripotentDistance[pluripotents.frame$GSM, "distance"],
	breaks = geo.pluripotentDistance.hist$breaks, xlim = c(0,1), 
	main = "", xlab = "")
hist(GSE26946.pluripotentDistance[, "distance"],
  breaks = geo.pluripotentDistance.hist$breaks, xlim = c(0,1), 
	main = "", col = "red", add = TRUE)


###################################################
### code chunk number 9: plothistogram
###################################################
par(mfcol = c(2,1), mar = c(0, 4, 4, 2))
geo.pluripotentDistance.hist<-hist(geo.pluripotentDistance[,"distance"],
	nclass = 50, xlim = c(0,1), main = "Distance from pluripotent consensus")
par(mar = c(7, 4, 4, 2))
hist(geo.pluripotentDistance[pluripotents.frame$GSM, "distance"],
	breaks = geo.pluripotentDistance.hist$breaks, xlim = c(0,1), 
	main = "", xlab = "")
hist(GSE26946.pluripotentDistance[, "distance"],
  breaks = geo.pluripotentDistance.hist$breaks, xlim = c(0,1), 
	main = "", col = "red", add = TRUE)


###################################################
### code chunk number 10: distance
###################################################
GSE26946.H1<-consensusFingerprint(
  GSE26946.fingerprint[,grep("H1", GSE26946.names)], threshold=0.9)
geo.H1Distance<-consensusDistance(
  GSE26946.H1, GEO.fingerprint.matrix)
# look at top 20
GEO.metadata.matrix[match(head(rownames(geo.H1Distance),20), rownames(GEO.metadata.matrix)),c("GSE", "GPL", "Source")]


