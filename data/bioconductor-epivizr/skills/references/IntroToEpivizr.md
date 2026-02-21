# Introduction to `epivizr`: interactive visualization for genomic data

Héctor Corrada Bravo

#### 2025-10-29

# Contents

* [1 Preliminaries: the data](#preliminaries-the-data)
* [2 Using epivizr](#using-epivizr)
  + [2.1 The epivizr app](#the-epivizr-app)
  + [2.2 Listing available chart types](#listing-available-chart-types)
* [3 Adding charts](#adding-charts)
  + [3.1 Adding block region tracks](#adding-block-region-tracks)
  + [3.2 Modifying chart settings and colors](#modifying-chart-settings-and-colors)
  + [3.3 Printing charts](#printing-charts)
  + [3.4 Adding line plots along the genome](#adding-line-plots-along-the-genome)
* [4 Managing the app](#managing-the-app)
* [5 Charts that are not aligned to genomic location](#charts-that-are-not-aligned-to-genomic-location)
  + [5.1 Adding a scatterplot](#adding-a-scatterplot)
  + [5.2 The RangedSummarizedExperiment Object](#the-rangedsummarizedexperiment-object)
* [6 Visualizing data available from epiviz webserver](#visualizing-data-available-from-epiviz-webserver)
  + [6.1 Load remote measurements](#load-remote-measurements)
  + [6.2 Query measurements and add charts](#query-measurements-and-add-charts)
* [7 More application interactions](#more-application-interactions)
  + [7.1 Slideshow](#slideshow)
  + [7.2 Printing the epivizr workspace](#printing-the-epivizr-workspace)
  + [7.3 Saving the epivizr workspace](#saving-the-epivizr-workspace)
  + [7.4 Restarting the epivizr workspace](#restarting-the-epivizr-workspace)
  + [7.5 Closing the session](#closing-the-session)
* [8 Standalone version and browsing arbitrary genomes](#standalone-version-and-browsing-arbitrary-genomes)
* [9 SessionInfo](#sessioninfo)

[`Epiviz`](http://epiviz.cbcb.umd.edu) is an interactive visualization tool for functional genomics data. It supports genome navigation like other genome browsers, but allows multiple visualizations of data within genomic regions using scatterplots, heatmaps and other user-supplied visualizations. It also includes data from the [Gene Expression Barcode project](http://barcode.luhs.org/) for transcriptome visualization. It has a flexible plugin framework so users can add [d3](http://d3js.org/) visualizations. You can find more information about Epiviz at <http://epiviz.cbcb.umd.edu/help> and see a video tour [here](http://youtu.be/099c4wUxozA).

The *[epivizr](https://bioconductor.org/packages/3.22/epivizr)* package implements two-way communication between the `R/Bioconductor` computational genomics environment and `Epiviz`. Objects in an `R` session can be displayed as tracks or plots on Epiviz. Epivizr uses Websockets for communication between the browser Javascript client and the R environment, the same technology underlying the popular [Shiny](http://www.rstudio.com/shiny/) system for authoring interactive web-based reports in R.

# 1 Preliminaries: the data

In this vignette we will look at colon cancer methylation data from the TCGA project and expression data from the gene expression barcode project. The *[epivizrData](https://bioconductor.org/packages/3.22/epivizrData)* package contains human chromosome 11 methylation data from the Illumina 450kHumanMethylation beadarray processed with the *[minfi](https://bioconductor.org/packages/3.22/minfi)* package. We use expression data from the *[antiProfilesData](https://bioconductor.org/packages/3.22/antiProfilesData)* bioconductor package.

```
library(epivizr)
library(antiProfilesData)
library(SummarizedExperiment)
```

```
data(tcga_colon_blocks)
data(tcga_colon_curves)
data(apColonData)
```

The `tcga_colon_blocks` object is a `GRanges` object containing chromosome 11 regions of hypo or hyper methylation in colon cancer identified using the `blockFinder` function in the *[minfi](https://bioconductor.org/packages/3.22/minfi)* package.

```
show(tcga_colon_blocks)
```

```
## GRanges object with 129 ranges and 11 metadata columns:
##         seqnames              ranges strand |      value      area   cluster
##            <Rle>           <IRanges>  <Rle> |  <numeric> <numeric> <numeric>
##     [1]    chr11     4407026-6435089      * |  -0.142955   30.3064       495
##     [2]    chr11 131239366-133716186      * |  -0.135137   23.9193       520
##     [3]    chr11   55041873-57022542      * |  -0.173347   19.5882       507
##     [4]    chr11 114645223-116602403      * |  -0.140934   14.0934       520
##     [5]    chr11   78357700-80184550      * |  -0.156037   14.0433       507
##     ...      ...                 ...    ... .        ...       ...       ...
##   [125]    chr11   29644815-29650449      * | -0.0940451 0.1880901       497
##   [126]    chr11   41943963-41956273      * | -0.0760193 0.1520386       502
##   [127]    chr11   16298618-16314417      * | -0.0748444 0.1496888       495
##   [128]    chr11            38740154      * | -0.1172488 0.1172488       499
##   [129]    chr11            81757203      * | -0.0710558 0.0710558       508
##         indexStart  indexEnd         L  clusterL   p.value      fwer
##          <integer> <integer> <numeric> <integer> <numeric> <numeric>
##     [1]     130755    131000       212      1629         0         0
##     [2]     141959    142173       177      1759         0         0
##     [3]     134251    134374       113      1816         0         0
##     [4]     140000    140138       100      1759         0         0
##     [5]     138132    138249        90      1816         0         0
##     ...        ...       ...       ...       ...       ...       ...
##   [125]     132733    132734         2       367 0.0949029         1
##   [126]     133379    133380         2        45 0.3164872         1
##   [127]     131986    131987         2      1629 0.3420919         1
##   [128]     133331    133331         1         7 0.0564139         1
##   [129]     138263    138263         1        22 0.7299055         1
##         p.valueArea  fwerArea
##           <numeric> <numeric>
##     [1]           0         0
##     [2]           0         0
##     [3]           0         0
##     [4]           0         0
##     [5]           0         0
##     ...         ...       ...
##   [125]    0.416952         1
##   [126]    0.485759         1
##   [127]    0.494229         1
##   [128]    0.592025         1
##   [129]    0.860076         1
##   -------
##   seqinfo: 23 sequences from an unspecified genome; no seqlengths
```

The columns `value` and `p.value` can be used to determine which of these regions, or blocks, are interesting by looking at a volcano plot for instance.

```
plot(tcga_colon_blocks$value, -log10(tcga_colon_blocks$p.value), main="Volcano plot", xlab="Avg. methylation difference", ylab="-log10 p-value",xlim=c(-.5,.5))
```

![](data:image/png;base64...)

The `tcga_colon_curves` object is another `GRanges` object which contains the basepair resolution methylation data used to define these regions.

```
show(tcga_colon_curves)
```

```
## GRanges object with 7135 ranges and 7 metadata columns:
##          seqnames        ranges strand |        id    type blockgroup
##             <Rle>     <IRanges>  <Rle> | <numeric> <array>  <numeric>
##      [1]    chr11 131996-132411      * |    129466 OpenSea        495
##      [2]    chr11        189654      * |    129467 OpenSea        495
##      [3]    chr11        190242      * |    129468 OpenSea        495
##      [4]    chr11 192096-192141      * |    129469 OpenSea        495
##      [5]    chr11 192763-193112      * |    129470 OpenSea        495
##      ...      ...           ...    ... .       ...     ...        ...
##   [7131]    chr11     134892703      * |    142360 OpenSea        520
##   [7132]    chr11     134903175      * |    142361 OpenSea        520
##   [7133]    chr11     134910774      * |    142362 OpenSea        520
##   [7134]    chr11     134911302      * |    142363 OpenSea        520
##   [7135]    chr11     134945848      * |    142364 OpenSea        520
##                 diff     smooth normalMean cancerMean
##             <matrix>  <numeric>  <numeric>  <numeric>
##      [1] -0.08887101 -0.1236671   0.754493  0.6656216
##      [2] -0.00124486 -0.0865624   0.959529  0.9582840
##      [3] -0.16475918 -0.0862512   0.680068  0.5153091
##      [4]  0.00309472 -0.0852664   0.051342  0.0544367
##      [5] -0.10246356 -0.0848406   0.552358  0.4498948
##      ...         ...        ...        ...        ...
##   [7131]   -0.113948  -0.142140   0.401382   0.287434
##   [7132]   -0.011489  -0.153023   0.848214   0.836725
##   [7133]   -0.200665  -0.162767   0.636523   0.435859
##   [7134]   -0.140138  -0.163505   0.583162   0.443024
##   [7135]   -0.246704  -0.230860   0.675747   0.429043
##   -------
##   seqinfo: 24 sequences from an unspecified genome; no seqlengths
```

This basepair resolution data includes mean methylation levels for normal and cancer and a smoothed estimate of methylation difference. This smoothed difference estimate is used to define regions in the `tcga_colon_blocks` object.

Finally, the `apColonData` object is an `ExpressionSet` containing gene expression data for colon normal and tumor samples for genes within regions of methylation loss identified [this paper](http://www.nature.com/ng/journal/v43/n8/full/ng.865.html). Our goal in this vignette is to visualize this data as we browse the genome.

# 2 Using epivizr

## 2.1 The epivizr app

The connection to `Epiviz` is managed through a session manager object of class `EpivizApp`. We can create this object and open `Epiviz` using the `startEpiviz` function.

```
app <- startEpiviz(workspace="qyOTB6vVnff", gists="2caf8e891201130c7daa")
```

This opens a websocket connection between the interactive `R` session and the browser client. This will allow us to visualize data stored in the `Epiviz` server along with data in the interactive `R` session.

---

*Windows users:* In Windows platforms we need to use the `service` function to let the interactive `R` session connect to the `epiviz` web app and serve data requests. We then escape (using `ctl-c` or `esc` depending on your environment) to continue with the interactive `R` session. This is required anytime you want `epivizr` to serve data to the web app, for example, when interacting with the UI. (We are actively developing support for non-blocking sessions in Windows platforms).

```
app$server$service()
```

---

## 2.2 Listing available chart types

Once the browser is open and is connected to an active epivizr session, the epivizr session registers available chart types supported in the epiviz JS app. To list available chart types we use method `list_chart_types`. In this vignette, we only show three chart types available for use in the epiviz JS app. The production epiviz JS app has a larger number of chart types available. Chart types can also be added dynamically as described in the epiviz JS documentation: <http://epiviz.cbcb.umd.edu/help>. Chart types that are added dynamically are listed and usable within an `epivizr` session.

```
app$chart_mgr$list_chart_types()
```

```
##          type                          js_class num_settings
## 1 BlocksTrack epiviz.plugins.charts.BlocksTrack            6
## 2   LineTrack   epiviz.plugins.charts.LineTrack           15
## 3 ScatterPlot epiviz.plugins.charts.ScatterPlot           11
##                                                                              settings
## 1                title,marginTop,marginBottom,marginLeft,marginRight,minBlockDistance
## 2 title,marginTop,marginBottom,marginLeft,marginRight,measurementGroupsAggregator,...
## 3 title,marginTop,marginBottom,marginLeft,marginRight,measurementGroupsAggregator,...
##   num_colors
## 1         10
## 2          8
## 3         10
```

Chart type settings, e.g., line widths, colors, margins etc. can be modified dynamically. Settings available for each chart type are briefly listed in this call. See below for further detail on customizing charts through settings and colors.

# 3 Adding charts

## 3.1 Adding block region tracks

Once the browser is open we can visualize the `tcga_colon_blocks` object containing blocks of methylation modifications in colon cancer.
We use the `plot` method to do so.

```
blocks_chart <- app$plot(tcga_colon_blocks, datasource_name="450k colon_blocks")
```

---

*Windows users:* We need the `service` function to let the interactive `R` session serve data requests from the browser client as you interact with the UI.
Escape (using `ctl-c` or `esc` depending on your environment) to continue with the interactive `R` session.

```
app$server$service()
```

---

You should now see that a new track is added to the `Epiviz` web app. You can think of this track as an interactive display device in `R`. As you navigate on the browser, data is requested from the `R` session through the websocket connection. Remember to escape to continue with your interactive `R` session if you are not running “non-blocking” mode. The `blocks_chart` object inherits from class `EpivizChart`, which we can use to get information about the data being displayed and the chart used to display it. Note that the “brushing” effect we implement in `Epiviz` works for `epivizr` tracks as well.

Now that we have interactive data connections to `Epiviz` we may want to iteratively compute and visualize our data. For example, we may want to only display methylation blocks inferred at a certain statistical significance level. In this case, we will filter by block size.

```
# subset to those with length > 250Kbp
keep <- width(tcga_colon_blocks) > 250000

# get the data object for chart
ms_obj <- app$get_ms_object(blocks_chart)
app$update_measurements(ms_obj, tcga_colon_blocks[keep,])
```

Now, only this subset of blocks will be displayed in the already existing track.

## 3.2 Modifying chart settings and colors

To modify default chart colors or settings, we need to know what settings can be applied to the chart. Again, as these are defined dynamically in the epiviz JS app we use a method, `print_chart_type_info` on the `EpivizChartMgr` class to list settings that can be applied to specific chart type. For example, to list chart settings available for a `BlocksTrack` chart we use the following:

```
app$chart_mgr$print_chart_type_info("BlocksTrack")
```

```
## Settings for chart type  BlocksTrack
##                 id                  label default_value possible_values   type
## 1            title                  Title                               string
## 2        marginTop             Top margin            25                 number
## 3     marginBottom          Bottom margin            23                 number
## 4       marginLeft            Left margin            20                 number
## 5      marginRight           Right margin            10                 number
## 6 minBlockDistance Minimum block distance             5                 number
## Colors: #1f77b4, #ff7f0e, #2ca02c, #d62728, #9467bd, #8c564b, #e377c2, #7f7f7f, #bcbd22, #17becf
```

There are two ways to set settings and colors to a chart: when the chart is initially created using the `plot` method, or after the
chart is created using the `set` method in class `EpivizChart`. We will illustrate both ways of doing this:

If using the `plot` method, use the `list_chart_settings` method as above to list settings that can be applied to a chart type.
For example, for a `BlocksTrack` chart, we can set `minBlockDistance` as a setting for the plot function which controls how close genomic
regions can be before they are merged into a single rectangle in the chart. We can also change colors used in the chart this way.

```
settings <- list(minBlockDistance=50)
colors <- c("#d15014", "#5e97eb", "#e81ccd")
blocks_chart <- app$plot(tcga_colon_blocks, datasource_name="450k colon_blocks", settings=settings, colors=colors)
```

This will create a second blocks track using a different color map.

On the other hand, if the `BlockChart` is already added to the epiviz JS application session, use the `set_chart_settings` method to update settings and colors.

```
# create a list of settings and colors to update the plot
settings <- list(minBlockDistance=100)
colors <- c("#5e97eb", "#d15014", "#e81ccd")
app$chart_mgr$set_chart_settings(blocks_chart, settings=settings, colors=colors)
```

This changes the color map for the second blocks track added. Use the `print_chart_info` method to list settings and colors currently used in the chart.

```
# to list applied chart settings
app$chart_mgr$print_chart_info(blocks_chart)
```

```
## Chart settings for chart id  epivizChart_2 :
##                 id                  label default_value possible_values   type
## 1            title                  Title                               string
## 2        marginTop             Top margin            25                 number
## 3     marginBottom          Bottom margin            23                 number
## 4       marginLeft            Left margin            20                 number
## 5      marginRight           Right margin            10                 number
## 6 minBlockDistance Minimum block distance           100                 number
## Colors: #5e97eb, #d15014, #e81ccd
```

Methods are also available directly on the `EpivizChart` objects. E.g., calls `blocks_chart$set(settings=settings, colors=colors)`
and `blocks_chart$print_info()` yield the same result.

## 3.3 Printing charts

Charts can be printed as a pdf or png file through the epivizr session. To do so, use the `print_chart` method:

```
app$chart_mgr$print_chart(blocks_chart, file_name="blocks_chart", file_type="pdf")
```

This will create a file named `blocks_chart.pdf` which will be downloaded through your web browser. It will be found in the default file download location for your web browser.

## 3.4 Adding line plots along the genome

There are a number of different data types available to use through `epivizr`. You can see a list of R/BioC classes that are supported using `?register`. In the previous section, we used the `block` data type to register a `GenomicRanges` object. To visualize methylation data at base-pair resolution from the `tcga_colon_curves` `GenomicRanges` object, we will use the `bp` type.

```
# add low-filter smoothed methylation estimates
means_track <- app$plot(tcga_colon_curves, datasource_name="450kMeth",type="bp",columns=c("cancerMean","normalMean"))
```

NOTE: You can adjust track settings to change how this new track looks like. For instance, to show all points in the window set the `step` parameter to 1, and to see a smooth interpolation of the data set the `interpolation` parameter to `basis`:

```
means_track$set(settings=list(step=1, interpolation="basis"))
```

Notice that we added two lines in this plot, one for mean methylation in cancer and another for mean methylation in normal. The `columns` argument specifies which columns in `mcols(colon_curves)` will be displayed.

We can also add a track containing the smooth methylation difference estimate used to define methylation blocks.

```
diff_chart <- app$plot(tcga_colon_curves, datasource_name="450kMethDiff",type="bp",columns=c("smooth"),ylim=matrix(c(-.5,.5),nc=1))
```

We pass limits for the y axis in this case. To see other arguments supported, you can use the help framework in R `?"EpivizApp"`. As before, we can specify settings for this new track.

# 4 Managing the app

We can use the app connection object to list charts we have added so far, or to remove charts.

```
app$chart_mgr$list_charts()
```

```
##              id                              type
## 1 epivizChart_1 epiviz.plugins.charts.BlocksTrack
## 2 epivizChart_2 epiviz.plugins.charts.BlocksTrack
## 3 epivizChart_3   epiviz.plugins.charts.LineTrack
## 4 epivizChart_4   epiviz.plugins.charts.LineTrack
##                                  measurements connected
## 1       450k colon_blocks_1:450k colon_blocks
## 2       450k colon_blocks_2:450k colon_blocks
## 3 450kMeth_3:cancerMean,450kMeth_3:normalMean
## 4                       450kMethDiff_4:smooth
```

```
app$chart_mgr$rm_chart(means_track)
app$chart_mgr$list_charts()
```

```
##              id                              type
## 1 epivizChart_1 epiviz.plugins.charts.BlocksTrack
## 2 epivizChart_2 epiviz.plugins.charts.BlocksTrack
## 3 epivizChart_4   epiviz.plugins.charts.LineTrack
##                            measurements connected
## 1 450k colon_blocks_1:450k colon_blocks
## 2 450k colon_blocks_2:450k colon_blocks
## 3                 450kMethDiff_4:smooth
```

# 5 Charts that are not aligned to genomic location

## 5.1 Adding a scatterplot

Now we want to visualize the colon expression data in `apColonData` object as an MA plot in `Epiviz`. First, we add an `"MA"` assay to the `ExpressionSet`:

```
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
```

```
## ExpressionSet (storageMode: lockedEnvironment)
## assayData: 5339 features, 2 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: colonM colonA
##   varLabels: stat
##   varMetadata: labelDescription
## featureData: none
## experimentData: use 'experimentData(object)'
## Annotation: hgu133plus2
```

`epivizr` will use the `annotation(maEset)` annotation to determine genomic locations using the `AnnotationDbi` package so that only probesets inside the current browser window are displayed.

```
eset_chart <- app$plot(maEset, datasource_name="MAPlot", columns=c("colonA","colonM"))
```

```
## Loading required package: hgu133plus2.db
```

```
## Loading required package: AnnotationDbi
```

```
## Loading required package: org.Hs.eg.db
```

```
##
```

```
##
```

```
## 'select()' returned 1:many mapping between keys and columns
```

In this case, we specify which data is displayed in each axis of the scatter plot using the `columns` argument. The `assay` arguments indicates where data is obtained.

## 5.2 The RangedSummarizedExperiment Object

`Epiviz` is also able to display plots of data in the form of a `RangedSummarizedExperiment` object. After loading the `tcga_colon_expression` dataset in the `epivizrData` package, we can see that this object contains information on 239322 exons in 40 samples.

```
data(tcga_colon_expression)
show(tcga_colon_expression)
```

```
## class: RangedSummarizedExperiment
## dim: 12800 40
## metadata(0):
## assays(1): ''
## rownames(12800): 143686 149186 ... 149184 149185
## rowData names(2): exon_id gene_id
## colnames(40): TCGA-A6-5659-01A-01R-1653-07 TCGA-A6-5659-11A-01R-1653-07
##   ... TCGA-D5-5540-01A-01R-1653-07 TCGA-D5-5541-01A-01R-1653-07
## colData names(110): bcr_patient_barcode bcr_sample_uuid ... Basename
##   fullID
```

The `assay` slot holds a matrix of raw sequencing counts, so before we can plot a scatterplot showing expression, we must first normalize the count data. We use the geometric mean of each row as a reference sample to divide each column (sample) by, then use the median of each column as a scaling factor to divide each row (exon) by.

```
ref_sample <- 2 ^ rowMeans(log2(assay(tcga_colon_expression) + 1))
scaled <- (assay(tcga_colon_expression) + 1) / ref_sample
scaleFactor <- Biobase::rowMedians(t(scaled))
assay_normalized <- sweep(assay(tcga_colon_expression), 2, scaleFactor, "/")
assay(tcga_colon_expression) <- assay_normalized
```

Now, using the expression data in the `assay` slot and the sample data in the `colData` slot, we can compute mean exon expression by sample type.

```
status <- colData(tcga_colon_expression)$sample_type
index <- split(seq(along = status), status)
logCounts <- log2(assay(tcga_colon_expression) + 1)
means <- sapply(index, function(ind) rowMeans(logCounts[, ind]))
mat <- cbind(cancer = means[, "Primary Tumor"], normal = means[, "Solid Tissue Normal"])
```

Now, create a new `RangedSummarizedExperiment` object with the two column matrix, and all the information about the features of interest, in this case exons, are stored in the `rowRanges` slot to be queried by `Epiviz`.

```
sumexp <- SummarizedExperiment(mat, rowRanges=rowRanges(tcga_colon_expression))
se_chart <- app$plot(sumexp, datasource_name="Mean by Sample Type", columns=c("normal", "cancer"))
```

Again, the `columns` argument specifies what data will be displayed along which axis.

# 6 Visualizing data available from epiviz webserver

## 6.1 Load remote measurements

Epiviz web server (<http://epiviz.cbcb.umd.edu>) currently hosts data sets from several sources including Gene Expression Barcode project. We provide a way to load these remotely hosted datasets and integrate/analyze with your current workflow and local data. For this, Lets first get the list of measurements available from the webserver

```
app$load_remote_measurements()
remote_measurements <- app$data_mgr$get_remote_measurements()
```

## 6.2 Query measurements and add charts

`remote_measurements` is a list of `EpivizMeasurement` objects. We can query this list to choose the datasets we would like to load from the webserver. For the purpose of this vignette, lets find measurements to visualize data from gene expression barcode project for tumor and normal samples from lung, colon and breast tissues.

```
measurementList <- lapply(remote_measurements, function(m) {
  if(m@name %in% c("colon normal", "lung normal", "breast normal", "colon tumor", "lung tumor", "breast tumor") && m@datasourceId == "gene_expression_barcode_subtype") {
    m
  }
})

measurements <- Filter(Negate(is.null), measurementList)
```

Now lets add a heatmap using the measurements we just selected. For this we use the `visualize` function from the `EpivizChartMgr` class.

```
app$chart_mgr$visualize("HeatmapPlot", measurements = measurements)
```

Similarly other chart types registered with the current epivizr session can be used with the datasets from the webserver.

# 7 More application interactions

## 7.1 Slideshow

We can navigate to a location on the genome using the `navigate` method of the app object:

```
app$navigate("chr11", 110000000, 120000000)
```

There is a convenience function to quickly navigate to a series of locations in succession.
We can use that to browse the genome along a ranked list of regions. Let’s navigate to the
5 most up-regulated exons in the colon exon expression data.

```
foldChange <- mat[,"cancer"]-mat[,"normal"]
ind <- order(foldChange,decreasing=TRUE)

# bounding 1Mb around each exon
slideshowRegions <- trim(rowRanges(sumexp)[ind] + 1000000L)
app$slideshow(slideshowRegions, n=5)
```

## 7.2 Printing the epivizr workspace

To print the current epiviz workspace as a pdf or png, we use the `print_workspace` method:

```
app$print_workspace(file_name="workspace", file_type="pdf")
```

This will create a file named `workspace.pdf` and will be downloaded through your web browser. It will be saved to the default file download location for your web browser.

## 7.3 Saving the epivizr workspace

To save the current state of the epiviz app, and UI workspace, into an `rda` file, we use the `save` method:

```
app$save(file="app.rda", include_data=TRUE)
```

This will create a file named `app.rda` that can be restarted for later use and analysis. For a smaller file size, you may choose whether to include or exclude the data when saving the workspace. In this case, expressions used to add data
to the app, through `add_measurements` or `plot` as shown above, will be stored
and re-evaluated when restarting the app.

## 7.4 Restarting the epivizr workspace

After a workspace is saved using the `save` method shown above, we can replot it using the following:

```
app <- restartEpiviz(file="app.rda", open_browser=TRUE)
```

```
## .
```

This will recreate the workspace in your web browser and reconnect it with the R session. If the workspace you are restarting did not include its data when saving the file, you will need to load the data in your global environment before restarting epiviz. This will allow to reload the data used in the app.

## 7.5 Closing the session

To close the connection to `Epiviz` and remove all tracks added during the interactive session, we use the `stop_app` function.

```
app$stop_app()
```

# 8 Standalone version and browsing arbitrary genomes

The `epivizrStandalone` all files required to run the web app UI locally. This feature
can be used to browse any genome of interest. See that packages vignette for more information.

# 9 SessionInfo

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] hgu133plus2.db_3.13.0       org.Hs.eg.db_3.22.0
##  [3] AnnotationDbi_1.72.0        SummarizedExperiment_1.40.0
##  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [7] IRanges_2.44.0              S4Vectors_0.48.0
##  [9] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [11] antiProfilesData_1.45.0     Biobase_2.70.0
## [13] BiocGenerics_0.56.0         generics_0.1.4
## [15] epivizr_2.40.0              BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] blob_1.2.4               Biostrings_2.78.0        bitops_1.0-9
##  [4] fastmap_1.2.0            RCurl_1.98-1.17          lazyeval_0.2.2
##  [7] GenomicAlignments_1.46.0 promises_1.4.0           XML_3.99-0.19
## [10] digest_0.6.37            mime_0.13                lifecycle_1.0.4
## [13] ProtGenerics_1.42.0      KEGGREST_1.50.0          RSQLite_2.4.3
## [16] magrittr_2.0.4           compiler_4.5.1           rlang_1.1.6
## [19] sass_0.4.10              tools_4.5.1              yaml_2.3.10
## [22] rtracklayer_1.70.0       knitr_1.50               S4Arrays_1.10.0
## [25] bit_4.6.0                curl_7.0.0               DelayedArray_0.36.0
## [28] abind_1.4-8              BiocParallel_1.44.0      grid_4.5.1
## [31] tinytex_0.57             cli_3.6.5                rmarkdown_2.30
## [34] crayon_1.5.3             otel_0.2.0               httr_1.4.7
## [37] rjson_0.2.23             DBI_1.2.3                cachem_1.1.0
## [40] parallel_4.5.1           AnnotationFilter_1.34.0  BiocManager_1.30.26
## [43] XVector_0.50.0           restfulr_0.0.16          vctrs_0.6.5
## [46] Matrix_1.7-4             jsonlite_2.0.0           bookdown_0.45
## [49] bit64_4.6.0-1            RBGL_1.86.0              ensembldb_2.34.0
## [52] magick_2.9.0             GenomicFeatures_1.62.0   jquerylib_0.1.4
## [55] codetools_0.2-20         epivizrData_1.38.0       epivizrServer_1.38.0
## [58] later_1.4.4              GenomeInfoDb_1.46.0      BiocIO_1.20.0
## [61] UCSC.utils_1.6.0         htmltools_0.5.8.1        graph_1.88.0
## [64] R6_2.6.1                 evaluate_1.0.5           OrganismDbi_1.52.0
## [67] lattice_0.22-7           png_0.1-8                Rsamtools_2.26.0
## [70] cigarillo_1.0.0          memoise_2.0.1            httpuv_1.6.16
## [73] bslib_0.9.0              Rcpp_1.1.0               SparseArray_1.10.0
## [76] xfun_0.53                pkgconfig_2.0.3
```