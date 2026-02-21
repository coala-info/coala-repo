# Code example from 'doseR' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
collapse = TRUE,
comment = "#>"
)

## ----eval = F-----------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("doseR")

## -----------------------------------------------------------------------------
library(doseR)
library(SummarizedExperiment)

## -----------------------------------------------------------------------------
data(hmel.data.doser)

## -----------------------------------------------------------------------------
reps <- c("Male", "Male", "Male", "Female", "Female", "Female")

## -----------------------------------------------------------------------------
annotxn <- data.frame("Chromosome" = factor(hmel.dat$chromosome, 
levels = 1:21))
annotxn$ZA <- factor(ifelse(hmel.dat$chromosome == 21, "Z", "A"), 
levels = c("A", "Z"))

## -----------------------------------------------------------------------------

counts <- hmel.dat$readcounts
colData <- S4Vectors::DataFrame(Treatment=as.factor(reps), 
row.names=colnames(hmel.dat$readcounts))
rowData <- S4Vectors::DataFrame(annotation = annotxn, 
seglens = hmel.dat$trxLength,
row.names=rownames(hmel.dat$readcounts) )
se2 <- SummarizedExperiment(assays=list(counts=counts), 
colData=colData, rowData=rowData)


## -----------------------------------------------------------------------------
SummarizedExperiment::colData(se2)$Libsizes <- getLibsizes3(se2, 
estimationType = "total")


## -----------------------------------------------------------------------------
SummarizedExperiment::assays(se2)$rpkm <- make_RPKM(se2)

# se2 now equals se...

data(hmel.se)  # loads hmel.dat list

# MD5 checksum equivalence:
#library(digest)
digest::digest(se) == digest::digest(se2)


## ----fig.align="center", fig.width=6------------------------------------------
plotMA.se(se, samplesA ="Male", samplesB = "Female", cex = .2 , 
pch = 19, col = rgb(0,0,0, .2), xlab = "Log2(Average RPKM)", 
ylab = "Log2(Male:Female)")

## -----------------------------------------------------------------------------
f_se <- simpleFilter(se, mean_cutoff = 0.01, counts = FALSE)


## ----fig.align="center", fig.width=5------------------------------------------
plotExpr(f_se, groupings = "annotation.ZA", clusterby_grouping = FALSE, 
col=c("grey80","red","grey80","red"), notch=TRUE, ylab = "Log2(RPKM)")

## -----------------------------------------------------------------------------
se.male <- f_se[, colData(f_se)$Treatment == "Male"]
male_ZvA <- generateStats(se.male , groupings = "annotation.ZA", LOG2 = FALSE)
male_ZvA$summary  # distributional summary statistics
male_ZvA$kruskal  # htest class output from kruskal.test()
lapply(male_ZvA$data, head) # a record of values used for statistics.

## ----fig.align="center"-------------------------------------------------------
plotExpr(f_se, groupings = "annotation.Chromosome", col=c(rep("grey80", 20), 
"red"), notch=TRUE, ylab = "Log2(RPKM)", las = 2, treatment = "Male",  
clusterby_grouping = TRUE )

## ----fig.align="center", fig.width=4------------------------------------------
plotRatioBoxes(f_se, groupings = "annotation.ZA", treatment1 = "Male", 
treatment2 = "Female", outline = FALSE, col = c("grey80", "red"),
ylab = "Log(Male:Female)" )

## ----fig.align="center", fig.width = 5----------------------------------------
plotRatioDensity(f_se, groupings = "annotation.ZA", treatment1 = "Male", 
treatment2 = "Female", type = "l", xlab = "Log(Male:Female)", ylab = "Density")

## ----fig.align="center", fig.width=10-----------------------------------------
par(mfrow = c(1,2))
plotRatioBoxes(f_se, groupings = "annotation.Chromosome", treatment1 =
"Male", treatment2 = "Female", outline = FALSE, col=c(rep("grey80", 20), 
"red"), ylab = "Log(Male:Female)", xlab = "Chromosome" )

plotRatioDensity(f_se, groupings = "annotation.Chromosome", treatment1 = 
"Male", treatment2 = "Female", type = "l", xlab = "Log(Male:Female)",
ylab = "Density", col=c(rep("grey80", 20), "red"), lty = 1)

## -----------------------------------------------------------------------------
za.ratios.test <- test_diffs(f_se, groupings = "annotation.ZA", 
treatment1 = "Male", treatment2 = "Female", LOG2 = FALSE )
za.ratios.test$summary  # summary statistics for each grouping
za.ratios.test$kruskal  # htest class output from kruskal.test()
lapply(za.ratios.test$data, head) # values used for summaries and tests

