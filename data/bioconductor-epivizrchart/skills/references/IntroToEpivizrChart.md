# Visualizing Epiviz Web Components with epivizrChart

Hector Corrada Bravo, Jayaram Kancherla, Brian Gottfried

#### 2025-10-29

# Contents

* [1 What are Epiviz Web Components ?](#what-are-epiviz-web-components)
  + [1.0.1 Epiviz Charts](#epiviz-charts)
  + [1.0.2 Epiviz Environment](#epiviz-environment)
  + [1.0.3 Epiviz Navigation](#epiviz-navigation)
* [2 `epivizrChart` examples](#epivizrchart-examples)
  + [2.0.1 Navigate the Genome](#navigate-the-genome)
  + [2.0.2 Epiviz Navigation Element](#epiviz-navigation-element)
  + [2.0.3 Remove Charts](#remove-charts)
  + [2.0.4 Create Charts with Settings and Colors](#create-charts-with-settings-and-colors)
* [3 Using Interactive Mode](#using-interactive-mode)
  + [3.1 Visualizing data from `data.frame`](#visualizing-data-from-data.frame)

The `epivizrChart` package is used to add interactive charts and dashboards for genomic data visualization into RMarkdown and HTML documents using the [epiviz](http://epiviz.org) framework. It provides an API to interactively create and manage web components that encapsulate epiviz charts. Charts can be embedded in R markdown/notebooks to create interactive documents. Epiviz Web components are built using the Google [Polymer](https://www.polymer-project.org/) library. This vignette demonstrates how to use these visualization components in RMarkdown documents.

Sample data sets we will be using for the vignette.

```
data(tcga_colon_blocks)
data(tcga_colon_curves)
data(tcga_colon_expression)
data(apColonData)
```

# 1 What are Epiviz Web Components ?

We currently have three different web components built for genomic data exploration and visualization.

### 1.0.1 Epiviz Charts

Epiviz charts are used to visualize genomic data objects in R/BioConductor. The data objects can be BioConductor data types for ex: Genomic Ranges, ExpressionSet, SummarizedExperiment etc.

For example, to visualize hg19 reference genome as a genes track at a particular genomic location (`chr`, `start`, `end`)

```
library(Homo.sapiens)

genes_track <- epivizChart(Homo.sapiens, chr="chr11", start=118000000, end=121000000)
```

```
## creating gene annotation (it may take a bit)
```

```
##   24 genes were dropped because they have exons located on both strands of the
##   same reference sequence or on more than one reference sequence, so cannot be
##   represented by a single genomic range.
##   Use 'single.strand.genes.only=FALSE' to get all the genes in a GRangesList
##   object, or use suppressMessages() to suppress this message.
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
genes_track
```

`epivizChart` infers the chart type from the data object that was passed. Instead of inferring a chart type from the data object, we can use the `chart` parameter to specify a chart type. Currently, we support the following chart types - `BlocksTrack`, `HeatmapPlot`, `LinePlot`, `LineTrack`, `ScatterPlot`, `StackedLinePlot`, `StackedLineTrack`.

```
scatter_plot <- epivizChart(tcga_colon_curves, chr="chr11", start=99800000, end=103383180, type="bp", columns=c("cancerMean","normalMean"), chart="ScatterPlot")
scatter_plot
```

### 1.0.2 Epiviz Environment

An important part of the `epivizrChart` design is that data and plots are separated: you can make multiple charts from the same data object without having to replicate data multiple times. This way, data queries are made by data object, not per chart, which leads to a more responsive design of the system. To enable this, we built the `epiviz-environment` web component. The environment element also enables brushing across all the charts.

To create an environment,

```
epivizEnv <- epivizEnv(chr="chr11", start=118000000, end=121000000)

genes_track <- epivizEnv$plot(Homo.sapiens)
```

```
## creating gene annotation (it may take a bit)
```

```
##   24 genes were dropped because they have exons located on both strands of the
##   same reference sequence or on more than one reference sequence, so cannot be
##   represented by a single genomic range.
##   Use 'single.strand.genes.only=FALSE' to get all the genes in a GRangesList
##   object, or use suppressMessages() to suppress this message.
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
blocks_track <- epivizEnv$plot(tcga_colon_blocks, datasource_name="450kMeth")

epivizEnv
```

### 1.0.3 Epiviz Navigation

`epiviz-navigation` is an instance of environment with genomic context linked to it. In interactive sessions with a data provider, navigation elements provide functionality to search for a gene/probe and navigate to a genomic location. Navigation elements also provide an ideogram view when collapsed.

To create a navigation,

```
epivizNav <- epivizNav(chr="chr11", start=118000000, end=121000000)

genes_track <- epivizNav$plot(Homo.sapiens)
```

```
## creating gene annotation (it may take a bit)
```

```
##   24 genes were dropped because they have exons located on both strands of the
##   same reference sequence or on more than one reference sequence, so cannot be
##   represented by a single genomic range.
##   Use 'single.strand.genes.only=FALSE' to get all the genes in a GRangesList
##   object, or use suppressMessages() to suppress this message.
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
blocks_track <- epivizNav$plot(tcga_colon_blocks, datasource_name="450kMeth")

epivizNav
```

Note: you can create environments without any genomic location. This will then plot all the data from a data object. Navigation elements must be initialized with a genomic location.

# 2 `epivizrChart` examples

We’ll walk through a few examples of visualizing different bioconductor data types with epivizrChart and enable interactive data exploration.

First, lets create an epiviz enivornment element

```
epivizEnv <- epivizEnv(chr="chr11", start=99800000, end=103383180)
```

Add a genome track to the environment. You can add charts to an environment by using the environment’s `plot` method. For this vignette, we use the human genome from the `Homo.sapiens` package.

```
require(Homo.sapiens)

genes_track <- epivizEnv$plot(Homo.sapiens)
genes_track
```

Add a blocks track using the `tcga_colon_blocks` object.

```
blocks_track <- epivizEnv$plot(tcga_colon_blocks, datasource_name="450kMeth")
blocks_track
```

You can now render the `epivizEnv` object and see that both the charts are linked to each other. Brushing is now enabled across charts.

```
epivizEnv
```

Similarly let’s add a line track using the `tcga_colon_curves` data object. We can specify what columns to visualize from the data object.

```
means_track <- epivizEnv$plot(tcga_colon_curves, datasource_name="450kMeth", type="bp", columns=c("cancerMean","normalMean"))
means_track
```

The `apColonData` object is an `ExpressionSet` containing gene expression data for colon normal and tumor samples for genes within regions of methylation loss identified [this paper](http://www.nature.com/ng/journal/v43/n8/full/ng.865.html).

To visualize an MA plot from the `apColonData`, we first create an `ExpressionSet` object and create an `EpivizChart` object.

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

eset_chart <- epivizEnv$plot(maEset, datasource_name="MAPlot", columns=c("colonA","colonM"))
eset_chart
```

We can also visualize data from `SummarizedExperiment` objects.

```
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
```

If a data set is already added to an `EpivizEnvironment`, we can reuse the same data object and visualize the data using a different chart type. This avoids creating multiple copies of data. For example, lets visualize the `sumexp` using a `HeatmapPlot`. measurements from different data objects can also be used to create a chart.

```
# get measurements
measurements <- se_chart$get_measurements()

# create a heatmap using these measurements
heatmap_plot <- epivizEnv$plot(measurements=measurements, chart="HeatmapPlot")
heatmap_plot
```

If we want to change the ordering of the charts within the `EpivizEnvironment`, we can use `order_charts`. Let’s reorder the environment and move the `HeatmapPlot` to the top.

```
order <- list(
  heatmap_plot,
  genes_track,
  blocks_track,
  means_track,
  se_chart,
  eset_chart
)

epivizEnv$order_charts(order)
```

Render the Environment and all its charts.

```
epivizEnv
```

### 2.0.1 Navigate the Genome

We can navigate to another location on the genome using the `navigate` method. This will update the data for all the charts in the environment.

```
epivizEnv$navigate(chr="chr11", start=110800000, end=130383180)
epivizEnv
```

### 2.0.2 Epiviz Navigation Element

Epiviz Navigation elements are useful to visualize data from a particular genomic region. For example, we can create an environment that shows data for an entire chromosome. But a navigation element can then show data for a genomic region. In an interactive session, Navigation elements also provide functionality to search by gene/probe and navigate along the genome(move left/right).

```
# create an environment to show data from entire chromosome 11
epivizEnv <- epivizEnv(chr="chr11")

# add a line track from tcga_colon_curves object to the environment
means_track <- epivizEnv$plot(tcga_colon_curves, datasource_name="450kMeth", type="bp", columns=c("cancerMean","normalMean"))

# add a scatter plot from the summarized experiment object to the environment
se_chart <- epivizEnv$plot(sumexp, datasource_name="Mean by Sample Type", columns=c("normal", "cancer"))

# create a new navigation element that shows a particular region in chr11
epivizNav <- epivizNav(chr="chr11", start=99800000, end=103383180, parent=epivizEnv)

# add a blocks track to the navigation element
blocks_track <- epivizNav$plot(tcga_colon_blocks, datasource_name="450kMeth")

epivizEnv
```

If we’d like a navigation element to include all of the current environment’s charts at a particular genomic region, we can use the environment’s `init_region`.

```
epivizEnv <- epivizEnv(chr="chr11")

# add a blocks track to the evironment
blocks_track <- epivizEnv$plot(tcga_colon_blocks, datasource_name="450kMeth")
# add a scatter plot from the summarized experiment object to the environment
se_chart <- epivizEnv$plot(sumexp, datasource_name="Mean by Sample Type", columns=c("normal", "cancer"))

epivizNav <- epivizEnv$init_region(chr="chr11", start=99800000, end=103383180)

epivizEnv
```

### 2.0.3 Remove Charts

To remove all the charts from an environment or navigation element, we can use the `remove_all_charts` methods.

```
epivizEnv$remove_all_charts()
```

### 2.0.4 Create Charts with Settings and Colors

```
colors <- brewer.pal(3, "Dark2")

blocks_track <- epivizChart(tcga_colon_blocks, chr="chr11", start=99800000, end=103383180, colors=colors)

# to list availble settings for a chart
blocks_track$get_available_settings()

settings <- list(
  title="Blocks",
  minBlockDistance=10
  )

blocks_track$set_settings(settings)
blocks_track

blocks_track$set_colors(c("#D95F02"))
blocks_track

colors <- brewer.pal(3, "Dark2")
lines_track <- epivizChart(tcga_colon_curves, chr="chr11", start=99800000, end=103383180, type="bp", columns=c("cancerMean","normalMean"))
lines_track

lines_track$set_colors(colors)
lines_track
```

# 3 Using Interactive Mode

The interactive mode takes advantage of the websocket protocol to create an active connection between the R-session and the epiviz components visualized in the browser. In interactive mdoe, data is not embedded along with the components, So the charts make data requests to the R-session to get data.

To use charts in `interactive` mode, first we create an epiviz environment with interactive mode enabled.

```
library(epivizrChart)

# initialize environment with interactive = true. this argument will init. an epiviz-data-source element
epivizEnv <- epivizEnv(chr="chr11", start=118000000, end=121000000, interactive=TRUE)
```

We then create an instance of an `epivizrServer` to manage websocket connections. The register\_all\_the\_epiviz\_things adds listeners and handlers to manage data requests.

```
library(epivizrServer)

library(Homo.sapiens)
data(tcga_colon_blocks)

# initialize server
server <- epivizrServer::createServer()

# register all our actions between websocket and components
epivizrChart:::.register_all_the_epiviz_things(server, epivizEnv)

# start server
server$start_server()
```

We now have an epiviz environment and an active websocket connection to the R-session. Adding and managing charts is exactly the same as described in this vignette.

```
# plot charts
blocks_track <- epivizEnv$plot(tcga_colon_blocks, datasource_name="450kMeth")
epivizEnv

genes <- epivizEnv$plot(Homo.sapiens)
epivizEnv
```

Finally close the server

```
server$stop_server()
```

## 3.1 Visualizing data from `data.frame`

We can visualize genomic data stored in `data.frame` use epivizrChart. If the `data.frame` does not contain genomic location columns like `chr`, `start` or `end`, linking between charts is by row\_number.

For this example, we will use rna-seq data from `AnnotationHub`.

```
ah <- AnnotationHub()
epi <- query(ah, c("roadmap"))
df <- epi[["AH49015"]]
```

```
## loading from cache
```

now we’ll create a scatter plot to visualize samples “E006” & “E114” from the `data.frame`

```
rna_plot <- epivizChart(df, datasource_name="RNASeq", columns=c("E006","E114"), chart="ScatterPlot")
rna_plot
```