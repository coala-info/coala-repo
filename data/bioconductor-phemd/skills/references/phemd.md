# Tutorial on using PhEMD to analyze multi-sample single-cell experiments

William Chen

#### October 20, 2018

# Contents

* [0.1 Overview](#overview)
* [0.2 1. Installation](#installation)
* [0.3 2. Preparing data for cell state definition and embedding](#preparing-data-for-cell-state-definition-and-embedding)
* [0.4 3. Generate Monocle 2 cell embedding with cell state definitions](#generate-monocle-2-cell-embedding-with-cell-state-definitions)
* [0.5 4. Deconvolute single-cell samples and compare using Earth Mover’s Distance](#deconvolute-single-cell-samples-and-compare-using-earth-movers-distance)
* [0.6 5. Visualize single-cell samples based on PhEMD-based similarity](#visualize-single-cell-samples-based-on-phemd-based-similarity)

## 0.1 Overview

PhEMD is a package for comparing multiple heterogeneous single-cell samples to
one another. It currently does so by first defining cell subtypes and relating
them to one another using Monocle 2. It then computes Earth Mover’s Distance
(EMD) between each pair of samples, incorporating information about intrinsic
cell subtype dissimilarity (i.e. manifold distance between cell subtypes) and
differences between samples with respect to relative abundance of each cell
subtype. PhEMD uses these pairwise distances to construct a network of
single-cell samples that may be visually related in 2D or 3D using a diffusion
map and partitioned to identify groups of similar samples.

## 0.2 1. Installation

PhEMD requires R version >= 3.4.0 (recommended 3.5.0+), Bioconductor
version >= 3.5 (recommended 3.7+), and Monocle 2 version >= 2.4.0
(recommended 2.8.0)

###Install from Github

```
library(devtools)
install_github("wschen/phemd")
```

###Install from Bioconductor

```
BiocManager::install("phemd")
```

###Load library after installation

```
library('phemd')
library('monocle')
```

## 0.3 2. Preparing data for cell state definition and embedding

PhEMD expects single-cell data to be represented as an R list of samples. Each
sample (i.e. list element) is expected to be a matrix of dimension *num\_cells*
x *num\_markers*, where markers may represent genes or cytometry protein markers.
For this vignette, we will be demonstrating our analysis pipeline on a melanoma
dataset consisting of tumor-infiltrating immune cell scRNA-seq data (selected
genes) that were log-transformed following TPM-normalization (first published
by Tirosh et al., 2016).

We first start by creating a PhEMD data object, specifying the multi-sample
expression data (R list), marker names (i.e. column names of the data matrices
in the list of expression data), and sample names (in the order they appear in
the list of expression data).

```
load('melanomaData.RData')
myobj <- createDataObj(all_expn_data, all_genes, as.character(snames))
```

We can optionally remove samples in the PhEMD data object that have fewer than
min\_sz number of cells as follows:

```
myobj <- removeTinySamples(myobj, min_sz = 20)
```

```
## [1] "Mel78 removed because only contains 3 cells"
## [1] "Mel59 removed because only contains 12 cells"
```

Note that samples that don’t meet the meet the minimum cell yield criteria are
removed from rawExpn(myobj) and from the list of sample names in
sampleNames(myobj).

Next, aggregate data from all samples into a matrix that is stored in the PhEMD
data object (in slot ‘data\_aggregate’). This aggregated data will then be used
for initial cell subtype definition and embedding. If there are more cells
collectively in all samples than max\_cells, an equal number of cells from each
sample will be subsampled and stored in pooledCells(myobj).

```
myobj <- aggregateSamples(myobj, max_cells=12000)
```

## 0.4 3. Generate Monocle 2 cell embedding with cell state definitions

Now that we have aggregated single-cell data from all samples, we are ready to
perform cell subtype definition and dimensionality reduction to visually and
spatially relate cells and cell subtypes. For this, we use Monocle 2. Before we
begin, we first perform feature selection by selecting 44 important genes.
Suggestions on how to choose important genes can be found here: <http://cole-trapnell-lab.github.io/monocle-release/docs/#trajectory-step-1-choose-genes-that-define-a-cell-s-progress>

```
myobj <- selectFeatures(myobj, selected_genes)
```

We are now ready to generate a Monocle 2 embedding. Our *embedCells()* function
is a wrapper function for the *reduceDimension()* function in Monocle 2. For our
example dataset, we specify the expression distribution model as *‘gaussianff’*
as is recommended in the Monocle 2 tutorial for log-transformed scRNA-seq TPM
values (<http://cole-trapnell-lab.github.io/monocle-release/docs/#choosing-a-distribution-for-your-data-required>).
*‘negbinomial\_sz’* is the recommended data type for most unnormalized scRNA-seq
data (raw read counts) and *‘gaussianff’* is recommended for log-transformed
data or arcsin-transformed mass cytometry data. See above link for more details.

Additional parameters may be passed to Monocle 2 *reduceDimension()* as optional
named parameters in *embed\_cells()*. We found that Monocle 2 is robust to a
range of parameters. Sigma can be thought of as a “noise” parameter and we
empirically found that sigma in the range of [0.01, 0.1] often works well for
log-transformed scRNA-seq data or normalized CyTOF data. Greater values of sigma
generally result in fewer total number of clusters. See Monocle 2 publication
(Qiu et al., 2017) for additional details on parameter selection.

```
# generate 2D cell embedding and cell subtype assignments
myobj <- embedCells(myobj, data_model = 'gaussianff', pseudo_expr=0, sigma=0.02)
# generate pseudotime ordering of cells
myobj <- orderCellsMonocle(myobj)
```

The result of the code above is a Monocle 2 object stored in
*monocleInfo(myobj)*. This object contains cell subtype and pseudotime
assignments for each cell in the aggregated data matrix (stored in
*pooledCells(myobj)*). A 2D embedding of these cells has also been generated.
We can visualize the embedding by writing them to file in this way:

```
cmap <- plotEmbeddings(myobj, cell_model='monocle2')
```

![](data:image/png;base64...)

To visualize the expression profiles of the cell subtypes, we can plot a heatmap
and save to file as such:

```
plotHeatmaps(myobj, cell_model='monocle2', selected_genes=heatmap_genes)
```

![](data:image/png;base64...)

## 0.5 4. Deconvolute single-cell samples and compare using Earth Mover’s Distance

Now that we have identified a comprehensive set of cell subtypes across all
single-cell samples and related them in a low-dimensional embedding by
aggregating cells from all samples, we want to perform deconvolution to
determine the abundance of each cell subtype on a per sample basis. To do so,
we call this function:

```
# Determine cell subtype breakdown of each sample
myobj <- clusterIndividualSamples(myobj)
```

The results of this process are stored in *celltypeFreqs(myobj)*. Row
*i* column *j* represents the fraction of all cells in sample *i* assigned to
cell subtype *j*.

To compare single-cell samples, we use Earth Mover’s Distance, which is a metric
that takes into account both the difference in relative frequencies of matching
cell subtypes (e.g. % of all cells in each sample that are CD8+ T-cells) and the
dissimilarity of the cell subtypes themselves (e.g. intrinsic dissimilarity
between CD8+ and CD4+ T-cells). To compute the intrinsic dissimilarity between
cell subtypes, we call the following function:

```
# Determine (dis)similarity of different cell subtypes
myobj <- generateGDM(myobj)
```

*generateGDM()* stores the pairwise dissimilarity (i.e. “ground-distance” or
“tree-distance”) between cell subtypes in *GDM(myobj)*.

We are now ready to compare single-cell samples using EMD. To do so, we simply
call the function *compareSamples()*:

```
# Perform inter-sample comparisons using EMD
my_distmat <- compareSamples(myobj)
```

*compareSamples()* returns a distance matrix representing the pairwise EMD
between single-cell samples; *my\_distmat[i,j]* represents the dissimilarity
between samples *i* and *j* (i.e. samples represented by rows *i* and *j* in
celltypeFreqs(myobj)). We can use this distance matrix to identify similar
groups of samples as such:

```
## Identify similar groups of inhibitors
group_assignments <- groupSamples(my_distmat, distfun = 'hclust', ncluster=5)
```

## 0.6 5. Visualize single-cell samples based on PhEMD-based similarity

We can also use the PhEMD-based distance matrix to generate an embedding of
single-cell samples, colored by group assignments.

```
dmap_obj <- plotGroupedSamplesDmap(my_distmat, group_assignments, pt_sz = 1.5)
```

![](data:image/png;base64...)

To retrieve the cell subtype distribution on a per-sample basis, use the
following function. Histograms can be subsequently plotted for a given sample
as desired.

```
# Plot cell subtype distribution (histogram) for each sample
sample.cellfreqs <- getSampleHistsByCluster(myobj, group_assignments, cell_model='monocle2')
```

To plot cell subtype histograms summarizing groups of similar samples (bin-wise
mean of each cell subtype across all samples assigned to a particular group),
use the following plotting function:

```
# Plot representative cell subtype distribution for each group of samples
plotSummaryHistograms(myobj, group_assignments, cell_model='monocle2', cmap,
                      ncol.plot = 5, ax.lab.sz=1.3, title.sz=2)
```

![](data:image/png;base64...)

To plot cell yield of each samples as a barplot, use the following function:

```
# Plot cell yield of each experimental condition
plotCellYield(myobj, group_assignments, font_sz = 0.7, w=8, h=5)
```

![](data:image/png;base64...)

```
sessionInfo()
```

```
## R version 3.6.0 (2019-04-26)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 18.04.2 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.9-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.9-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
##  [1] splines   stats4    parallel  stats     graphics  grDevices utils
##  [8] datasets  methods   base
##
## other attached packages:
##  [1] phemd_1.0.1         monocle_2.12.0      DDRTree_0.1.5
##  [4] irlba_2.3.3         VGAM_1.1-1          ggplot2_3.1.1
##  [7] Biobase_2.44.0      BiocGenerics_0.30.0 Matrix_1.2-17
## [10] BiocStyle_2.12.0
##
## loaded via a namespace (and not attached):
##   [1] readxl_1.3.1                RcppEigen_0.3.3.5.0
##   [3] plyr_1.8.4                  igraph_1.2.4.1
##   [5] lazyeval_0.2.2              sp_1.3-1
##   [7] BiocParallel_1.18.0         densityClust_0.3
##   [9] listenv_0.7.0               GenomeInfoDb_1.20.0
##  [11] fastICA_1.2-1               digest_0.6.18
##  [13] htmltools_0.3.6             viridis_0.5.1
##  [15] gdata_2.18.0                magrittr_1.5
##  [17] cluster_2.0.9               ROCR_1.0-7
##  [19] openxlsx_4.1.0              limma_3.40.0
##  [21] globals_0.12.4              matrixStats_0.54.0
##  [23] R.utils_2.8.0               docopt_0.6.1
##  [25] xts_0.11-2                  colorspace_1.4-1
##  [27] ggrepel_0.8.1               haven_2.1.0
##  [29] xfun_0.6                    dplyr_0.8.0.1
##  [31] jsonlite_1.6                sparsesvd_0.1-4
##  [33] crayon_1.3.4                RCurl_1.95-4.12
##  [35] survival_2.44-1.1           zoo_1.8-5
##  [37] ape_5.3                     glue_1.3.1
##  [39] gtable_0.3.0                zlibbioc_1.30.0
##  [41] XVector_0.24.0              DelayedArray_0.10.0
##  [43] car_3.0-2                   SingleCellExperiment_1.6.0
##  [45] future.apply_1.2.0          DEoptimR_1.0-8
##  [47] abind_1.4-5                 VIM_4.8.0
##  [49] scales_1.0.0                pheatmap_1.0.12
##  [51] bibtex_0.4.2                ggthemes_4.1.1
##  [53] Rcpp_1.0.1                  metap_1.1
##  [55] viridisLite_0.3.0           laeken_0.5.0
##  [57] reticulate_1.12             rsvd_1.0.0
##  [59] foreign_0.8-71              proxy_0.4-23
##  [61] SDMTools_1.1-221.1          tsne_0.1-3
##  [63] vcd_1.4-4                   httr_1.4.0
##  [65] htmlwidgets_1.3             FNN_1.1.3
##  [67] gplots_3.0.1.1              RColorBrewer_1.1-2
##  [69] Seurat_3.0.0                ica_1.0-2
##  [71] pkgconfig_2.0.2             R.methodsS3_1.7.1
##  [73] nnet_7.3-12                 labeling_0.3
##  [75] tidyselect_0.2.5            rlang_0.3.4
##  [77] reshape2_1.4.3              munsell_0.5.0
##  [79] cellranger_1.1.0            tools_3.6.0
##  [81] ranger_0.11.2               ggridges_0.5.1
##  [83] evaluate_0.13               stringr_1.4.0
##  [85] maptree_1.4-7               yaml_2.2.0
##  [87] npsurv_0.4-0                transport_0.11-1
##  [89] knitr_1.22                  fitdistrplus_1.0-14
##  [91] zip_2.0.1                   robustbase_0.93-4
##  [93] caTools_1.17.1.2            purrr_0.3.2
##  [95] RANN_2.6.1                  pbapply_1.4-0
##  [97] future_1.12.0               nlme_3.1-139
##  [99] slam_0.1-45                 R.oo_1.22.0
## [101] pracma_2.2.5                compiler_3.6.0
## [103] png_0.1-7                   plotly_4.9.0
## [105] curl_3.3                    e1071_1.7-1
## [107] lsei_1.2-0                  smoother_1.1
## [109] tibble_2.1.1                stringi_1.4.3
## [111] forcats_0.4.0               lattice_0.20-38
## [113] HSMMSingleCell_1.4.0        pillar_1.3.1
## [115] BiocManager_1.30.4          Rdpack_0.11-0
## [117] combinat_0.0-8              lmtest_0.9-37
## [119] data.table_1.12.2           cowplot_0.9.4
## [121] bitops_1.0-6                gbRd_0.4-11
## [123] GenomicRanges_1.36.0        R6_2.4.0
## [125] bookdown_0.9                KernSmooth_2.23-15
## [127] gridExtra_2.3               rio_0.5.16
## [129] IRanges_2.18.0              codetools_0.2-16
## [131] boot_1.3-22                 MASS_7.3-51.4
## [133] gtools_3.8.1                assertthat_0.2.1
## [135] destiny_2.14.0              SummarizedExperiment_1.14.0
## [137] withr_2.1.2                 sctransform_0.2.0
## [139] qlcMatrix_0.9.7             S4Vectors_0.22.0
## [141] GenomeInfoDbData_1.2.1      hms_0.4.2
## [143] grid_3.6.0                  rpart_4.1-15
## [145] tidyr_0.8.3                 class_7.3-15
## [147] rmarkdown_1.12              carData_3.0-2
## [149] Rtsne_0.15                  TTR_0.23-4
## [151] scatterplot3d_0.3-41
```