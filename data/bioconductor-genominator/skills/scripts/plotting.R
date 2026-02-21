# Code example from 'plotting' vignette. See references/ for full tutorial.

### R code from vignette source 'plotting.Rnw'

###################################################
### code chunk number 1: plotting.Rnw:5-6
###################################################
options(width = 80)


###################################################
### code chunk number 2: plotting.Rnw:47-64
###################################################
require(Genominator)

options(verbose = FALSE)
N <- 100000 # the number of observations. 
K <- 100    # the number of annotation regions, not less than 10

df <- data.frame(chr = sample(1:16, size = N, replace = TRUE),
                 location = sample(1:1000, size = N, replace = TRUE),
                 strand = sample(c(1L,-1L), size = N, replace = TRUE))
eData <- aggregateExpData(importToExpData(df, dbFilename = "pmy.db", overwrite = TRUE, tablename = "ex_tbl"))

annoData <- data.frame(chr = sample(1:16, size = K, replace = TRUE),
                       strand = sample(c(1, -1), size = K, replace = TRUE),
                       start = (st <- sample(1:1000, size = K, replace = TRUE)),
                       end = st + rpois(K, 75),
                       feature = c("gene", "intergenic")[sample(1:2, size = K, replace = TRUE)])
rownames(annoData) <- paste("elt", 1:K, sep = ".")


###################################################
### code chunk number 3: plotting.Rnw:67-69
###################################################
rp <- Genominator:::makeRegionPlotter(list("track.1" = list(expData = eData, what = "counts")))
args(rp)


###################################################
### code chunk number 4: plotting.Rnw:74-75
###################################################
rp(1, 10, 1000)


###################################################
### code chunk number 5: plotting.Rnw:82-85
###################################################
rp <- Genominator:::makeRegionPlotter(list("track.1" = list(expData = eData, what = "counts",
                                             dp = DisplayPars(lwd = .45, color = "grey"))))
rp(1, 400, 500)


###################################################
### code chunk number 6: plotting.Rnw:93-103
###################################################
annoFactory <- Genominator:::makeAnnoFactory(annoData, featureColumnName = "feature", 
                                             groupColumnName = NULL, idColumnName = NULL,
                                             dp = DisplayPars("gene" = "blue", 
                                             "intergenic" = "green"))
rp <- Genominator:::makeRegionPlotter(list("track.1" = list(expData = eData, what = "counts",
                                           dp = DisplayPars(lwd=.2, color = "grey")),
                                           "track.2" = list(expData = eData, what = "counts", 
                                           fx = log2, DisplayPars(lwd=.3, color = "black"))),
                                      annoFactory = annoFactory)
rp(annoData[1,"chr"], annoData[1, "start"] - 100, annoData[1, "end"] + 100)


###################################################
### code chunk number 7: plotting.Rnw:113-127
###################################################
require("biomaRt")
mart <- useMart("ensembl", dataset = "scerevisiae_gene_ensembl")
annoFactory <- Genominator:::makeAnnoFactory(mart, chrFunction = function(chr) as.roman(chr))

load(system.file("data", "chr1_yeast.rda", package = "Genominator"))
head(chr1_yeast)
yData <- importToExpData(chr1_yeast, dbFilename = "my.db", tablename = "yeast", 
                         overwrite = TRUE)

rp <- Genominator:::makeRegionPlotter(list("track.-" = list(expData = yData, what = c("mRNA_1", "mRNA_2"),
                                             fx = rowMeans, strand = -1,
                                             dp = DisplayPars(lwd=.3, color = "grey"))),
                                      annoFactory = annoFactory)
rp(1, 20000, 50000)


###################################################
### code chunk number 8: sessionInfo
###################################################
toLatex(sessionInfo())


