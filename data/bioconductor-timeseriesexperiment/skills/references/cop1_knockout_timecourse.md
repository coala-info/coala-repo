# Cop1 role in pro-inflammatory response

#### *Lan Huong Nguyen*

ICME, Stanford University, CA 94305

#### *2019-01-15*

# Abstract

The analysis of time-series data is non-trivial as in involves dependencies between datapoints. Our package helps researchers analyze RNA-seq datasets which include gene expression measurements taken over time. The methods are specifically designed for at datasets with a small number of replicates and time points – a typical case for RNA-seq time course studies. Short time courses are more difficult to analyze, as many statistical methods designed for time-series data might require a minimum number of time points, e.g. functional data analysis (FDA) and goodness of fit methods might be ineffective. Our approach is non-parametric and gives the user a flexibility to incorporate different normalization techniques, and distance metrics. `TimeSeriesExperiment` is a comprehensive time course analysis toolbox with methods for data visualization, clustering and differential expression analysis. Additionally, the package can perform enrichment analysis for DE genes.

# Introduction

We will demonstrate the effectiveness of `TimeSeriesExperiment` package using the in-house dataset exploring the role of Cop1 in pro-inflammatory response. The experiments were designed to study the induction and repression kinetics of genes in bone marrow derived macrophages (BMDMs).

The dataset includes cells from 6 mice. The cells were divided into two equal groups. For one group the Cop1 gene was in vitro knock out with tamoxifen. All samples where then subject to LPS treatment to induce an inflammatory response. Bulk RNA-seq was performed at 6 time-points: one at time 0 before LPS treatment, then at time 2.5, 4, 6, 9 and 13 hours after LPS was added.

# Obtain and process data

First we load the necessary packages.

```
.packages <- c(
"edgeR", "viridis", "Biobase", "SummarizedExperiment",
"ggplot2", "dplyr", "tidyr", "tibble", "readr",
"TimeSeriesExperiment")
sapply(.packages, require, character.only = TRUE)
```

```
##                edgeR              viridis              Biobase SummarizedExperiment              ggplot2                dplyr                tidyr               tibble                readr
##                 TRUE                 TRUE                 TRUE                 TRUE                 TRUE                 TRUE                 TRUE                 TRUE                 TRUE
## TimeSeriesExperiment
##                 TRUE
```

```
theme_set(theme_bw())
theme_update(
text = element_text(size = 15),
strip.background = element_rect(fill = "grey70"),
strip.text = element_text(size = 10))
```

The dataset we will study is available from GEO repositories under accession number: `GSE114762`. We can import the processed read counts saved in a supplementary file ‘GSE114762\_raw\_counts.csv.gz’. Similarly both the phenotype and feature data are also available for download as ‘GSE114762\_sample\_info.csv.gz’, and ‘GSE114762\_gene\_data.csv.gz’ files respectively.

```
# Remote location of the data
urls <- paste0(
"https://www.ncbi.nlm.nih.gov/geo/download/",
"?acc=GSE114762&format=file&file=",
c(
"GSE114762_raw_counts.csv.gz",
"GSE114762_gene_data.csv.gz",
"GSE114762_sample_info.csv.gz"
)
)
```

We will save the files to cache using `BiocFileCache` utilities to avoid unnecessary multiple downloading.

```
library(BiocFileCache)
bfc <- BiocFileCache(ask = FALSE)

cnts <- read_csv(bfcrpath(rnames = urls[1])) %>%
column_to_rownames("X1") %>%
as.matrix()

gene.data <- read_csv(bfcrpath(rnames = urls[2])) %>%
as.data.frame() %>%
column_to_rownames("X1")

pheno.data <- read_csv(bfcrpath(rnames = urls[3])) %>%
as.data.frame() %>%
column_to_rownames("X1")
```

# Building `TimeSeriesExperiment` object

We can now combine all the data, `cnts`, `gene.data` and `pheno.data`, into a single `TimeSeriesExperiment` (S4) object. The data will store everything together in a way that is easier to perform further time course data analysis. The most important fields in the object are “assays”, “colData” which will contain information on group, replicate and time associated with each sample. In `TimeSeriesExperiment` the time variable MUST be numeric.

```
cop1.te <- TimeSeriesExperiment(
assays = list(cnts),
rowData = gene.data,
colData = pheno.data,
timepoint = "time",
replicate = "replicate",
group = "group"
)
cop1.te
```

```
## class: TimeSeriesExperiment
## dim: 36528 36
## metadata(0):
## assays(1): raw
## rownames(36528): 100009600 100009609 ... 99929 99982
## rowData names(5): feature symbol size type desc
## colnames(36): SAM24331086 SAM24331087 ... SAM24331084 SAM24331085
## colData names(9): sample group ... timepoint category
## ==========
## timepoints(36): 0 2.5 ... 9 13
## groups(36): Loxp Loxp ... WT WT
## replicates(36): Loxp_1 Loxp_1 ... WT_3 WT_3
## -----
## assayCollapsed: NULL
## colDataCollapsed: NULL
## timeSeries: NULL
## dimensionReduction: NULL
## clusterRows: NULL
## differentialExpression: NULL
```

Alternatively, we can build `TimeSeriesExperiment` object from a `ExpressionSet` or `SummarizedExperiment` objects.

To show how this is done, we first combine the three data tables into an `ExpressionSet` objects.

```
cop1.es <- ExpressionSet(
as.matrix(cnts),
phenoData = AnnotatedDataFrame(pheno.data),
featureData = AnnotatedDataFrame(gene.data))
```

Then, we can easily convert an `ExpressionSet` to a `TimeSeriesExperiment` object using `makeTimeSeriesExperimentFromExpressionSet()` function, and indicating columns names with relevant information.

```
(cop1.te <- makeTimeSeriesExperimentFromExpressionSet(
cop1.es, timepoint = "time", group = "group",
replicate = "individual"))
```

```
## class: TimeSeriesExperiment
## dim: 36528 36
## metadata(0):
## assays(1): raw
## rownames(36528): 100009600 100009609 ... 99929 99982
## rowData names(5): feature symbol size type desc
## colnames(36): SAM24331086 SAM24331087 ... SAM24331084 SAM24331085
## colData names(9): sample group ... timepoint category
## ==========
## timepoints(36): 0 2.5 ... 9 13
## groups(36): Loxp Loxp ... WT WT
## replicates(36): 1 1 ... 3 3
## -----
## assayCollapsed: NULL
## colDataCollapsed: NULL
## timeSeries: NULL
## dimensionReduction: NULL
## clusterRows: NULL
## differentialExpression: NULL
```

Repeating the same for `SummarizedExperiment`:

```
cop1.se <- SummarizedExperiment(
assays = list(counts = cnts),
rowData = gene.data, colData = pheno.data)

(cop1.te <- makeTimeSeriesExperimentFromSummarizedExperiment(
cop1.se, time = "time", group = "group",
replicate = "individual"))
```

```
## class: TimeSeriesExperiment
## dim: 36528 36
## metadata(0):
## assays(1): raw
## rownames(36528): 100009600 100009609 ... 99929 99982
## rowData names(5): feature symbol size type desc
## colnames(36): SAM24331086 SAM24331087 ... SAM24331084 SAM24331085
## colData names(9): sample group ... timepoint category
## ==========
## timepoints(36): 0 2.5 ... 9 13
## groups(36): Loxp Loxp ... WT WT
## replicates(36): 1 1 ... 3 3
## -----
## assayCollapsed: NULL
## colDataCollapsed: NULL
## timeSeries: NULL
## dimensionReduction: NULL
## clusterRows: NULL
## differentialExpression: NULL
```

```
# Remove raw data
rm(cnts, gene.data, pheno.data, cop1.se, cop1.es)
```

## Data normalization and filtering

The raw read counts cannot be immediately used for analysis, as sequencing data involves the issue of varying sample depths. We can convert the raw counts to counts per million (CPM) using `TimeSeriesExperiment` function, `normalizeData()`, which performs data normalization by column. Currently, we only support scaling sample counts by constant factors (size factors). If the argument `column.scale.factor` is not specified, by default `TimeSeriesExperiment` divides by column sums and multiplies by 1 million to obtain CPMs. The normalized data is stored separately from the raw data in a slot “data”.

```
# Compute CPMs
cop1.te <- normalizeData(cop1.te)
```

```
## Normalizing data...
```

Since the dataset contains more than 36k genes, we will filter out the very rare ones which we assume to be too noisy and not containing enough signal for further analysis.

Here, we find and remove all genes which have the mean expression (CPM) below `min_mean_cpm = 50` within either of the two groups of interest, *wild type* or *knock-out*. We set a very large threshold of 100 for this vignette only because the graphics below would make the size of this vignette too large. When running on the your own study you should pick the threshold more carefully.

```
# Fine genes with minimum mean count of 5 at least in one of the two groups
min_mean_cpm <- 5
group_cpm_means <- data.frame(row.names = rownames(cop1.te))
norm.cnts <- assays(cop1.te)$norm
for(g in unique(groups(cop1.te))) {
g_cnts <- norm.cnts[ , which(groups(cop1.te) == g)]
group_cpm_means[, g] <- apply(g_cnts, 1, mean)
}
group_cpm_max <- apply(as.vector(group_cpm_means), 1, max)
genes_expressed <- rownames(cop1.te)[group_cpm_max > min_mean_cpm]
```

```
# Filter out the noisy genes
cop1.te <- filterFeatures(cop1.te, genes_expressed)
cop1.te
```

```
## class: TimeSeriesExperiment
## dim: 9356 36
## metadata(0):
## assays(2): raw norm
## rownames(9356): 100017 100019 ... 99929 99982
## rowData names(5): feature symbol size type desc
## colnames(36): SAM24331086 SAM24331087 ... SAM24331084 SAM24331085
## colData names(9): sample group ... timepoint category
## ==========
## timepoints(36): 0 2.5 ... 9 13
## groups(36): Loxp Loxp ... WT WT
## replicates(36): 1 1 ... 3 3
## -----
## assayCollapsed: NULL
## colDataCollapsed: NULL
## timeSeries: NULL
## dimensionReduction: NULL
## clusterRows: NULL
## differentialExpression: NULL
```

## Collapse replicates

In parts of our later analysis, we will make comparisons between genes, and therefore it is useful to aggregate gene expression across replicates to obtain their mean behavior. To do this we can use `collapseReplicates()` function for `TimeSeriesExperiment`. The function saves collapsed sample and aggregated expression data in “sample.data.collapsed”, and “data.collapsed” respectively.

```
# Collapsed sample data stored in cop1.te@sample.data.collapsed,
# and mean expression values in cop1.te@data.collapsed
cop1.te <- collapseReplicates(cop1.te, FUN = mean)
```

```
## Aggregating across replicates...
```

# Time course format

The main focus on `TimeSeriesExperiment` is to analyze and visualize time-series data efficiently. For this reason, we convert the expression data in a form of a rectangular matrix into a “time-course format” where each row stores a single time series corresponding to a specified combination of group membership and and replicate id (here mouse id). This data wrangling step can be performed with `makeTimeSeries()` function, the “time-course” will be stored in a slot `timeSeries`. This slot contains a list containing data.frames `tc` and `tc_collapsed` (if `assayCollapsed` is defined).

Before converting data to “time-course” format, gene transformation should be performed. Transformation is thus allows for a fair gene-to-gene comparison. For example, when clustering genes, one uses pairwise distances to estimate dissimilarities between genes. Since, we are generally more interested in grouping genes based on similarities in their trajectories rather than their absolute expression levels, the read counts must be transformed before computing the distances.

Currently, gene transformation methods available in `TimeSeriesExperiment` are “scale\_feat\_sum” (scaling by gene sum) or “var\_stab” (variance stabilization). The user can specify a variance stabilization method if “var\_stab” is used. VST methods supported are: “log1p” (log plus one), “asinh” (inverse hyperbolic sine) or “deseq” (`DESeq2::varianceStabilizingTransformation`).

Usually simply scaling by the gene sum, that is normalizing so that the total abundance the same (and equal to 1) for all genes gives good clustering of gene trajectories.

```
# Before conversion, scales gene expression to an even sum, for a fair
# gene-to-gene comparison.
cop1.te <- makeTimeSeries(
cop1.te, feature.trans.method = "scale_feat_sum")
```

```
## Converting to timeseries format...
```

```
# untransfomed
head(timeSeries(cop1.te, "ts"))
```

| feature | group | replicate | 0 | 2.5 | 4 | 6 | 9 | 13 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 100017 | Loxp | 1 | 181.2367 | 30.48920 | 13.41001 | 19.58618 | 48.43795 | 157.1302 |
| 100017 | Loxp | 2 | 188.6391 | 30.57038 | 14.31970 | 29.69035 | 83.93528 | 168.5095 |
| 100017 | Loxp | 3 | 193.7659 | 27.61548 | 12.98989 | 23.28758 | 51.96757 | 155.0601 |
| 100017 | WT | 1 | 186.9893 | 27.54414 | 13.56621 | 22.96282 | 52.04936 | 148.6426 |
| 100017 | WT | 2 | 220.9431 | 32.70219 | 11.50873 | 20.85574 | 45.29843 | 161.3555 |
| 100017 | WT | 3 | 200.6372 | 23.68253 | 12.28389 | 23.77404 | 51.05345 | 152.3733 |

```
# transfomed
head(timeSeries(cop1.te, "ts_trans"))
```

| feature | group | replicate | 0 | 2.5 | 4 | 6 | 9 | 13 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 100017 | Loxp | 1 | 0.0638413 | 0.0107399 | 0.0047237 | 0.0068993 | 0.0170624 | 0.0553497 |
| 100017 | Loxp | 2 | 0.0664488 | 0.0107685 | 0.0050442 | 0.0104585 | 0.0295665 | 0.0593581 |
| 100017 | Loxp | 3 | 0.0682547 | 0.0097277 | 0.0045757 | 0.0082031 | 0.0183058 | 0.0546205 |
| 100017 | WT | 1 | 0.0658677 | 0.0097025 | 0.0047787 | 0.0080887 | 0.0183346 | 0.0523599 |
| 100017 | WT | 2 | 0.0778280 | 0.0115195 | 0.0040540 | 0.0073465 | 0.0159565 | 0.0568380 |
| 100017 | WT | 3 | 0.0706752 | 0.0083423 | 0.0043270 | 0.0083745 | 0.0179838 | 0.0536741 |

## Lag differences

Time-series data have a dependency structure and are not standard multivariate vectors. Many methods have been developed for representing time-series data. A common technique is for example to fit functions e.g. polynomials or splines to the data. A similar approach is taken in functional data analysis (FDA) literature, where time series are represented as linear combinations of basis functions (e.g. principal functions). These methods seek to smooth the data and to reduce of complexity of the inherent (infinite dimensional) functional data. The fitted coefficients are often used as the time-series representation then used for clustering or visualization.

Unfortunately, most of the biological time course studies are short, sometimes containing as few as three or four time-points. Therefore, fitting functions to sparse time points would be inefficient. Instead, here we propose a simpler way to incorporate the dependency structure of the time-series. Our method involves construction of additional data features, which are lag differences between consecutive time-points. Lag of order 1 for time-point \(i\), \(Lag\_1(i)\), denotes the difference between the expression level at time \(i\) and time \(i-1\), lag 2 is the difference between time \(i\) and time \(i-2\), and so on. Intuitively, the lag 1 at time \(i\) approximates the slope or the first derivative of the time series curve at time-point \(i\).

We can add these extra lag features to the “time-course” data using `addLags()` function, which appends lag features to “tc” and “tc\_collapsed” data frames in the slot `timeSeries`. Additionally,the user can define the weight for each lag feature by specifying the `lambda` argument. The length of `lambda` indicates how many orders of lags you would like to include, e.g. `lambda = c(0.5, 0.25)` means lag order 1 will be added with multiplicative weight of \(0.5\) and lag order 2 will be added with weight \(0.025\).

```
# Add lags to time-course data
cop1.te <- addLags(cop1.te, lambda = c(0.5, 0.25))
```

```
## Adding lags with coefficients: 0.5 0.25...
```

```
head(timeSeries(cop1.te, "ts_trans"))
```

| feature | group | replicate | 0 | 2.5 | 4 | 6 | 9 | 13 | Lag\_2.5\_0 | Lag\_4\_2.5 | Lag\_6\_4 | Lag\_9\_6 | Lag\_13\_9 | Lag\_4\_0 | Lag\_6\_2.5 | Lag\_9\_4 | Lag\_13\_6 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 100017 | Loxp | 1 | 0.0638413 | 0.0107399 | 0.0047237 | 0.0068993 | 0.0170624 | 0.0553497 | -0.0265507 | -0.0030081 | 0.0010878 | 0.0050816 | 0.0191436 | -0.0147794 | -0.0009602 | 0.0030847 | 0.0121126 |
| 100017 | Loxp | 2 | 0.0664488 | 0.0107685 | 0.0050442 | 0.0104585 | 0.0295665 | 0.0593581 | -0.0278401 | -0.0028622 | 0.0027072 | 0.0095540 | 0.0148958 | -0.0153512 | -0.0000775 | 0.0061306 | 0.0122249 |
| 100017 | Loxp | 3 | 0.0682547 | 0.0097277 | 0.0045757 | 0.0082031 | 0.0183058 | 0.0546205 | -0.0292635 | -0.0025760 | 0.0018137 | 0.0050513 | 0.0181574 | -0.0159198 | -0.0003811 | 0.0034325 | 0.0116043 |
| 100017 | WT | 1 | 0.0658677 | 0.0097025 | 0.0047787 | 0.0080887 | 0.0183346 | 0.0523599 | -0.0280826 | -0.0024619 | 0.0016550 | 0.0051229 | 0.0170127 | -0.0152722 | -0.0004034 | 0.0033890 | 0.0110678 |
| 100017 | WT | 2 | 0.0778280 | 0.0115195 | 0.0040540 | 0.0073465 | 0.0159565 | 0.0568380 | -0.0331543 | -0.0037327 | 0.0016463 | 0.0043050 | 0.0204408 | -0.0184435 | -0.0010432 | 0.0029756 | 0.0123729 |
| 100017 | WT | 3 | 0.0706752 | 0.0083423 | 0.0043270 | 0.0083745 | 0.0179838 | 0.0536741 | -0.0311665 | -0.0020076 | 0.0020237 | 0.0048046 | 0.0178452 | -0.0165870 | 0.0000081 | 0.0034142 | 0.0113249 |

At this point, we completed all data pre-processing steps available in `TimeSeriesExperiment`. In later sections we specify how visualization, clustering and differential expression test can be performed with the package.

# Data Visualization

In this section we show plotting utilities available in `TimeSeriesExperiment`. Visualizations are data exploration tools and serve as the first step in our data analysis. In the following subsections we will describe more in details how heatmaps and PCA plots can be generated.

## Heatmaps

Here we will generate a heatmap of top 100 most variable genes. The plot of the expression matrix for these most variable features will give us some insight whether there is a clear difference between the two experimental groups and whether a strong temporal trend can be detected.

```
plotHeatmap(cop1.te, num.feat = 100)
```

![](data:image/png;base64...)

In the above heatmap the columns are ordered by experimental group, replicate (mouse id) and time at which the sample was sequenced; the sample membership is indicated in the color bars on top of the columns. The main heatmap rectangle shows Z-scores of expression values represented by colors in the red-and-blue palette corresponding to high-and-low respectively. Even this first look at the data, shows us patterns present in the data – within each condition, i.e. each mouse and in each experimental group there are expression levels seem to be dependent on time.

# PCA

Another way to explore the dataset is through dimensionality reduction. Here we will project the data into a space of principal components. With PCA, you can visualize both samples and features in the same coordinates space with a biplot. Here we will keep these two maps separately, as the visualization can become overcrowded with points which obscure the inherent structure. Even though, we are plotting the feature and sample projections separately, they can be compared side by side to see which groups of features are more correlated with which group of samples.

## Visualizing Samples

First, we project samples on a 2D map to check whether their relative location reflects time at which the sequencing was performed. If the samples are ordered in agreement with time in the PCA plot, there might be patterns in gene expression levels changing over the course of the study.

A PCA plot can also be used to examine whether samples corresponding to the same condition, here wild type or knockouts, tend to group together, i.e. whether they are more similar to each other than to the ones in a different condition. We use `prcomp()` function from `stats` (default) package to compute PCA projection.

RNA-seq data is highly heteroscedastic, which means the features (genes) included have vastly different variances. It is know that bulk expression count data can be well modeled with a negative binomial distribution. In this distribution, variance is a quadratic function of the mean, \(\sigma^2 = \mu + \alpha\mu^2\). That is the higher the mean expression level, the higher the variance is. PCA projection maximizes the amount variance preserved in consecutive principal components, which implies that computing PCA on raw expression counts or even the RPKMs or CPMs would put too much weight on most highly abundant genes.

This step is recommended because RNA-seq data is highly heteroscedastic, which means the features (genes) included have vastly different variances. It is know that bulk expression count data can be well modeled with a negative binomial distribution. In this distribution, variance is a quadratic function of the mean, \(\sigma^2 = \mu + \alpha\mu^2\). That is the higher the mean expression level, the higher the variance is.

Thus, we recommend user to variance stabilize the data before computing a PCA projection (as described in *Time course format* section). The variance stabilization method can be specified in `var.stabilize.method` argument.

Additionally, the user might limit calculations to only specific group of samples, e.g. in this case you might be interested in visualizing samples only in the wild type group. A user can also indicate whether PCA should be applied to sample resolved data or one with replicates aggregated (stored in “data.collapsed” slot of a `TimeSeriesExperiment` object).

```
cop1.te <- runPCA(cop1.te, var.stabilize.method = "asinh")
```

```
plotSamplePCA(cop1.te, col.var = "group", size = 5)
```

![](data:image/png;base64...)

```
plotSamplePCA(cop1.te, col.var = "timepoint", size = 5)
```

![](data:image/png;base64...)

In the plots above we see that the samples group mostly by time at which they have been sequenced. For some time-points, we see also a clear separation between sample from different experimental groups.

## Visualizing Features

PCA also provides a projection of features to the same principal component space. The coordinates of features (here genes) are commonly referred to as PCA loadings. Since gene expression datasets usually includes thousands of genes, it is not possible to include labels for all of them in the same 2D PCA plot. Apart from that, in a time-course study one is usually interested in trajectories of genes over time, and it is good to see groups of genes with similar expression pattern clustered together on a visualization.

In order to make PCA plots for features more informative, we overlay average (over replicates) gene expression trend over time for each experimental group. Plotting trajectories for every gene would make plot overcrowded and unreadable, therefore we divide the PCA plot into \(m \times n\) grid and plot a trajectory for a gene which PCA coordinates are closes to the grid center point.

In the feature PCA plot below we see that genes exhibit different responses to LPS treatment. The figure shows genes organized according to their trajectory. Inhibited genes tend to gather on the left side of the plot, the primary response (early spike) genes are at the bottom, and the late response (late increase) clustered at the top. The plot doesn’t show a global difference between the wild type and knock-out group. Most genes have trajectories that are exactly overlapping in both conditions. There are, however, a few genes for which we do observe some difference between groups.

```
plotTimeSeriesPCA(
cop1.te,
linecol = c("WT" = "#e31a1c", "Loxp" = "#1f78b4"),
main = paste("Visualizing gene profiles with PCA"),
m  = 15, n = 15, col = adjustcolor("grey77", alpha=0.7),
cex.main = 3, cex.axis = 2, cex.lab = 2)
```

![](data:image/png;base64...)

# Gene Clustering

To cluster the gene trajectories we will use the data stored in `timeSeries` slot of `cop1.te`. These are time-series of transformed expression values together with appended time lags which resolving differences between the temporal trends.

We use hierarchical clustering define gene groupings. Either static or dynamic branch cutting (from `dynamicTreeCut` package) algorithms can be used to assign clusters. Since hierarchical clustering is computationally intensive (with \(O(n^3)\) complexity for standard implementations), we apply it only to a subset of genes. Specifically, we pick `n.top.feat` with average (over replicates) most variable expression over time in each of selected `groups` (here we use both wild type and knock-out) to perform clustering. Remaining genes are, then, assigned to a cluster with the closest centroid. An additional advantage of using only a subset of most variable genes for clustering is that, the core genes which exhibit negligible changes over time (which might be the majority of genes) will not much effect on clustering results.

Here we pick 1000 genes for clustering, which is roughly 1/3 of the number of genes after filtering.

```
params_for_clustering <- list(
dynamic = TRUE,
dynamic_cut_params = list(deepSplit = TRUE, minModuleSize = 150))

cop1.te <- clusterTimeSeries(
cop1.te, n.top.feat = 3000, groups = "all",
clust.params = params_for_clustering)
```

```
## Averaging timecourses over all 'groups' selected and recomputing lags with coefficients: 0.5 0.25
```

We can see the size of each of clusters computed

```
# See the count of genes in each cluster
cluster_map <- clusterMap(cop1.te)
table(cluster_map$cluster)
```

```
##
##   C1   C2   C3   C4   C5   C6
## 2873 2418 2201  979  478  407
```

We can plot the hclust dendrogram obtained from hierarchical clustering performed.

```
# Plot the hierarchical clustering of genes2cluster
hclust_obj <- clusterAssignment(cop1.te, "hclust")
plot(x = hclust_obj, labels = FALSE, xlab = "genes", sub = "")
```

![](data:image/png;base64...)

Here we plot average (over replicates) gene trajectories grouped into 10 clusters found using the above described approach. The expression profiles for wild type and knock-out are plotted separately, side by side.

```
plotTimeSeriesClusters(cop1.te, transparency = 0.2) +
scale_color_manual(values = c("WT" = "#1f78b4", "Loxp" = "#e31a1c")) +
theme(strip.text = element_text(size = 10)) +
ylim(NA, 0.55)
```

![](data:image/png;base64...)

Timecourse plots above show genes clustered clearly into groups related to their pattern of response to LPS treatment. We see cluster C1, C2, and C4 generally inhibited. Genes in C6 spike right after LPS was applied. C3 shows moderate secondary response, and C5 exhibit late increase in expression.

# Differential Expression Ranking

In the previous section we grouped the genes based on the trajectories recorded for both experimental groups. In this section we will describe how to find specific genes that exhibit different expression patterns between two experimental groups over the time-course of the study.

## Differential Point-wise Expression

In some cases, a user might be interested in differential expression (DE) at specific timepoints between different experimental groups, here wild type and knock-out. We can easily test differential expression at any timepoint over the course of the study using standard DE approaches.

`TimeSeriesExperiment` provides a wrapper `timepointDE()` for differential expression testing functions (`voom()` + `limma()`) from `limma` package, which allows users to easily apply testing to `TimeSeriesExperiment` objects.

```
cop1.te <- timepointDE(cop1.te, timepoints = "all", alpha = 0.05)
```

```
## testing timepoint: 0
```

```
## testing timepoint: 2.5
```

```
## testing timepoint: 4
```

```
## testing timepoint: 6
```

```
## testing timepoint: 9
```

```
## testing timepoint: 13
```

Information on DE genes e.g. at timepoint 2.5 can be access as follows:

```
tmp_de <- differentialExpression(cop1.te, "timepoint_de")
# First 6 DE genes at timepoint = 2.5:
head(tmp_de$`2.5`)
```

|  | feature | symbol | size | type | desc | cluster | used\_for\_hclust | logFC | AveExpr | t | P.Value | adj.P.Val | B |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 12816 | 12816 | Col12a1 | 14801 | protein\_coding | collagen, type XII, alpha 1 | C1 | TRUE | 1.6133178 | 3.766775 | 12.408537 | 6.0e-07 | 0.0026451 | 6.533085 |
| 26374 | 26374 | Rfwd2 | 5341 | protein\_coding | ring finger and WD repeat domain 2 | C3 | FALSE | 1.2880720 | 3.273972 | 12.518509 | 6.0e-07 | 0.0026451 | 6.473224 |
| 213002 | 213002 | Ifitm6 | 541 | protein\_coding | interferon induced transmembrane protein 6 | C6 | TRUE | -1.7168075 | 2.308143 | -11.984034 | 8.0e-07 | 0.0026451 | 5.673224 |
| 320832 | 320832 | Sirpb1a | 1786 | protein\_coding | signal-regulatory protein beta 1A | C6 | TRUE | -0.9648697 | 3.456528 | -10.529209 | 2.5e-06 | 0.0058671 | 5.279358 |
| 109648 | 109648 | Npy | 547 | protein\_coding | neuropeptide Y | C2 | FALSE | -0.8567081 | 6.071158 | -10.098207 | 3.5e-06 | 0.0066364 | 5.060502 |
| 13039 | 13039 | Ctsl | 2327 | protein\_coding | cathepsin L | C3 | FALSE | -0.6281533 | 11.877995 | -9.649871 | 5.2e-06 | 0.0066451 | 4.676455 |

To find genes with the highest log-fold change in each timepoint we can call the following commands:

```
top10_genes <- sapply(tmp_de, function(tab) {
top10 <- tab %>% arrange(-logFC) %>% .[["symbol"]] %>% .[1:10]
if(length(top10) < 10)
top10 <- c(top10, rep(NA, 10 - length(top10)))
return(top10)
}) %>%
as.data.frame()
top10_genes
```

| 0 | 2.5 | 4 | 6 | 9 | 13 |
| --- | --- | --- | --- | --- | --- |
| NA | Itga11 | Col2a1 | Col2a1 | Wisp1 | Thbs2 |
| NA | Postn | Mpo | Actg2 | Timp3 | Postn |
| NA | Col1a1 | Itga11 | Gm22 | Postn | Col1a1 |
| NA | Actg2 | Gm22 | Col1a1 | Thbs2 | Timp3 |
| NA | Timp3 | Crlf1 | Lrrc32 | Col1a1 | Col1a2 |
| NA | Wisp1 | Col1a1 | Wisp1 | Hspg2 | Rcn3 |
| NA | Cxcl5 | Wisp1 | Timp3 | Vgll3 | Col3a1 |
| NA | Crlf1 | Timp3 | Itga11 | Crlf1 | Hspg2 |
| NA | Ddr1 | Hspg2 | Hspg2 | Myl9 | Crlf1 |
| NA | Scube3 | Thbs2 | Ddr1 | Grem2 | Col5a1 |

We can also find a list of genes which were found differentially expressed at any of the timepoints

```
de_genes <- lapply(tmp_de, function(x) x$symbol)
de_any_tmp <- unique(unlist(de_genes))
cat("Out of all", nrow(cop1.te), ", there were",
length(de_any_tmp), "were found differentially expressed at any timepoint.")
```

```
## Out of all 9356 , there were 997 were found differentially expressed at any timepoint.
```

A useful diagram would show intersections of differentially expressed genes at different time-points. You should expert more intersection between consecutive time-points. You can use functions from `UpSetR` package to show the overlap between the DE genes across timepoints:

```
library(UpSetR)
upset(fromList(de_genes),
sets = rev(c("2.5", "4", "6", "9", "13")), keep.order = TRUE,
number.angles = 30, #point.size = 3.5, line.size = 1,
mainbar.y.label = "DE Gene Intersections",
sets.x.label = "DE Genes Per Timepoint")
```

![](data:image/png;base64...)

## Differential Trajectories

Instead of looking at each time-point separately, it is often useful to identifying genes which exhibit different expression trajectories, i.e. ones with differential kinetics over time. We take a most natural approach which can be applied to short time-course datasets, which is an analysis of variance. In particular we use a method based on non-parametric permutation multivariate analysis of variance (MANOVA).

To test each gene for differential trajectory under two conditions, we use the time-course format, where each row is a transformed time-series with lags corresponding to a single replicate within a particular group. `adonis()` function from `vegan` package is applied to find genes with differential trajectories. `adonis` approach is based on partitioning the sums of squares of the multivariate (here time-series with lags) data to within and between-class. The significance is determined with an F-test on permutations of the data.

Using this procedure, here we will identify genes which have different trajectories within the wild type and knock-out group. This difference is determined when time series replicates (expression profiles) are more different between the groups than within the same group.

With a small number of available replicates (3 wild type and 3 knockout), a permutation based method does not yield high power. Combined with multiple hypothesis testing correction (for testing thousands of genes), we expect the method’s p-values to be mostly below significance level of \(\alpha = 0.5\). However, this approach is still useful, as we can user raw (unadjusted) p-values to filter out the genes that are with high probability not significant, and use the \(R^2\) value (the percentage variance explained by groups) for ranking the genes in terms of the difference in expression profiles between two groups.

Function `trajectoryDE()` can be used to find differential genes using the above described method. Results of testing procedure can be accessed with: `differentialExpression(cop1.te, "trajectory_de")`.

```
cop1.te <- trajectoryDE(cop1.te, dist_method = "euclidean")
de_trajectory_res <- differentialExpression(cop1.te, "trajectory_de")
saveRDS(de_trajectory_res, "de_trajectory_cop1.rds")
```

```
head(de_trajectory_res, 20)
```

| feature | Df | SumsOfSqs | MeanSqs | F.Model | R2 | pval | p.adj | symbol | size | type | desc | cluster | used\_for\_hclust |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 26374 | 1 | 0.0034744 | 0.0034744 | 112.51257 | 0.9656689 | 0.1 | 0.3534567 | Rfwd2 | 5341 | protein\_coding | ring finger and WD repeat domain 2 | C4 | FALSE |
| 320782 | 1 | 0.0072386 | 0.0072386 | 103.81930 | 0.9629009 | 0.1 | 0.3534567 | Tmem154 | 3342 | protein\_coding | transmembrane protein 154 | C2 | TRUE |
| 104156 | 1 | 0.0048415 | 0.0048415 | 83.55940 | 0.9543167 | 0.1 | 0.3534567 | Etv5 | 4066 | protein\_coding | ets variant 5 | C6 | TRUE |
| 27355 | 1 | 0.0118039 | 0.0118039 | 65.46214 | 0.9424147 | 0.1 | 0.3534567 | Pald1 | 4490 | protein\_coding | phosphatase domain containing, paladin 1 | C2 | TRUE |
| 16763 | 1 | 0.0087209 | 0.0087209 | 63.29198 | 0.9405576 | 0.1 | 0.3534567 | Lad1 | 2992 | protein\_coding | ladinin | C3 | TRUE |
| 13039 | 1 | 0.0011924 | 0.0011924 | 57.83038 | 0.9353069 | 0.1 | 0.3534567 | Ctsl | 2327 | protein\_coding | cathepsin L | C4 | FALSE |
| 17394 | 1 | 0.0039649 | 0.0039649 | 56.47761 | 0.9338598 | 0.1 | 0.3534567 | Mmp8 | 2453 | protein\_coding | matrix metallopeptidase 8 | C4 | TRUE |
| 66455 | 1 | 0.0015594 | 0.0015594 | 43.69125 | 0.9161272 | 0.1 | 0.3534567 | Cnpy4 | 1781 | protein\_coding | canopy 4 homolog (zebrafish) | C1 | TRUE |
| 240913 | 1 | 0.0040984 | 0.0040984 | 43.51711 | 0.9158198 | 0.1 | 0.3534567 | Adamts4 | 3673 | protein\_coding | a disintegrin-like and metallopeptidase (reprolysin type) with thrombospondin type 1 motif, 4 | C6 | TRUE |
| 219144 | 1 | 0.0011053 | 0.0011053 | 41.02111 | 0.9111528 | 0.1 | 0.3534567 | Arl11 | 2810 | protein\_coding | ADP-ribosylation factor-like 11 | C2 | TRUE |
| 15370 | 1 | 0.0111295 | 0.0111295 | 40.50848 | 0.9101295 | 0.1 | 0.3534567 | Nr4a1 | 5035 | protein\_coding | nuclear receptor subfamily 4, group A, member 1 | C2 | TRUE |
| 213956 | 1 | 0.0074680 | 0.0074680 | 38.03157 | 0.9048334 | 0.1 | 0.3534567 | Fam83f | 3317 | protein\_coding | family with sequence similarity 83, member F | C2 | TRUE |
| 15530 | 1 | 0.0127704 | 0.0127704 | 34.42740 | 0.8959076 | 0.1 | 0.3534567 | Hspg2 | 15128 | protein\_coding | perlecan (heparan sulfate proteoglycan 2) | C1 | TRUE |
| 100038947 | 1 | 0.0026511 | 0.0026511 | 33.98330 | 0.8946906 | 0.1 | 0.3534567 | LOC100038947 | 1593 | protein\_coding | signal-regulatory protein beta 1-like | C5 | FALSE |
| 14118 | 1 | 0.0050996 | 0.0050996 | 33.53175 | 0.8934236 | 0.1 | 0.3534567 | Fbn1 | 10019 | protein\_coding | fibrillin 1 | C3 | FALSE |
| 17105 | 1 | 0.0003392 | 0.0003392 | 32.93845 | 0.8917118 | 0.1 | 0.3534567 | Lyz2 | 1057 | protein\_coding | lysozyme 2 | C4 | FALSE |
| 67465 | 1 | 0.0002480 | 0.0002480 | 32.74887 | 0.8911531 | 0.1 | 0.3534567 | Sf3a1 | 4916 | protein\_coding | splicing factor 3a, subunit 1 | C1 | FALSE |
| 18600 | 1 | 0.0016279 | 0.0016279 | 32.64502 | 0.8908446 | 0.1 | 0.3534567 | Padi2 | 4850 | protein\_coding | peptidyl arginine deiminase, type II | C2 | TRUE |
| 237256 | 1 | 0.0013029 | 0.0013029 | 31.28856 | 0.8866488 | 0.1 | 0.3534567 | Zc3h12d | 4262 | protein\_coding | zinc finger CCCH type containing 12D | C5 | TRUE |
| 58217 | 1 | 0.0085137 | 0.0085137 | 29.31514 | 0.8799345 | 0.1 | 0.3534567 | Trem1 | 3468 | protein\_coding | triggering receptor expressed on myeloid cells 1 | C3 | TRUE |

You can filter out the genes based on the \(R^2\) value (the percentage variance explained by groups). There are 372 genes with \(R^2 \ge 0.7\) which constitutes a fraction of 0.0397606 of all the genes in the dataset.

Here we print out 20 of the genes with highest \(R^2\) value and the pvalue equal 0.1. P-value of 0.1 is the minimum possible when performing permutation test on distances between 6 observations split evenly into 2 groups (0.1 = 2/(6 choose 3)).

```
# Select top most different genes across two groups
n_genes <- 20
genes_with_de_trajectory <- de_trajectory_res %>%
filter(pval <= max(0.05, min(pval)), R2 > 0.7) %>%
arrange(-R2)
(genes_to_plot <- genes_with_de_trajectory$feature[1:n_genes])
```

```
##  [1] "26374"     "320782"    "104156"    "27355"     "16763"     "13039"     "17394"     "66455"     "240913"    "219144"    "15370"     "213956"    "15530"     "100038947" "14118"     "17105"
## [17] "67465"     "18600"     "237256"    "58217"
```

```
plotTimeSeries(cop1.te, features = genes_to_plot) +
scale_color_manual(values = c("WT" =  "#1f78b4", "Loxp" = "#e31a1c"))
```

```
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
```

![](data:image/png;base64...)

Note, that in this analysis of variance approach we can specify a distance metric. Additionally, if you are interested in finding out genes DE in specific time intervals e.g. beginning or end of an experiment, you can choose to keep only the timepoints of interest are remove the rest from the time-courses stored in `cop1.te@timecourse.data$tc`. `trajectory_de()` would then compute the distance for the specified time period and return DE genes at these specific time intervals.

# Functional pathways

In this section we will describe procedures to find functional pathways/gene sets corresponding to genes exhibiting differential expression profiles. We use publicly available reference databases to find relevant pathways.

You can select any list of genes for this step. However, the method is intended for sets of genes found differentially expressed using methods provided by `TimeSeriesExperiment`, discussed in the previous section.

Below, we use genes with DE trajectory, selected in the previous section. There are 372 in the set:

```
length(genes_with_de_trajectory$feature)
```

```
## [1] 372
```

Multiple functional pathways might be affected by knocking-out Cop1 gene. Therefore, we expect that genes found differential expressed can be parts of distinct pathways. Selected DE genes can be grouped by their cluster membership found earlier.

Below we plot expression profiles of selected DE genes, separated according to their cluster assignment.

```
plotTimeSeriesClusters(
cop1.te, transparency = 0.5,
features = genes_with_de_trajectory$feature) +
scale_color_manual(values = c("WT" = "#1f78b4", "Loxp" = "#e31a1c"))
```

![](data:image/png;base64...)

We can test sets (clusters) of DE genes individually for pathway enrichment using `pathwayEnrichment()` which is built on top of `goanna()` and `kegga()` functions from `limma` package. The `features` argument provided to `pathwayEnrichment()` must be Entrez Gene IDs. The user must also specify the relevant species. Optionally, the user can modify the filtering parameters applied to enrichment results: `fltr_DE`, `fltr_N`, and `fltr_P.DE`. For details see the documentation `?pathwayEnrichment`.

```
enrich_res <- pathwayEnrichment(
object = cop1.te,
features = genes_with_de_trajectory$feature,
species = "Mm", ontology ="BP")
saveRDS(enrich_res, "enrich_res_cop1.rds")
```

We can plot enrichment results for genes with differential trajectory in each cluster separately using `plotEnrichment()`. Here we plot the top `n_max = 15` terms for each cluster. Next to enrichment terms, in the brackets, we have included information on the exact number of DE genes in a set (DE) and the size of the reference enrichment term (N). The points are colored by this fraction. The size of the points correspond the enrichment term size (N).

Below we print we print for example a plot for cluster C4 and C5

```
clst <- "C4"
plotEnrichment(
enrich = enrich_res[[clst]], n_max = 15) +
ggtitle(paste0("Cluster , ", clst, " enrichment"))
```

![](data:image/png;base64...)

```
clst <- "C5"
plotEnrichment(
enrich = enrich_res[[clst]], n_max = 15) +
ggtitle(paste0("Cluster , ", clst, " enrichment"))
```

![](data:image/png;base64...)

# Session Information

```
sessionInfo()
```

```
## R version 3.5.2 (2018-12-20)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 16.04.5 LTS
##
## Matrix products: default
## BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_US.UTF-8        LC_COLLATE=C               LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8    LC_PAPER=en_US.UTF-8
##  [8] LC_NAME=C                  LC_ADDRESS=C               LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats4    parallel  stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
##  [1] UpSetR_1.3.3                bindrcpp_0.2.2              BiocFileCache_1.6.0         dbplyr_1.3.0                TimeSeriesExperiment_1.0.4  readr_1.3.1                 tibble_2.0.1
##  [8] tidyr_0.8.2                 dplyr_0.7.8                 ggplot2_3.1.0               SummarizedExperiment_1.12.0 DelayedArray_0.8.0          BiocParallel_1.16.5         matrixStats_0.54.0
## [15] GenomicRanges_1.34.0        GenomeInfoDb_1.18.1         IRanges_2.16.0              S4Vectors_0.20.1            Biobase_2.42.0              BiocGenerics_0.28.0         viridis_0.5.1
## [22] viridisLite_0.3.0           edgeR_3.24.3                limma_3.38.3                rmarkdown_1.11
##
## loaded via a namespace (and not attached):
##  [1] colorspace_1.4-0       rjson_0.2.20           dynamicTreeCut_1.63-1  circlize_0.4.5         htmlTable_1.13.1       XVector_0.22.0         GlobalOptions_0.1.0    base64enc_0.1-3
##  [9] rstudioapi_0.9.0       proxy_0.4-22           bit64_0.9-7            AnnotationDbi_1.44.0   splines_3.5.2          geneplotter_1.60.0     knitr_1.21             Formula_1.2-3
## [17] annotate_1.60.0        cluster_2.0.7-1        compiler_3.5.2         httr_1.4.0             backports_1.1.3        assertthat_0.2.0       Matrix_1.2-15          lazyeval_0.2.1
## [25] acepack_1.4.1          htmltools_0.3.6        tools_3.5.2            gtable_0.2.0           glue_1.3.0             GenomeInfoDbData_1.2.0 rappdirs_0.3.1         Rcpp_1.0.0
## [33] nlme_3.1-137           xfun_0.4               stringr_1.3.1          XML_3.98-1.16          zlibbioc_1.28.0        MASS_7.3-51.1          scales_1.0.0           hms_0.4.2
## [41] RColorBrewer_1.1-2     ComplexHeatmap_1.20.0  yaml_2.2.0             curl_3.3               memoise_1.1.0          gridExtra_2.3          rpart_4.1-13           latticeExtra_0.6-28
## [49] stringi_1.2.4          RSQLite_2.1.1          highr_0.7              genefilter_1.64.0      checkmate_1.9.1        permute_0.9-4          shape_1.4.4            rlang_0.3.1
## [57] pkgconfig_2.0.2        bitops_1.0-6           evaluate_0.12          lattice_0.20-38        purrr_0.2.5            bindr_0.1.1            labeling_0.3           htmlwidgets_1.3
## [65] bit_1.1-14             tidyselect_0.2.5       plyr_1.8.4             magrittr_1.5           DESeq2_1.22.2          R6_2.3.0               Hmisc_4.1-1            DBI_1.0.0
## [73] pillar_1.3.1           foreign_0.8-71         withr_2.1.2            mgcv_1.8-26            survival_2.43-3        RCurl_1.95-4.11        nnet_7.3-12            crayon_1.3.4
## [81] GetoptLong_0.1.7       locfit_1.5-9.1         grid_3.5.2             data.table_1.12.0      blob_1.1.1             vegan_2.5-3            digest_0.6.18          xtable_1.8-3
## [89] munsell_0.5.0
```