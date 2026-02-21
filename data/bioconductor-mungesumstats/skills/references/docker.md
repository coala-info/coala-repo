# Docker/Singularity Containers

#### Authors: *Alan Murphy, Brian Schilder, Nathan Skene*

#### Vignette updated: *Jan-08-2026*

# Contents

* [1 Installation](#installation)
  + [1.1 Method 1: via Docker](#method-1-via-docker)
    - [1.1.1 NOTES](#notes)
  + [1.2 Method 2: via Singularity](#method-2-via-singularity)
* [2 Usage](#usage)
* [3 Session Info](#session-info)

# 1 Installation

MungeSumstats is now available via [ghcr.io](https://ghcr.io/ghcr.io/neurogenomics/MungeSumstats)
as a containerised environment with Rstudio and
all necessary dependencies pre-installed.

## 1.1 Method 1: via Docker

First, [install Docker](https://docs.docker.com/get-docker/)
if you have not already.

Create an image of the [Docker](https://www.docker.com/) container
in command line:

```
docker pull ghcr.io/neurogenomics/MungeSumstats
```

Once the image has been created, you can launch it with:

```
docker run \
  -d \
  -e ROOT=true \
  -e PASSWORD="<your_password>" \
  -v ~/Desktop:/Desktop \
  -v /Volumes:/Volumes \
  -p 8900:8787 \
  ghcr.io/neurogenomics/MungeSumstats
```

### 1.1.1 NOTES

* Make sure to replace `<your_password>` above with whatever you want your password to be.
* Change the paths supplied to the `-v` flags for your particular use case.
* The `-d` ensures the container will run in “detached” mode,
  which means it will persist even after you’ve closed your command line session.
* The username will be *“rstudio”* by default.
* Optionally, you can also install the [Docker Desktop](https://www.docker.com/products/docker-desktop/)
  to easily manage your containers.

## 1.2 Method 2: via Singularity

If you are using a system that does not allow Docker
(as is the case for many institutional computing clusters),
you can instead [install Docker images via Singularity](https://docs.sylabs.io/guides/2.6/user-guide/singularity_and_docker.html).

```
singularity pull docker://ghcr.io/neurogenomics/MungeSumstats
```

For troubleshooting, see the [Singularity documentation](https://docs.sylabs.io/guides/latest/user-guide/singularity_and_docker.html#github-container-registry).

# 2 Usage

Finally, launch the containerised Rstudio by entering the
following URL in any web browser:
*http://localhost:8900/*

Login using the credentials set during the Installation steps.

# 3 Session Info

```
utils::sessionInfo()
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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] MungeSumstats_1.18.1 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1
##  [2] dplyr_1.1.4
##  [3] blob_1.2.4
##  [4] R.utils_2.13.0
##  [5] Biostrings_2.78.0
##  [6] bitops_1.0-9
##  [7] fastmap_1.2.0
##  [8] RCurl_1.98-1.17
##  [9] VariantAnnotation_1.56.0
## [10] GenomicAlignments_1.46.0
## [11] XML_3.99-0.20
## [12] digest_0.6.39
## [13] lifecycle_1.0.5
## [14] KEGGREST_1.50.0
## [15] RSQLite_2.4.5
## [16] magrittr_2.0.4
## [17] compiler_4.5.2
## [18] rlang_1.1.6
## [19] sass_0.4.10
## [20] tools_4.5.2
## [21] yaml_2.3.12
## [22] data.table_1.18.0
## [23] rtracklayer_1.70.1
## [24] knitr_1.51
## [25] S4Arrays_1.10.1
## [26] bit_4.6.0
## [27] curl_7.0.0
## [28] DelayedArray_0.36.0
## [29] ieugwasr_1.1.0
## [30] abind_1.4-8
## [31] BiocParallel_1.44.0
## [32] BiocGenerics_0.56.0
## [33] R.oo_1.27.1
## [34] grid_4.5.2
## [35] stats4_4.5.2
## [36] SummarizedExperiment_1.40.0
## [37] cli_3.6.5
## [38] rmarkdown_2.30
## [39] crayon_1.5.3
## [40] generics_0.1.4
## [41] otel_0.2.0
## [42] BSgenome.Hsapiens.1000genomes.hs37d5_0.99.1
## [43] httr_1.4.7
## [44] rjson_0.2.23
## [45] DBI_1.2.3
## [46] cachem_1.1.0
## [47] stringr_1.6.0
## [48] parallel_4.5.2
## [49] AnnotationDbi_1.72.0
## [50] BiocManager_1.30.27
## [51] XVector_0.50.0
## [52] restfulr_0.0.16
## [53] matrixStats_1.5.0
## [54] vctrs_0.6.5
## [55] Matrix_1.7-4
## [56] jsonlite_2.0.0
## [57] bookdown_0.46
## [58] IRanges_2.44.0
## [59] S4Vectors_0.48.0
## [60] bit64_4.6.0-1
## [61] GenomicFiles_1.46.0
## [62] GenomicFeatures_1.62.0
## [63] jquerylib_0.1.4
## [64] glue_1.8.0
## [65] codetools_0.2-20
## [66] stringi_1.8.7
## [67] GenomeInfoDb_1.46.2
## [68] BiocIO_1.20.0
## [69] GenomicRanges_1.62.1
## [70] UCSC.utils_1.6.1
## [71] tibble_3.3.0
## [72] pillar_1.11.1
## [73] SNPlocs.Hsapiens.dbSNP155.GRCh37_0.99.24
## [74] htmltools_0.5.9
## [75] Seqinfo_1.0.0
## [76] BSgenome_1.78.0
## [77] R6_2.6.1
## [78] evaluate_1.0.5
## [79] lattice_0.22-7
## [80] Biobase_2.70.0
## [81] R.methodsS3_1.8.2
## [82] png_0.1-8
## [83] Rsamtools_2.26.0
## [84] cigarillo_1.0.0
## [85] memoise_2.0.1
## [86] bslib_0.9.0
## [87] SparseArray_1.10.8
## [88] xfun_0.55
## [89] MatrixGenerics_1.22.0
## [90] pkgconfig_2.0.3
```