# tuberculosis

Lucas Schiffer, MPH1\*

1Section of Computational Biomedicine, Boston University School of Medicine, Boston, MA, U.S.A.

\*schifferl@bu.edu

#### 4 November 2025

#### Abstract

The tuberculosis R/Bioconductor package features tuberculosis gene expression data for machine learning. All human samples from GEO that did not come from cell lines, were not taken postmortem, and did not feature recombination have been included. The package has more than 10,000 samples from both microarray and sequencing studies that have been processed from raw data through a hyper-standardized, reproducible pipeline.

#### Package

tuberculosis 1.16.0

# Contents

* [1 The Pipeline](#the-pipeline)
* [2 Installation](#installation)
* [3 Load Package](#load-package)
* [4 Finding Data](#finding-data)
* [5 Getting Data](#getting-data)
* [6 No Metadata?](#no-metadata)
* [7 ML Analysis?](#ml-analysis)
* [8 Session Info](#session-info)

# 1 The Pipeline

To fully understand the provenance of data in the *[tuberculosis](https://bioconductor.org/packages/3.22/tuberculosis)* R/Bioconductor package, please see the [tuberculosis.pipeline](https://github.com/schifferl/tuberculosis.pipeline) GitHub repository; however, all users beyond the extremely curious can ignore these details without consequence. Yet, a brief summary of data processing is appropriate here. Microarray data were processed from raw files (e.g. `CEL` files) and background corrected using the normal-exponential method and the saddle-point approximation to maximum likelihood as implemented in the *[limma](https://bioconductor.org/packages/3.22/limma)* R/Bioconductor package; no normalization of expression values was done; where platforms necessitated it, the RMA (robust multichip average) algorithm without background correction or normalization was used to generate an expression matrix. Sequencing data were processed from raw files (i.e. `fastq` files) using the [nf-core/rnaseq](https://nf-co.re/rnaseq/1.4.2) pipeline inside a Singularity container; the GRCh38 genome build was used for alignment. Gene names for both microarray and sequencing data are HGNC-approved GRCh38 gene names from the [genenames.org](https://www.genenames.org/) REST API.

# 2 Installation

To install *[tuberculosis](https://bioconductor.org/packages/3.22/tuberculosis)* from Bioconductor, use *[BiocManager](https://CRAN.R-project.org/package%3DBiocManager)* as follows.

```
BiocManager::install("tuberculosis")
```

To install *[tuberculosis](https://bioconductor.org/packages/3.22/tuberculosis)* from GitHub, use *[BiocManager](https://CRAN.R-project.org/package%3DBiocManager)* as follows.

```
BiocManager::install("schifferl/tuberculosis", dependencies = TRUE, build_vignettes = TRUE)
```

Most users should simply install *[tuberculosis](https://bioconductor.org/packages/3.22/tuberculosis)* from Bioconductor.

# 3 Load Package

To use the package without double colon syntax, it should be loaded as follows.

```
library(tuberculosis)
```

The package is lightweight, with few dependencies, and contains no data itself.

# 4 Finding Data

To find data, users will use the `tuberculosis` function with a regular expression pattern to list available resources. The resources are organized by [GEO](https://www.ncbi.nlm.nih.gov/geo/) series accession numbers. If multiple platforms were used in a single study, the platform accession number follows the series accession number and is separated by a dash. The date before the series accession number denotes the date the resource was created.

```
tuberculosis("GSE103147")
```

```
## 2021-09-15.GSE103147
```

The function will print the names of matching resources as a message and return them invisibly as a character vector. To see all available resources use `"."` for the `pattern` argument.

# 5 Getting Data

To get data, users will also use the `tuberculosis` function, but with an additional argument, `dryrun = FALSE`. This will either download resources from *[ExperimentHub](https://bioconductor.org/packages/3.22/ExperimentHub)* or load them from the user’s local cache. If a resource has multiple creation dates, the most recent is selected by default; add a date to override this behavior.

```
tuberculosis("GSE103147", dryrun = FALSE)
```

```
## $`2021-09-15.GSE103147`
## class: SummarizedExperiment
## dim: 24353 1649
## metadata(0):
## assays(1): exprs
## rownames(24353): A1BG A1BG-AS1 ... ZZEF1 ZZZ3
## rowData names(0):
## colnames(1649): SRR5980424 SRR5980425 ... SRR5982072 SRR5982073
## colData names(0):
```

The function returns a `list` of `SummarizedExperiment` objects, each with a single assay, `exprs`, where the rows are features (genes) and the columns are observations (samples). If multiple resources are requested, multiple resources will be returned, each as a `list` element.

```
tuberculosis("GSE10799.", dryrun = FALSE)
```

```
## $`2021-09-15.GSE107991`
## class: SummarizedExperiment
## dim: 24353 54
## metadata(0):
## assays(1): exprs
## rownames(24353): A1BG A1BG-AS1 ... ZZEF1 ZZZ3
## rowData names(0):
## colnames(54): SRR6369879 SRR6369880 ... SRR6369931 SRR6369932
## colData names(0):
##
## $`2021-09-15.GSE107992`
## class: SummarizedExperiment
## dim: 24353 47
## metadata(0):
## assays(1): exprs
## rownames(24353): A1BG A1BG-AS1 ... ZZEF1 ZZZ3
## rowData names(0):
## colnames(47): SRR6369945 SRR6369946 ... SRR6369990 SRR6369991
## colData names(0):
##
## $`2021-09-15.GSE107993`
## class: SummarizedExperiment
## dim: 24353 138
## metadata(0):
## assays(1): exprs
## rownames(24353): A1BG A1BG-AS1 ... ZZEF1 ZZZ3
## rowData names(0):
## colnames(138): SRR6370167 SRR6370168 ... SRR6370303 SRR6370304
## colData names(0):
##
## $`2021-09-15.GSE107994`
## class: SummarizedExperiment
## dim: 24353 175
## metadata(0):
## assays(1): exprs
## rownames(24353): A1BG A1BG-AS1 ... ZZEF1 ZZZ3
## rowData names(0):
## colnames(175): SRR6369992 SRR6369993 ... SRR6370165 SRR6370166
## colData names(0):
##
## $`2021-09-15.GSE107995`
## class: SummarizedExperiment
## dim: 24353 414
## metadata(0):
## assays(1): exprs
## rownames(24353): A1BG A1BG-AS1 ... ZZEF1 ZZZ3
## rowData names(0):
## colnames(414): SRR6369879 SRR6369880 ... SRR6370303 SRR6370304
## colData names(0):
```

The `assay` of each `SummarizedExperiment` object is named `exprs` rather than `counts` because it can come from either a microarray or a sequencing platform. If `colnames` begin with `GSE`, data comes from a microarray platform; if `colnames` begin with `SRR`, data comes from a sequencing platform.

# 6 No Metadata?

The `SummarizedExperiment` objects do not have sample metadata as `colData`, and this limits their use to unsupervised analyses for the time being. Sample metadata are currently undergoing manual curation, with the same level of diligence that was applied in data processing, and will be included in the package when they are ready.

# 7 ML Analysis?

No Bioconductor package is complete without at least a miniature demonstration analysis, but it is difficult to provide any substantial machine learning analysis without the necessary labels. Therefore, a only a dimension reduction, that is by no means machine learning, is provided here for example with the expectation that it will be replaced in the future.

The largest resource available in the *[tuberculosis](https://bioconductor.org/packages/3.22/tuberculosis)* package comes from [GEO](https://www.ncbi.nlm.nih.gov/geo/) series accession `GSE103147`, data that was originally published by Zak *et al.* in 2016.111 Zak, D. E. *et al.* A blood RNA signature for tuberculosis disease risk: a prospective cohort study. *Lancet* **387**, 2312–2322 (2016) To download this data for use in dimension reduction, the `tuberculosis` function is used; then, `magrittr::use_series` is used to select the `SummarizedExperiment` object from the `list` that was returned.

```
zak_data <-
    tuberculosis("GSE103147", dryrun = FALSE) |>
    magrittr::use_series("2021-09-15.GSE103147")
```

Even though they are not used, the sample identifiers (i.e. column names) of the `zak_data` will become the row names of the UMAP `data.frame`, and they are serialized below for use in setting row names later.

```
row_names <-
    base::colnames(zak_data)
```

Serialization is also done for column names, only they are created using `purrr::map_chr` instead. The embedding will be in two dimensions, therefore axis labels, `UMAP1` and `UMAP2`, are created.

```
col_names <-
    purrr::map_chr(1:2, ~ base::paste("UMAP", .x, sep = ""))
```

The *[scater](https://bioconductor.org/packages/3.22/scater)* package is used to calculate UMAP coordinates, which are piped to *[magrittr](https://CRAN.R-project.org/package%3Dmagrittr)* to set the row and column names. Once the `matrix` returned by `scater::calculateUMAP` is coerced to a `data.frame`, *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)* is used to plot the embedding and *[hrbrthemes](https://CRAN.R-project.org/package%3Dhrbrthemes)* is used for theming.

```
scater::calculateUMAP(zak_data, exprs_values = "exprs") |>
    magrittr::set_rownames(row_names) |>
    magrittr::set_colnames(col_names) |>
    base::as.data.frame() |>
    ggplot2::ggplot(mapping = ggplot2::aes(UMAP1, UMAP2)) +
    ggplot2::geom_point()
```

![](data:image/png;base64...)

The embedding displays four distinct clusters, perhaps pertaining to stages of progression of tuberculosis infection as distinct classes; although, definitive conclusions are difficult to make without sufficient labeling of clinical sequelae. Again, as stated above, such labels are currently being curated, and will be included in the package when they are ready.

# 8 Session Info

```
utils::sessionInfo()
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
##  [1] tuberculosis_1.16.0         SummarizedExperiment_1.40.0
##  [3] Biobase_2.70.0              GenomicRanges_1.62.0
##  [5] Seqinfo_1.0.0               IRanges_2.44.0
##  [7] S4Vectors_0.48.0            BiocGenerics_0.56.0
##  [9] generics_0.1.4              MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3                   gridExtra_2.3
##  [3] httr2_1.2.1                 rlang_1.1.6
##  [5] magrittr_2.0.4              scater_1.38.0
##  [7] compiler_4.5.1              RSQLite_2.4.3
##  [9] png_0.1-8                   vctrs_0.6.5
## [11] stringr_1.5.2               pkgconfig_2.0.3
## [13] crayon_1.5.3                fastmap_1.2.0
## [15] magick_2.9.0                dbplyr_2.5.1
## [17] XVector_0.50.0              scuttle_1.20.0
## [19] labeling_0.4.3              rmarkdown_2.30
## [21] ggbeeswarm_0.7.2            tinytex_0.57
## [23] purrr_1.1.0                 bit_4.6.0
## [25] xfun_0.54                   cachem_1.1.0
## [27] beachmat_2.26.0             jsonlite_2.0.0
## [29] blob_1.2.4                  DelayedArray_0.36.0
## [31] BiocParallel_1.44.0         irlba_2.3.5.1
## [33] parallel_4.5.1              R6_2.6.1
## [35] bslib_0.9.0                 stringi_1.8.7
## [37] RColorBrewer_1.1-3          jquerylib_0.1.4
## [39] Rcpp_1.1.0                  bookdown_0.45
## [41] knitr_1.50                  FNN_1.1.4.1
## [43] Matrix_1.7-4                tidyselect_1.2.1
## [45] dichromat_2.0-0.1           abind_1.4-8
## [47] yaml_2.3.10                 viridis_0.6.5
## [49] codetools_0.2-20            curl_7.0.0
## [51] lattice_0.22-7              tibble_3.3.0
## [53] withr_3.0.2                 KEGGREST_1.50.0
## [55] S7_0.2.0                    evaluate_1.0.5
## [57] BiocFileCache_3.0.0         ExperimentHub_3.0.0
## [59] Biostrings_2.78.0           pillar_1.11.1
## [61] BiocManager_1.30.26         filelock_1.0.3
## [63] BiocVersion_3.22.0          ggplot2_4.0.0
## [65] scales_1.4.0                glue_1.8.0
## [67] tools_4.5.1                 AnnotationHub_4.0.0
## [69] BiocNeighbors_2.4.0         ScaledMatrix_1.18.0
## [71] grid_4.5.1                  tidyr_1.3.1
## [73] AnnotationDbi_1.72.0        SingleCellExperiment_1.32.0
## [75] beeswarm_0.4.0              BiocSingular_1.26.0
## [77] vipor_0.4.7                 cli_3.6.5
## [79] rsvd_1.0.5                  rappdirs_0.3.3
## [81] S4Arrays_1.10.0             viridisLite_0.4.2
## [83] dplyr_1.1.4                 uwot_0.2.3
## [85] gtable_0.3.6                sass_0.4.10
## [87] digest_0.6.37               SparseArray_1.10.1
## [89] ggrepel_0.9.6               farver_2.1.2
## [91] memoise_2.0.1               htmltools_0.5.8.1
## [93] lifecycle_1.0.4             httr_1.4.7
## [95] bit64_4.6.0-1
```