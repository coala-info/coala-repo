# Single Cells with edgeR

This vignette demonstrates usage of Glimma on a single cell dataset. The data here comes from brain cells from the Zeisel A et al. (2015) study on mouse brain single cells. We will use the MDS plot to perform unsupervised clustering of the cells. A pseudo-bulk single cell aggregation approach with edgeR will be used to test for differential expression, and two styles of MA plots will be used to investigate the results.

This is a simplified workflow not intended to represent best practice, but to produce reasonable looking plots in the minimal amount of code. Please refer to a resource such [Orchestrating Single-Cell Analysis with Bioconductor](https://bioconductor.org/books/release/OSCA/) (OSCA) for appropriate workflows for analysis.

We start by loading in the data using the scRNAseq package.

```
library(scRNAseq)
library(scater)
library(scran)
library(Glimma)
library(edgeR)

sce <- ZeiselBrainData(ensembl=TRUE)
#> loading from cache
#> require("ensembldb")
#> Warning: Unable to map 1565 of 20006 requested IDs.
```

Once the data is loaded in we follow the OSCA procedure for identifying highly variable genes for creating a multi-dimensional scaling (MDS) plot. We use the functions provided by scran to identify the most highly variable genes rather than the algorithm within glimmaMDS, as scran is tailored towards single cells.

```
sce <- logNormCounts(sce)

var_mod <- modelGeneVar(sce)
hvg_genes <- getTopHVGs(var_mod, n=500)
hvg_sce <- sce[hvg_genes, ]

hvg_sce <- logNormCounts(hvg_sce)
```

Choosing to colour the MDS plot using `level1class` reveals separation between cell types.

```
glimmaMDS(
    exprs(hvg_sce),
    groups = colData(hvg_sce)
)
```

To demonstrate the MA plot we will perform a differential expression analysis using the pseudo-bulk approach. This involves creating pseudo-bulk samples by aggregating single cells as an analogue of biological replicates. Here the pseudo-bulk samples will be generated from combinations of `level1class` and `level2class`, the cells belonging to unique combinations of the two factors will be aggregated into samples.

```
colData(sce)$pb_group <-
    paste0(colData(sce)$level1class,
           "_",
           colData(sce)$level2class)

sce_counts <- counts(sce)
pb_counts <- t(rowsum(t(sce_counts), colData(sce)$pb_group))

pb_samples <- colnames(pb_counts)
pb_samples <- gsub("astrocytes_ependymal", "astrocytes-ependymal", pb_samples)
pb_split <- do.call(rbind, strsplit(pb_samples, "_"))
pb_sample_anno <- data.frame(
    sample = pb_samples,
    cell_type = pb_split[, 1],
    sample_group = pb_split[, 2]
)
```

With the pseudo-bulk annotations and counts we can construct a DGEList object.

```
pb_dge <- DGEList(
    counts = pb_counts,
    samples = pb_sample_anno,
    group = pb_sample_anno$cell_type
)

pb_dge <- calcNormFactors(pb_dge)
```

With this we perform differential expression analysis between “pyramidal SS” and “pyramidal CA1” samples using edgeR’s generalised linear models.

```
design <- model.matrix(~0 + cell_type, data = pb_dge$samples)
colnames(design) <- make.names(gsub("cell_type", "", colnames(design)))

pb_dge <- estimateDisp(pb_dge, design)

contr <- makeContrasts("pyramidal.SS - pyramidal.CA1", levels = design)

pb_fit <- glmFit(pb_dge, design)
pb_lrt <- glmLRT(pb_fit, contrast = contr)
```

The results of this analysis can be visualised using `glimmaMA()` as it would be for bulk RNA-seq.

```
glimmaMA(pb_lrt, dge = pb_dge)
```

An alternative view of the data can be constructed using the single cells in the expression plot rather than the pseudo-bulk samples. Since the MA plot is related to the expressions by only the genes in the rows, another expression matrix containing the same genes can be substituted in as below.

We construct a new DGE list from the raw single cell counts, then filter it down to just the cells used in our comparison and further down-sampled to 100 cells. This is done because Glimma does not handle a large number of cells well, the limit being a few hundred for most computers. Sampling still provides an approximate representation of the data without computation strain.

The code is not evaluated here to keep the vignette compact.

```
sc_dge <- DGEList(
    counts = sce_counts,
    group = colData(sce)$level1class
)

sc_dge <- sc_dge[, colData(sce)$level1class %in% c("pyramidal CA1", "pyramidal SS")]

glimmaMA(
    pb_lrt,
    dge = sc_dge[, sample(1:ncol(sc_dge), 100)]
)
```

# Session Info

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
#>  [1] ensembldb_2.34.0            AnnotationFilter_1.34.0
#>  [3] GenomicFeatures_1.62.0      AnnotationDbi_1.72.0
#>  [5] AnnotationHub_4.0.0         BiocFileCache_3.0.0
#>  [7] dbplyr_2.5.1                scran_1.38.0
#>  [9] scater_1.38.0               ggplot2_4.0.0
#> [11] scuttle_1.20.0              scRNAseq_2.23.1
#> [13] SingleCellExperiment_1.32.0 DESeq2_1.50.0
#> [15] SummarizedExperiment_1.40.0 Biobase_2.70.0
#> [17] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [19] GenomicRanges_1.62.0        Seqinfo_1.0.0
#> [21] IRanges_2.44.0              S4Vectors_0.48.0
#> [23] BiocGenerics_0.56.0         generics_0.1.4
#> [25] edgeR_4.8.0                 limma_3.66.0
#> [27] Glimma_2.20.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3       jsonlite_2.0.0           magrittr_2.0.4
#>   [4] ggbeeswarm_0.7.2         gypsum_1.6.0             farver_2.1.2
#>   [7] rmarkdown_2.30           BiocIO_1.20.0            vctrs_0.6.5
#>  [10] memoise_2.0.1            Rsamtools_2.26.0         RCurl_1.98-1.17
#>  [13] htmltools_0.5.8.1        S4Arrays_1.10.0          curl_7.0.0
#>  [16] BiocNeighbors_2.4.0      Rhdf5lib_1.32.0          SparseArray_1.10.0
#>  [19] rhdf5_2.54.0             sass_0.4.10              alabaster.base_1.10.0
#>  [22] bslib_0.9.0              htmlwidgets_1.6.4        alabaster.sce_1.10.0
#>  [25] httr2_1.2.1              cachem_1.1.0             GenomicAlignments_1.46.0
#>  [28] igraph_2.2.1             lifecycle_1.0.4          pkgconfig_2.0.3
#>  [31] rsvd_1.0.5               Matrix_1.7-4             R6_2.6.1
#>  [34] fastmap_1.2.0            digest_0.6.37            dqrng_0.4.1
#>  [37] irlba_2.3.5.1            ExperimentHub_3.0.0      RSQLite_2.4.3
#>  [40] beachmat_2.26.0          filelock_1.0.3           httr_1.4.7
#>  [43] abind_1.4-8              compiler_4.5.1           bit64_4.6.0-1
#>  [46] withr_3.0.2              S7_0.2.0                 BiocParallel_1.44.0
#>  [49] viridis_0.6.5            DBI_1.2.3                HDF5Array_1.38.0
#>  [52] alabaster.ranges_1.10.0  alabaster.schemas_1.10.0 rappdirs_0.3.3
#>  [55] DelayedArray_0.36.0      bluster_1.20.0           rjson_0.2.23
#>  [58] tools_4.5.1              vipor_0.4.7              beeswarm_0.4.0
#>  [61] glue_1.8.0               h5mread_1.2.0            restfulr_0.0.16
#>  [64] rhdf5filters_1.22.0      grid_4.5.1               cluster_2.1.8.1
#>  [67] gtable_0.3.6             metapod_1.18.0           BiocSingular_1.26.0
#>  [70] ScaledMatrix_1.18.0      XVector_0.50.0           ggrepel_0.9.6
#>  [73] BiocVersion_3.22.0       pillar_1.11.1            dplyr_1.1.4
#>  [76] lattice_0.22-7           rtracklayer_1.70.0       bit_4.6.0
#>  [79] tidyselect_1.2.1         locfit_1.5-9.12          Biostrings_2.78.0
#>  [82] knitr_1.50               gridExtra_2.3            ProtGenerics_1.42.0
#>  [85] xfun_0.53                statmod_1.5.1            UCSC.utils_1.6.0
#>  [88] lazyeval_0.2.2           yaml_2.3.10              evaluate_1.0.5
#>  [91] codetools_0.2-20         cigarillo_1.0.0          tibble_3.3.0
#>  [94] alabaster.matrix_1.10.0  BiocManager_1.30.26      cli_3.6.5
#>  [97] jquerylib_0.1.4          dichromat_2.0-0.1        Rcpp_1.1.0
#> [100] GenomeInfoDb_1.46.0      png_0.1-8                XML_3.99-0.19
#> [103] parallel_4.5.1           blob_1.2.4               bitops_1.0-9
#> [106] viridisLite_0.4.2        alabaster.se_1.10.0      scales_1.4.0
#> [109] purrr_1.1.0              crayon_1.5.3             rlang_1.1.6
#> [112] KEGGREST_1.50.0
```