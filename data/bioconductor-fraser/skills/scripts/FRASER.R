# Code example from 'FRASER' vignette. See references/ for full tutorial.

## ----style-knitr, eval=TRUE, echo=FALSE, results="asis"--------------------
BiocStyle::latex()

## ----parallel, echo=FALSE, cache=FALSE, results="hide"---------------------
library(BiocParallel)
# for speed we run everything in serial mode
register(SerialParam())

## ----knitr, echo=FALSE, cache=FALSE, results="hide"------------------------
library(knitr)
opts_chunk$set(
    tidy=FALSE,
    dev="png",
    fig.width=7, 
    fig.height=7,
    dpi=300,
    message=FALSE,
    warning=FALSE,
    cache=FALSE
)

## ----include=FALSE---------------------------------------------------------
opts_chunk$set(concordance=TRUE)

## ----loadFraser, echo=FALSE------------------------------------------------
suppressPackageStartupMessages({
    library(FRASER)
})

## ----quick_fraser_guide, echo=TRUE-----------------------------------------
# load FRASER library
library(FRASER)

# count raw data
fds <- createTestFraserSettings()
fds <- countRNAData(fds)
fds

# compute stats
fds <- calculatePSIValues(fds)

# filter junctions with low expression
fds <- filterExpressionAndVariability(fds, minExpressionInOneSample=20,
       minDeltaPsi=0.0, filter=TRUE)

# we provide two ways to annotate introns with the corresponding gene symbols:
# the first way uses TxDb-objects provided by the user as shown here
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(org.Hs.eg.db)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
orgDb <- org.Hs.eg.db
fds <- annotateRangesWithTxDb(fds, txdb=txdb, orgDb=orgDb)

# fit the splicing model for each metric 
# with a specific latentspace dimension
fds <- FRASER(fds, q=c(jaccard=2))

# Alternatively, we also provide a way to use BioMart for the annotation:
# fds <- annotateRanges(fds)

# get results: we recommend to use an FDR cutoff of 0.05, but due to the small
# dataset size, we extract all events and their associated values
# eg: res <- results(fds, padjCutoff=0.05, deltaPsiCutoff=0.1)
res <- results(fds, all=TRUE)
res

# result visualization, aggregate=TRUE means that results are aggregated at the gene level 
plotVolcano(fds, sampleID="sample1", type="jaccard", aggregate=TRUE)


## ----sampleData Table, echo=TRUE-------------------------------------------
library(data.table)
sampleTable <- fread(system.file(
    "extdata", "sampleTable.tsv", package="FRASER", mustWork=TRUE))
head(sampleTable)

## ----FRASER setting example1, echo=TRUE------------------------------------
# convert it to a bamFile list
bamFiles <- system.file(sampleTable[,bamFile], package="FRASER", mustWork=TRUE)
sampleTable[, bamFile := bamFiles]

# create FRASER object
settings <- FraserDataSet(colData=sampleTable, workingDir="FRASER_output")

# show the FraserSettings object
settings

## ----FRASER setting example2, echo=TRUE------------------------------------
settings <- createTestFraserSettings()
settings

## ----parallelize example, eval=FALSE---------------------------------------
# # example of how to use parallelization: use 10 cores or the maximal number of
# # available cores if fewer than 10 are available and use Snow if on Windows
# if(.Platform$OS.type == "unix") {
#     register(MulticoreParam(workers=min(10, multicoreWorkers())))
# } else {
#     register(SnowParam(workers=min(10, multicoreWorkers())))
# }

## ----counting reads, echo=TRUE---------------------------------------------
# count reads
fds <- countRNAData(settings)
fds

## ----create fds with counts, echo=TRUE-------------------------------------
# example sample annotation for precalculated count matrices
sampleTable <- fread(system.file("extdata", "sampleTable_countTable.tsv",
        package="FRASER", mustWork=TRUE))
head(sampleTable)

# get raw counts
junctionCts   <- fread(system.file("extdata", "raw_junction_counts.tsv.gz",
        package="FRASER", mustWork=TRUE))
head(junctionCts)

spliceSiteCts <- fread(system.file("extdata", "raw_site_counts.tsv.gz",
        package="FRASER", mustWork=TRUE))
head(spliceSiteCts)

# create FRASER object
fds <- FraserDataSet(colData=sampleTable, junctions=junctionCts,
        spliceSites=spliceSiteCts, workingDir="FRASER_output")
fds

## ----calculate psi/jaccard values, echo=TRUE-------------------------------
fds <- calculatePSIValues(fds)
fds

## ----filter_junctions, echo=TRUE-------------------------------------------
fds <- filterExpressionAndVariability(fds, minDeltaPsi=0, filter=FALSE)

plotFilterExpression(fds, bins=100)

## ----subset to filtered junctions, echo=TRUE-------------------------------
fds_filtered <- fds[mcols(fds, type="j")[,"passed"]]
fds_filtered
# filtered_fds not further used for this tutorial because the example dataset
# is otherwise too small

## ----sample_covariation, echo=TRUE-----------------------------------------
# Heatmap of the sample correlation
plotCountCorHeatmap(fds, type="jaccard", logit=TRUE, normalized=FALSE)

## ----intron_sample_correlation, echo=TRUE, eval=FALSE----------------------
# # Heatmap of the intron/sample expression
# plotCountCorHeatmap(fds, type="jaccard", logit=TRUE, normalized=FALSE,
#     plotType="junctionSample", topJ=100, minDeltaPsi = 0.01)

## ----model fitting, echo=TRUE----------------------------------------------
# This is computational heavy on real datasets and can take some hours
fds <- FRASER(fds, q=c(jaccard=3))

## ----covariation_after_fitting, echo=TRUE----------------------------------
plotCountCorHeatmap(fds, type="jaccard", normalized=TRUE, logit=TRUE)

## ----result table, echo=TRUE-----------------------------------------------
# annotate introns with the HGNC symbols of the corresponding gene
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(org.Hs.eg.db)

txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
orgDb <- org.Hs.eg.db
fds <- annotateRangesWithTxDb(fds, txdb=txdb, orgDb=orgDb)
# fds <- annotateRanges(fds) # alternative way using biomaRt

# retrieve results with default and recommended cutoffs (padj <= 0.05 and
# |deltaPsi| >= 0.3)
res <- results(fds)

## ----result_table, echo=TRUE-----------------------------------------------
# for visualization purposes for this tutorial, no cutoffs were used
res <- results(fds, all=TRUE)
res

# for the gene level pvalues, gene symbols need to be added to the fds object
# before calling the calculatePadjValues function (part of FRASER() function)
# as we previously called FRASER() before annotating genes, we run it again here
fds <- calculatePadjValues(fds, type="jaccard", geneLevel=TRUE)
# generate gene-level results table (if gene symbols have been annotated)
res_gene <- results(fds, aggregate=TRUE, all=TRUE)
res_gene

## ----finding_candidates, echo=TRUE-----------------------------------------
plotVolcano(fds, type="jaccard", "sample10")

## ----sample result, echo=TRUE----------------------------------------------
sampleRes <- res[res$sampleID == "sample10"]
sampleRes

## ----plot_expression, echo=TRUE, eval=FALSE--------------------------------
# plotExpression(fds, type="jaccard", result=sampleRes[9]) # plots the 9th row
# plotSpliceMetricRank(fds, type="jaccard", result=sampleRes[9])
# plotExpectedVsObservedPsi(fds, result=sampleRes[9])

## ----save_load, echo=TRUE--------------------------------------------------
# saving a fds
workingDir(fds) <- "FRASER_output"
name(fds) <- "ExampleAnalysis"
saveFraserDataSet(fds, dir=workingDir(fds), name=name(fds))

# two ways of loading a fds by either specifying the directory and anaysis name
# or directly giving the path the to fds-object.RDS file
fds <- loadFraserDataSet(dir=workingDir(fds), name=name(fds))
fds <- loadFraserDataSet(file=file.path(workingDir(fds), 
    "savedObjects", "ExampleAnalysis", "fds-object.RDS"))


## ----control confounders, echo=TRUE----------------------------------------
# Using an alternative way to correct splicing ratios
# here: only 2 iterations to speed the calculation up for the vignette
# the default is 15 iterations
fds <- fit(fds, q=3, type="jaccard", implementation="PCA-BB-Decoder", 
            iterations=2)

## ----findBestQ, echo=TRUE--------------------------------------------------
set.seed(42)
# Optimal Hard Thresholding (default method)
fds <- estimateBestQ(fds, type="jaccard", plot=FALSE)
plotEncDimSearch(fds, type="jaccard", plotType="sv")

# Hyperparameter optimization (grid-search)
fds <- estimateBestQ(fds, type="jaccard", useOHT=FALSE, plot=FALSE)
plotEncDimSearch(fds, type="jaccard", plotType="auc")

# retrieve the estimated optimal dimension of the latent space
bestQ(fds, type="jaccard")

## ----p-value calculation, echo=TRUE----------------------------------------
fds <- calculatePvalues(fds, type="jaccard")
head(pVals(fds, type="jaccard"))

## ----p-adj calculation, echo=TRUE------------------------------------------
fds <- calculatePadjValues(fds, type="jaccard", method="BY")
head(padjVals(fds,type="jaccard"))

## ----p-adj calculation on subset, echo=TRUE--------------------------------
genesOfInterest <- list("sample1"=c("XAB2", "PNPLA6", "STXBP2", "ARHGEF18"), 
                        "sample2"=c("ARHGEF18", "TRAPPC5"))
fds <- calculatePadjValues(fds, type="jaccard", 
              subsets=list("exampleSubset"=genesOfInterest))
head(padjVals(fds, type="jaccard", subsetName="exampleSubset"))

## ----result_visualization, echo=TRUE---------------------------------------
plotAberrantPerSample(fds)

# qq-plot for single junction
plotQQ(fds, result=res[1])

# global qq-plot (on gene level since aggregate=TRUE)
plotQQ(fds, aggregate=TRUE, global=TRUE)

## ----manhattan_plot, echo=TRUE---------------------------------------------
plotManhattan(fds, sampleID="sample10")
plotManhattan(fds, sampleID="sample10", chr="chr19")

## ----bamCoverage_plot, echo=TRUE-------------------------------------------
### plot coverage from bam file for a certain genomic region
fds <- createTestFraserSettings()
vizRange <- GRanges(seqnames="chr19",
                IRanges(start=7587496, end=7598895),
                strand="+")
plotBamCoverage(fds, gr=vizRange, sampleID="sample3",
                control_samples="sample2", min_junction_count=5,
                curvature_splicegraph=1, curvature_coverage=1,
                mar=c(1, 7, 0.1, 3))

### plot coverage from bam file for a row in the result table
fds <- createTestFraserDataSet()

# load gene annotation
require(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
require(org.Hs.eg.db)
orgDb <- org.Hs.eg.db
 
# get results table 
res <- results(fds, padjCutoff=NA, deltaPsiCutoff=NA)
res_dt <- as.data.table(res)
res_dt <- res_dt[sampleID == "sample2",]

# plot full range of gene highlighting the outlier intron
plotBamCoverageFromResultTable(fds, result=res_dt[1,], show_full_gene=TRUE,
    txdb=txdb, orgDb=orgDb, control_samples="sample3")
     
# plot only certain range around the outlier intron
plotBamCoverageFromResultTable(fds, result=res_dt[1,], show_full_gene=FALSE, 
     control_samples="sample3", curvature_splicegraph=0.5, txdb=txdb,
     curvature_coverage=0.5, right_extension=5000, left_extension=5000,
     splicegraph_labels="id")

## ----sessionInfo, echo=FALSE-----------------------------------------------
sessionInfo()

