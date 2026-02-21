# Docker/Singularity Containers

#### Authors: *Brian Schilder*

#### Vignette updated: *Jan-05-2026*

# Contents

* [1 Installation](#installation)
  + [1.1 Method 1: via Docker](#method-1-via-docker)
    - [1.1.1 NOTES](#notes)
  + [1.2 Method 2: via Singularity](#method-2-via-singularity)
* [2 Usage](#usage)
* [3 Session Info](#session-info)

# 1 Installation

orthogene is now available via [ghcr.io](https://ghcr.io/ghcr.io/neurogenomics/orthogene)
as a containerised environment with Rstudio and
all necessary dependencies pre-installed.

## 1.1 Method 1: via Docker

First, [install Docker](https://docs.docker.com/get-docker/)
if you have not already.

Create an image of the [Docker](https://www.docker.com/) container
in command line:

```
docker pull ghcr.io/neurogenomics/orthogene
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
  ghcr.io/neurogenomics/orthogene
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
singularity pull docker://ghcr.io/neurogenomics/orthogene
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
## [1] orthogene_1.16.1 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6              babelgene_22.9
##  [3] xfun_0.55                 bslib_0.9.0
##  [5] ggplot2_4.0.1             htmlwidgets_1.6.4
##  [7] rstatix_0.7.3             lattice_0.22-7
##  [9] vctrs_0.6.5               tools_4.5.2
## [11] generics_0.1.4            yulab.utils_0.2.3
## [13] parallel_4.5.2            tibble_3.3.0
## [15] pkgconfig_2.0.3           Matrix_1.7-4
## [17] data.table_1.18.0         homologene_1.4.68.19.3.27
## [19] ggplotify_0.1.3           RColorBrewer_1.1-3
## [21] S7_0.2.1                  lifecycle_1.0.4
## [23] compiler_4.5.2            farver_2.1.2
## [25] treeio_1.34.0             carData_3.0-5
## [27] ggtree_4.0.4              gprofiler2_0.2.4
## [29] fontLiberation_0.1.0      fontquiver_0.2.1
## [31] ggfun_0.2.0               htmltools_0.5.9
## [33] sass_0.4.10               yaml_2.3.12
## [35] lazyeval_0.2.2            plotly_4.11.0
## [37] Formula_1.2-5             pillar_1.11.1
## [39] car_3.1-3                 ggpubr_0.6.2
## [41] jquerylib_0.1.4           tidyr_1.3.2
## [43] cachem_1.1.0              abind_1.4-8
## [45] fontBitstreamVera_0.1.1   nlme_3.1-168
## [47] tidyselect_1.2.1          aplot_0.2.9
## [49] digest_0.6.39             dplyr_1.1.4
## [51] purrr_1.2.0               bookdown_0.46
## [53] fastmap_1.2.0             grid_4.5.2
## [55] cli_3.6.5                 magrittr_2.0.4
## [57] patchwork_1.3.2           dichromat_2.0-0.1
## [59] broom_1.0.11              ape_5.8-1
## [61] gdtools_0.4.4             scales_1.4.0
## [63] backports_1.5.0           rappdirs_0.3.3
## [65] httr_1.4.7                rmarkdown_2.30
## [67] otel_0.2.0                ggsignif_0.6.4
## [69] evaluate_1.0.5            knitr_1.51
## [71] viridisLite_0.4.2         gridGraphics_0.5-1
## [73] rlang_1.1.6               ggiraph_0.9.2
## [75] Rcpp_1.1.0                glue_1.8.0
## [77] tidytree_0.4.6            BiocManager_1.30.27
## [79] jsonlite_2.0.0            R6_2.6.1
## [81] systemfonts_1.3.1         fs_1.6.6
```