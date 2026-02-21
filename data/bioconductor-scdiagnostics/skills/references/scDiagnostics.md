# Getting Started with `scDiagnostics`

Anthony Christidis1, Andrew Ghazi1, Smriti Chawla1, Nitesh Turaga1, Ludwig Geistlinger1 and Robert Gentleman1

1Core for Computational Biomedicine, Harvard Medical School

#### 30 October 2025

#### Package

scDiagnostics 1.4.0

# 1 Purpose

Annotation transfer from a reference dataset is a key process for
annotating cell types in new single-cell RNA-sequencing (scRNA-seq)
experiments. This approach provides a quick, automated, and reproducible
alternative to manual annotation based on marker gene expression.
Despite its advantages, challenges such as dataset imbalance and
unrecognized discrepancies between query and reference datasets can lead
to inaccurate annotations and affect subsequent analyses.

The `scDiagnostics` package is designed to address these issues by
offering a suite of diagnostic tools for the systematic evaluation of
cell type assignments in scRNA-seq data. It provides functionality to
assess whether query and reference datasets are well-aligned, which is
crucial for ensuring accurate annotation transfer. In addition,
`scDiagnostics` helps evaluate annotation ambiguity, cluster
heterogeneity, and marker gene alignment. By providing insights into
these aspects, `scDiagnostics` enables researchers to determine the
precision with which cells from a new scRNA-seq experiment can be
assigned to known cell types, thereby supporting more accurate and
reliable downstream analysis.

# 2 Installation

## 2.1 Installation from Bioconductor (Release)

Users interested in using the stable release version of the `scDiagnostics` package: please follow the installation instructions [**here**](https://bioconductor.org/packages/release/bioc/html/scDiagnostics.html). This is the recommended way of installing the package.

## 2.2 Installation from GitHub (Development)

To install the development version of the package from Github, use the
following command:

```
BiocManager::install("ccb-hms/scDiagnostics")
```

To build the package vignettes upon installation use:

```
BiocManager::install("ccb-hms/scDiagnostics",
                     build_vignettes = TRUE,
                     dependencies = TRUE)
```

Once you have installed the package, you can load it with the following
code:

```
library(scDiagnostics)
```

# 3 Preliminaries

To explore the full capabilities of the `scDiagnostics` package, you
have the option to use your own data or leverage the datasets included
within the `scDiagnostics` package itself. In this guide, we will focus
on utilizing these built-in datasets, which provide a practical and
convenient resource for demonstrating the features of `scDiagnostics.`
These datasets are specifically designed to facilitate the exploration
of the package’s functionalities and to help evaluate the accuracy of
cell type assignments. You can learn more about the datasets by looking
at the documentation of the datasets available in the reference manual.

## 3.1 Loading Datasets

In these datasets available in the `scDiagnostics` package,
`reference_data`, `query_data`, and `qc_data` are all
*[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* objects that include a
`logcounts` assay, which stores the log-transformed expression values
for the genes.

The `reference_data` and `query_data` objects both originate from
scRNA-seq experiments on hematopoietic tissues, specifically bone marrow
samples, as provided by the *[scRNAseq](https://bioconductor.org/packages/3.22/scRNAseq)* package.
These datasets have undergone comprehensive processing and cleaning,
ensuring high-quality data for downstream analysis. Log-normalized
counts were added to both datasets using the
*[scuttle](https://bioconductor.org/packages/3.22/scuttle)* package. The `query_data` object has
been further annotated with cell type assignments using the
*[SingleR](https://bioconductor.org/packages/3.22/SingleR)* package, and it includes
`annotation_scores` that reflect the confidence in these annotations.
Additionally, gene set scores were computed and incorporated into the
`query_data` using the *[AUCell](https://bioconductor.org/packages/3.22/AUCell)* package. For
feature selection, the top 500 highly variable genes (HVGs) common to
both datasets were identified and retained using the
*[scran](https://bioconductor.org/packages/3.22/scran)* package. Finally, dimensionality
reduction techniques including PCA, t-SNE, and UMAP were applied to both
datasets, with the results stored within each object using the
*[scater](https://bioconductor.org/packages/3.22/scater)* package.

The `qc_data` dataset in this package is derived from the `hpca` dataset
available in the *[celldex](https://bioconductor.org/packages/3.22/celldex)* package. Like the
other datasets, `qc_data` has undergone significant cleaning and
processing to ensure high data quality. Quality control (QC) metrics
were added using the *[scuttle](https://bioconductor.org/packages/3.22/scuttle)* package. Cell
type annotations and associated annotation\_scores were generated using
the *[SingleR](https://bioconductor.org/packages/3.22/SingleR)* package. Additionally, the top
highly variable genes were selected using the
*[scran](https://bioconductor.org/packages/3.22/scran)* package to enhance the dataset’s utility
for downstream analyses.

```
# Load datasets
data("reference_data")
data("query_data")
data("qc_data")

# Set seed for reproducibility
set.seed(0)
```

The `reference_data` contains a column data labeled `expert_annotation`,
which provides cell type annotations assigned by experts. On the other
hand, `query_data` also includes `expert_annotation`, but it
additionally features `SingleR_annotation`, which is the cell type
annotation generated by the *[SingleR](https://bioconductor.org/packages/3.22/SingleR)* package, a
popular package for cell type assignment based on reference datasets.
The `qc_data` object contains a special column called
`annotation_scores`, which holds the scores from the `SingleR`
annotations, providing a measure of confidence or relevance for the
assigned cell types.

By working with these datasets, you can gain hands-on experience with
the various diagnostic tools and functions offered by `scDiagnostics`,
allowing you to better understand how well it aligns query and reference
datasets, assesses annotation ambiguity, and evaluates cluster
heterogeneity and marker gene alignment.

## 3.2 Subsetting the Datasets

Some functions in the vignette are designed to work with
*[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* objects that contain data
from only one cell type. We will create separate
*[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* objects that only CD4
cells, to ensure compatibility with these functions.

```
# Load library
library(scran)
library(scater)

# Subset to CD4 cells
ref_data_cd4 <- reference_data[, which(
    reference_data$expert_annotation == "CD4")]
query_data_cd4 <- query_data_cd4 <- query_data[, which(
    query_data$expert_annotation == "CD4")]

# Select highly variable genes
ref_top_genes <- getTopHVGs(ref_data_cd4, n = 500)
query_top_genes <- getTopHVGs(query_data_cd4, n = 500)
common_genes <- intersect(ref_top_genes, query_top_genes)

# Subset data by common genes
ref_data_cd4 <- ref_data_cd4[common_genes,]
query_data_cd4 <- query_data_cd4[common_genes,]

# Run PCA on both datasets
ref_data_cd4 <- runPCA(ref_data_cd4)
query_data_cd4 <- runPCA(query_data_cd4)
```

# 4 Getting Started with `scDiagnostics`

**The functions introduced in this section represent just a subset of
the functions available in the `scDiagnostics` package.**

For a complete overview and detailed demonstrations of all the functions
included in the package, please refer to the designated vignettes which
you may browse from the [pkgdown site for
`scDiagnostics`](https://ccb-hms.github.io/scDiagnostics/). Each
vignette is designed to address specific aspects of `scDiagnostics`, and
this vignette highlights key functionalities to illustrate their
applications. These vignettes provide in-depth guidance and examples for
each function, helping users fully leverage the capabilities of
`scDiagnostics` in their single-cell analyses.

# 5 Visualization of Cell Type Annotations

For a detailed example of all possible functions to visualize reference
and query datasets, please refer to the [Visualization of Cell Type
Annotations](https://ccb-hms.github.io/scDiagnostics/articles/VisualizationTools.html)
vignette.

## 5.1 Visualization of Cell Type Annotations in Reduced Dimensions

### 5.1.1 `plotCellTypePCA()`

The `plotCellTypePCA()` function provides a visual comparison of
principal components (PCs) for different cell types across query and
reference datasets. By projecting the query data onto the PCA space of
the reference dataset, it creates informative plots to help you
understand how various cell types are distributed in the principal
component space.

```
# Plot PCA data
pc_plot <- plotCellTypePCA(
    query_data = query_data,
    reference_data = reference_data,
    cell_types = c("CD4", "CD8", "B_and_plasma", "Myeloid"),
    query_cell_type_col = "expert_annotation",
    ref_cell_type_col = "expert_annotation",
    pc_subset = 1:3
)
# Display plot
pc_plot
#> Picking joint bandwidth of 0.522
#> Picking joint bandwidth of 0.513
#> Picking joint bandwidth of 0.472
```

![](data:image/png;base64...)

The function returns a `ggplot` object featuring pairwise scatter plots
of the selected principal components. Each plot compares how different
cell types from the query and reference datasets project onto the PCA
space. This visualization aids in identifying how cell types distribute
across PCs and facilitates comparisons between datasets.

The `reference_data` argument contains the reference cell data, which
serves as the foundation for defining the PC space. The `query_data`
parameter includes the query cell data that will be projected. The
function uses the `ref_cell_type_col` and `query_cell_type_col` to
identify the relevant cell type annotations in the reference and query
datasets.

### 5.1.2 `calculateDiscriminantSpace()`

Alternatively, you can also use the `calculateDiscriminantSpace()`
function, which projects query single-cell RNA-seq data onto a
discriminant space defined by a reference dataset. This approach helps
evaluate the similarity between the query and reference data, offering
insights into the classification of query cells.

```
disc_output <- calculateDiscriminantSpace(
    reference_data = reference_data,
    query_data = query_data,
    ref_cell_type_col = "expert_annotation",
    query_cell_type_col = "SingleR_annotation"
)
```

The function returns a comprehensive output that includes discriminant
eigenvalues and eigenvectors, which represent the variance explained by
each discriminant axis and are used to project the data. It also
provides the projections of the reference and query data onto the
discriminant space. The Mahalanobis distances between the query and
reference cell types are calculated, offering insights into how close
the query projections are to the reference. The cosine similarity scores
provide another metric to assess the similarity between the datasets.

```
plot(disc_output, plot_type = "scatterplot")
#> Picking joint bandwidth of 0.117
#> Picking joint bandwidth of 0.162
#> Picking joint bandwidth of 0.169
```

![](data:image/png;base64...)

Alternatively, you can create a boxplot comparing query and reference
projections for a specific cell type. See the reference manual for an
example.

## 5.2 Visualization of Marker Expressions

Visualizing gene expression distributions is crucial for understanding
dataset similarity and cell type-specific expression patterns. The
`plotMarkerExpression()` function allows you to compare the expression
levels of a specific gene between a reference dataset and a query
dataset, both overall and within a specified cell type. This comparison
is done using density plots, which help in assessing the alignment and
potential discrepancies between datasets.

```
plotMarkerExpression(reference_data = reference_data,
                     query_data = query_data,
                     ref_cell_type_col = "expert_annotation",
                     query_cell_type_col = "SingleR_annotation",
                     gene_name = "VPREB3",
                     cell_type = "B_and_plasma")
#> Picking joint bandwidth of 0.324
#> Picking joint bandwidth of 0.234
```

![](data:image/png;base64...)

## 5.3 Visualization of QC and Annotation Scores

The scatter plot illustrates the relationship between key QC metrics
(e.g., total library size, percentage of mitochondrial genes) and cell
type annotation scores. This visualization aids in assessing how QC
factors might influence or correlate with the assigned cell type
annotations.

```
# Remove cell types with very few cells
qc_data_subset <- qc_data[, !(qc_data$SingleR_annotation
                              %in% c("Chondrocytes", "DC",
                                     "Neurons","Platelets"))]

# Generate scatter plot
library(ggplot2)
p1 <- plotQCvsAnnotation(sce_object = qc_data_subset,
                         cell_type_col = "SingleR_annotation",
                         qc_col = "total",
                         score_col = "annotation_scores")
p1 + xlab("Library Size")
```

![](data:image/png;base64...)

This scatter plot can uncover patterns, such as whether cells with
larger library sizes or higher mitochondrial content are linked to
specific annotations. For example, cells exhibiting unusually high
mitochondrial content may be flagged as low-quality or stressed, which
could impact their annotation accuracy.

# 6 Evaluation of Dataset and Marker Gene Alignment

For a detailed example of all possible functions to assess the alignment
of datasets and marker genes, please refer to the [Evaluation of Dataset
and Marker Gene
Alignment](https://ccb-hms.github.io/scDiagnostics/articles/https%3A//ccb-hms.github.io/scDiagnostics/articles/DatasetAlignment.html)
vignette.

## 6.1 `comparePCASubspace()`

In single-cell RNA-seq analysis, evaluating how closely the subspaces
defined by the leading principal components (PCs) of query and reference
datasets match is crucial. This evaluation is key to understanding how
each dataset captures and represents structure and variation. The
`comparePCASubspace()` function is specifically designed to assess this
alignment by calculating the cosine similarity between the loadings of
the most significant variables for each principal component. This
analysis is essential for measuring the extent of similarity between
datasets, which is vital for precise cell type annotation and effective
data integration.

```
# Compare PCA subspaces between query and reference data
subspace_comparison <- comparePCASubspace(
    query_data = query_data_cd4,
    reference_data = ref_data_cd4,
    query_cell_type_col = "expert_annotation",
    ref_cell_type_col = "expert_annotation",
    pc_subset = 1:5
)

# View weighted cosine similarity score
subspace_comparison$weighted_cosine_similarity
#> [1] 0.2609384

# Plot output for PCA subspace comparison (if a plot method is available)
plot(subspace_comparison)
```

![](data:image/png;base64...)

## 6.2 `plotPairwiseDistancesDensity()`

The `plotPairwiseDistancesDensity()` function calculates and visualizes
pairwise distances or correlations between cell types in query and
reference datasets, aiding in the evaluation of cell type annotation
consistency in single-cell RNA sequencing (scRNA-seq) analysis.
Operating on *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* objects, it
allows users to specify cell types of interest and compute either
distances or correlation coefficients, with the option to project data
into PCA space for focused analysis. The function generates a density
plot using `ggplot2`, comparing cell relationships within and between
datasets.

```
# Example usage of the function
plotPairwiseDistancesDensity(query_data = query_data,
                             reference_data = reference_data,
                             query_cell_type_col = "expert_annotation",
                             ref_cell_type_col = "expert_annotation",
                             cell_type = "CD8",
                             pc_subset = 1:10,
                             distance_metric = "correlation",
                             correlation_method = "pearson")
```

![](data:image/png;base64...)

## 6.3 `calculateWassersteinDistance()`

The code below illustrates how to use the
`calculateWassersteinDistance()` function to compare the Wasserstein
distances between CD4 cells in the reference and query datasets. The
resulting plot provides insight into whether the differences between the
datasets are statistically significant.

```
# Generate the Wasserstein distance density plot
wasserstein_data <- calculateWassersteinDistance(
    query_data = query_data_cd4,
    reference_data = ref_data_cd4,
    query_cell_type_col = "expert_annotation",
    ref_cell_type_col = "expert_annotation",
    pc_subset = 1:10,
)
plot(wasserstein_data)
#> Picking joint bandwidth of 0.00905
```

![](data:image/png;base64...)

## 6.4 `calculateVarImpOverlap()`

Imagine you have two sets of data: one called reference\_data and another
called query\_data. Both sets include information about gene expression
and cell types, with columns named `expert_annotation` for the reference
data and `SingleR_annotation` for the query data. You want to find out
which genes are most important for each dataset and then compare them.

Here’s how you can do it with the function:

```
# RF function to compare (between datasets) which genes are best at differentiating cell types
rf_output <- calculateVarImpOverlap(reference_data = reference_data,
                                    query_data = query_data,
                                    query_cell_type_col = "SingleR_annotation",
                                    ref_cell_type_col = "expert_annotation",
                                    n_tree = 500,
                                    n_top = 50)

# Comparison table
rf_output$var_imp_comparison
#>              CD4-CD8     CD4-B_and_plasma          CD4-Myeloid
#>                 0.80                 0.76                 0.86
#>     CD8-B_and_plasma          CD8-Myeloid B_and_plasma-Myeloid
#>                 0.76                 0.86                 0.78
```

## 6.5 `calculateAveragePairwiseCorrelation()`

The `calculateAveragePairwiseCorrelation()` function computes the
average pairwise correlations between specified cell types in
single-cell gene expression data. It calculates pairwise correlations
between query and reference cells using a specified correlation method,
and then averages these correlations for each cell type pair. This
approach helps assess the similarity between cells in reference and
query datasets and provides insights into the reliability of cell type
annotations.

```
# Compute pairwise correlations between specified cell types
cor_matrix_avg <- calculateAveragePairwiseCorrelation(
  query_data = query_data,
  reference_data = reference_data,
  query_cell_type_col = "SingleR_annotation",
  ref_cell_type_col = "expert_annotation",
  cell_types = c("CD4", "CD8", "B_and_plasma"),
  pc_subset = 1:5,
  correlation_method = "spearman"
)

# Visualize the average pairwise correlation matrix
plot(cor_matrix_avg)
```

![](data:image/png;base64...)

# 7 Detection and Analysis of Annotation Anomalies

For a detailed example of all possible functions to detect and analyze
potentially anomalous cells, please refer to the [Detection and Analysis
of Annotation
Anomalies](https://ccb-hms.github.io/scDiagnostics/articles/AnnotationAnomalies.html)
vignette.

## 7.1 Detection of Annotation Anomalies

The `detectAnomaly()` function is designed to identify anomalies in
single-cell data by leveraging PCA projections and the Isolation Forest
algorithm. This method is useful for detecting anomalies or unusual
patterns in single-cell datasets, whether you’re analyzing a reference
dataset or comparing a query dataset against it.

The function projects single-cell data onto a PCA space and builds an
Isolation Forest model on this PCA space to detect anomalies. If a query
dataset is provided, the function computes anomaly scores for the query
data based on its PCA projections relative to the reference data. If no
query data is provided, it computes anomaly scores for the reference
data itself.

```
# Perform anomaly detection
anomaly_output <- detectAnomaly(reference_data = reference_data,
                                query_data = query_data,
                                ref_cell_type_col = "expert_annotation",
                                query_cell_type_col = "SingleR_annotation",
                                pc_subset = 1:5)
# Plot the results for a specific cell type
plot(anomaly_output,
     cell_type = "CD4",
     data_type = "query",
     pc_subset = 1:5)
```

![](data:image/png;base64...)

## 7.2 Analysis of Annotation Anomalies

The `calculateCellDistances()` function computes distances both within a
reference dataset and between query cells and reference cells for each
specified cell type. By first projecting data onto a PCA space, the
function calculates Euclidean distances to quantify similarities and
dissimilarities. For each cell type, it generates pairwise distances
within the reference dataset and measures how far each query cell is
from all reference cells. This approach enables detailed analysis of
cell type-specific distances, aiding in the identification of outliers
and other patterns of interest.

To identify anomalous cells within the query data, we first use the
`detectAnomaly()` function, focusing specifically on the CD4 cell type.
This function will compute anomaly scores for each CD4 cell in the query
dataset based on their projection in the PCA space of the reference
data. Next, we will plot the distance distributions for the top 6 CD4
cells with the highest anomaly scores. These distances, computed using
the `calculateCellDistances()` function, will illustrate how these
anomalous cells differ from the reference cells, providing insight into
their potential outlier status and helping to visualize patterns within
the data.

```
# Identify outliers for CD4
cd4_anomalies <- detectAnomaly(reference_data = reference_data,
                               query_data = query_data,
                               query_cell_type_col = "SingleR_annotation",
                               ref_cell_type_col = "expert_annotation")
cd4_top6_anomalies <- names(sort(cd4_anomalies$CD4$query_anomaly_scores,
                                 decreasing = TRUE)[1:6])

# Plot the PC data
distance_data <- calculateCellDistances(
    query_data = query_data,
    reference_data = reference_data,
    query_cell_type_col = "SingleR_annotation",
    ref_cell_type_col = "expert_annotation"
)

# Plot the densities of the distances
plot(distance_data, ref_cell_type = "CD4", cell_names = cd4_top6_anomalies)
```

![](data:image/png;base64...)

---

# 8 R Session Info

```
R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
 [3] LC_TIME=en_GB              LC_COLLATE=C
 [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
 [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
 [9] LC_ADDRESS=C               LC_TELEPHONE=C
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats4    stats     graphics  grDevices utils     datasets  methods
[8] base

other attached packages:
 [1] scater_1.38.0               ggplot2_4.0.0
 [3] scran_1.38.0                scuttle_1.20.0
 [5] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
 [7] Biobase_2.70.0              GenomicRanges_1.62.0
 [9] Seqinfo_1.0.0               IRanges_2.44.0
[11] S4Vectors_0.48.0            BiocGenerics_0.56.0
[13] generics_0.1.4              MatrixGenerics_1.22.0
[15] matrixStats_1.5.0           scDiagnostics_1.4.0
[17] BiocStyle_2.38.0

loaded via a namespace (and not attached):
 [1] gridExtra_2.3       cramer_0.9-4        rlang_1.1.6
 [4] magrittr_2.0.4      ggridges_0.5.7      compiler_4.5.1
 [7] systemfonts_1.3.1   vctrs_0.6.5         stringr_1.5.2
[10] pkgconfig_2.0.3     fastmap_1.2.0       magick_2.9.0
[13] XVector_0.50.0      labeling_0.4.3      rmarkdown_2.30
[16] ggbeeswarm_0.7.2    ragg_1.5.0          tinytex_0.57
[19] purrr_1.1.0         xfun_0.53           bluster_1.20.0
[22] cachem_1.1.0        beachmat_2.26.0     jsonlite_2.0.0
[25] DelayedArray_0.36.0 BiocParallel_1.44.0 irlba_2.3.5.1
[28] parallel_4.5.1      cluster_2.1.8.1     R6_2.6.1
[31] bslib_0.9.0         stringi_1.8.7       RColorBrewer_1.1-3
[34] ranger_0.17.0       limma_3.66.0        GGally_2.4.0
[37] boot_1.3-32         jquerylib_0.1.4     Rcpp_1.1.0
[40] bookdown_0.45       knitr_1.50          Matrix_1.7-4
[43] igraph_2.2.1        tidyselect_1.2.1    dichromat_2.0-0.1
[46] abind_1.4-8         yaml_2.3.10         viridis_0.6.5
[49] codetools_0.2-20    lattice_0.22-7      tibble_3.3.0
[52] withr_3.0.2         S7_0.2.0            evaluate_1.0.5
[55] ggstats_0.11.0      pillar_1.11.1       BiocManager_1.30.26
[58] scales_1.4.0        RhpcBLASctl_0.23-42 glue_1.8.0
[61] metapod_1.18.0      tools_4.5.1         BiocNeighbors_2.4.0
[64] data.table_1.17.8   ScaledMatrix_1.18.0 locfit_1.5-9.12
[67] grid_4.5.1          tidyr_1.3.1         edgeR_4.8.0
[70] beeswarm_0.4.0      BiocSingular_1.26.0 vipor_0.4.7
[73] cli_3.6.5           rsvd_1.0.5          textshaping_1.0.4
[76] S4Arrays_1.10.0     viridisLite_0.4.2   dplyr_1.1.4
[79] gtable_0.3.6        isotree_0.6.1-4     sass_0.4.10
[82] digest_0.6.37       SparseArray_1.10.0  ggrepel_0.9.6
[85] dqrng_0.4.1         farver_2.1.2        htmltools_0.5.8.1
[88] lifecycle_1.0.4     statmod_1.5.1       transport_0.15-4
```