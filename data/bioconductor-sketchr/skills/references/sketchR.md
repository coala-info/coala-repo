# Subsampling single-cell data sets with sketchR

#### 2025-10-30

## Introduction

As the number of cells that are routinely interrogated in single-cell experiments increases rapidly and can easily reach hundreds of thousands, the computational resource requirements also grow larger. Several approaches have been proposed to either subsample or aggregate cells in order to reduce the size of the data and enable the application of standard analysis procedures. One such approach is geometric sketching - subsampling in a density-aware manner in such a way that densely populated regions of the gene expression space are subsampled more aggressively, while a larger fraction of cells are retained in sparsely populated regions. In addition to reducing the size of the data set, this often also increases the relative representation of rare cell types in the subsampled data set.

Several tools have been developed for applying sketching to single-cell (or other) data sets, but not all of them are easily applicable from R. The `sketchR` package implements an R/Bioconductor interface to some of the most popular python packages for geometric sketching, allowing them to be directly incorporated into Bioconductor-based single-cell analysis workflows. The interaction with python is managed using the `basilisk` package, which automatically takes care of generating and activating a suitable conda environment with the required packages.

This vignette showcases the main functionalities of the `sketchR` package, and illustrates how it can be used to generate a subsample of a dataset using the geometric sketching/subsampling algorithms and implementations proposed by Hie et al. (2019) and Song et al. (2022), as well as create a set of diagnostic plots.

## Installation

`sketchR` can be installed from Bioconductor using the following code:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("sketchR")
```

## Preparation

We start by loading the required packages and preparing an example data set.

```
suppressPackageStartupMessages({
    library(sketchR)
    library(TENxPBMCData)
    library(scuttle)
    library(scran)
    library(scater)
    library(SingleR)
    library(celldex)
    library(cowplot)
    library(SummarizedExperiment)
    library(SingleCellExperiment)
    library(beachmat.hdf5)
})
```

We will use the PBMC3k data set from the *[TENxPBMCData](https://bioconductor.org/packages/3.22/TENxPBMCData)* Bioconductor package for illustration. The chunk below prepares the data set by calculating log-transformed normalized counts, finding highly variable genes, performing dimensionality reduction and predicting cell type labels using the *[SingleR](https://bioconductor.org/packages/3.22/SingleR)* package.

```
## Load data
pbmc3k <- TENxPBMCData(dataset = "pbmc3k")
#> see ?TENxPBMCData and browseVignettes('TENxPBMCData') for documentation
#> loading from cache

## Set row and column names
colnames(pbmc3k) <- paste0("Cell", seq_len(ncol(pbmc3k)))
rownames(pbmc3k) <- uniquifyFeatureNames(
    ID = rowData(pbmc3k)$ENSEMBL_ID,
    names = rowData(pbmc3k)$Symbol_TENx
)

## Normalize and log-transform counts
pbmc3k <- logNormCounts(pbmc3k)

## Find highly variable genes
dec <- modelGeneVar(pbmc3k)
top.hvgs <- getTopHVGs(dec, n = 2000)

## Perform dimensionality reduction
set.seed(100)
pbmc3k <- runPCA(pbmc3k, subset_row = top.hvgs)
pbmc3k <- runTSNE(pbmc3k, dimred = "PCA")

## Predict cell type labels
ref_monaco <- MonacoImmuneData()
pred_monaco_main <- SingleR(test = pbmc3k, ref = ref_monaco,
                            labels = ref_monaco$label.main)
pbmc3k$labels_main <- pred_monaco_main$labels

dim(pbmc3k)
#> [1] 32738  2700
```

## Subsampling

The `geosketch()` function performs geometric sketching by calling the `geosketch` [python package](https://github.com/brianhie/geosketch). The output is a vector of indices that can be used to subset the full dataset. The provided seed will be propagated to the python code to achieve reproducibility.

```
idx800gs <- geosketch(reducedDim(pbmc3k, "PCA"),
                      N = 800, seed = 123)
#> Using Python: /home/biocbuild/.pyenv/versions/3.12.10/bin/python3.12
#> Creating virtual environment '/var/cache/basilisk/1.22.0/sketchR/1.6.0/universal' ...
#> + /home/biocbuild/.pyenv/versions/3.12.10/bin/python3.12 -m venv /var/cache/basilisk/1.22.0/sketchR/1.6.0/universal
#> Done!
#> Installing packages: pip, wheel, setuptools
#> + /var/cache/basilisk/1.22.0/sketchR/1.6.0/universal/bin/python -m pip install --upgrade pip wheel setuptools
#> Installing packages: 'fbpca==1.0', 'geosketch==1.2', 'scsampler==1.0.2', 'anndata==0.11.4', 'array_api_compat==1.11.2', 'contourpy==1.3.2', 'cycler==0.12.1', 'fonttools==4.57.0', 'h5py==3.13.0', 'joblib==1.5.0', 'kiwisolver==1.4.8', 'legacy-api-wrap==1.4.1', 'llvmlite==0.44.0', 'matplotlib==3.10.3', 'natsort==8.4.0', 'networkx==3.4.2', 'numba==0.61.2', 'numpy==1.26.4', 'packaging==25.0', 'pandas==2.2.3', 'patsy==1.0.1', 'pillow==11.2.1', 'pip==25.1.1', 'pynndescent==0.5.13', 'pyparsing==3.2.3', 'python-dateutil==2.9.0.post0', 'pytz==2025.2', 'scanpy==1.10.3', 'scikit-learn==1.6.1', 'scipy==1.15.3', 'seaborn==0.13.2', 'session_info==1.0.1', 'setuptools==80.3.1', 'six==1.17.0', 'statsmodels==0.14.4', 'stdlib-list==0.11.1', 'threadpoolctl==3.6.0', 'tqdm==4.67.1', 'tzdata==2025.2', 'umap-learn==0.5.7', 'wheel==0.45.1'
#> + /var/cache/basilisk/1.22.0/sketchR/1.6.0/universal/bin/python -m pip install --upgrade --no-user 'fbpca==1.0' 'geosketch==1.2' 'scsampler==1.0.2' 'anndata==0.11.4' 'array_api_compat==1.11.2' 'contourpy==1.3.2' 'cycler==0.12.1' 'fonttools==4.57.0' 'h5py==3.13.0' 'joblib==1.5.0' 'kiwisolver==1.4.8' 'legacy-api-wrap==1.4.1' 'llvmlite==0.44.0' 'matplotlib==3.10.3' 'natsort==8.4.0' 'networkx==3.4.2' 'numba==0.61.2' 'numpy==1.26.4' 'packaging==25.0' 'pandas==2.2.3' 'patsy==1.0.1' 'pillow==11.2.1' 'pip==25.1.1' 'pynndescent==0.5.13' 'pyparsing==3.2.3' 'python-dateutil==2.9.0.post0' 'pytz==2025.2' 'scanpy==1.10.3' 'scikit-learn==1.6.1' 'scipy==1.15.3' 'seaborn==0.13.2' 'session_info==1.0.1' 'setuptools==80.3.1' 'six==1.17.0' 'statsmodels==0.14.4' 'stdlib-list==0.11.1' 'threadpoolctl==3.6.0' 'tqdm==4.67.1' 'tzdata==2025.2' 'umap-learn==0.5.7' 'wheel==0.45.1'
#> Virtual environment '/var/cache/basilisk/1.22.0/sketchR/1.6.0/universal' successfully created.
head(idx800gs)
#> [1]  3  6  9 11 15 16
length(idx800gs)
#> [1] 800
```

Similarly, the `scsampler()` function calls the `scSampler` [python package](https://github.com/SONGDONGYUAN1994/scsampler) to perform subsampling.

To illustrate the result of the subsampling, we plot the tSNE representation of the original data as well as the subset (using the tSNE coordinates derived from the full dataset).

```
plot_grid(
    plotTSNE(pbmc3k, colour_by = "labels_main"),
    plotTSNE(pbmc3k[, idx800gs], colour_by = "labels_main")
)
```

![](data:image/png;base64...)

We can also illustrate the relative abundance of each cell type in the full data and in the subset, respectively.

```
compareCompositionPlot(colData(pbmc3k),
                       idx = list(geosketch = idx800gs),
                       column = "labels_main")
```

![](data:image/png;base64...)

## Diagnostic plots

`sketchR` provides a convenient function to plot the Hausdorff distance between the full dataset and the subsample, for a range of sketch sizes (to make this plot reproducible, we use `set.seed` before the call).

```
set.seed(123)
hausdorffDistPlot(mat = reducedDim(pbmc3k, "PCA"),
                  Nvec = c(400, 800, 2000),
                  Nrep = 3, methods = c("geosketch", "uniform"))
```

![](data:image/png;base64...)

## Session info

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] beachmat.hdf5_1.8.0         cowplot_1.2.0
#>  [3] celldex_1.19.0              SingleR_2.12.0
#>  [5] scater_1.38.0               ggplot2_4.0.0
#>  [7] scran_1.38.0                scuttle_1.20.0
#>  [9] TENxPBMCData_1.27.0         HDF5Array_1.38.0
#> [11] h5mread_1.2.0               rhdf5_2.54.0
#> [13] DelayedArray_0.36.0         SparseArray_1.10.0
#> [15] S4Arrays_1.10.0             abind_1.4-8
#> [17] Matrix_1.7-4                SingleCellExperiment_1.32.0
#> [19] SummarizedExperiment_1.40.0 Biobase_2.70.0
#> [21] GenomicRanges_1.62.0        Seqinfo_1.0.0
#> [23] IRanges_2.44.0              S4Vectors_0.48.0
#> [25] BiocGenerics_0.56.0         generics_0.1.4
#> [27] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [29] sketchR_1.6.0               BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3        jsonlite_2.0.0
#>   [3] magrittr_2.0.4            ggbeeswarm_0.7.2
#>   [5] gypsum_1.6.0              farver_2.1.2
#>   [7] rmarkdown_2.30            vctrs_0.6.5
#>   [9] memoise_2.0.1             DelayedMatrixStats_1.32.0
#>  [11] htmltools_0.5.8.1         AnnotationHub_4.0.0
#>  [13] curl_7.0.0                BiocNeighbors_2.4.0
#>  [15] Rhdf5lib_1.32.0           sass_0.4.10
#>  [17] alabaster.base_1.10.0     bslib_0.9.0
#>  [19] basilisk_1.22.0           httr2_1.2.1
#>  [21] cachem_1.1.0              igraph_2.2.1
#>  [23] lifecycle_1.0.4           pkgconfig_2.0.3
#>  [25] rsvd_1.0.5                R6_2.6.1
#>  [27] fastmap_1.2.0             digest_0.6.37
#>  [29] AnnotationDbi_1.72.0      dqrng_0.4.1
#>  [31] irlba_2.3.5.1             ExperimentHub_3.0.0
#>  [33] RSQLite_2.4.3             beachmat_2.26.0
#>  [35] filelock_1.0.3            labeling_0.4.3
#>  [37] httr_1.4.7                compiler_4.5.1
#>  [39] bit64_4.6.0-1             withr_3.0.2
#>  [41] S7_0.2.0                  BiocParallel_1.44.0
#>  [43] viridis_0.6.5             DBI_1.2.3
#>  [45] alabaster.ranges_1.10.0   alabaster.schemas_1.10.0
#>  [47] rappdirs_0.3.3            bluster_1.20.0
#>  [49] tools_4.5.1               vipor_0.4.7
#>  [51] beeswarm_0.4.0            glue_1.8.0
#>  [53] rhdf5filters_1.22.0       grid_4.5.1
#>  [55] Rtsne_0.17                cluster_2.1.8.1
#>  [57] gtable_0.3.6              BiocSingular_1.26.0
#>  [59] ScaledMatrix_1.18.0       metapod_1.18.0
#>  [61] XVector_0.50.0            ggrepel_0.9.6
#>  [63] BiocVersion_3.22.0        pillar_1.11.1
#>  [65] limma_3.66.0              dplyr_1.1.4
#>  [67] BiocFileCache_3.0.0       lattice_0.22-7
#>  [69] bit_4.6.0                 tidyselect_1.2.1
#>  [71] locfit_1.5-9.12           Biostrings_2.78.0
#>  [73] knitr_1.50                gridExtra_2.3
#>  [75] edgeR_4.8.0               xfun_0.53
#>  [77] statmod_1.5.1             yaml_2.3.10
#>  [79] evaluate_1.0.5            codetools_0.2-20
#>  [81] tibble_3.3.0              alabaster.matrix_1.10.0
#>  [83] BiocManager_1.30.26       cli_3.6.5
#>  [85] reticulate_1.44.0         jquerylib_0.1.4
#>  [87] dichromat_2.0-0.1         Rcpp_1.1.0
#>  [89] dir.expiry_1.18.0         dbplyr_2.5.1
#>  [91] png_0.1-8                 parallel_4.5.1
#>  [93] blob_1.2.4                sparseMatrixStats_1.22.0
#>  [95] alabaster.se_1.10.0       viridisLite_0.4.2
#>  [97] scales_1.4.0              purrr_1.1.0
#>  [99] crayon_1.5.3              rlang_1.1.6
#> [101] KEGGREST_1.50.0
```

## References

Hie, Brian, Hyunghoon Cho, Benjamin DeMeo, Bryan Bryson, and Bonnie Berger. 2019. “Geometric Sketching Compactly Summarizes the Single-Cell Transcriptomic Landscape.” *Cell Syst* 8 (6): 483–493.e7.

Song, Dongyuan, Nan Miles Xi, Jingyi Jessica Li, and Lin Wang. 2022. “ScSampler: Fast Diversity-Preserving Subsampling of Large-Scale Single-Cell Transcriptomic Data.” *bioRxiv*, 2022.01.15.476407.