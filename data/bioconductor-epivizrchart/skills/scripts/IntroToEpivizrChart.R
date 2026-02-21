# Code example from 'IntroToEpivizrChart' vignette. See references/ for full tutorial.

## ----setup, eval=TRUE, include=FALSE------------------------------------------
library(epivizrChart)
library(antiProfilesData)
library(SummarizedExperiment)
library(RColorBrewer)
library(Homo.sapiens)
library(AnnotationHub)
library(GenomicRanges)

## -----------------------------------------------------------------------------
data(tcga_colon_blocks)
data(tcga_colon_curves)
data(tcga_colon_expression)
data(apColonData)

## -----------------------------------------------------------------------------
library(Homo.sapiens)

genes_track <- epivizChart(Homo.sapiens, chr="chr11", start=118000000, end=121000000)
genes_track

## -----------------------------------------------------------------------------
scatter_plot <- epivizChart(tcga_colon_curves, chr="chr11", start=99800000, end=103383180, type="bp", columns=c("cancerMean","normalMean"), chart="ScatterPlot")
scatter_plot

## -----------------------------------------------------------------------------
epivizEnv <- epivizEnv(chr="chr11", start=118000000, end=121000000)

genes_track <- epivizEnv$plot(Homo.sapiens)
blocks_track <- epivizEnv$plot(tcga_colon_blocks, datasource_name="450kMeth")

epivizEnv

## -----------------------------------------------------------------------------
epivizNav <- epivizNav(chr="chr11", start=118000000, end=121000000)

genes_track <- epivizNav$plot(Homo.sapiens)
blocks_track <- epivizNav$plot(tcga_colon_blocks, datasource_name="450kMeth")

epivizNav

## -----------------------------------------------------------------------------
epivizEnv <- epivizEnv(chr="chr11", start=99800000, end=103383180)

## ----warning=FALSE, message=FALSE---------------------------------------------
require(Homo.sapiens)

genes_track <- epivizEnv$plot(Homo.sapiens)
genes_track

## -----------------------------------------------------------------------------
blocks_track <- epivizEnv$plot(tcga_colon_blocks, datasource_name="450kMeth")
blocks_track

## ----eval=FALSE---------------------------------------------------------------
# epivizEnv

## -----------------------------------------------------------------------------
means_track <- epivizEnv$plot(tcga_colon_curves, datasource_name="450kMeth", type="bp", columns=c("cancerMean","normalMean"))
means_track

## ----warning=FALSE, message=FALSE---------------------------------------------
keep <- pData(apColonData)$SubType!="adenoma"
apColonData <- apColonData[,keep]
status <- pData(apColonData)$Status
Indexes <- split(seq(along=status),status)

exprMat <- exprs(apColonData)
mns <- sapply(Indexes, function(ind) rowMeans(exprMat[,ind]))
mat <- cbind(colonM=mns[,"1"]-mns[,"0"], colonA=0.5*(mns[,"1"]+mns[,"0"]))

pd <- data.frame(stat=c("M","A"))
rownames(pd) <- colnames(mat)

maEset <- ExpressionSet(
  assayData=mat,
  phenoData=AnnotatedDataFrame(pd),
  featureData=featureData(apColonData),
  annotation=annotation(apColonData)
)

eset_chart <- epivizEnv$plot(maEset, datasource_name="MAPlot", columns=c("colonA","colonM"))
eset_chart

## -----------------------------------------------------------------------------
ref_sample <- 2 ^ rowMeans(log2(assay(tcga_colon_expression) + 1))
scaled <- (assay(tcga_colon_expression) + 1) / ref_sample
scaleFactor <- Biobase::rowMedians(t(scaled))
assay_normalized <- sweep(assay(tcga_colon_expression), 2, scaleFactor, "/")
assay(tcga_colon_expression) <- assay_normalized

status <- colData(tcga_colon_expression)$sample_type
index <- split(seq(along = status), status)
logCounts <- log2(assay(tcga_colon_expression) + 1)
means <- sapply(index, function(ind) rowMeans(logCounts[, ind]))
mat <- cbind(cancer = means[, "Primary Tumor"], normal = means[, "Solid Tissue Normal"])

sumexp <- SummarizedExperiment(mat, rowRanges=rowRanges(tcga_colon_expression))

se_chart <- epivizEnv$plot(sumexp, datasource_name="Mean by Sample Type", columns=c("normal", "cancer"))
se_chart

## -----------------------------------------------------------------------------
# get measurements
measurements <- se_chart$get_measurements()

# create a heatmap using these measurements
heatmap_plot <- epivizEnv$plot(measurements=measurements, chart="HeatmapPlot")
heatmap_plot

## ----eval=FALSE---------------------------------------------------------------
# order <- list(
#   heatmap_plot,
#   genes_track,
#   blocks_track,
#   means_track,
#   se_chart,
#   eset_chart
# )
# 
# epivizEnv$order_charts(order)

## -----------------------------------------------------------------------------
epivizEnv

## ----eval=FALSE---------------------------------------------------------------
# epivizEnv$navigate(chr="chr11", start=110800000, end=130383180)
# epivizEnv

## ----eval=FALSE---------------------------------------------------------------
# # create an environment to show data from entire chromosome 11
# epivizEnv <- epivizEnv(chr="chr11")
# 
# # add a line track from tcga_colon_curves object to the environment
# means_track <- epivizEnv$plot(tcga_colon_curves, datasource_name="450kMeth", type="bp", columns=c("cancerMean","normalMean"))
# 
# # add a scatter plot from the summarized experiment object to the environment
# se_chart <- epivizEnv$plot(sumexp, datasource_name="Mean by Sample Type", columns=c("normal", "cancer"))
# 
# # create a new navigation element that shows a particular region in chr11
# epivizNav <- epivizNav(chr="chr11", start=99800000, end=103383180, parent=epivizEnv)
# 
# # add a blocks track to the navigation element
# blocks_track <- epivizNav$plot(tcga_colon_blocks, datasource_name="450kMeth")
# 
# epivizEnv

## ----eval=FALSE---------------------------------------------------------------
# epivizEnv <- epivizEnv(chr="chr11")
# 
# # add a blocks track to the evironment
# blocks_track <- epivizEnv$plot(tcga_colon_blocks, datasource_name="450kMeth")
# # add a scatter plot from the summarized experiment object to the environment
# se_chart <- epivizEnv$plot(sumexp, datasource_name="Mean by Sample Type", columns=c("normal", "cancer"))
# 
# epivizNav <- epivizEnv$init_region(chr="chr11", start=99800000, end=103383180)
# 
# epivizEnv

## ----eval=FALSE---------------------------------------------------------------
# epivizEnv$remove_all_charts()

## ----eval=FALSE---------------------------------------------------------------
# colors <- brewer.pal(3, "Dark2")
# 
# blocks_track <- epivizChart(tcga_colon_blocks, chr="chr11", start=99800000, end=103383180, colors=colors)
# 
# # to list availble settings for a chart
# blocks_track$get_available_settings()
# 
# settings <- list(
#   title="Blocks",
#   minBlockDistance=10
#   )
# 
# blocks_track$set_settings(settings)
# blocks_track
# 
# blocks_track$set_colors(c("#D95F02"))
# blocks_track
# 
# colors <- brewer.pal(3, "Dark2")
# lines_track <- epivizChart(tcga_colon_curves, chr="chr11", start=99800000, end=103383180, type="bp", columns=c("cancerMean","normalMean"))
# lines_track
# 
# lines_track$set_colors(colors)
# lines_track

## ----eval=FALSE---------------------------------------------------------------
# 
# library(epivizrChart)
# 
# # initialize environment with interactive = true. this argument will init. an epiviz-data-source element
# epivizEnv <- epivizEnv(chr="chr11", start=118000000, end=121000000, interactive=TRUE)
# 

## ----eval=FALSE---------------------------------------------------------------
# library(epivizrServer)
# 
# library(Homo.sapiens)
# data(tcga_colon_blocks)
# 
# # initialize server
# server <- epivizrServer::createServer()
# 
# # register all our actions between websocket and components
# epivizrChart:::.register_all_the_epiviz_things(server, epivizEnv)
# 
# # start server
# server$start_server()

## ----eval=FALSE---------------------------------------------------------------
# # plot charts
# blocks_track <- epivizEnv$plot(tcga_colon_blocks, datasource_name="450kMeth")
# epivizEnv
# 
# genes <- epivizEnv$plot(Homo.sapiens)
# epivizEnv

## ----eval=FALSE---------------------------------------------------------------
# server$stop_server()

## -----------------------------------------------------------------------------
ah <- AnnotationHub()
epi <- query(ah, c("roadmap"))
df <- epi[["AH49015"]]

## -----------------------------------------------------------------------------
rna_plot <- epivizChart(df, datasource_name="RNASeq", columns=c("E006","E114"), chart="ScatterPlot")
rna_plot

