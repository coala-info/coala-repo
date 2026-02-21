# Differential discovery with `CATALYST`

Helena L Crowell1,2\* and Mark D Robinson1,2

1Institute for Molecular Life Sciences, University of Zurich, Switzerland
2SIB Swiss Institute of Bioinformatics, University of Zurich, Switzerland

\*helena.crowell@uzh.ch

#### 20 November 2025

#### Package

CATALYST 1.34.1

# Contents

* [1 Example data](#example-data)
* [2 Data preparation](#data-preparation)
* [3 Clustering](#clustering)
  + [3.1 `cluster`: *FlowSOM* clustering & *ConsensusClusterPlus* metaclustering](#cluster-flowsom-clustering-consensusclusterplus-metaclustering)
  + [3.2 `mergeClusters`: Manual cluster merging](#mergeclusters-manual-cluster-merging)
  + [3.3 Delta area plot](#delta-area-plot)
* [4 Visualization](#visualization)
  + [4.1 `plotCounts`: Number of cells measured per sample](#plotcounts-number-of-cells-measured-per-sample)
  + [4.2 `pbMDS`: Pseudobulk-level MDS plot](#pbmds-pseudobulk-level-mds-plot)
    - [4.2.1 Ex. 2: MDS on sample-level pseudobulks](#ex.-2-mds-on-sample-level-pseudobulks)
    - [4.2.2 Ex. 1: MDS on pseudobulks by cluster-sample](#ex.-1-mds-on-pseudobulks-by-cluster-sample)
  + [4.3 `clrDR`: Reduced dimension plot on CLR of proportions](#clrdr-reduced-dimension-plot-on-clr-of-proportions)
    - [4.3.1 Ex. 1: CLR on cluster proportions across samples](#ex.-1-clr-on-cluster-proportions-across-samples)
    - [4.3.2 Ex. 2: CLR on sample proportions across clusters](#ex.-2-clr-on-sample-proportions-across-clusters)
  + [4.4 `plotExprHeatmap`: Heatmap of aggregated marker expressions](#plotExprHeatmap)
  + [4.5 `plotPbExprs`: Pseudobulk expression boxplot](#plotpbexprs-pseudobulk-expression-boxplot)
  + [4.6 `plotClusterExprs`: Marker-densities by cluster](#plotclusterexprs-marker-densities-by-cluster)
  + [4.7 `plotAbundances`: Relative population abundances](#plotabundances-relative-population-abundances)
  + [4.8 `plotFreqHeatmap`: Heatmap of cluster fequencies](#plotFreqHeatmap)
  + [4.9 `plotMultiHeatmap`: Multi-panel Heatmaps](#plotmultiheatmap-multi-panel-heatmaps)
    - [4.9.1 Ex. 1: Type- & state-markers](#plotMultiHeatmap-example1)
    - [4.9.2 Ex. 2: CDx markers & cluster frequencies](#plotMultiHeatmap-example2)
    - [4.9.3 Ex. 3: Selected markers](#plotMultiHeatmap-example3)
* [5 Dimensionality reduction](#dimensionality-reduction)
* [6 Filtering](#filtering)
* [7 Differental testing with *diffcyt*](#differental-testing-with-diffcyt)
  + [7.1 `plotDiffHeatmap`: Heatmap of differential testing results](#plotdiffheatmap-heatmap-of-differential-testing-results)
  + [7.2 Ex. 1: DA testing results](#ex.-1-da-testing-results)
  + [7.3 Ex. 2: DS testing results](#ex.-2-ds-testing-results)
  + [7.4 Ex. 3: Filtering results](#ex.-3-filtering-results)
  + [7.5 Ex. 4: Customizing appearance](#ex.-4-customizing-appearance)
* [8 More](#more)
  + [8.1 Exporting FCS files](#exporting-fcs-files)
  + [8.2 Using other clustering algorithms](#using-other-clustering-algorithms)
  + [8.3 Customizing visualizations](#customizing-visualizations)
    - [8.3.1 Modifying `ggplot`s](#modifying-ggplots)
    - [8.3.2 Modifying `ComplexHeatmap`s](#modifying-complexheatmaps)
  + [8.4 Combining `ComplexHeatmap`s](#combining-complexheatmaps)
    - [8.4.1 Ex. 1: type- & state-markers + cluster frequencies](#ex.-1-type--state-markers-cluster-frequencies)
    - [8.4.2 Ex. 2: frequencies + selected markers + all markers](#ex.-2-frequencies-selected-markers-all-markers)
* [9 Session information](#session-information)
* [References](#references)

**Most of the pipeline and visualizations presented herein have been adapted from Nowicka et al. ([2019](#ref-Nowicka2019-F1000))’s *“CyTOF workflow: differential discovery in high-throughput high-dimensional cytometry datasets”* available [here](https://f1000research.com/articles/6-748/v4).**

```
# load required packages
library(CATALYST)
library(cowplot)
library(flowCore)
library(diffcyt)
library(scater)
library(SingleCellExperiment)
```

# 1 Example data

* `PBMC_fs`:
* `PBMC_panel`:
  a data.frame containing each marker’s column name in the FCS file (`fcs_colname` column), its targeted protein marker (`antigen` column), and the `marker_class` (“type” or “state”).
* `PBMC_md`:
  a data.frame where rows correspond to samples, and columns specify each sample’s `file_name`, `sample_id`, `condition`, and `patient_id`.

```
# load example data
data(PBMC_fs, PBMC_panel, PBMC_md)
PBMC_fs
```

```
## A flowSet with 8 experiments.
##
## column names(24): CD3(110:114)Dd CD45(In115)Dd ... HLA-DR(Yb174)Dd
##   CD7(Yb176)Dd
```

```
head(PBMC_panel)
```

```
##      fcs_colname antigen marker_class
## 1 CD3(110:114)Dd     CD3         type
## 2  CD45(In115)Dd    CD45         type
## 3 pNFkB(Nd142)Dd   pNFkB        state
## 4  pp38(Nd144)Dd    pp38        state
## 5   CD4(Nd145)Dd     CD4         type
## 6  CD20(Sm147)Dd    CD20         type
```

```
head(PBMC_md)
```

```
##                 file_name sample_id condition patient_id
## 1 PBMC_patient1_BCRXL.fcs    BCRXL1     BCRXL   Patient1
## 2   PBMC_patient1_Ref.fcs      Ref1       Ref   Patient1
## 3 PBMC_patient2_BCRXL.fcs    BCRXL2     BCRXL   Patient2
## 4   PBMC_patient2_Ref.fcs      Ref2       Ref   Patient2
## 5 PBMC_patient3_BCRXL.fcs    BCRXL3     BCRXL   Patient3
## 6   PBMC_patient3_Ref.fcs      Ref3       Ref   Patient3
```

The code snippet below demonstrates how to construct a `flowSet` from a set of FCS files. However, we also give the option to directly specify the path to a set of FCS files (see next section).

```
# download exemplary set of FCS files
url <- "http://imlspenticton.uzh.ch/robinson_lab/cytofWorkflow"
zip <- "PBMC8_fcs_files.zip"
download.file(paste0(url, "/", zip), destfile = zip, mode = "wb")
unzip(zip)

# read in FCS files as flowSet
fcs <- list.files(pattern = ".fcs$")
fs <- read.flowSet(fcs, transformation = FALSE, truncate_max_range = FALSE)
```

# 2 Data preparation

Data used and returned throughout differential analysis are held in objects of the *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* class. To bring the data into the appropriate format, `prepData()` requires the following inputs:

* `x`: a `flowSet` holding the raw measurement data, or a character string that specifies a path to a set of FCS files.
* `panel`: a 2 column data.frame that contains for each marker of interest i) its column name in the raw input data, and ii) its targeted protein marker.
* `md`: a data.frame with columns describing the experimental design.

Optionally, `features` will specify which columns (channels) to keep from the input data. Here, we keep all measurement parameters (default value `features = NULL`).

```
(sce <- prepData(PBMC_fs, PBMC_panel, PBMC_md))
```

```
## class: SingleCellExperiment
## dim: 24 5428
## metadata(2): experiment_info chs_by_fcs
## assays(2): counts exprs
## rownames(24): CD3 CD45 ... HLA-DR CD7
## rowData names(3): channel_name marker_name marker_class
## colnames: NULL
## colData names(3): sample_id condition patient_id
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

We provide flexibility in the way the panel and metadata table can be set up. Specifically, column names are allowed to differ from the example above, and multiple factors (patient ID, conditions, batch etc.) can be specified. Arguments `panel_cols` and `md_cols` should then be used to specify which columns hold the required information. An example is given below:

```
# alter panel column names
panel2 <- PBMC_panel
colnames(panel2)[1:2] <- c("channel_name", "marker")

# alter metadata column names & add 2nd condition
md2 <- PBMC_md
colnames(md2) <- c("file", "sampleID", "cond1", "patientID")
md2$cond2 <- rep(c("A", "B"), 4)

# construct SCE
prepData(PBMC_fs, panel2, md2,
    panel_cols = list(channel = "channel_name", antigen = "marker"),
    md_cols = list(file = "file", id = "sampleID",
        factors = c("cond1", "cond2", "patientID")))
```

Note that, independent of the input panel and metadata tables, the constructor will fix the names of mandatory slots for latter data accession (`sample_id` in the `rowData`, `channel_name` and `marker_name` in the `colData`). The `md` table will be stored under `experiment_info` inside the `metadata`.

# 3 Clustering

## 3.1 `cluster`: *FlowSOM* clustering & *ConsensusClusterPlus* metaclustering

*[CATALYST](https://bioconductor.org/packages/3.22/CATALYST)* provides a simple wrapper to perform high resolution `FlowSOM` clustering and lower resolution `ConsensusClusterPlus` metaclustering. By default, the data will be initially clustered into `xdim = 10` x `ydim = 10` = 100 groups. Secondly, the function will metacluster populations into 2 through `maxK` (default 20) clusters. To make analyses reproducible, the random seed may be set via `seed`. By default, if the `rowData(sce)$marker_class` column is specified, the set of markers with marker class `"type"` will be used for clustering (argument `features = "type"`). Alternatively, the markers that should be used for clustering can be specified manually.

```
sce <- cluster(sce, features = "type",
    xdim = 10, ydim = 10, maxK = 20,
    verbose = FALSE, seed = 1)
```

Let K = `xdim` x `ydim` be the number of *[FlowSOM](https://bioconductor.org/packages/3.22/FlowSOM)* clusters. `cluster` will add information to the following slots of the input `SingleCellExperiment`:

* `rowData`:
  + `marker_class`: factor `"type"` or `"state"`. Specifies whether a marker has been used for clustering or not, respectively.
* `colData`:
  + `cluster_id`: cluster ID as inferred by *[FlowSOM](https://bioconductor.org/packages/3.22/FlowSOM)*. One of 1, …, K.
* `metadata`:
  + `SOM_codes`: a table with dimensions K x (# type markers). Contains the SOM codes.
  + `cluster_codes`: a table with dimensions K x (`maxK` + 1). Contains the cluster codes for all metaclusterings.
  + `delta_area`: a `ggplot` object (see below for details).

## 3.2 `mergeClusters`: Manual cluster merging

Provided with a 2 column data.frame containing `old_cluster` and `new_cluster` IDs, `mergeClusters` allows for manual cluster merging of any clustering available within the input `SingleCellExperiment` (i.e. the `xdim` x `ydim` *[FlowSOM](https://bioconductor.org/packages/3.22/FlowSOM)* clusters, and any of the 2-`maxK` *[ConsensusClusterPlus](https://bioconductor.org/packages/3.22/ConsensusClusterPlus)* metaclusters). For latter accession (visualization, differential testing), the function will assign a unique ID (specified with `id`) to each merging, and add a column to the `cluster_codes` inside the `metadata` slot of the input `SingleCellExperiment`.

```
data(merging_table)
head(merging_table)
```

```
## # A tibble: 6 × 2
##   old_cluster new_cluster
##         <dbl> <chr>
## 1           1 B-cells IgM+
## 2           2 surface-
## 3           3 NK cells
## 4           4 CD8 T-cells
## 5           5 B-cells IgM-
## 6           6 monocytes
```

```
sce <- mergeClusters(sce, k = "meta20", table = merging_table, id = "merging1")
head(cluster_codes(sce))[, seq_len(10)]
```

```
##   som100 meta2 meta3 meta4 meta5 meta6 meta7 meta8 meta9 meta10
## 1      1     1     1     1     1     1     1     1     1      1
## 2      2     1     1     1     1     1     1     1     1      1
## 3      3     1     1     1     1     1     1     1     1      1
## 4      4     1     1     1     1     1     1     1     1      1
## 5      5     1     1     1     1     1     2     2     2      2
## 6      6     1     1     1     1     1     2     2     2      2
```

## 3.3 Delta area plot

The delta area represents the amount of extra cluster stability gained when clustering into k groups as compared to k-1 groups. It can be expected that high stability of clusters can be reached when clustering into the number of groups that best fits the data. The “natural” number of clusters present in the data should thus corresponds to the value of k where there is no longer a considerable increase in stability (pleateau onset). For more details, the user can refer to the original description of the consensus clustering method (Monti et al. [2003](#ref-Monti2003-ConsensusClusterPlus)).

```
# access & render delta area plot
# (equivalent to metadata(sce)$delta_area)
delta_area(sce)
```

![](data:image/png;base64...)

# 4 Visualization

## 4.1 `plotCounts`: Number of cells measured per sample

The number of cells measured per sample may be plotted with `plotCounts`. This plot should be used as a guide together with other readouts to identify samples where not enough cells were assayed. Here, the grouping of samples (x-axis) is controlled by `group_by`; bars can be colored by a an additional cell metadata variable (argument `color_by`):

```
plotCounts(sce,
    group_by = "sample_id",
    color_by = "condition")
```

![](data:image/png;base64...)

As opposed to plotting absolute cell counts, argument `prop` can be used to visualize relative abundances (frequencies) instead:

```
plotCounts(sce,
    prop = TRUE,
    group_by = "condition",
    color_by = "patient_id")
```

![](data:image/png;base64...)

## 4.2 `pbMDS`: Pseudobulk-level MDS plot

A multi-dimensional scaling (MDS) plot on aggregated measurement values may be rendered with `pbMDS`. Such a plot will give a sense of similarities between cluster and/or samples in an unsupervised way and of key difference in expression before conducting any formal testing.

Arguments `by`, `assay` and `fun` control the aggregation strategy, allowing to compute pseudobulks by sample (`by = "sample_id"`), cluster (`by = "cluster_id"`) or cluster-sample instances (`by = "both"`) using the specified `assay` data and summarry statistic (argument `fun`)111 By default, median expression values are computed.. When `by != "sample_id"`, i.e., when aggregating by cluster or cluster-sample, argument `k` specifies the clustering to use. The features to include in the computation of reduced dimensions may be specified via argument `features`.

Arguments `color_by`, `label_by`, `shape_by` can be used to color, label, shape pseudobulk instances by cell metadata variables of interest. Moreover, `size_by = TRUE` will scale point sizes proportional to the number of cells that went into aggregation. Finally, a custom color palette may be supplied to argument `pal.`

### 4.2.1 Ex. 2: MDS on sample-level pseudobulks

A multi-dimensional scaling (MDS) plot on median marker expression by sample has the potential to reveal global proteomic differences across conditions or other experimental metadata. Here, we color points by condition (to reveal treatment effects) and further shape them by patient (to highlight patient effects). In our example, we can see a clear horizontal (MDS dim. 1) separation between reference (REF) and stimulation condition (BCRXL), while patients are, to a lesser extent, separated vertically (MDS dim. 2):

```
pbMDS(sce, shape_by = "patient_id", size_by = FALSE)
```

![](data:image/png;base64...)

### 4.2.2 Ex. 1: MDS on pseudobulks by cluster-sample

Complementary to the visualize above, we can generate an MDS plot on pseudobulks computed for each cluster-sample instance. Here, we color point by cluster (to highlight similarity between cell subpopulations), and shape them by condition (to reveal subpopulation-specific expression changes across conditions). In this example, we can see that cluster-sample instances of the same cell subpopulations group together. Meanwhile, most subpopulations exhibit a shift between instances where samples come from different treatment groups:

```
pbMDS(sce, by = "both", k = "meta12",
    shape_by = "condition", size_by = TRUE)
```

![](data:image/png;base64...)

## 4.3 `clrDR`: Reduced dimension plot on CLR of proportions

A dimensionality reduction plot on centered log-ratios (CLR) of sample/cluster proportions across clusters/samples can be rendered with `clrDR`. Here, we view each sample (cluster) as a vector of cluster (sample) proportions. Complementary to `pbMDS`, such a plot will give a sense of similarities between samples/clusters in terms of their composition.

**Centered log-ratio**
Let \(s\_i=s\_1,...,s\_S\) denote one of \(S\) samples, \(k\_i=k\_1,...,k\_K\) one of \(K\) clusters, and \(p\_k(s\_i)\) be the proportion of cells from sample \(s\_i\) in cluster \(k\). The centered log-ratio (CLR) on a given sample’s cluster composition is then defined as:

\[\text{clr}\_{sk} = \log p\_k(s\_i) - \frac{1}{K}\sum\_{i=1}^K \log p\_k(s\_i)\]

Thus, each sample \(s\) gives a vector with length \(K\) with mean 0, and the CLRs computed across all instances can be represented as a matrix with dimensions \(S \times K\).
We can embed the CLR matrix into a lower dimensional space in which points represent samples; or embed its transpose, in which case points represent samples. Distances in this lower-dimensional space will then represent the similarity in cluster compositions between samples and the in sample compositions between clusters, respectively.

**Dimensionality reduction**
In principle, `clrDR` allows any dimension reduction to be applied on the CLRs, with `dims` (default `c(1, 2)`) specifying which dimensions to visualize. The default method `dr = "PCA"` will include the percentage of variance explained by each principal component (PC) in the axis labels. Noteworthily, *distances between points in the lower-dimensional space are meaningful only for linear DR methods* (PCA and MDS), and results obtained from other methods should be interpreted with caution. The output plot’s aspect ratio should thus be kept as is for PCA and MDS; meanwhile, non-linear DR methods can use `aspect.ratio = 1`, rendering a squared plot.

**Interpreting loadings**
For `dr = "PCA"`, PC loadings will be represented as arrows that may be interpreted as follows: 0° (180°) between vectors indicates a strong positive (negative) relation between them, while vectors that are orthogonal to one another (90°) are roughly independent.
When a vector points towards a given quadrant, the variability in proportions for the points within this quadrant are largely driven by the corresponding variable. Here, only the relative orientation of loading vectors to each other and to the PC axes is meaningful; however, the sign of loadings (i.e., whether an arrow points left or right) can be flipped when re-computing PCs.

**Aesthetics**
Cell metadata variables to color points and PC loading arrows by are determined by arguments `point/arrow_col`, with `point/arrow_pal` specifying the color palettes to use for each layer. For example, rather than coloring samples by their unique identifiers, we may choose to use their condition for coloring instead to highlight differences across groups. In addition, point sizes may be scaled by the number of cells in a given sample/cluster (when `by = "sample/cluster_id"`) via setting `size_by = TRUE`.
Argument `arrow_len` (default 0.5) controls the length of PC loading vectors relative to the largest absolute xy-coordinate. When specified, PC loading vectors will be re-scaled to improve their visibility: A value of 1 will stretch vectors such that the largest loading will touch on the outer most point. Importantly, while absolute arrow lengths are not interpretable, their relative length is.

### 4.3.1 Ex. 1: CLR on cluster proportions across samples

We here visualize the first two PCs computed on CLRs of sample proportions across clusters: small distances between samples mean similar cluster compositions between them, while large distances are indicative of differences in cluster proportions. In our example, PC 1 clearly separates treatment groups:

```
clrDR(sce, by = "sample_id", k = "meta12")
```

![](data:image/png;base64...)

### 4.3.2 Ex. 2: CLR on sample proportions across clusters

As an alternative to the plot above, we can visualize the first two PCs computed on the CLR matrix’ transpose. Here, we can observe that most of the variability in cluster-compositions across samples is driven by BCRXL samples (PC1):

```
clrDR(sce, by = "cluster_id", arrow_col = "condition", size_by = FALSE)
```

![](data:image/png;base64...)

## 4.4 `plotExprHeatmap`: Heatmap of aggregated marker expressions

`plotExprHeatmap` allows generating heatmaps of aggregated (pseudobulk) marker expressions. Argument `assay` (default `"exprs"`) and `fun` (default `"median"`) control the aggregation. Depending on argument `by`, aggregation will be performed by `"sample_id"`, `"cluster"`, or `"both"`.

**Scaling**
`plotExprHeatmap` supports various scaling strategies that are controlled by arguments `scale` and `q`, and will greatly alter the visualization and its interpretation222 Regardless of the chosen scaling strategy, row and column clusterings will be performed on unscaled data.:

* When `scale = "first"`, the specified assay data will be scaled between 0 and 1 using lower (`q`) and upper (`1-q`) quantiles as boundaries, where `q = 0.01` by default. This way, while losing information on absolut expression values, marker expressions will stay comparable, and visualization is improved in cases where the expression range varies greatly between markers.
* When `scale = "last"`, assay data will be aggregated first and scaled subsequently. Thus, each marker’s value range will be [0,1]. While all comparability between markers is lost, such scaling will improve seeing differences across, e.g., samples or clusters.
* When `scale = "never"`, no scaling (and quantile trimming) is applied. The resulting heatmap will thus display *raw* pseudobulk data (e.g., median expression values).

**Hierarchical clustering**
Various arguments control whether rows/columns should be hierarchically clustered (and re-ordered) accordingly (`row/col_clust`), and whether to include the resulting dendrograms in the heatmap (`row/col_dend`). Here, clustering is performed using `dist` followed by `hclust` on the assay data matrix with the specified `method` as distance metric (default `euclidean`) and `linkage` for agglomeration (default `average`).

**Cell count annotation**
Optionally, argument `bars` specifies whether to include a barplot of cell counts, which can further be annotated with relative abundances (%) via `perc = TRUE`. These will correspong to cell counts by cluster (when `by != "sample_id"`), and by sample otherwise.

**Sample and cluster annotations**
By default (`row/col_anno = TRUE`), for axes corresponding to samples (y-axis for `by = "sample_id"` and x-axis for `by = "both"`), annotations will be drawn for all non-numeric cell metadata variables. Alternatively, a specific subset of annotations can be included for only a subset of variables by specifying `row/col_anno` to be a character vector in (see examples).
For axes corresponding to clusters (y-axis for `by = "cluster_id"` and `"both"`), annotations will be drawn for the specified clustering(s) (arguments `k` and `m`).

The following examples shall cover the 3 different modes of `plotExprHeatmap`:

```
# scale each marker between 0 and 1
# (after aggregation & without trimming)
plotExprHeatmap(sce, features = "state",
    scale = "last", q = 0, bars = FALSE)
```

![](data:image/png;base64...)

When `by != "sample_id"`, the clustering to use for aggregation is specified via `k`, and an additional metaclusting may be included as an annotation (argument `m`):

```
# medians of scaled & trimmed type-marker expressions by cluster
plotExprHeatmap(sce, features = "type",
    by = "cluster_id", k = "meta12", m = "meta8",
    scale = "first", q = 0.01, perc = TRUE, col_dend = FALSE)
```

![](data:image/png;base64...)

Finally, we can visualize the aggregated expression of specific markers by cluster *and* sample via `by = "both"`333 In this case, only a single features is allowed as input.:

```
# raw (not scaled, not trimmed)
# median expression by cluster-sample
plotExprHeatmap(sce, features = "pS6", by = "both", k = "meta8",
    scale = "never", col_clust = FALSE, row_anno = FALSE, bars = FALSE)
```

![](data:image/png;base64...)

## 4.5 `plotPbExprs`: Pseudobulk expression boxplot

A combined boxplot and jitter of aggregated marker intensities can be generated via `plotPbExprs()`. Here, argument `features` (default `"state"`, which is equivalent to `state_markers(sce)`) controls which markers to include. `features = NULL` will include all markers (and is equivalent to `rownames(sce)`).
The specified `assay` values (default `"exprs"`) will be aggregated using `fun` (default `"median"`) as summary statistic, resulting in one pseudobulk value per sample, or cluster-sample (when one of `facet_by`, `color_by` or `group_by` is set to `"cluster_id"`).

In order to compare medians for each cluster, and potentially identify changes across conditions early on, we specify `facet = "cluster_id"`:

```
plotPbExprs(sce, k = "meta8", facet_by = "cluster_id", ncol = 4)
```

![](data:image/png;base64...)

Alternatively, we can facet the above plot by `antigen` in order to compare marker expressions calculated over all cells across conditions:

```
plotPbExprs(sce, facet_by = "antigen", ncol = 7)
```

![](data:image/png;base64...)

Thirdly, we can investigate how consistent type-markers are expressed across clusters. To this end, we specify `color_by = "cluster_id"` in order to aggregate expression values by both clusters and samples. The resulting plot gives an indication how *good* our selection of type markers is: Ideally, their expression should be fairly specific to a subset of clusters.

```
plotPbExprs(sce, k = "meta10", features = "type",
  group_by = "cluster_id", color_by = "sample_id",
  size_by = TRUE, geom = "points", jitter = FALSE, ncol = 5)
```

![](data:image/png;base64...)

Finally, we can investigate how variable state-marker expressions are across clusters by setting `group_by = "cluster_id"` (to aggregate by both, samples and clusters) and `color_by = "condition"` (to additionally group samples by treatment). This type of visualization yields similar information as the plot above: We can observe that there are global shifts in expression for a set of markers (e.g., pNFkB, pp38), and rather subpopulation-specific changes for others (e.g., pS6).

```
plotPbExprs(sce, k = "meta6", features = "state",
    group_by = "cluster_id", color_by = "condition", ncol = 7)
```

![](data:image/png;base64...)

## 4.6 `plotClusterExprs`: Marker-densities by cluster

Distributions of marker intensities (arcsinh-transformed) across cell populations of interest can be plotted with `plotClusterExprs`. We specify `features = "type"` (equivalent to `type_markers(sce)`), to include type-markers only. Here, blue densities (top row) are calculated over all cells and serve as a reference.

```
plotClusterExprs(sce, k = "meta8", features = "type")
```

![](data:image/png;base64...)

## 4.7 `plotAbundances`: Relative population abundances

Relative population abundances for any clustering of interest can be plotted with `plotAbundances`. Argument `by` will specify whether to plot proportions for each sample or cluster; `group_by` determines the grouping within each panel as well ascolor coding.

* If `by = "sample_id"`, the function displays each sample’s cell type composition, and the size of a given stripe reflects the proportion of the corresponding cell type the given sample. Argument `group_by` then specifies the facetting.
* If `by = "cluster_id"`, argument `group_by` then specifies the grouping and color coding.

```
plotAbundances(sce, k = "meta12", by = "sample_id", group_by = "condition")
```

![](data:image/png;base64...)

```
plotAbundances(sce, k = "meta8", by = "cluster_id",
    group_by = "condition", shape_by = "patient_id")
```

![](data:image/png;base64...)

## 4.8 `plotFreqHeatmap`: Heatmap of cluster fequencies

Complementary to `plotAbundances`, a heatmap of relative cluster abundances by cluster can be generated with `plotFreqHeatmap`. By default (`normalize = TRUE`), frequencies will we standarized for each cluster, across samples. Analogous to `plotExprHeatmap` (Sec. [4.4](#plotExprHeatmap)), arguments `row/col_clust/dend` control hierarchical clustering or rows (clusters) and columns (samples), and whether the resulting dendrograms should be display; `k` specifies the clustering across which to compute abundances, and `m` a secondary clustering for display. Again, `bars` and `perc` can be used to include a labelled cell count barplot.

```
# complete example
plotFreqHeatmap(sce,
    k = "meta8", m = "meta5",
    hm_pal = rev(hcl.colors(10, "RdBu")),
    k_pal = hcl.colors(7, "Zissou 1"),
    m_pal = hcl.colors(4, "Temps"),
    bars = TRUE, perc = TRUE)
```

![](data:image/png;base64...)

```
# minimal example
plotFreqHeatmap(sce, k = "meta10",
    normalize = FALSE, bars = FALSE,
    row_anno = FALSE, col_anno = FALSE,
    row_clust = FALSE, col_clust = FALSE,
    hm_pal = c("grey95", "black"))
```

![](data:image/png;base64...)

## 4.9 `plotMultiHeatmap`: Multi-panel Heatmaps

`plotMultiHeatmap` provides flexible options to combine expression and cluster frequency heatmaps generated with `plotExprHeatmap` (Sec. [4.4](#plotExprHeatmap)) and `plotFreqHeatmap` (Sec. [4.8](#plotFreqHeatmap)), respectively, with arguments `hm1` and `hm2` controlling the panel contents.

**Panel contents**
In its 1st panel, `plotMultiHeatmap` will display pseudobulks by cluster. Here, `hm1` may be used to specify a set of markers (subset of `rownames(sce)`), or `"type"/"state"` for `type/state_markers(sce)` when `marker_classes(sce)` have been specified. The 1st heatmap can be turned off altogether by setting `hm1 = FALSE`.
Anologously, for `hm2 = "type"/"state"`, an expression heatmap of type-/state-markers will be displayed as 2nd heatmap (see Sec. [4.9.1](#plotMultiHeatmap-example1)). `hm2 = "abundances"` will render cluster frequencies by sample (see Sec. [4.9.2](#plotMultiHeatmap-example2)). As opposed to argument `hm1`, however, when `hm2` specifies one or multiple marker(s), a separate heatmap of pseudobulks by cluster-sample will be drawn for each marker (see Sec. [4.9.3](#plotMultiHeatmap-example3)).

**Row and column annotations**
The clustering to aggregate by is specified with argument `k`. Optionally, a metaclustering of interest may be provided via `m`; here, clustering `m` is merely included as an additional annotation (and not used for any computation). Thus, `m` serves to visually inspect the quality a lower-resolution clustering or manual merging.
When an x-axis corresponds to samples, `plotMultiHeatmap` will include column annotations for cell metadata variables (columns in `colData`) that map uniquely to each sample (e.g., condition, patient ID). These annotations can be omitted via `col_anno = FALSE`, or reduced (e.g., `col_anno = "condition"` to include only a single annotation); by default (`col_anno = TRUE`), all available metadata is included.

**Argument handling**
Most of `plotMultiHeatmap`’s arguments take a single value as input. For example, row annotations and dendrograms are automatically removed for all but the 1st panel. Nevertheless, a subset of arguments may be set uniquely for each heatmap; these are:

* `scale` and `q` controlling the scaling strategy for expression heatmaps
* `col_clust/dend` specifying whether or not to column-cluster each heatmap and draw the resulting dendrograms

When any of these arguments is of length one, the specified value will be recycled for both heatmaps. E.g., setting `scale = "never"` will have all expression heatmaps show unscaled data.

### 4.9.1 Ex. 1: Type- & state-markers

To demonstrate `plotMultiHeatmap`’s basic functionality and handling of arguments, we plot expression heatmaps for both type- (`hm1 = "type"`) and state-markers (`hm2 = "state"`), and choose to include a column dendrogram for the 2nd heatmap only:

```
# both, median type- & state-marker expressions
plotMultiHeatmap(sce,
    hm1 = "type", hm2 = "state",
    k = "meta12", m = "meta8",
    col_dend = c(FALSE, TRUE))
```

![](data:image/png;base64...)

### 4.9.2 Ex. 2: CDx markers & cluster frequencies

As a second example, we plot an expession heatmap for a selection of markers (here, those starting with “CD”: `hm1 = c("CDx", "CDy", ...`)444 `hm1 = NULL` would include *all* markers. next to the relative cluster abundances across samples (`hm2 = "abundances"`). We also add a barplot for the cell counts in each cluster (`bars = TRUE`) along with labels for their relative abundance (`perc = TRUE`):

```
# 1st: CDx markers by cluster;
# 2nd: population frequencies by sample
cdx <- grep("CD", rownames(sce), value = TRUE)
plotMultiHeatmap(sce, k = "meta6",
    hm1 = cdx, hm2 = "abundances",
    bars = TRUE, perc = TRUE, row_anno = FALSE)
```

![](data:image/png;base64...)

### 4.9.3 Ex. 3: Selected markers

In this final example, we view a selection of markers side-by-side, and omit the 1st panel (`hm1 = FALSE`). We also retain the ordering of samples (column order) across panels (`col_clust = FALSE`). In this case, `plotMultiHeatmap` will drop column names (sample IDs) for all but the first panel to avoid repeating these labels and overcrowding the plot. Lastly, we set `scale = "never"` to visualize *raw* (unscaled) pseudobulks (= median expressions by cluster-sample):

```
# plot selected markers side-by-side;
# omit left-hand side heatmap
plotMultiHeatmap(sce,
    k = "meta8", scale = "never",
    hm1 = FALSE, hm2 = c("pS6", "pp38", "pBtk"),
    row_anno = FALSE, col_clust = FALSE,
    hm2_pal = c("grey95", "black"))
```

![](data:image/png;base64...)

# 5 Dimensionality reduction

The number of cells in cytometry data is typically large, and for visualization of cells in a two-dimensional space it is often sufficient to run dimension reductions on a subset of the data. Thus, `CATALYST` provides the wrapper function `runDR` to apply any of the dimension reductions available from `BiocStyle::Biocpkg("scater")` using

1. the subset of features specified via argument `features`; either a subset of `rownames(.)` or, e.g., `"type"` for `type_markers(.)` (if `marker_classes(.)` have been specified).
2. the subset of cells specified via argument `cells`; either `NULL` for all cells, or `n` to sample a random subset of n cells per sample.

To make results reproducible, the random seed should be set via `set.seed` *prior* to computing reduced dimensions:

```
set.seed(1601)
sce <- runDR(sce, dr = "UMAP", cells = 500, features = "type")
```

Alternatively, dimension reductions can be computed using one of *[scater](https://bioconductor.org/packages/3.22/scater)*’s `runX` functions (`X = "TSNE", "UMAP", ...`). Note that, by default, `scater` expects expression values to be stored in the `logcounts` assay of the SCE; specification of `exprs_values = "exprs"` is thus required:

```
sce <- runUMAP(sce, exprs_values = "exprs")
```

DRs available within the SCE can be viewed via `reducedDimNames` and accessed with `reducedDim(s)`:

```
# view & access DRs
reducedDimNames(sce)
```

```
## [1] "UMAP"
```

```
head(reducedDim(sce, "UMAP"))
```

```
##            [,1]       [,2]
## [1,]  0.4334406 -2.0447120
## [2,] -3.6649808 -4.4617884
## [3,]  7.5133005  1.0810667
## [4,]  0.9780358 -2.0807892
## [5,] -3.2964105  0.4385978
## [6,]  3.2840014  0.7110685
```

While *[scater](https://bioconductor.org/packages/3.22/scater)*’s `plotReducedDim` function can be used to visualize DRs, `CATALYST` provides the `plotDR` wrapper, specifically to allow for coloring cells by the various clusterings available, and to support facetting by metadata factors (e.g., experimental condition, sample IDs):

```
# color by marker expression & split by condition
plotDR(sce, color_by = c("pS6", "pNFkB"), facet_by = "condition")
```

![](data:image/png;base64...)

```
# color by 8 metaclusters & split by sample ID
p <- plotDR(sce, color_by = "meta8", facet_by = "sample_id")
p$facet$params$ncol <- 4; p
```

![](data:image/png;base64...)

# 6 Filtering

SCEs constructed with `prepData` can be filtered using the `filterSCE` function, which allows for filtering of both cells and markers according to conditional statements in `dplyr`-style. When filtering on `cluster_id`s, argument `k` specifies which clustering to use (the default `NULL` uses `colData` column `"cluster_id"`). Two examples are given below:

```
u <- filterSCE(sce, patient_id == "Patient1")
table(u$sample_id)
```

```
##
##   Ref1 BCRXL1
##    881    528
```

```
u <- filterSCE(sce, k = "meta8",
    cluster_id %in% c(1, 3, 8))
plot_grid(
    plotDR(sce, color_by = "meta8"),
    plotDR(u, color_by = "meta8"))
```

![](data:image/png;base64...)

# 7 Differental testing with *[diffcyt](https://bioconductor.org/packages/3.22/diffcyt)*

*[CATALYST](https://bioconductor.org/packages/3.22/CATALYST)* has been designed to be compatible with the *[diffcyt](https://bioconductor.org/packages/3.22/diffcyt)* package (Weber et al. [2019](#ref-Weber2019-diffcyt)), which implements statistical methods for differential discovery in high-dimensional cytometry (including flow cytometry, mass cytometry or CyTOF, and oligonucleotide-tagged cytometry) using high-resolution clustering and moderated tests. The input to the *[diffcyt](https://bioconductor.org/packages/3.22/diffcyt)* pipeline can either be raw data, or a `SingleCellExperiment` object. We give an exmaple of the latter below.
Please refer to the *[diffcyt](https://bioconductor.org/packages/3.22/diffcyt)* [vignette](https://bioconductor.org/packages/3.7/bioc/vignettes/diffcyt/inst/doc/diffcyt_workflow.html) and R documentation (`??diffcyt`) for more detailed information.

```
# create design & contrast matrix
design <- createDesignMatrix(ei(sce), cols_design = "condition")
contrast <- createContrast(c(0, 1))

# test for
# - differential abundance (DA) of clusters
# - differential states (DS) within clusters
res_DA <- diffcyt(sce, clustering_to_use = "meta10",
    analysis_type = "DA", method_DA = "diffcyt-DA-edgeR",
    design = design, contrast = contrast, verbose = FALSE)
res_DS <- diffcyt(sce, clustering_to_use = "meta10",
    analysis_type = "DS", method_DS = "diffcyt-DS-limma",
    design = design, contrast = contrast, verbose = FALSE)

# extract result tables
tbl_DA <- rowData(res_DA$res)
tbl_DS <- rowData(res_DS$res)
```

## 7.1 `plotDiffHeatmap`: Heatmap of differential testing results

Differential testing results returned by *[diffcyt](https://bioconductor.org/packages/3.22/diffcyt)* can be displayed with the `plotDiffHeatmap` function.

For differential abundance (DA) tests, `plotDiffHeatmap` will display relative cluster abundances by samples; for differential state (DS) tests, `plotDiffHeatmap` will display aggregated marker expressions by sample.

**Filtering**
The results to retain for visualization can be filtered via

* `fdr`: threshold on adjusted p-values *below* which to keep a result
* `lfc`: threshold on absolute logFCs *above* which to keep a result

The number of top findings to display can be specified with `top_n` (default 20). When `all = TRUE`, significance and logFC filtering will be skipped, and all `top_n` results are shown.

**Annotations**
Analogous to `plotFreq/Expr/MuliHeatmap`, when `col_anno = TRUE`, `plotDiffHeatmap` will include column annotations for cell metadata variables (columns in `colData`) that map uniquely to each sample (e.g., condition, patient ID). These annotations can be omitted via `col_anno = FALSE`, or reduced (e.g., `col_anno = "condition"` to include only a single annotation).
When `row_anno = TRUE`, cluster (DA) and cluster-marker instances (DS) will be marked as *significant* if their adjusted p-value falls below the threshold value specified with `fdr`. A second annotation will be drawn for the logFCs.

**Normalization**
When `normalize = TRUE`, the heatmap will display Z-score normalized values. For DA, cluster frequencies will be arcsine-square-root scaled prior to normalization. While losing information on absolution frequency/expression values, this option will make differences across samples and conditions more notable.

## 7.2 Ex. 1: DA testing results

We here set `all = TRUE` to display top-20 DA analysis results, without filtering on adjusted p-values and logFCs. Since differential testing was performed on 10 clusters only, this will simply include all available results.
By setting `fdr = 0.05` despite not filtering on significance, we can control the right-hand side annotation:

```
plotDiffHeatmap(sce, tbl_DA, all = TRUE, fdr = 0.05)
```

![](data:image/png;base64...)

## 7.3 Ex. 2: DS testing results

Via setting `fdr = 0.05`, we here display the top DS analysis results in terms of significance. Alternative to the example above, we sort these according their logFCs (`sort_by = "lfc"`), and include only a selected sample annotation (`col_anno = "condition"`):

```
plotDiffHeatmap(sce, tbl_DS, fdr = 0.05,
    sort_by = "lfc", col_anno = "condition")
```

![](data:image/png;base64...)

## 7.4 Ex. 3: Filtering results

As an alternative to leaving the selection of markers and clusters to their ordering (significance), we can visualize a specific subset of results (e.g., a selected marker or cluster) using `filterSCE`:

```
# include all results for selected marker
plotDiffHeatmap(sce["pp38", ], tbl_DS, all = TRUE, col_anno = FALSE)
```

![](data:image/png;base64...)

```
# include all results for selected cluster
k <- metadata(res_DS$res)$clustering_name
sub <- filterSCE(sce, cluster_id == 8, k = k)
plotDiffHeatmap(sub, tbl_DS, all = TRUE, normalize = FALSE)
```

![](data:image/png;base64...)

## 7.5 Ex. 4: Customizing appearance

Heatmap and annotation colors are controlled via arguments `hm_pal` and `fdr/lfc_pal`, respectively. Here’s an example how these can be modified:

```
plotDiffHeatmap(sce, tbl_DA, all = TRUE, col_anno = FALSE,
    hm_pal = c("gold", "white", "navy"),
    fdr_pal = c("grey90", "grey50"),
    lfc_pal = c("red3", "grey90", "green3"))
```

![](data:image/png;base64...)

# 8 More

## 8.1 Exporting FCS files

Conversion from SCE to `flowFrame`s/`flowSet`, which in turn can be writting to FCS files using *[flowCore](https://bioconductor.org/packages/3.22/flowCore)*’s `write.FCS` function, is not straightforward. It is not recommended to directly write FCS via `write.FCS(flowFrame(t(assay(sce))))`, as this can lead to invalid FCS files or the data being shown on an inappropriate scale in e.g. Cytobank. Instead, `CATALYST` provides the `sce2fcs` function to facilitate correct back-conversion.

`sce2fcs` allows specification of a `colData` column to split the SCE by (argument `split_by`), e.g., to split the data by cluster; whether to keep or drop any cell metadata (argument `keep_cd`) and dimension reductions (argument `keep_dr`) available within the object; and which assay data to use (argument `assay`)555 Only count-like data should be written to FCS files and is guaranteed to show with appropriate scale in Cytobank!:

```
# store final clustering in cell metadata
sce$mm <- cluster_ids(sce, "merging1")
# convert to 'flowSet' with one frame per cluster
(fs <- sce2fcs(sce, split_by = "mm"))
```

```
## A flowSet with 8 experiments.
##
## column names(24): CD3(110:114)Dd CD45(In115)Dd ... HLA-DR(Yb174)Dd
##   CD7(Yb176)Dd
```

```
# split check: number of cells per barcode ID
# equals number of cells in each 'flowFrame'
all(c(fsApply(fs, nrow)) == table(sce$mm))
```

```
## [1] TRUE
```

```
# store identifiers (= cluster names)
(ids <- c(fsApply(fs, identifier)))
```

```
## [1] "B-cells IgM+" "B-cells IgM-" "CD4 T-cells"  "CD8 T-cells"  "DC"
## [6] "NK cells"     "monocytes"    "surface-"
```

Having converted out SCE to a `flowSet`, we can write out each of its `flowFrame`s to an FCS file with a meaningful filename that retains the cluster of origin:

```
for (id in ids) {
    # subset 'flowFrame' for cluster 'id'
    ff <- fs[[id]]
    # specify output name that includes ID
    fn <- sprintf("manuel_merging_%s.fcs", id)
    # construct output path
    fn <- file.path("...", fn)
    # write frame to FCS
    write.FCS(ff, fn)
}
```

## 8.2 Using other clustering algorithms

While *[FlowSOM](https://bioconductor.org/packages/3.22/FlowSOM)* has proven to perform well in systematic comparisons of clustering algorithms for CyTOF data (Weber and Robinson [2016](#ref-Weber2016-clustering); Freytag et al. [2018](#ref-Freytag2018-clustering)), it is not the only method out there. Here we demonstrate how clustering assignments from another clustering method, say, *[Rphenograph](https://github.com/JinmiaoChenLab)*, could be incorporated into the SCE to make use of the visualizations available in `CATALYST`. Analogous to the example below, virtually any clustering algorithm could be applied, however, with the following **limitation**:

The `ConsensusClusterPlus` metaclusterings applied to the initial `FlowSOM` clustering by `CATALYST`’s `cluster` function have a hierarchical cluster structure. Thus, clustering IDs can be matched from a higher resolution (e.g. 100 SOM clusters) to any lower resolution (e.g., 2 through 20 metaclusters). This is not guaranteed for other clustering algorithms. Thus, we store only a single resolution in the cell metadata column `cluster_id`, and a single column under `metadata` slot `cluster_codes` containing the unique cluster IDs. Adding additional resolutions to the `cluster_codes` will fail if cluster IDs can not be matched uniquely across conditions, which will be the case for any non-hierarchical clustering method.

```
# subset type-marker expression matrix
es <- assay(sce, "exprs")
es <- es[type_markers(sce), ]

# run clustering method X
# (here, we just split the cells into
# equal chunks according to CD33 expression)
cs <- split(seq_len(ncol(sce)), cut(es["CD33", ], nk <- 10))
kids <- lapply(seq_len(nk), function(i) {
    rep(i, length(cs[[i]]))
})
kids <- factor(unlist(kids))

# store cluster IDs in cell metadata & codes in metadata
foo <- sce
foo$cluster_id[unlist(cs)] <- unlist(kids)
metadata(foo)$cluster_codes <- data.frame(
    custom = factor(levels(kids), levels = levels(kids)))

# tabulate cluster assignments
table(cluster_ids(foo, "custom"))
```

```
##
##    1    2    3    4    5    6    7    8    9   10
##    5   34  427 3326  611  436  335  176   64   14
```

## 8.3 Customizing visualizations

Most of `CATALYST`’s plotting functions return `ggplot` objects whose aesthetics can (in general) be modified easily. However, while e.g. theme aesthetics and color scales can simply be added to the plot, certain modifications can be achieved only through overwriting elements stored in the object, and thus require a decent understanding of its structure.

Other functions (`plotExprHeatmap`, `plotMultiHeatmap` and `plotDiffHeatmap`) generate objects of the `Heatmap` of `HeatmapList` class from the *[ComplexHeatmap](https://bioconductor.org/packages/3.22/ComplexHeatmap)* package, and are harder to modify once created. Therefore, `CATALYST` tries to expose a reasonable amount of arguments to the user that control key aesthetics such as the palettes used for coloring clusters and heatmaps.

The examples below serve to illustrate how some less exposed `ggplot` aesthetics can be modified in retrospect, and the effects of different arguments that control visualization of *[ComplexHeatmap](https://bioconductor.org/packages/3.22/ComplexHeatmap)* outputs.

### 8.3.1 Modifying `ggplot`s

```
p <- plotPbExprs(sce, k = "meta4", facet_by = "cluster_id")
# facetting layout is 2x2; plot all side-by-side instead
p$facet$params$nrow <- 1
# remove points
p$layers <- p$layers[-1]
# overwrite default colors
p <- p + scale_color_manual(values = c("royalblue", "orange"))
# remove x-axis title, change angle & decrease size of labels
(p + labs(x = NULL) + theme(axis.text.x = element_text(angle = 90, size = 8, vjust = 0.5)))
```

```
## Ignoring unknown labels:
## • fill : "condition"
```

![](data:image/png;base64...)

### 8.3.2 Modifying `ComplexHeatmap`s

```
plotMultiHeatmap(sce,
    k = "meta8",
    m = "meta4",
    hm2 = "abundances",
    # include all dendrograms
    row_dend = TRUE,
    col_dend = TRUE,
    # exclude sample annotations
    col_anno = FALSE,
    # primary & merging cluster palettes
    k_pal = hcl.colors(8, "Vik"),
    m_pal = hcl.colors(4, "Tropic"),
    # 1st & 2nd heatmap coloring
    hm1_pal = c("grey95", "blue"),
    hm2_pal = c("grey95", "red3"))
```

![](data:image/png;base64...)

```
# minimal heatmap
plotExprHeatmap(sce,
    row_anno = FALSE,   # don't annotate samples
    row_clust = FALSE,  # keep samples in original order
    col_clust = FALSE,  # keep markers in original order
    bin_anno = FALSE,   # don't annotate bins
    bars = FALSE,       # don't include sample sizes
    scale = "last",     # aggregate, then scale
    hm_pal = hcl.colors(10, "YlGnBu", rev = TRUE))
```

![](data:image/png;base64...)

```
# complete heatmap
plotExprHeatmap(sce, row_anno = TRUE,   # annotate samples
    row_clust = TRUE, col_clust = TRUE, # cluster samples/markers
    row_dend = TRUE, col_dend = TRUE,   # include dendrograms
    bin_anno = TRUE,          # annotate bins with value
    bars = TRUE, perc = TRUE, # include barplot of sample sizes
    hm_pal = c("grey95", "orange"))
```

![](data:image/png;base64...)

## 8.4 Combining `ComplexHeatmap`s

While `plotMultiHeatmap` provides a convenient way to combine pseudoublk expression heatmaps across clusters or cluster-sample combinations with heatmaps of relative cluster abundances, `Heatmap` objects can be, in principle, combined arbitrarily with a few notes of caution:

1. each `Heatmap` should use the same clustering for aggregation (argument `k`).
2. each `Heatmap` should have unique identifier (slot `@name`); otherwise, a warning is given.
3. each `Heatmap`’s legend should have a unique title (slot `@matrix_color_mapping@name`);
   otherwise, legends with a title that is already in use will be dropped.

### 8.4.1 Ex. 1: type- & state-markers + cluster frequencies

```
# specify clustering to aggregate by
k <- "meta11"

# median type-marker expression by cluster
p1 <- plotExprHeatmap(sce, features = "type",
    by = "cluster_id", k = k, m = "meta7")

# median state-marker expression by cluster
p2 <- plotExprHeatmap(sce, features = "state",
    by = "cluster_id", k = k, row_anno = FALSE)

# relative cluster abundances by sample
p3 <- plotFreqHeatmap(sce, k = k, perc = TRUE,
    row_anno = FALSE, col_clust = FALSE)

# make legend titles unique
p1@name <- p1@matrix_color_mapping@name <- "type"
p2@name <- p2@matrix_color_mapping@name <- "state"

p1 + p2 + p3
```

![](data:image/png;base64...)

### 8.4.2 Ex. 2: frequencies + selected markers + all markers

```
# specify clustering to aggregate by
k <- "meta9"

# relative cluster abundances by sample
p <- plotFreqHeatmap(sce, k = k,
    bars = FALSE, hm_pal = c("white", "black"),
    row_anno = FALSE, col_clust = FALSE, col_anno = FALSE)

# specify unique coloring
cs <- c(pp38 = "maroon", pBtk = "green4")

# median expression of selected markers by cluster-sample
for (f in names(cs)) {
    q <- plotExprHeatmap(sce, features = f,
        by = "both", k = k, scale = "never",
        row_anno = FALSE, col_clust = FALSE,
        hm_pal = c("white", cs[f]))
    # make identifier & legend title unique
    q@name <- q@matrix_color_mapping@name <- f
    # remove column annotation names
    for (i in seq_along(q@top_annotation@anno_list))
        q@top_annotation@anno_list[[i]]@name_param$show <- FALSE
    # remove redundant sample names
    q@column_names_param$show <- FALSE
    p <- p + q
}

# add heatmap of median expression across all features
p + plotExprHeatmap(sce, features = NULL,
    by = "cluster_id", k = k, row_anno = FALSE)
```

![](data:image/png;base64...)

# 9 Session information

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
##  [1] scater_1.38.0               ggplot2_4.0.1
##  [3] scuttle_1.20.0              diffcyt_1.30.0
##  [5] flowCore_2.22.0             cowplot_1.2.0
##  [7] CATALYST_1.34.1             SingleCellExperiment_1.32.0
##  [9] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [11] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [13] IRanges_2.44.0              S4Vectors_0.48.0
## [15] BiocGenerics_0.56.0         generics_0.1.4
## [17] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [19] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          jsonlite_2.0.0
##   [3] shape_1.4.6.1               magrittr_2.0.4
##   [5] magick_2.9.0                TH.data_1.1-5
##   [7] ggbeeswarm_0.7.2            nloptr_2.2.1
##   [9] farver_2.1.2                rmarkdown_2.30
##  [11] GlobalOptions_0.1.2         vctrs_0.6.5
##  [13] Cairo_1.7-0                 minqa_1.2.8
##  [15] tinytex_0.58                rstatix_0.7.3
##  [17] htmltools_0.5.8.1           S4Arrays_1.10.0
##  [19] plotrix_3.8-13              BiocNeighbors_2.4.0
##  [21] broom_1.0.10                SparseArray_1.10.2
##  [23] Formula_1.2-5               sass_0.4.10
##  [25] bslib_0.9.0                 plyr_1.8.9
##  [27] sandwich_3.1-1              zoo_1.8-14
##  [29] cachem_1.1.0                igraph_2.2.1
##  [31] lifecycle_1.0.4             iterators_1.0.14
##  [33] pkgconfig_2.0.3             rsvd_1.0.5
##  [35] Matrix_1.7-4                R6_2.6.1
##  [37] fastmap_1.2.0               rbibutils_2.4
##  [39] clue_0.3-66                 digest_0.6.39
##  [41] colorspace_2.1-2            ggnewscale_0.5.2
##  [43] RSpectra_0.16-2             irlba_2.3.5.1
##  [45] ggpubr_0.6.2                beachmat_2.26.0
##  [47] labeling_0.4.3              cytolib_2.22.0
##  [49] colorRamps_2.3.4            nnls_1.6
##  [51] polyclip_1.10-7             abind_1.4-8
##  [53] compiler_4.5.2              withr_3.0.2
##  [55] doParallel_1.0.17           ConsensusClusterPlus_1.74.0
##  [57] S7_0.2.1                    backports_1.5.0
##  [59] BiocParallel_1.44.0         carData_3.0-5
##  [61] viridis_0.6.5               ggforce_0.5.0
##  [63] ggsignif_0.6.4              MASS_7.3-65
##  [65] drc_3.0-1                   DelayedArray_0.36.0
##  [67] rjson_0.2.23                FlowSOM_2.18.0
##  [69] gtools_3.9.5                tools_4.5.2
##  [71] vipor_0.4.7                 beeswarm_0.4.0
##  [73] glue_1.8.0                  nlme_3.1-168
##  [75] grid_4.5.2                  Rtsne_0.17
##  [77] cluster_2.1.8.1             reshape2_1.4.5
##  [79] gtable_0.3.6                tidyr_1.3.1
##  [81] data.table_1.17.8           utf8_1.2.6
##  [83] BiocSingular_1.26.1         ScaledMatrix_1.18.0
##  [85] car_3.1-3                   XVector_0.50.0
##  [87] ggrepel_0.9.6               foreach_1.5.2
##  [89] pillar_1.11.1               stringr_1.6.0
##  [91] limma_3.66.0                circlize_0.4.16
##  [93] splines_4.5.2               dplyr_1.1.4
##  [95] tweenr_2.0.3                lattice_0.22-7
##  [97] FNN_1.1.4.1                 survival_3.8-3
##  [99] RProtoBufLib_2.22.0         tidyselect_1.2.1
## [101] locfit_1.5-9.12             ComplexHeatmap_2.26.0
## [103] knitr_1.50                  reformulas_0.4.2
## [105] gridExtra_2.3               bookdown_0.45
## [107] edgeR_4.8.0                 xfun_0.54
## [109] statmod_1.5.1               stringi_1.8.7
## [111] boot_1.3-32                 yaml_2.3.10
## [113] evaluate_1.0.5              codetools_0.2-20
## [115] tibble_3.3.0                BiocManager_1.30.27
## [117] cli_3.6.5                   uwot_0.2.4
## [119] Rdpack_2.6.4                jquerylib_0.1.4
## [121] dichromat_2.0-0.1           Rcpp_1.1.0
## [123] png_0.1-8                   XML_3.99-0.20
## [125] parallel_4.5.2              lme4_1.1-37
## [127] viridisLite_0.4.2           mvtnorm_1.3-3
## [129] scales_1.4.0                ggridges_0.5.7
## [131] purrr_1.2.0                 crayon_1.5.3
## [133] GetoptLong_1.0.5            rlang_1.1.6
## [135] multcomp_1.4-29
```

# References

Bodenmiller, Bernd, Eli R Zunder, Rachel Finck, Tiffany J Chen, Erica S Savig, Robert V Bruggner, Erin F Simonds, et al. 2012. “Multiplexed Mass Cytometry Profiling of Cellular States Perturbed by Small-Molecule Regulators.” *Nature Biotechnology* 30 (9): 858–67.

Bruggner, Robert V, Bernd Bodenmiller, David L Dill, Robert J Tibshirani, and Garry P Nolan. 2014. “Automated Identification of Stratifying Signatures in Cellular Subpopulations.” *PNAS* 111 (26): E2770–7.

Freytag, Saskia, Luyi Tian, Ingrid Lönnstedt, Milica Ng, and Melanie Bahlo. 2018. “Comparison of Clustering Tools in R for Medium-Sized 10x Genomics Single-Cell RNA-sequencing Data.” *F1000Research* 7: 1297.

Monti, Stefano, Pablo Tamayo, Jill Mesirov, and Todd Golub. 2003. “Consensus Clustering: A Resampling-Based Method for Class Discovery and Visualization of Gene Expression Microarray Data.” *Machine Learning* 52 (1): 91–118.

Nowicka, Malgorzata, Carsten Krieg, Helena L Crowell, Lukas M Weber, Felix J Hartmann, Silvia Guglietta, Burkhard Becher, Mitchell P Levesque, and Mark D Robinson. 2019. “CyTOF Workflow: Differential Discovery in High-Throughput High-Dimensional Cytometry Datasets.” *F1000Research* 6: 748.

Weber, Lukas M, Malgorzata Nowicka, Charlotte Soneson, and Mark D Robinson. 2019. “Diffcyt: Differential Discovery in High-Dimensional Cytometry via High-Resolution Clustering.” *Communications Biology* 2: 183.

Weber, Lukas M, and Mark D Robinson. 2016. “Comparison of Clustering Methods for High-Dimensional Single-Cell Flow and Mass Cytometry Data.” *Cytometry A* 89 (12): 1084–96.