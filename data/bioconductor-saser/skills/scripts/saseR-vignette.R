# Code example from 'saseR-vignette' vignette. See references/ for full tutorial.

## ----echo = FALSE-------------------------------------------------------------
library(knitr)

## ----eval=FALSE---------------------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("saseR")

## ----eval=FALSE---------------------------------------------------------------
# library(devtools)
# devtools::install_github("statOmics/saseR")

## ----message=FALSE, warning=FALSE---------------------------------------------
library(saseR)
suppressWarnings(library(ASpli))
library(edgeR)
library(DESeq2)
library(limma)
library(GenomicFeatures)
library(dplyr)
library(PRROC)
library(BiocParallel)
library(data.table)
library(igraph)
library(txdbmaker)


## -----------------------------------------------------------------------------
gtfFileName <- ASpli::aspliExampleGTF()
BAMFiles <- ASpli::aspliExampleBamList()

gtfFileName
head(BAMFiles)

## -----------------------------------------------------------------------------
targets <- data.frame( 
  row.names = paste0('Sample',c(1:12)),
  bam = BAMFiles,
  f1 = rep("A",12),
  stringsAsFactors = FALSE)

head(targets)

## -----------------------------------------------------------------------------
genomeTxDb <- txdbmaker::makeTxDbFromGFF(gtfFileName)
features <- binGenome(genomeTxDb, logTo = NULL)

## -----------------------------------------------------------------------------
ASpliSE <- BamtoAspliCounts(
                    features = features,
                    targets = targets,
                    minReadLength = 100,
                    libType = "SE",
                    BPPARAM = MulticoreParam(1L)
                    )

## -----------------------------------------------------------------------------
SEgenes <- convertASpli(ASpliSE, type = "gene")
SEbins <- convertASpli(ASpliSE, type = "bin")
SEjunctions <- convertASpli(ASpliSE, type = "junction")

## -----------------------------------------------------------------------------
metadata(SEgenes)$design <- ~1

## -----------------------------------------------------------------------------
filtergenes <- filterByExpr(SEgenes)
SEgenes <- SEgenes[filtergenes,]

## -----------------------------------------------------------------------------
SEgenes <- calculateOffsets(SEgenes, method = "TMM")

## -----------------------------------------------------------------------------
SEgenes <- saseRfindEncodingDim(SEgenes, method = "GD")

## -----------------------------------------------------------------------------
SEgenes <- saseRfit(SEgenes,
                    analysis = "AE",
                    padjust = "BH",
                    fit = "fast")

## -----------------------------------------------------------------------------
order <- apply(assays(SEgenes)$pValue, 2, order, decreasing = FALSE)

topPvalsGenes <- sapply(1:ncol(SEgenes), 
                   function(x) {assays(SEgenes)$pValue[order[1:5,x],x]})
rownames(topPvalsGenes) <- NULL

topGenes <- sapply(1:ncol(SEgenes), 
                   function(x) {rownames(SEgenes)[order[1:5,x]]})

significantgenes <- sapply(1:ncol(SEgenes), 
              function(x) {
                  rownames(SEgenes)[assays(SEgenes)$pValueAdjust[,x] < 0.05]})


head(topPvalsGenes)
head(topGenes)
head(significantgenes)

## -----------------------------------------------------------------------------
metadata(SEbins)$design <- ~1
metadata(SEjunctions)$design <- ~1


## -----------------------------------------------------------------------------
SEbins <- calculateOffsets(SEbins, 
                            method = "AS", 
                            aggregation = "locus")

SEjunctions <- calculateOffsets(SEjunctions, 
                            method = "AS", 
                            aggregation = "symbol",
                            mergeGeneASpli = TRUE)


## -----------------------------------------------------------------------------
filterbins <- filterByExpr(SEbins)
SEbins <- SEbins[filterbins,]

filterjunctions <- filterByExpr(SEjunctions)
SEjunctions <- SEjunctions[filterjunctions,]

## -----------------------------------------------------------------------------
SEbins <- saseRfindEncodingDim(SEbins, method = "GD")
SEjunctions <- saseRfindEncodingDim(SEjunctions, method = "GD")


## -----------------------------------------------------------------------------
SEbins <- saseRfit(SEbins,
                    analysis = "AS",
                    padjust = "BH",
                    fit = "fast")

SEjunctions <- saseRfit(SEjunctions,
                    analysis = "AS",
                    padjust = "BH",
                    fit = "fast")

## -----------------------------------------------------------------------------
order <- apply(assays(SEbins)$pValue, 2, order, decreasing = FALSE)

topPvalsBins <- sapply(1:ncol(SEbins), 
                   function(x) {assays(SEbins)$pValue[order[1:5,x],x]})

rownames(topPvalsBins) <- NULL

topBins <- sapply(1:ncol(SEbins), 
                   function(x) {rownames(SEbins)[order[1:5,x]]})

significantBins <- sapply(1:ncol(SEbins), 
                   function(x) {
                    rownames(SEbins)[assays(SEgenes)$pValueAdjust[,x] < 0.05]})

head(topPvalsBins)
head(topBins)
head(significantBins)

## -----------------------------------------------------------------------------
order <- apply(metadata(SEbins)$pValuesLocus, 2, order, decreasing = FALSE)

topPvalsBinsAggregated <- sapply(1:ncol(SEbins), 
                   function(x) {metadata(SEbins)$pValuesLocus[order[1:5,x],x]})
rownames(topPvalsBinsAggregated) <- NULL

topBinsAggregated <- sapply(1:ncol(SEbins), 
                   function(x) {
                     rownames(metadata(SEbins)$pValuesLocus)[order[1:5,x]]})

significantBinsAggregated <- sapply(1:ncol(SEbins), 
              function(x) {
                  rownames(SEbins)[metadata(SEgenes)$pValuesLocus[,x] < 0.05]})

head(topPvalsBinsAggregated)
head(topBinsAggregated)
head(significantBinsAggregated)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(ASpli)
library(DESeq2)
library(edgeR)
library(dplyr)
library(GenomicAlignments)
library(GenomicFeatures)

## -----------------------------------------------------------------------------
gtfFileName <- aspliExampleGTF()
BAMFiles <- aspliExampleBamList()

## -----------------------------------------------------------------------------
genomeTxDb <- txdbmaker::makeTxDbFromGFF(gtfFileName)
flattenedAnnotation = GenomicFeatures::exonicParts(genomeTxDb, 
                                  linked.to.single.gene.only=TRUE )

## -----------------------------------------------------------------------------
se = GenomicAlignments::summarizeOverlaps(
    flattenedAnnotation,
    BAMFiles, 
    singleEnd=TRUE, 
    ignore.strand=TRUE )

## -----------------------------------------------------------------------------
colData(se)$condition <- factor(c(rep(c("control", "case"), each = 6)))


## -----------------------------------------------------------------------------
counts <- assays(se)$counts
offsetsGene <- aggregate(counts,
                     by = list("gene" = rowData(se)$gene_id), FUN = sum) 
offsets <- offsetsGene[match(rowData(se)$gene_id, offsetsGene$gene), ] %>% 
                     mutate("gene" = NULL) %>% 
                     as.matrix() 

## -----------------------------------------------------------------------------
index <- offsets == 0
counts[index] <- 1
offsets[index] <- 1


## -----------------------------------------------------------------------------
dds <- DESeqDataSetFromMatrix(countData = counts,
                              colData = colData(se),
                              rowData = rowData(se),
                              design= ~ condition)
normalizationFactors(dds) <- offsets

dds <- DESeq2::estimateDispersionsGeneEst(dds)
dispersions(dds) <- mcols(dds)$dispGeneEst
dds <- DESeq2::nbinomWaldTest(dds)
results_dds <- DESeq2::results(dds)




## -----------------------------------------------------------------------------
DGE <- DGEList(counts = counts)
DGE$offset <- log(offsets)
design <- model.matrix(~condition, data = colData(se))

DGE <- edgeR::estimateDisp(DGE, design = design)
fitDGE <- edgeR::glmFit(DGE, design= design)
results_DGE <- edgeR::glmLRT(fitDGE, coef = 2)


## -----------------------------------------------------------------------------
sessionInfo()

