Code

* Show All Code
* Hide All Code

# Single Cell Proteomics data sets

Laurent Gatto and Christophe Vanderaa

#### 4 November 2025

#### Package

scpdata 1.18.0

# 1 The `scpdata` package

`scpdata` disseminates mass spectrometry (MS)-based single-cell
proteomics (SCP) data sets formatted using the `scp` data structure.
The data structure is described in the
[`scp` vignette](http://www.bioconductor.org/packages/release/bioc/vignettes/scp/inst/doc/scp.html).

In this vignette, we describe how to access the SCP data sets. To
start, we load the `scpdata` package.

```
library("scpdata")
```

# 2 Load data from `ExperimentHub`

The data is stored using the
[`ExperimentHub`](https://bioconductor.org/packages/release/bioc/html/ExperimentHub.html)
infrastructure. We first create a connection with `ExperimentHub`.

```
eh <- ExperimentHub()
```

You can list all data sets available in `scpdata` using the query
function.

```
query(eh, "scpdata")
#> ExperimentHub with 30 records
#> # snapshotDate(): 2025-10-29
#> # $dataprovider: MassIVE, PRIDE, SlavovLab website, Dataverse
#> # $species: Homo sapiens, Mus musculus, Rattus norvegicus, Gallus gallus
#> # $rdataclass: QFeatures, SingleCellExperiment
#> # additional mcols(): taxonomyid, genome, description,
#> #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
#> #   rdatapath, sourceurl, sourcetype
#> # retrieve records with, e.g., 'object[["EH3899"]]'
#>
#>            title
#>   EH3899 | specht2019v2
#>   EH3900 | specht2019v3
#>   EH3901 | dou2019_lysates
#>   EH3902 | dou2019_mouse
#>   EH3903 | dou2019_boosting
#>   ...      ...
#>   EH9498 | petrosius2023_AstralAML
#>   EH9609 | krull2024
#>   EH9610 | hu2023_K562
#>   EH9611 | hu2023_oocyte
#>   EH9627 | ai2025a
```

Another way to get information about the available data sets is to
call `scpdata()`. This will retrieve all the available metadata. For
example, we can retrieve the data set titles along with the
description to make an informed choice about which data set to choose.

```
info <- scpdata()
knitr::kable(info[, c("title", "description")])
```

|  | title | description |
| --- | --- | --- |
| EH3899 | specht2019v2 | SCP expression data for monocytes (U-937) and macrophages at PSM, peptide and protein level |
| EH3900 | specht2019v3 | SCP expression data for more monocytes (U-937) and macrophages at PSM, peptide and protein level |
| EH3901 | dou2019\_lysates | SCP expression data for Hela digests (0.2 or 10 ng) at PSM and protein level |
| EH3902 | dou2019\_mouse | SCP expression data for C10, SVEC or Raw cells at PSM and protein level |
| EH3903 | dou2019\_boosting | SCP expression data for C10, SVEC or Raw cells and 3 boosters (0, 5 or 50 ng) at PSM and protein level |
| EH3904 | zhu2018MCP | Near SCP expression data for micro-dissection rat brain samples (50, 100, or 200 µm width) at PSM level |
| EH3905 | zhu2018NC\_hela | Near SCP expression data for HeLa samples (aproximately 12, 40, or 140 cells) at PSM level |
| EH3906 | zhu2018NC\_lysates | Near SCP expression data for HeLa lysates (10, 40 and 140 cell equivalent) at PSM level |
| EH3907 | zhu2018NC\_islets | Near SCP expression data for micro-dissected human pancreas samples (control patients or type 1 diabetes) at PSM level |
| EH3908 | cong2020AC | SCP expression data for Hela cells at PSM, peptide and protein level |
| EH3909 | zhu2019EL | SCP expression data for chicken utricle samples (1, 3, 5 or 20 cells) at PSM, peptide and protein level |
| EH6011 | liang2020\_hela | Expression data for HeLa cells (0, 1, 10, 150, 500 cells) at PSM, peptide and protein level |
| EH7085 | schoof2021 | Single-cell proteomics data from OCI-AML8227 cell culture to reconstruct the cellular hierarchy. |
| EH7295 | williams2020\_lfq | Single-cell label free proteomics data from a MCF10A cell line culture. |
| EH7296 | williams2020\_tmt | Single-cell proteomics data from three acute myeloid leukemia cell line culture (MOLM-14, K562, CMK). |
| EH7712 | derks2022 | Single-cell and bulk (100-cell) proteomics data of PDAC, melanoma cells and monocytes. |
| EH7713 | brunner2022 | Single-cell proteomics data of cell cycle stages in HeLa. |
| EH8301 | leduc2022\_pSCoPE | Single-cell proteomics data of 878 melanoma cells and 877 monocytes (pSCoPE). |
| EH8302 | leduc2022\_plexDIA | Single-cell proteomics data of 126 melanoma cells (plexDIA). |
| EH8303 | woo2022\_macrophage | Single-cell proteomics data from LPS-treated macrophages. |
| EH8304 | woo2022\_lung | Single-cell proteomics data from primary human lung cells. |
| EH9450 | gregoire2023\_mixCTRL | Single-cell proteomics data from two monocyte cell lines |
| EH9477 | khan2023 | Single-cell proteomics data of 421 MCF-10A cells undergoing EMT triggered by TGF-beta |
| EH9487 | guise2024 | Single-cell proteomics data of 108 postmortem CTL or ALS spinal moto neurons |
| EH9497 | petrosius2023\_mES | Mouse embryonic stem cells across ground-state (m2i) and differentiation-permissive (m15) culture conditions. |
| EH9498 | petrosius2023\_AstralAML | Single-cell proteomics data of 4 cell types from the OCI-AML8227 model. |
| EH9609 | krull2024 | Single-cell proteomics data IFN-Y response of U-2 OS cells |
| EH9610 | hu2023\_K562 | Single-cell proteomics data of K562 cells |
| EH9611 | hu2023\_oocyte | Single-cell proteomics data of oocytes |
| EH9627 | ai2025a | Single-cell proteomics data of adult cardiomyocytes from Ai et al. (2025) |

To get one of the data sets (*e.g.* `dou2019_lysates`) you can either
retrieve it using the `ExperimentHub` query function

```
scp <- eh[["EH3901"]]
#> see ?scpdata and browseVignettes('scpdata') for documentation
#> loading from cache
scp
#> An instance of class QFeatures (type: scp) with 4 sets:
#>
#>  [1] Hela_run_1: SingleCellExperiment with 24562 rows and 10 columns
#>  [2] Hela_run_2: SingleCellExperiment with 24310 rows and 10 columns
#>  [3] peptides: SingleCellExperiment with 13934 rows and 20 columns
#>  [4] proteins: SingleCellExperiment with 1641 rows and 20 columns
```

or you can the use the built-in functions from `scpdata`

```
scp <- dou2019_lysates()
#> see ?scpdata and browseVignettes('scpdata') for documentation
#> loading from cache
scp
#> An instance of class QFeatures (type: scp) with 4 sets:
#>
#>  [1] Hela_run_1: SingleCellExperiment with 24562 rows and 10 columns
#>  [2] Hela_run_2: SingleCellExperiment with 24310 rows and 10 columns
#>  [3] peptides: SingleCellExperiment with 13934 rows and 20 columns
#>  [4] proteins: SingleCellExperiment with 1641 rows and 20 columns
```

# 3 Data sets information

Each data set has been extensively documented in a separate man page
(*e.g.* `?dou2019_lysates`). You can find information about the data
content, the acquisition protocol, the data collection procedure as
well as the data sources and reference.

# 4 Data manipulation

For more information about manipulating the data sets, check the
[`scp`](http://bioconductor.org/packages/release/bioc/html/scp.html)
package. The `scp`
[vignette](http://bioconductor.org/packages/release/bioc/vignettes/scp/inst/doc/scp.html)
will guide you through a typical SCP data processing workflow. Once
your data is loaded from `scpdata` you can skip section 2
*Read in SCP data* of the `scp` vignette.

# Session information

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
 [1] scpdata_1.18.0              ExperimentHub_3.0.0
 [3] AnnotationHub_4.0.0         BiocFileCache_3.0.0
 [5] dbplyr_2.5.1                QFeatures_1.20.0
 [7] MultiAssayExperiment_1.36.0 SummarizedExperiment_1.40.0
 [9] Biobase_2.70.0              GenomicRanges_1.62.0
[11] Seqinfo_1.0.0               IRanges_2.44.0
[13] S4Vectors_0.48.0            BiocGenerics_0.56.0
[15] generics_0.1.4              MatrixGenerics_1.22.0
[17] matrixStats_1.5.0           BiocStyle_2.38.0

loaded via a namespace (and not attached):
 [1] tidyselect_1.2.1            dplyr_1.1.4
 [3] blob_1.2.4                  filelock_1.0.3
 [5] Biostrings_2.78.0           SingleCellExperiment_1.32.0
 [7] fastmap_1.2.0               lazyeval_0.2.2
 [9] digest_0.6.37               lifecycle_1.0.4
[11] cluster_2.1.8.1             ProtGenerics_1.42.0
[13] KEGGREST_1.50.0             RSQLite_2.4.3
[15] magrittr_2.0.4              compiler_4.5.1
[17] rlang_1.1.6                 sass_0.4.10
[19] tools_4.5.1                 igraph_2.2.1
[21] yaml_2.3.10                 knitr_1.50
[23] S4Arrays_1.10.0             bit_4.6.0
[25] curl_7.0.0                  DelayedArray_0.36.0
[27] plyr_1.8.9                  abind_1.4-8
[29] withr_3.0.2                 purrr_1.1.0
[31] grid_4.5.1                  MASS_7.3-65
[33] cli_3.6.5                   rmarkdown_2.30
[35] crayon_1.5.3                httr_1.4.7
[37] reshape2_1.4.4              BiocBaseUtils_1.12.0
[39] DBI_1.2.3                   cachem_1.1.0
[41] stringr_1.5.2               AnnotationDbi_1.72.0
[43] AnnotationFilter_1.34.0     BiocManager_1.30.26
[45] XVector_0.50.0              vctrs_0.6.5
[47] Matrix_1.7-4                jsonlite_2.0.0
[49] bookdown_0.45               bit64_4.6.0-1
[51] clue_0.3-66                 tidyr_1.3.1
[53] jquerylib_0.1.4             glue_1.8.0
[55] stringi_1.8.7               BiocVersion_3.22.0
[57] tibble_3.3.0                pillar_1.11.1
[59] rappdirs_0.3.3              htmltools_0.5.8.1
[61] R6_2.6.1                    httr2_1.2.1
[63] evaluate_1.0.5              lattice_0.22-7
[65] png_0.1-8                   memoise_2.0.1
[67] bslib_0.9.0                 Rcpp_1.1.0
[69] SparseArray_1.10.1          xfun_0.54
[71] MsCoreUtils_1.22.0          pkgconfig_2.0.3
```

# 5 License

This vignette is distributed under a
[CC BY-SA license](https://creativecommons.org/licenses/by-sa/2.0/).