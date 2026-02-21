Code

* Show All Code
* Hide All Code

# systemPipeTools: Data Visualizations

Author: Daniela Cassol and Thomas Girke

#### Last update: 30 October, 2025

#### Package

systemPipeTools 1.18.0

# 1 Data Visualization with `systemPipeR`

*systemPipeTools* package extends the widely used
*[systemPipeR](https://systempipe.org/)* (SPR) (H Backman and Girke [2016](#ref-H_Backman2016-bt))
workflow environment with enhanced toolkit for data visualization,
including utilities to automate the analysis of differentially expressed genes
(DEGs).
*systemPipeTools* provides functions for data transformation and data
exploration via scatterplots, hierarchical clustering heatMaps, principal
component analysis, multidimensional scaling, generalized principal components,
t-Distributed Stochastic Neighbor embedding (t-SNE), and MA and volcano plots.
All these utilities can be integrated with the modular design of the
*systemPipeR* environment that allows users to easily substitute any of these
features and/or custom with alternatives.

## 1.1 Installation

*`systemPipeTools`* environment can be installed from the R console using the [*`BiocManager::install`*](https://cran.r-project.org/web/packages/BiocManager/index.html)
command. The associated package [*`systemPipeR`*](http://bioconductor.org/packages/release/bioc/html/systemPipeR.html)
can be installed the same way. The latter provides core functionalities for
defining workflows, interacting with command-line software, and executing both
R and/or command-line software, as well as generating publication-quality
analysis reports.

```
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("systemPipeTools")
BiocManager::install("systemPipeR")
```

### 1.1.1 Loading package and documentation

```
library("systemPipeTools")  # Loads the package
library(help = "systemPipeTools")  # Lists package info
vignette("systemPipeTools")  # Opens vignette
```

## 1.2 Metadata and Reads Counting Information

The first step is importing the `targets` file and raw reads counting table.
- The `targets` file defines all FASTQ files and sample comparisons of the
analysis workflow.
- The raw reads counting table represents all the reads that map to gene
(row) for each sample (columns).

```
## Targets file
targetspath <- system.file("extdata", "targets.txt", package = "systemPipeR")
targets <- read.delim(targetspath, comment = "#")
cmp <- systemPipeR::readComp(file = targetspath, format = "matrix", delim = "-")
## Count table file
countMatrixPath <- system.file("extdata", "countDFeByg.xls", package = "systemPipeR")
countMatrix <- read.delim(countMatrixPath, row.names = 1)
showDT(countMatrix)
```

## 1.3 Data Transformation

For gene differential expression, raw counts are required, however for data
visualization or clustering, it can be useful to work with transformed count
data.
`exploreDDS` function is convenience wrapper to transform raw read counts
using the [`DESeq2`](%40Love2014-sh) package transformations methods. The input
file has to contain all the genes, not just differentially expressed ones.
Supported methods include variance stabilizing transformation (`vst`)
(Anders and Huber ([2010](#ref-Anders2010-tp))), and regularized-logarithm transformation or `rlog`
(Love, Huber, and Anders ([2014](#ref-Love2014-sh))).

```
exploredds <- exploreDDS(countMatrix, targets, cmp = cmp[[1]], preFilter = NULL,
    transformationMethod = "rlog")
exploredds
```

```
## class: DESeqTransform
## dim: 116 18
## metadata(1): version
## assays(1): ''
## rownames(116): AT1G01010 AT1G01020 ... ATMG00180 ATMG00200
## rowData names(51): baseMean baseVar ... dispFit rlogIntercept
## colnames(18): M1A M1B ... V12A V12B
## colData names(2): condition sizeFactor
```

Users are strongly encouraged to consult the [`DESeq2`](%40Love2014-sh) vignette
for more detailed information on this topic and how to properly run `DESeq2` on
datasets with more complex experimental designs.

## 1.4 Scatterplot

To decide which transformation to choose, we can visualize the transformation
effect comparing two samples or a grid of all samples, as follows:

```
exploreDDSplot(countMatrix, targets, cmp = cmp[[1]], preFilter = NULL, samples = c("M12A",
    "M12A", "A12A", "A12A"), scattermatrix = TRUE)
```

The scatterplots are created using the log2 transform normalized reads count,
variance stabilizing transformation (VST) (Anders and Huber ([2010](#ref-Anders2010-tp))), and
regularized-logarithm transformation or `rlog` (Love, Huber, and Anders ([2014](#ref-Love2014-sh))).

## 1.5 Hierarchical Clustering Dendrogram

The following computes the sample-wise correlation coefficients using the
`stats::cor()` function from the transformed expression values. After
transformation to a distance matrix, hierarchical clustering is performed with
the `stats::hclust` function and the result is plotted as a dendrogram,
as follows:

```
hclustplot(exploredds, method = "spearman")
```

![](data:image/png;base64...)

The function provides the utility to save the plot automatically.

## 1.6 Hierarchical Clustering HeatMap

This function performs hierarchical clustering on the transformed expression
matrix generated within the `DESeq2` package. It uses, by default, a `Pearson`
correlation-based distance measure and complete linkage for cluster join.
If `samples` selected in the `clust` argument, it will be applied the
`stats::dist()` function to the transformed count matrix to get sample-to-sample
distances. Also, it is possible to generate the `pheatmap` or `plotly`
plot format.

```
## Samples plot
heatMaplot(exploredds, clust = "samples", plotly = FALSE)
```

![](data:image/png;base64...)

If `ind` selected in the `clust` argument, it is necessary to provide the list
of differentially expressed genes for the `exploredds` subset.

```
## Individuals genes identified in DEG analysis DEG analysis with `systemPipeR`
degseqDF <- systemPipeR::run_DESeq2(countDF = countMatrix, targets = targets, cmp = cmp[[1]],
    independent = FALSE)
DEG_list <- systemPipeR::filterDEGs(degDF = degseqDF, filter = c(Fold = 2, FDR = 10))
```

![](data:image/png;base64...)

```
### Plot
heatMaplot(exploredds, clust = "ind", DEGlist = unique(as.character(unlist(DEG_list[[1]]))))
```

![](data:image/png;base64...)

The function provides the utility to save the plot automatically.

## 1.7 Principal Component Analysis

This function plots a Principal Component Analysis (PCA) from transformed
expression matrix. This plot shows samples variation based on the expression
values and identifies batch effects.

```
PCAplot(exploredds, plotly = FALSE)
```

```
## using ntop=500 top features by variance
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the systemPipeTools package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

The function provides the utility to save the plot automatically.

## 1.8 Multidimensional scaling with `MDSplot`

This function computes and plots multidimensional scaling analysis for dimension
reduction of count expression matrix. Internally, it is applied the
`stats::dist()` function to the transformed count matrix to get sample-to-sample
distances.

```
MDSplot(exploredds, plotly = FALSE)
```

![](data:image/png;base64...)

The function provides the utility to save the plot automatically.

## 1.9 Dimension Reduction with `GLMplot`

This function computes and plots generalized principal components analysis for
dimension reduction of count expression matrix.

```
exploredds_r <- exploreDDS(countMatrix, targets, cmp = cmp[[1]], preFilter = NULL,
    transformationMethod = "raw")
GLMplot(exploredds_r, plotly = FALSE)
```

![](data:image/png;base64...)

The function provides the utility to save the plot automatically.

## 1.10 MA plot

This function plots log2 fold changes (y-axis) versus the mean of normalized
counts (on the x-axis). Statistically significant features are colored.

```
MAplot(degseqDF, comparison = "M12-A12", filter = c(Fold = 1, FDR = 20), genes = "ATCG00280")
```

![](data:image/png;base64...)

The function provides the utility to save the plot automatically.

## 1.11 t-Distributed Stochastic Neighbor embedding with `tSNEplot`

This function computes and plots t-Distributed Stochastic Neighbor embedding
(t-SNE) analysis for unsupervised nonlinear dimensionality reduction of count
expression matrix. Internally, it is applied the `Rtsne::Rtsne()` (Krijthe [2015](#ref-Rtsne))
function, using the exact
t-SNE computing with `theta=0.0`.

```
tSNEplot(countMatrix, targets, perplexity = 5)
```

![](data:image/png;base64...)

## 1.12 Volcano plot

A simple function that shows statistical significance (`p-value`) versus
magnitude of change (`log2 fold change`).

```
volcanoplot(degseqDF, comparison = "M12-A12", filter = c(Fold = 1, FDR = 20), genes = "ATCG00280")
```

![](data:image/png;base64...)

# 2 Version information

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
##  [1] systemPipeR_2.16.0          ShortRead_1.68.0
##  [3] GenomicAlignments_1.46.0    SummarizedExperiment_1.40.0
##  [5] Biobase_2.70.0              MatrixGenerics_1.22.0
##  [7] matrixStats_1.5.0           BiocParallel_1.44.0
##  [9] Rsamtools_2.26.0            Biostrings_2.78.0
## [11] XVector_0.50.0              GenomicRanges_1.62.0
## [13] IRanges_2.44.0              S4Vectors_0.48.0
## [15] Seqinfo_1.0.0               BiocGenerics_0.56.0
## [17] generics_0.1.4              systemPipeTools_1.18.0
## [19] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] bitops_1.0-9            deldir_2.0-4            formatR_1.14
##   [4] rlang_1.1.6             magrittr_2.0.4          compiler_4.5.1
##   [7] png_0.1-8               systemfonts_1.3.1       vctrs_0.6.5
##  [10] stringr_1.5.2           pwalign_1.6.0           pkgconfig_2.0.3
##  [13] crayon_1.5.3            fastmap_1.2.0           magick_2.9.0
##  [16] labeling_0.4.3          rmarkdown_2.30          tinytex_0.57
##  [19] purrr_1.1.0             xfun_0.54               cachem_1.1.0
##  [22] cigarillo_1.0.0         aplot_0.2.9             jsonlite_2.0.0
##  [25] DelayedArray_0.36.0     jpeg_0.1-11             parallel_4.5.1
##  [28] R6_2.6.1                stringi_1.8.7           bslib_0.9.0
##  [31] RColorBrewer_1.1-3      GGally_2.4.0            jquerylib_0.1.4
##  [34] Rcpp_1.1.0              bookdown_0.45           knitr_1.50
##  [37] glmpca_0.2.0            Matrix_1.7-4            tidyselect_1.2.1
##  [40] dichromat_2.0-0.1       abind_1.4-8             yaml_2.3.10
##  [43] codetools_0.2-20        hwriter_1.3.2.1         lattice_0.22-7
##  [46] tibble_3.3.0            withr_3.0.2             treeio_1.34.0
##  [49] S7_0.2.0                evaluate_1.0.5          Rtsne_0.17
##  [52] gridGraphics_0.5-1      ggstats_0.11.0          pillar_1.11.1
##  [55] BiocManager_1.30.26     ggtree_4.0.1            DT_0.34.0
##  [58] ggfun_0.2.0             plotly_4.11.0           ggplot2_4.0.0
##  [61] scales_1.4.0            tidytree_0.4.6          glue_1.8.0
##  [64] gdtools_0.4.4           pheatmap_1.0.13         lazyeval_0.2.2
##  [67] tools_4.5.1             interp_1.1-6            data.table_1.17.8
##  [70] locfit_1.5-9.12         ggiraph_0.9.2           fs_1.6.6
##  [73] grid_4.5.1              tidyr_1.3.1             ape_5.8-1
##  [76] crosstalk_1.2.2         latticeExtra_0.6-31     nlme_3.1-168
##  [79] patchwork_1.3.2         cli_3.6.5               rappdirs_0.3.3
##  [82] fontBitstreamVera_0.1.1 S4Arrays_1.10.0         viridisLite_0.4.2
##  [85] dplyr_1.1.4             gtable_0.3.6            yulab.utils_0.2.1
##  [88] DESeq2_1.50.0           sass_0.4.10             digest_0.6.37
##  [91] fontquiver_0.2.1        SparseArray_1.10.0      ggrepel_0.9.6
##  [94] ggplotify_0.1.3         htmlwidgets_1.6.4       farver_2.1.2
##  [97] htmltools_0.5.8.1       lifecycle_1.0.4         httr_1.4.7
## [100] fontLiberation_0.1.0    MASS_7.3-65
```

# 3 Funding

This project is funded by NSF award [ABI-1661152](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1661152).

# References

Anders, Simon, and Wolfgang Huber. 2010. “Differential Expression Analysis for Sequence Count Data.” *Genome Biol.* 11 (10): R106.

H Backman, Tyler W, and Thomas Girke. 2016. “systemPipeR: NGS workflow and report generation environment.” *BMC Bioinformatics* 17 (1): 388. <https://doi.org/10.1186/s12859-016-1241-0>.

Krijthe, Jesse H. 2015. *Rtsne: T-Distributed Stochastic Neighbor Embedding Using Barnes-Hut Implementation*. <https://github.com/jkrijthe/Rtsne>.

Love, Michael, Wolfgang Huber, and Simon Anders. 2014. “Moderated Estimation of Fold Change and Dispersion for RNA-seq Data with DESeq2.” *Genome Biol.* 15 (12): 550. <https://doi.org/10.1186/s13059-014-0550-8>.