# Code example from 'IntroToEpivizr' vignette. See references/ for full tutorial.

## ----eval=TRUE, echo=TRUE, results='hide', warning=FALSE, error=FALSE, message=FALSE----
library(epivizr)
library(antiProfilesData)
library(SummarizedExperiment)

## -----------------------------------------------------------------------------
data(tcga_colon_blocks)
data(tcga_colon_curves)
data(apColonData)

## -----------------------------------------------------------------------------
show(tcga_colon_blocks)

## ----fig.width=4, fig.height=4, fig.align='center'----------------------------
plot(tcga_colon_blocks$value, -log10(tcga_colon_blocks$p.value), main="Volcano plot", xlab="Avg. methylation difference", ylab="-log10 p-value",xlim=c(-.5,.5))

## -----------------------------------------------------------------------------
show(tcga_colon_curves)

## ----eval=FALSE, echo=TRUE----------------------------------------------------
# app <- startEpiviz(workspace="qyOTB6vVnff", gists="2caf8e891201130c7daa")

## ----eval=TRUE, echo=FALSE----------------------------------------------------
app <- startEpiviz(host="http://localhost", http_port=8989, debug=TRUE, open_browser=FALSE, non_interactive=TRUE, try_ports=TRUE)


# register BlockTrack
js_chart_settings <- list(list(id = "title", type = "string", defaultValue = "", label = "Title", possibleValues = NULL), list(id = "marginTop", type = "number", defaultValue = 25, label = "Top margin", possibleValues = NULL), list(id = "marginBottom", type = "number", defaultValue = 23, label = "Bottom margin", possibleValues = NULL), list(id = "marginLeft", type = "number", defaultValue = 20, label = "Left margin", possibleValues = NULL), list(id = "marginRight", type = "number", defaultValue = 10, label = "Right margin", possibleValues = NULL), list(id = "minBlockDistance", type = "number", defaultValue = 5, label = "Minimum block distance", possibleValues = NULL))

js_chart_colors = c("#1f77b4", "#ff7f0e", "#2ca02c", "#d62728", "#9467bd", "#8c564b", "#e377c2", "#7f7f7f", "#bcbd22", "#17becf")

app$chart_mgr$register_chart_type("BlocksTrack", "epiviz.plugins.charts.BlocksTrack", js_chart_settings=js_chart_settings, js_chart_colors=js_chart_colors)

# register LineTrack
js_chart_settings <- list(list(id = "title", type = "string", defaultValue = "", label = "Title", possibleValues = NULL), list(id = "marginTop", type = "number", defaultValue = 25, label = "Top margin", possibleValues = NULL), list(id = "marginBottom", type = "number", defaultValue = 23, label = "Bottom margin", possibleValues = NULL), list(id = "marginLeft", type = "number", defaultValue = 20, label = "Left margin", possibleValues = NULL), list(id = "marginRight", type = "number", defaultValue = 10, label = "Right margin", possibleValues = NULL), list(id = "measurementGroupsAggregator", type = "categorical", defaultValue = "mean-stdev", label = "Aggregator for measurement groups", possibleValues = c("mean-stdev", "quartiles", "count", "min", "max", "sum")), list(id = "step", type = "number", defaultValue = 50, label = "Step", possibleValues = NULL), list(id = "showPoints", type = "boolean", defaultValue = FALSE, label = "Show points", possibleValues = NULL), list(id = "showLines", type = "boolean", defaultValue = TRUE, label = "Show lines", possibleValues = NULL), list(id = "showErrorBars", type = "boolean", defaultValue = TRUE, label = "Show error bars", possibleValues = NULL), list(id = "pointRadius", type = "number", defaultValue = 1, label = "Point radius", possibleValues = NULL), list(id = "lineThickness", type = "number", defaultValue = 1, label = "Line thickness", possibleValues = NULL), list(id = "yMin", type = "number", defaultValue = "default", label = "Min Y", possibleValues = NULL), list(id = "yMax", type = "number", defaultValue = "default", label = "Max Y", possibleValues = NULL), list(id = "interpolation", type = "categorical", defaultValue = "linear", label = "Interpolation", possibleValues = c("linear", "step-before", "step-after", "basis", "basis-open", "basis-closed", "bundle", "cardinal", "cardinal-open", "monotone")))

js_chart_colors <- c("#1859a9", "#ed2d2e", "#008c47", "#010101", "#f37d22", "#662c91", "#a11d20", "#b33893")

app$chart_mgr$register_chart_type("LineTrack", "epiviz.plugins.charts.LineTrack", js_chart_settings=js_chart_settings, js_chart_colors=js_chart_colors)

# register ScatterPlot
js_chart_settings <- list(list(id = "title", type = "string", defaultValue = "", label = "Title", possibleValues = NULL), list(id = "marginTop", type = "number", defaultValue = 15, label = "Top margin", possibleValues = NULL), list(id = "marginBottom", type = "number", defaultValue = 50, label = "Bottom margin", possibleValues = NULL), list(id = "marginLeft", type = "number", defaultValue = 50, label = "Left margin", possibleValues = NULL), list(id = "marginRight", type = "number", defaultValue = 15, label = "Right margin", possibleValues = NULL), list(id = "measurementGroupsAggregator", type = "categorical", defaultValue = "mean-stdev", label = "Aggregator for measurement groups", possibleValues = c("mean-stdev", "quartiles", "count", "min", "max", "sum")), list(id = "circleRadiusRatio", type = "number", defaultValue = 0.015, label = "Circle radius ratio", possibleValues = NULL), list(id = "xMin", type = "number", defaultValue = "default", label = "Min X", possibleValues = NULL), list(id = "xMax", type = "number", defaultValue = "default", label = "Max X", possibleValues = NULL), list(id = "yMin", type = "number", defaultValue = "default", label = "Min Y", possibleValues = NULL), list(id = "yMax", type = "number", defaultValue = "default", label = "Max Y", possibleValues = NULL))

js_chart_colors <- c("#1f77b4", "#ff7f0e", "#2ca02c", "#d62728", "#9467bd", "#8c564b", "#e377c2", "#7f7f7f", "#bcbd22", "#17becf")

app$chart_mgr$register_chart_type("ScatterPlot", "epiviz.plugins.charts.ScatterPlot", js_chart_settings=js_chart_settings, js_chart_colors=js_chart_colors)

app$server$start_server()

## ----eval=FALSE---------------------------------------------------------------
# app$server$service()

## -----------------------------------------------------------------------------
app$chart_mgr$list_chart_types()

## ----eval=TRUE----------------------------------------------------------------
blocks_chart <- app$plot(tcga_colon_blocks, datasource_name="450k colon_blocks")

## ----eval=TRUE----------------------------------------------------------------
app$server$service()

## ----eval=TRUE----------------------------------------------------------------
# subset to those with length > 250Kbp
keep <- width(tcga_colon_blocks) > 250000

# get the data object for chart
ms_obj <- app$get_ms_object(blocks_chart)
app$update_measurements(ms_obj, tcga_colon_blocks[keep,])

## -----------------------------------------------------------------------------
app$chart_mgr$print_chart_type_info("BlocksTrack")

## ----eval=TRUE----------------------------------------------------------------
settings <- list(minBlockDistance=50)
colors <- c("#d15014", "#5e97eb", "#e81ccd")
blocks_chart <- app$plot(tcga_colon_blocks, datasource_name="450k colon_blocks", settings=settings, colors=colors)

## ----eval=TRUE----------------------------------------------------------------
# create a list of settings and colors to update the plot
settings <- list(minBlockDistance=100)
colors <- c("#5e97eb", "#d15014", "#e81ccd")
app$chart_mgr$set_chart_settings(blocks_chart, settings=settings, colors=colors)

## -----------------------------------------------------------------------------
# to list applied chart settings
app$chart_mgr$print_chart_info(blocks_chart)

## ----eval=TRUE----------------------------------------------------------------
app$chart_mgr$print_chart(blocks_chart, file_name="blocks_chart", file_type="pdf")

## ----eval=TRUE----------------------------------------------------------------
# add low-filter smoothed methylation estimates
means_track <- app$plot(tcga_colon_curves, datasource_name="450kMeth",type="bp",columns=c("cancerMean","normalMean"))

## ----eval=TRUE----------------------------------------------------------------
means_track$set(settings=list(step=1, interpolation="basis"))

## ----eval=TRUE----------------------------------------------------------------
diff_chart <- app$plot(tcga_colon_curves, datasource_name="450kMethDiff",type="bp",columns=c("smooth"),ylim=matrix(c(-.5,.5),nc=1))

## ----eval=TRUE----------------------------------------------------------------
app$chart_mgr$list_charts()
app$chart_mgr$rm_chart(means_track)
app$chart_mgr$list_charts()

## -----------------------------------------------------------------------------
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
show(maEset)

## ----eval=TRUE----------------------------------------------------------------
eset_chart <- app$plot(maEset, datasource_name="MAPlot", columns=c("colonA","colonM"))

## -----------------------------------------------------------------------------
data(tcga_colon_expression)
show(tcga_colon_expression)

## ----eval=TRUE----------------------------------------------------------------
ref_sample <- 2 ^ rowMeans(log2(assay(tcga_colon_expression) + 1))
scaled <- (assay(tcga_colon_expression) + 1) / ref_sample
scaleFactor <- Biobase::rowMedians(t(scaled))
assay_normalized <- sweep(assay(tcga_colon_expression), 2, scaleFactor, "/")
assay(tcga_colon_expression) <- assay_normalized

## ----eval=TRUE----------------------------------------------------------------
status <- colData(tcga_colon_expression)$sample_type
index <- split(seq(along = status), status)
logCounts <- log2(assay(tcga_colon_expression) + 1)
means <- sapply(index, function(ind) rowMeans(logCounts[, ind]))
mat <- cbind(cancer = means[, "Primary Tumor"], normal = means[, "Solid Tissue Normal"])

## ----eval=TRUE----------------------------------------------------------------
sumexp <- SummarizedExperiment(mat, rowRanges=rowRanges(tcga_colon_expression))
se_chart <- app$plot(sumexp, datasource_name="Mean by Sample Type", columns=c("normal", "cancer"))

## ----eval=FALSE, echo=TRUE----------------------------------------------------
# app$load_remote_measurements()
# remote_measurements <- app$data_mgr$get_remote_measurements()

## ----eval=FALSE, echo=TRUE----------------------------------------------------
# measurementList <- lapply(remote_measurements, function(m) {
#   if(m@name %in% c("colon normal", "lung normal", "breast normal", "colon tumor", "lung tumor", "breast tumor") && m@datasourceId == "gene_expression_barcode_subtype") {
#     m
#   }
# })
# 
# measurements <- Filter(Negate(is.null), measurementList)

## ----eval=FALSE, echo=TRUE----------------------------------------------------
# app$chart_mgr$visualize("HeatmapPlot", measurements = measurements)

## ----eval=TRUE----------------------------------------------------------------
app$navigate("chr11", 110000000, 120000000)

## ----eval=TRUE, warning=FALSE-------------------------------------------------
foldChange <- mat[,"cancer"]-mat[,"normal"]
ind <- order(foldChange,decreasing=TRUE)

# bounding 1Mb around each exon
slideshowRegions <- trim(rowRanges(sumexp)[ind] + 1000000L)
app$slideshow(slideshowRegions, n=5)

## ----eval=TRUE----------------------------------------------------------------
app$print_workspace(file_name="workspace", file_type="pdf")

## ----eval=TRUE----------------------------------------------------------------
app$save(file="app.rda", include_data=TRUE)

## ----eval=TRUE----------------------------------------------------------------
app <- restartEpiviz(file="app.rda", open_browser=TRUE)

## -----------------------------------------------------------------------------
app$stop_app()

## ----session-info, cache=FALSE------------------------------------------------
sessionInfo()

