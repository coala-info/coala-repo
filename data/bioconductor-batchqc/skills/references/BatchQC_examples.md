# BatchQC Examples

W. Evan Johnson1,2\*, Jessica McClintock1\*\* and Solaiappan Manimaran3

1Division of Infectious Disease, Department of Medicine, Rutgers University
2Director, Center for Data Science, Rutgers University
3Computational Biomedicine, Department of Medicine, Boston University

\*wj183@njms.rutgers.edu
\*\*jessica.mcclintock@rutgers.edu

#### 12 February 2026

#### Package

BatchQC 2.6.1

# Contents

* [1 Example 1: Protein Data](#example-1-protein-data)
* [2 Example 2: Signature Data](#example-2-signature-data)
* [3 Example 3: Bladderbatch Data](#example-3-bladderbatch-data)
* [4 Example 4: TB Data](#example-4-tb-data)
* [Session info](#session-info)

# 1 Example 1: Protein Data

This data set is from protein expression data captured for 39 proteins.
It has two batches and two conditions corresponding to case and control.

```
library(BatchQC)
data(protein_data)
data(protein_sample_info)
se_object <- BatchQC::summarized_experiment(protein_data, protein_sample_info)
```

# 2 Example 2: Signature Data

This data set is from signature data captured when activating different growth
pathway genes in human mammary epithelial cells (GEO accession: GSE73628).
This data consists of three batches and ten different conditions corresponding
to control and nine different pathways

```
data(signature_data)
data(batch_indicator)
se_object <- BatchQC::summarized_experiment(signature_data, batch_indicator)
```

# 3 Example 3: Bladderbatch Data

This data set is from bladder cancer data. This dataset has 57 bladder samples
with 5 batches and 3 covariate levels (cancer, biopsy, control). Batch 1
contains only cancer, 2 has cancer and controls, 3 has only controls, 4 contains
only biopsy, and 5 contains cancer and biopsy. This data set is from the
bladderbatch package which must be installed to use this data example set (Leek
JT (2023). bladderbatch: Bladder gene expression data illustrating batch
effects. R package version 1.38.0).

```
if (!requireNamespace("bladderbatch", quietly = TRUE))
    BiocManager::install("bladderbatch")
se_object <- BatchQC::bladder_data_upload()
```

# 4 Example 4: TB Data

This is a whole blood gene expression profiling from well and malnourished
Indian individuals with TB and severely malnourished household contacts with
latent TB infection (LTBI). Severe malnutrition was defined as body mass index
<16. kg/m2 in adults and based on weight-for-height Z scores in children <18
years. Gene expression was measured using RNA-sequencing. (VanValkenburg A, et
al. Malnutrition leads to increased inflammation and expression of tuberculosis
risk signatures in recently exposed household contacts of pulmonary
tuberculosis. Front Immunol. 2022 Sep 28;13:1011166.
doi: 10.3389/fimmu.2022.1011166")

```
if (!requireNamespace("curatedTBData", quietly = TRUE))
    BiocManager::install("curatedTBData")
se_object <- BatchQC::tb_data_upload()
```

# Session info

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
## [1] Biobase_2.70.0      S4Vectors_0.48.0    BiocGenerics_0.56.0
## [4] generics_0.1.4      curatedTBData_2.6.0 BatchQC_2.6.1
## [7] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] shinythemes_1.2.0           splines_4.5.2
##   [3] later_1.4.5                 bitops_1.0-9
##   [5] filelock_1.0.3              tibble_3.3.1
##   [7] XML_3.99-0.22               lifecycle_1.0.5
##   [9] httr2_1.2.2                 edgeR_4.8.2
##  [11] lattice_0.22-9              MASS_7.3-65
##  [13] crosstalk_1.2.2             MultiAssayExperiment_1.36.1
##  [15] magrittr_2.0.4              limma_3.66.0
##  [17] plotly_4.12.0               sass_0.4.10
##  [19] rmarkdown_2.30              jquerylib_0.1.4
##  [21] yaml_2.3.12                 metapod_1.18.0
##  [23] httpuv_1.6.16               otel_0.2.0
##  [25] askpass_1.2.1               reticulate_1.44.1
##  [27] reader_1.0.6                DBI_1.2.3
##  [29] RColorBrewer_1.1-3          abind_1.4-8
##  [31] GenomicRanges_1.62.1        purrr_1.2.1
##  [33] rappdirs_0.3.4              sva_3.58.0
##  [35] IRanges_2.44.0              irlba_2.3.7
##  [37] genefilter_1.92.0           testthat_3.3.2
##  [39] pheatmap_1.0.13             umap_0.2.10.0
##  [41] RSpectra_0.16-2             annotate_1.88.0
##  [43] dqrng_0.4.1                 codetools_0.2-20
##  [45] DelayedArray_0.36.0         scuttle_1.20.0
##  [47] tidyselect_1.2.1            farver_2.1.2
##  [49] ScaledMatrix_1.18.0         matrixStats_1.5.0
##  [51] BiocFileCache_3.0.0         Seqinfo_1.0.0
##  [53] jsonlite_2.0.0              BiocNeighbors_2.4.0
##  [55] survival_3.8-6              tools_4.5.2
##  [57] ggnewscale_0.5.2            Rcpp_1.1.1
##  [59] glue_1.8.0                  SparseArray_1.10.8
##  [61] BiocBaseUtils_1.12.0        xfun_0.56
##  [63] mgcv_1.9-4                  DESeq2_1.50.2
##  [65] MatrixGenerics_1.22.0       dplyr_1.2.0
##  [67] withr_3.0.2                 BiocManager_1.30.27
##  [69] fastmap_1.2.0               bluster_1.20.0
##  [71] shinyjs_2.1.1               openssl_2.3.4
##  [73] caTools_1.18.3              digest_0.6.39
##  [75] rsvd_1.0.5                  R6_2.6.1
##  [77] mime_0.13                   gtools_3.9.5
##  [79] dichromat_2.0-0.1           RSQLite_2.4.6
##  [81] utf8_1.2.6                  tidyr_1.3.2
##  [83] data.table_1.18.2.1         FNN_1.1.4.1
##  [85] httr_1.4.7                  htmlwidgets_1.6.4
##  [87] S4Arrays_1.10.1             pkgconfig_2.0.3
##  [89] gtable_0.3.6                NCmisc_1.2.0
##  [91] blob_1.3.0                  S7_0.2.1
##  [93] SingleCellExperiment_1.32.0 XVector_0.50.0
##  [95] brio_1.1.5                  htmltools_0.5.9
##  [97] bookdown_0.46               scales_1.4.0
##  [99] tidyverse_2.0.0             blockmodeling_1.1.8
## [101] png_0.1-8                   scran_1.38.0
## [103] EBSeq_2.8.0                 ggdendro_0.2.0
## [105] knitr_1.51                  reshape2_1.4.5
## [107] nlme_3.1-168                curl_7.0.0
## [109] cachem_1.1.0                stringr_1.6.0
## [111] BiocVersion_3.22.0          KernSmooth_2.23-26
## [113] parallel_4.5.2              AnnotationDbi_1.72.0
## [115] pillar_1.11.1               grid_4.5.2
## [117] vctrs_0.7.1                 gplots_3.3.0
## [119] promises_1.5.0              BiocSingular_1.26.1
## [121] dbplyr_2.5.1                beachmat_2.26.0
## [123] xtable_1.8-4                cluster_2.1.8.2
## [125] evaluate_1.0.5              tinytex_0.58
## [127] magick_2.9.0                cli_3.6.5
## [129] locfit_1.5-9.12             compiler_4.5.2
## [131] rlang_1.1.7                 crayon_1.5.3
## [133] labeling_0.4.3              plyr_1.8.9
## [135] stringi_1.8.7               viridisLite_0.4.3
## [137] BiocParallel_1.44.0         Biostrings_2.78.0
## [139] lazyeval_0.2.2              Matrix_1.7-4
## [141] ExperimentHub_3.0.0         RcppEigen_0.3.4.0.2
## [143] bit64_4.6.0-1               ggplot2_4.0.2
## [145] KEGGREST_1.50.0             statmod_1.5.1
## [147] shiny_1.12.1                SummarizedExperiment_1.40.0
## [149] AnnotationHub_4.0.0         igraph_2.2.2
## [151] memoise_2.0.1               bslib_0.10.0
## [153] bit_4.6.0
```