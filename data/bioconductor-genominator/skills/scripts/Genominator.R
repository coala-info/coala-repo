# Code example from 'Genominator' vignette. See references/ for full tutorial.

### R code from vignette source 'Genominator.Rnw'

###################################################
### code chunk number 1: Genominator.Rnw:5-6
###################################################
options(width = 80)


###################################################
### code chunk number 2: debug
###################################################
## -- For Debugging / Timing 
## require(RSQLite)
## source("../../R/Genominator.R")
## source("../../R/importAndManage.R")
## source("../../R/plotRegion.R")
## source("../../R/coverage.R")
## source("../../R/goodnessOfFit.R")


###################################################
### code chunk number 3: createExpData
###################################################
library(Genominator)
options(verbose = TRUE) # to be used by Genominator functions.
set.seed(123)
N <- 100000L # the number of observations. 
K <- 100L    # the number of annotation regions, not less than 10
df <- data.frame(chr = sample(1:16, size = N, replace = TRUE),
                 location = sample(1:1000, size = N, replace = TRUE),
                 strand = sample(c(1L,-1L), size = N, replace = TRUE))

head(df)
eDataRaw <- importToExpData(df, "my.db", tablename = "ex_tbl", overwrite = TRUE)
eDataRaw
head(eDataRaw)


###################################################
### code chunk number 4: aggregate
###################################################
eData <- aggregateExpData(eDataRaw, tablename = "counts_tbl",
                          deleteOriginal = FALSE, overwrite = TRUE)
eData
head(eData)


###################################################
### code chunk number 5: readOnly
###################################################
eData <- ExpData(dbFilename = "my.db", tablename = "counts_tbl") 
eData 
head(eData)


###################################################
### code chunk number 6: exampleOfSubsetting
###################################################
head(eData$chr)
eData[1:3, 1:2]


###################################################
### code chunk number 7: annoCreate
###################################################
annoData <- data.frame(chr = sample(1:16, size = K, replace = TRUE),
                       strand = sample(c(1L, -1L), size = K, replace = TRUE),
                       start = (st <- sample(1:1000, size = K, replace = TRUE)),
                       end = st + rpois(K, 75),
                       feature = c("gene", "intergenic")[sample(1:2, size = K, replace = TRUE)])
rownames(annoData) <- paste("elt", 1:K, sep = ".")
head(annoData)


###################################################
### code chunk number 8: eData2
###################################################
df2 <- data.frame(chr = sample(1:16, size = N, replace = TRUE),
                  location = sample(1:1000, size = N, replace = TRUE),
                  strand = sample(c(1L,-1L), size = N, replace = TRUE))
eData2 <- aggregateExpData(importToExpData(df2, dbFilename = "my.db", tablename = "ex2", 
                                           overwrite = TRUE))


###################################################
### code chunk number 9: eData1
###################################################
eData1 <- aggregateExpData(importToExpData(df, dbFilename = "my.db", tablename = "ex1", 
                                           overwrite = TRUE))


###################################################
### code chunk number 10: joinExample
###################################################
## eData1 <- aggregateExpData(importToExpData(df2, dbFilename = "my.db", tablename = "ex1", 
##                                            overwrite = TRUE))
## eData2 <- aggregateExpData(importToExpData(df, dbFilename = "my.db", tablename = "ex2", 
##                                            overwrite = TRUE))
eDataJoin <- joinExpData(list(eData1, eData2), fields = 
                  list(ex1 = c(counts = "counts_1"), ex2 = c(counts = "counts_2")), 
                  tablename = "allcounts")
head(eDataJoin)


###################################################
### code chunk number 11: summarizeJoin
###################################################
summarizeExpData(eDataJoin, fxs = c("total", "avg", "count"))


###################################################
### code chunk number 12: collapseExample1
###################################################
head(collapseExpData(eDataJoin, tablename = "collapsed", collapse = "sum", overwrite = TRUE))


###################################################
### code chunk number 13: collapseExample2
###################################################
head(collapseExpData(eDataJoin, tablename = "collapsed", collapse = "weighted.avg", overwrite = TRUE))
head(collapseExpData(eDataJoin, tablename = "collapsed", collapse = "avg", overwrite = TRUE))


###################################################
### code chunk number 14: interfaceSetup
###################################################
eData <- ExpData("my.db", tablename = "counts_tbl", mode = "r") 
eDataJoin <- ExpData("my.db", tablename = "allcounts", mode = "r")


###################################################
### code chunk number 15: sumEx1
###################################################
ss <- summarizeExpData(eData, what = "counts")
ss


###################################################
### code chunk number 16: sumEx2
###################################################
summarizeExpData(eData, what = "counts", fxs = c("MIN", "MAX"))


###################################################
### code chunk number 17: getRegionEx1
###################################################
reg <- getRegion(eData, chr = 2L, strand = -1L, start = 100L, end = 105L)
class(reg)
reg


###################################################
### code chunk number 18: summarizeByAnnotationEx1
###################################################
head(summarizeByAnnotation(eData, annoData, what = "counts", fxs = c("COUNT", "TOTAL"),
                           bindAnno = TRUE))


###################################################
### code chunk number 19: summarizeByAnnotationEx2
###################################################
head(summarizeByAnnotation(eDataJoin, annoData, , fxs = c("SUM"), 
                           bindAnno = TRUE, preserveColnames = TRUE, ignoreStrand = TRUE))


###################################################
### code chunk number 20: summarizeByAnnotationExampleSplit1
###################################################
res <- summarizeByAnnotation(eData, annoData, what = "counts", fxs = c("TOTAL", "COUNT"), 
                             splitBy = "feature")
class(res)
lapply(res, head)


###################################################
### code chunk number 21: summarizeByAnnotationExampleSplit2
###################################################
res <- summarizeByAnnotation(eData, annoData, what = "counts", fxs = c("TOTAL", "COUNT"), 
                             splitBy = "feature", bindAnno = TRUE)
lapply(res, head)


###################################################
### code chunk number 22: splitByAnnotationExample1
###################################################
dim(annoData[annoData$feature %in% "gene", ])
a <- splitByAnnotation(eData, annoData[annoData$feature %in% "gene", ])
class(a)
length(a)
names(a)[1:10]
head(a[[1]])


###################################################
### code chunk number 23: addQuantile
###################################################
sapply(a, function(x) { quantile(x[,"counts"], .9) })[1:10]


###################################################
### code chunk number 24: applyMapped
###################################################
applyMapped(a, annoData, FUN = function(region, anno) { 
    counts <- sum(region[,"counts"])
    length <- anno$end - anno$start + 1
    counts/length
})[1:10]


###################################################
### code chunk number 25: fastSplit
###################################################
sapply(splitByAnnotation(eData, annoData, what = "counts"), median)[1:10]


###################################################
### code chunk number 26: splitByAnnoExtendedExample
###################################################
## This returns a list-of-lists 
x1 <- splitByAnnotation(eData, annoData, expand = TRUE, ignoreStrand = TRUE)
names(x1[[1]])

## this returns a list-of-lists, however they are of length 1
x2 <- splitByAnnotation(eData, annoData, expand = TRUE)
names(x2[[1]])

## this returns a list where we have combined the two sublists
x3 <- splitByAnnotation(eData, annoData, expand = TRUE, addOverStrand = TRUE)
head(x3[[1]])


###################################################
### code chunk number 27: mergeWithAnnotation
###################################################
mergeWithAnnotation(eData, annoData)[1:3,]


###################################################
### code chunk number 28: mergeFig
###################################################
par(mfrow=c(1,2))
x <- lapply(mergeWithAnnotation(eData, annoData, splitBy = "feature", what = "counts"), 
            function(x) { 
                plot(density(x)) 
            })


###################################################
### code chunk number 29: coverage
###################################################
coverage <- computeCoverage(eData, annoData, effort = seq(100, 1000, by = 5), 
                            cutoff = function(e, anno, group) {e > 1}) 
plot(coverage, draw.legend = FALSE)


###################################################
### code chunk number 30: gof1
###################################################
plot(regionGoodnessOfFit(eDataJoin, annoData))


###################################################
### code chunk number 31: gof2
###################################################
plot(regionGoodnessOfFit(as.data.frame(matrix(rpois(1000, 100), ncol = 10)),
                         groups = rep(c("A", "B"), 5), denominator = rep(1, 10)))


###################################################
### code chunk number 32: sessionInfo
###################################################
toLatex(sessionInfo())


