# Code example from 'CNVMetrics' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', warning=FALSE, message=FALSE------
BiocStyle::markdown()

suppressPackageStartupMessages({
  library(knitr)
  library(GenomicRanges)
  library(CNVMetrics)
})

set.seed(121444)

## ----graphCNVpro, echo = FALSE, fig.align="center", fig.cap="Copy number profiles of two mouse metastatic pancreatic organoids (M10 and M30).", out.width = '90%', results='asis'----

knitr::include_graphics("CNV_mM30_mM10_v03_Feb_08_2021_small.png")

## ----figureWorkflow, echo = FALSE, fig.align="center", fig.cap="General CNVMetrics workflow.", out.width = '100%'----

knitr::include_graphics("CNVMetrics_partial_workflow_v10.png")

## ----installDemo01, eval=FALSE------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# 
# # The following initializes usage of Bioc devel
# BiocManager::install(version='devel')
# 
# BiocManager::install("CNVMetrics")

## ----figureCNVFile, echo = FALSE, fig.align="center", fig.cap="Example of a copy number file containing CNV calls.", out.width = '100%'----

knitr::include_graphics("Input_CNV_call_300ppi_v02_low_quality.jpg")

## ----demoImport01-------------------------------------------------------------
## Load required libraries
library(GenomicRanges)
library(CNVMetrics)

## Load file containing CNV calls for 10 mouse organoids
data.dir <- system.file("extdata", package="CNVMetrics")
cnv.file <- file.path(data.dir, "mousePairedOrganoids.txt")
calls <- read.table(cnv.file, header=TRUE, sep="\t")

## The CNV status calls for all samples are present in one file
## The 'state' column is required
## The chromosome Y has been removed
head(calls)

## The ID column identifies the 10 samples
unique(calls[,"ID"])

## The ID column is used to split the samples into different GRanges 
## inside a GRangesList
## The 'keep.extra.column=TRUE' parameter is needed to retained the extra 
## column 'state' that is needed for the calculation of the metrics
grl <- GenomicRanges::makeGRangesListFromDataFrame(calls, 
    split.field="ID", keep.extra.columns=TRUE)
grl

## ----demoCalculateMetric01----------------------------------------------------
## In this case, the default states (AMPLIFICATION, DELETION) are used. 
## So, the 'states' parameter doesn't have to be specified
## The 'states' parameter needs to be adjusted for user-specific states
## Ex: states=c("LOH", "gain")
metric <- calculateOverlapMetric(segmentData=grl, method="sorensen", nJobs=1)

metric

## ----demoPlot01, fig.align="center", fig.height=4.5, fig.width=4.5------------
## Create graph for the metrics related to amplified regions
plotMetric(metric, type="AMPLIFICATION")

## ----demoPlot02, fig.align="center", fig.height=4.8, fig.width=4.8------------
## Create graph for the metrics related to deleted regions
## Metric values are printed as 'display_numbers' and 'number_format' are
## arguments recognized by pheatmap() function
plotMetric(metric, type="DELETION", 
                    colorRange=c("white", "darkorange"),
                    show_colnames=TRUE,
                    display_numbers=TRUE,
                    number_format="%.2f")

## ----demoPlot03, fig.align="center", fig.height=4.8, fig.width=6--------------
## Load file containing annotations for the mouse organoids
## The mouse ID identifying the source of the sample
## The stage identifying the state (tumor vs metastasis) of the sample
data.dir <- system.file("extdata", package="CNVMetrics")
annotation.file <- file.path(data.dir, "mousePairedOrganoidsInfo.txt")
annotOrg <- read.table(annotation.file, header=TRUE, sep="\t")

## The row names must correspond to the names assigned to the rows/columns
## in the CNVMetric object
rownames(annotOrg) <- annotOrg$ID
annotOrg$ID <- NULL
all(rownames(annotOrg) == rownames(metric$AMPLIFICATION))

## Create graph for the metrics related to amplified regions
## Rows are annotated with the stage and mouse information
plotMetric(metric, type="AMPLIFICATION", 
                    colorRange=c("white", "steelblue"),
                    annotation_row=annotOrg)

## ----figureCNVFileLog2Ratio, echo = FALSE, fig.align="center", fig.cap="Example of a copy number file containing log2ratio values.", out.width = '100%'----

knitr::include_graphics("Input_CNV_log2ratio_v01_low_quality.jpg")

## ----demoImport02-------------------------------------------------------------
## Load required libraries
library(GenomicRanges)
library(CNVMetrics)

## Load file containing CNV calls for 10 mouse organoids
data.dir <- system.file("extdata", package="CNVMetrics")
cnv.file <- file.path(data.dir, "mousePairedOrganoids.txt")
calls <- read.table(cnv.file, header=TRUE, sep="\t")

## The CNV status calls for all samples are present in one file
## The 'log2ratio' column is required
## The chromosome Y has been removed
head(calls)

## The ID column identifies the 10 samples
unique(calls[,"ID"])

## The ID column is used to split the samples into different GRanges 
## inside a GRangesList
## The 'keep.extra.column=TRUE' parameter is needed to retained the extra 
## column 'state' that is needed for the calculation of the metrics
grlog <- GenomicRanges::makeGRangesListFromDataFrame(df=calls, 
    split.field="ID", keep.extra.columns=TRUE)
grlog

## ----demoCalculateMetricLog---------------------------------------------------
metricLog <- calculateLog2ratioMetric(segmentData=grlog, 
                              method="weightedEuclideanDistance", nJobs=1)

metricLog

## ----demoPlotLog01, fig.align="center", fig.height=4.5, fig.width=4.5---------
## Create graph for the metrics related to weighted Euclidean distance-based
plotMetric(metricLog)

## ----demoPlotLog02, fig.align="center", fig.height=4.8, fig.width=4.8---------
## Create graph for the weighted Euclidean distance-based metrics
## Remove title (argument main="")
## Metric values are printed as 'display_numbers' and 'number_format' are
## arguments recognized by pheatmap() function
plotMetric(metricLog, colorRange=c("white", "darkorange"),
                    show_colnames=TRUE,
                    display_numbers=TRUE,
                    number_format="%.2f",
                    main="")

## ----figureSimulationPart01, echo = FALSE, fig.align="center", fig.cap="Workflow showing the creation of a chromosome template from one reference sample.", out.width = '85%'----

knitr::include_graphics("Simulation_chromosome_workflow_part_01_v03.png")

## ----figureSimulationPart02, echo = FALSE, fig.align="center", fig.cap="Workflow showing the creation of a simulated chromosome through the use of a template.", out.width = '90%'----

knitr::include_graphics("Simulation_chromosome_workflow_part02_v03.png")

## ----demoSimulation-----------------------------------------------------------

## Load required package to generate the sample
require(GenomicRanges)

## Create one 'demo' genome with 3 chromosomes and few segments
## The stand of the regions doesn't affect the calculation of the metric
sampleRef <- GRanges(seqnames=c(rep("chr1", 4), rep("chr2", 3), rep("chr3", 6)),
     ranges=IRanges(start=c(1905048, 4554832, 31686841, 32686222,
         1, 120331, 725531, 12, 10331, 75531, 120001, 188331, 225531),
     end=c(2004603, 4577608, 31695808, 32689222, 117121,
         325555, 1225582, 9131, 55531, 100103, 158535, 211436, 275331)),
     strand="*",
     state=c("AMPLIFICATION", "NEUTRAL", "DELETION", "LOH",
         "DELETION", "NEUTRAL", "NEUTRAL", "NEUTRAL", "DELETION", "DELETION", 
         "NEUTRAL", "AMPLIFICATION", "NEUTRAL"),
     log2ratio=c(0.5849625, 0, -1, -1, -0.87777, 0, 0, 0.1, -0.9211, -0.9822, 
                  0.01, 0.9777, 0))

head(sampleRef)

## To ensure reproducibility, the seed must be fixed before running 
## the simulation method
set.seed(121)

## Generates 2 simulated genomes based on the 'demo' genome
## The ID column identify each simulation
simRes <- processSim(curSample=sampleRef, nbSim=3)

## Each simulated profile contains the same number of chromosomes as 
## the reference sample
head(simRes[simRes$ID == "S1",])

head(simRes[simRes$ID == "S2",])

head(simRes[simRes$ID == "S3",])

## ----demoGR-------------------------------------------------------------------
## First, create the GRanges objects; one per sample
gr1 <- GRanges(seqnames="chr2", ranges=IRanges(3, 6000),
          strand="+", state="AMPLIFICATION", 
          log2ratio=0.45)
gr2 <- GRanges(seqnames=c("chr1", "chr2"),
          ranges=IRanges(c(7,5555), width=c(1200, 40)),
          strand=c("+", "-"),  state=c("NEUTRAL", "AMPLIFICATION"), 
          log2ratio=c(0.034, 0.5))
gr3 <- GRanges(seqnames=c("chr1", "chr2"),
          ranges=IRanges(c(1, 5577), c(3, 5666)),
          strand=c("-", "-"), state=c("NEUTRAL", "AMPLIFICATION"), 
          log2ratio=c(0.04, 0.31))

## Then, construct a GRangesList() using all the GRanges objects
grl <- GRangesList("sample01"=gr1, "sample02"=gr2, "sample03"=gr3)

## ----demoSeed, eval=FALSE-----------------------------------------------------
# ## First, fixe the seed value
# set.seed(121234)
# 
# ## Run the method to calculated the desired metrics
# ## The number of jobs (*nJobs* parameter) can be higher than one but
# ## have to remain the same then the calculation is redone to ensure
# ## reproducitble results
# metricLog <- calculateLog2ratioMetric(segmentData=grlog,
#                         method="weightedEuclideanDistance", nJobs=1)
# 

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

