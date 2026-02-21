# Code example from 'overview' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE,
  tidy.opts=list(width.cutoff=70),
  tidy=TRUE)

## ----results='hide', message=FALSE, warning=FALSE-----------------------------
library(mitoClone2)

## ----baseCounts_bamlist-------------------------------------------------------

## example using function for a list of BAM files   

baseCounts <- baseCountsFromBamList(bamfiles =
list(system.file("extdata", "mm10_10x.bam", package="mitoClone2")),
sites="chrM:1-15000",
ncores=1)
print(length(baseCounts))   

print(head(baseCounts[[1]][13267:13277,]))   


## ----baseCounts_10x_BAM-------------------------------------------------------
## example using function for a multiplexed BAM files
## cell barcodes found by extracting the 'CB' BAM tag
baseCounts <- bam2R_10x(file = system.file("extdata", "mm10_10x.bam",
package="mitoClone2"), sites="chrM:1-15000", ncores=1)
print(length(baseCounts))   

print(head(baseCounts[[1]][13267:13277,]))   


## ----exclusionlist,fig.width = 6, fig.height=4--------------------------------
library(mitoClone2)
library(pheatmap)

## load our count data
load(system.file("extdata/example_counts.Rda",package = "mitoClone2"))

## investigate what our ideal baseCounts object looks like
print(head(example.counts[[1]]))

## calling mutations using our exclusionlist
Example <- mutationCallsFromExclusionlist(example.counts, min.af=0.05,
min.num.samples=5, universal.var.cells = 0.5 * length(example.counts),
binarize = 0.1)

## setting up the meta data
Example.rawnames <- getAlleleCount(Example,'nonmutant')
Example.meta <- data.frame(row.names = rownames(Example.rawnames),
Clone = gsub("_.*","",gsub("Donor1_","",rownames(Example.rawnames))))

## showing the clustering via heatmap (notice only 20 mutations were kept)
clustered <- quick_cluster(Example, binarize = TRUE, drop_empty = TRUE,
clustering.method = "ward.D2", annotation_col = Example.meta,
show_colnames=FALSE,fontsize_row = 7)


## ----cohort,fig.width = 6, fig.height=4---------------------------------------
## Calling mutations using our known clonal information
Example <- mutationCallsFromCohort(example.counts, MINFRAC=0.01, MINCELL=8,
MINCELLS.PATIENT=5, patient = Example.meta$Clone, sites='chrM:1-55')
## check the variants for a specific cluster
print(colnames(getAlleleCount(Example$C112,'mutant')))
private.mutations <- unique(unlist(
lapply(Example[grep('^C',names(Example))][unlist(lapply(
Example[grep('^C',names(Example))],function(x)!is.null(x)))],
function(y) names(getVarsCandidate(y)))
))
private.mutations.df <- pullcountsVars(example.counts,
gsub("X(\\d+)([AGCT])\\.([AGCT])","\\1 \\2>\\3",private.mutations))
private.mutations.df <- mutationCallsFromMatrix(t(private.mutations.df$M),
t(private.mutations.df$N), cluster = rep(TRUE, length(private.mutations)))

## Showing the clustering looks via heatmap
clustered <- quick_cluster(private.mutations.df, binarize = TRUE,
drop_empty = TRUE, clustering.method = "ward.D2",
annotation_col = Example.meta,show_colnames=FALSE,fontsize_row = 7)


## ----label='Session information', eval=TRUE, echo=FALSE-----------------------
sessionInfo()

