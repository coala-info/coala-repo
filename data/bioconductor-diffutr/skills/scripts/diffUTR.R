# Code example from 'diffUTR' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(BiocStyle)

## ----echo = FALSE, fig.cap = "A: Overview of the diffUTR workflow. B: Bin creation scheme."----
knitr::include_graphics(system.file('docs', 'figure1.svg', package = 'diffUTR'))

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("diffUTR")

## -----------------------------------------------------------------------------
suppressPackageStartupMessages({
  library(diffUTR)
  library(SummarizedExperiment)
})

## ----eval=FALSE---------------------------------------------------------------
# library(AnnotationHub)
# ah <- AnnotationHub()
# # obtain the identifier of the latest mouse ensembl annotation:
# ahid <- rev(query(ah, c("EnsDb", "Mus musculus"))$ah_id)[1]
# ensdb <- ah[[ahid]]

## -----------------------------------------------------------------------------
data(example_gene_annotation, package="diffUTR")
g <- example_gene_annotation
head(g)

## -----------------------------------------------------------------------------
# If you know that your data will be stranded, use
# bins <- prepareBins(g, stranded=TRUE)
# Otherwise use
bins <- prepareBins(g)

## ----eval=FALSE---------------------------------------------------------------
# bamfiles <- c("path/to/sample1.bam", "path/to/sample2.bam", ...)
# rse <- countFeatures(bamfiles, bins, strandSpecific=2, nthreads=6, isPairedEnd=FALSE)

## -----------------------------------------------------------------------------
data(example_bin_se, package="diffUTR")
rse <- example_bin_se
rse

## -----------------------------------------------------------------------------
head(rowRanges(rse))

## -----------------------------------------------------------------------------
rse <- diffSpliceWrapper(rse, design = ~condition)

## -----------------------------------------------------------------------------
head(rowData(rse))

## -----------------------------------------------------------------------------
perGene <- metadata(rse)$geneLevel
head(perGene)

## ----eval=FALSE---------------------------------------------------------------
# download.file("https://polyasite.unibas.ch/download/atlas/2.0/GRCm38.96/atlas.clusters.2.0.GRCm38.96.bed.gz",
#               destfile="apa.mm38.bed.gz")
# bins <- prepareBins(g, "apa.mm38.bed.gz")
# # (Again, if you know that your data will be stranded, use `stranded=TRUE`)

## -----------------------------------------------------------------------------
data(rn6_PAS)
# bins <- prepareBins(g, rn6_PAS)

## ----eval=FALSE---------------------------------------------------------------
# bamfiles <- c("path/to/sample1.bam", "path/to/sample2.bam", ...)
# se <- countFeatures(bamfiles, bins, strandSpecific=2, nthreads=6, isPairedEnd=TRUE)

## -----------------------------------------------------------------------------
rse <- diffSpliceWrapper( rse, design = ~condition )

## -----------------------------------------------------------------------------
# we can then only look for changes in CDS bins:
cds <- geneLevelStats(rse, includeTypes="CDS", returnSE=FALSE)
head(cds)
# or only look for changes in UTR bins:
utr <- geneLevelStats(rse, includeTypes="UTR", returnSE=FALSE)
head(utr)
# or only look for changes in bins that _could be_ UTRs:
# geneLevelStats(rse, excludeTypes=c("CDS","non-coding"), returnSE=FALSE)

## -----------------------------------------------------------------------------
plotTopGenes(rse)

## -----------------------------------------------------------------------------
# `utr` being the output of the above
# geneLevelStats(rse, includeTypes="UTR", returnSE=FALSE)
plotTopGenes(utr, diffUTR = TRUE)

## -----------------------------------------------------------------------------
rse <- addNormalizedAssays(rse)

## -----------------------------------------------------------------------------
deuBinPlot(rse,"Jund")
deuBinPlot(rse,"Jund", type="condition", colour="condition")
deuBinPlot(rse,"Jund", type="sample", colour="condition") # shows separate samples

## -----------------------------------------------------------------------------
library(ggplot2)
deuBinPlot(rse,"Jund",type="condition",colour="condition") + 
  guides(colour = guide_legend(override.aes = list(size = 3))) +
  scale_colour_manual(values=c(CTRL="darkblue", LTP="red"))

## -----------------------------------------------------------------------------
geneBinHeatmap(rse, "Smg6")

## -----------------------------------------------------------------------------
#' binTxPlot
#'
#' @param se A bin-wise SummarizedExperiment as produced by
#' \code{\link{countFeatures}} and including bin-level tests (i.e. having been
#' passed through one of the DEU wrappers such as
#' \code{\link{diffSpliceWrapper}} or \code{\link{DEXSeqWrapper}})
#' @param ensdb The `EnsDb` which was used to create the bins
#' @param gene The gene of interest
#' @param by The colData column of `se` used to split the samples
#' @param assayName The assay to plot
#' @param removeAmbiguous Logical; whether to remove bins that are
#' gene-ambiguous (i.e. overlap multiple genes).
#' @param size Size of the lines
#' @param ... Passed to `plotRangesLinkedToData`
#'
#' @return A `ggbio` `Tracks`
#' @importFrom AnnotationFilter GeneNameFilter GeneIdFilter
#' @importFrom ensembldb getGeneRegionTrackForGviz
#' @importFrom ggbio plotRangesLinkedToData autoplot
#' @export
binTxPlot <- function(se, ensdb, gene, by=NULL, assayName=c("logNormDensity"),
                      removeAmbiguous=TRUE, size=3, threshold=0.05, ...){
  w <- diffUTR:::.matchGene(se, gene)
  se <- sort(se[w,])
  if(removeAmbiguous) se <- se[!rowData(se)$geneAmbiguous,]
  if(length(w)==0) return(NULL)
  if(!is.null(by)) by <- match.arg(by, colnames(colData(se)))
  assayName <- match.arg(assayName, assayNames(se))
  if(rowData(se)$gene[[1]]==gene){
    filt <- GeneIdFilter(gene)
  }else{
    filt <- GeneNameFilter(gene)
  }
  gr <- ggbio::autoplot(ensdb, filt)
  gr2 <- rowRanges(se)
  if(!is.null(by)){
    sp <- split(seq_len(ncol(se)), se[[by]])
    for(f in names(sp))
      mcols(gr2)[[f]] <- rowMeans(assays(se)[[assayName]][,sp[[f]],drop=FALSE])
    y <- names(sp)
  }else{
    mcols(gr2)[[assayName]] <- rowMeans(assays(se)[[assayName]])
    y <- assayName
  }
  ggbio::plotRangesLinkedToData(gr2, stat.y=y, stat.ylab=assayName, 
                                annotation=list(gr),
                                size=size, ...) + ggtitle(gene)
}

# example usage (not run):
# binTxPlot(rse, ensdb, gene="Arid5a", by="condition")

## -----------------------------------------------------------------------------
sessionInfo()

