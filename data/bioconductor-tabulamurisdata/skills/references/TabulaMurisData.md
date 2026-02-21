# Tabula Muris data

Charlotte Soneson

#### 4 November 2025

#### Package

TabulaMurisData 1.28.0

# Contents

* [1 Load Tabula Muris data](#load-tabula-muris-data)
* [2 Explore data with `iSEE`](#explore-data-with-isee)
* [3 Session info](#session-info)

# 1 Load Tabula Muris data

The `TabulaMurisData` data package provides access to the 10x and SmartSeq2
single-cell RNA-seq data sets from
[the Tabula Muris Consortium](http://tabula-muris.ds.czbiohub.org/).
The contents of the package can be seen by querying the ExperimentHub for the
package name.

```
suppressPackageStartupMessages({
    library(ExperimentHub)
    library(SingleCellExperiment)
    library(TabulaMurisData)
})

eh <- ExperimentHub()
query(eh, "TabulaMurisData")
#> ExperimentHub with 2 records
#> # snapshotDate(): 2025-10-29
#> # $dataprovider: Tabula Muris Consortium
#> # $species: Mus musculus
#> # $rdataclass: SingleCellExperiment
#> # additional mcols(): taxonomyid, genome, description,
#> #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
#> #   rdatapath, sourceurl, sourcetype
#> # retrieve records with, e.g., 'object[["EH1617"]]'
#>
#>            title
#>   EH1617 | TabulaMurisDroplet
#>   EH1618 | TabulaMurisSmartSeq2
```

The individual data sets can be accessed using either their ExperimentHub
accession number, or the convenience functions provided in this package. For
example, for the 10x data:

```
droplet <- eh[["EH1617"]]
#> see ?TabulaMurisData and browseVignettes('TabulaMurisData') for documentation
#> loading from cache
droplet
#> class: SingleCellExperiment
#> dim: 23341 70118
#> metadata(0):
#> assays(1): counts
#> rownames(23341): 0610005C13Rik 0610007C21Rik ... Zzef1 Zzz3
#> rowData names(2): ID Symbol
#> colnames(70118): 10X_P4_0_AAACCTGAGATTACCC 10X_P4_0_AAACCTGAGTGCCAGA
#>   ... 10X_P8_15_TTTGTCATCTTACCGC 10X_P8_15_TTTGTCATCTTGTTTG
#> colData names(10): cell channel ... cell_ontology_id free_annotation
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
droplet <- TabulaMurisDroplet()
#> see ?TabulaMurisData and browseVignettes('TabulaMurisData') for documentation
#> loading from cache
droplet
#> class: SingleCellExperiment
#> dim: 23341 70118
#> metadata(0):
#> assays(1): counts
#> rownames(23341): 0610005C13Rik 0610007C21Rik ... Zzef1 Zzz3
#> rowData names(2): ID Symbol
#> colnames(70118): 10X_P4_0_AAACCTGAGATTACCC 10X_P4_0_AAACCTGAGTGCCAGA
#>   ... 10X_P8_15_TTTGTCATCTTACCGC 10X_P8_15_TTTGTCATCTTGTTTG
#> colData names(10): cell channel ... cell_ontology_id free_annotation
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
```

# 2 Explore data with `iSEE`

Each data set is provided in the form of a `SingleCellExperiment` object. To
gain further insights into the contents of the data sets, they can be explored
using, e.g., the *[iSEE](https://bioconductor.org/packages/3.22/iSEE)* package. For the purposes of this vignette,
we first subsample a small subset of the cells in the 10x data set, to reduce
the run time.

```
set.seed(1234)
se <- droplet[, sample(seq_len(ncol(droplet)), 250, replace = FALSE)]
se
#> class: SingleCellExperiment
#> dim: 23341 250
#> metadata(0):
#> assays(1): counts
#> rownames(23341): 0610005C13Rik 0610007C21Rik ... Zzef1 Zzz3
#> rowData names(2): ID Symbol
#> colnames(250): 10X_P8_12_ACGGGCTGTCAGAGGT 10X_P7_10_CGTCCATGTTATGCGT
#>   ... 10X_P7_9_TGACAACGTGTAAGTA 10X_P8_14_GATCTAGCACGGCCAT
#> colData names(10): cell channel ... cell_ontology_id free_annotation
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
```

Next, we calculate size factors and normalize the data using the
*[scran](https://bioconductor.org/packages/3.22/scran)* and *[scater](https://bioconductor.org/packages/3.22/scater)* packages, and perform dimension
reduction using PCA and t-SNE.

```
se <- scran::computeSumFactors(se)
se <- scater::logNormCounts(se)
se <- scater::runPCA(se)
se <- scater::runTSNE(se)
```

Finally, we call `iSEE` with the subsampled `SingleCellExperiment` object. This
opens up an instance of `iSEE` containing the provided data set.

```
if (require(iSEE)) {
    iSEE(se)
}
```

# 3 Session info

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
#>  [1] TabulaMurisData_1.28.0      SingleCellExperiment_1.32.0
#>  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
#>  [7] IRanges_2.44.0              S4Vectors_0.48.0
#>  [9] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [11] ExperimentHub_3.0.0         AnnotationHub_4.0.0
#> [13] BiocFileCache_3.0.0         dbplyr_2.5.1
#> [15] BiocGenerics_0.56.0         generics_0.1.4
#> [17] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] DBI_1.2.3            gridExtra_2.3        httr2_1.2.1
#>  [4] rlang_1.1.6          magrittr_2.0.4       scater_1.38.0
#>  [7] compiler_4.5.1       RSQLite_2.4.3        png_0.1-8
#> [10] vctrs_0.6.5          pkgconfig_2.0.3      crayon_1.5.3
#> [13] fastmap_1.2.0        XVector_0.50.0       scuttle_1.20.0
#> [16] rmarkdown_2.30       ggbeeswarm_0.7.2     purrr_1.1.0
#> [19] bit_4.6.0            xfun_0.54            bluster_1.20.0
#> [22] cachem_1.1.0         beachmat_2.26.0      jsonlite_2.0.0
#> [25] blob_1.2.4           DelayedArray_0.36.0  BiocParallel_1.44.0
#> [28] irlba_2.3.5.1        parallel_4.5.1       cluster_2.1.8.1
#> [31] R6_2.6.1             bslib_0.9.0          RColorBrewer_1.1-3
#> [34] limma_3.66.0         jquerylib_0.1.4      Rcpp_1.1.0
#> [37] bookdown_0.45        knitr_1.50           Matrix_1.7-4
#> [40] igraph_2.2.1         tidyselect_1.2.1     viridis_0.6.5
#> [43] dichromat_2.0-0.1    abind_1.4-8          yaml_2.3.10
#> [46] codetools_0.2-20     curl_7.0.0           lattice_0.22-7
#> [49] tibble_3.3.0         withr_3.0.2          KEGGREST_1.50.0
#> [52] S7_0.2.0             Rtsne_0.17           evaluate_1.0.5
#> [55] Biostrings_2.78.0    pillar_1.11.1        BiocManager_1.30.26
#> [58] filelock_1.0.3       BiocVersion_3.22.0   ggplot2_4.0.0
#> [61] scales_1.4.0         glue_1.8.0           metapod_1.18.0
#> [64] tools_4.5.1          BiocNeighbors_2.4.0  ScaledMatrix_1.18.0
#> [67] locfit_1.5-9.12      scran_1.38.0         grid_4.5.1
#> [70] AnnotationDbi_1.72.0 edgeR_4.8.0          beeswarm_0.4.0
#> [73] BiocSingular_1.26.0  vipor_0.4.7          cli_3.6.5
#> [76] rsvd_1.0.5           rappdirs_0.3.3       viridisLite_0.4.2
#> [79] S4Arrays_1.10.0      dplyr_1.1.4          gtable_0.3.6
#> [82] sass_0.4.10          digest_0.6.37        ggrepel_0.9.6
#> [85] SparseArray_1.10.1   dqrng_0.4.1          farver_2.1.2
#> [88] memoise_2.0.1        htmltools_0.5.8.1    lifecycle_1.0.4
#> [91] httr_1.4.7           statmod_1.5.1        bit64_4.6.0-1
```