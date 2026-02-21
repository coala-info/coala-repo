# PTR-TOF-MS volatolomics datasets description

Camille Roquencourt, Stanislas Grassin Delyle and Etienne Thevenot

#### 4 November 2025

#### Package

ptairData 1.18.0

# 1 Installation

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("ptairData")
```

# 2 Description

This package contains two volatolomics raw datasets acquired with a Proton-Transfer-Reaction Time-of-Flight mass spectrometer (PTR-TOF-MS; Ionicon Analytik GmbH, Innsbruck, Austria). They are stored in two subfolders:

* **exhaledAir**: Exhaled air from two healthy individuals, three acquisitions per individual on distinct days [6 files in total], with two expirations per acquisition and Buffered end-tidal (BET) sampling [Herbig et al, 2008](http://stacks.iop.org/1752-7163/2/i%3D3/a%3D037008?key=crossref.6c1463e66d0714dce9de2a6cfe05bf66))
* **mycobacteria**: cell culture headspace: two replicates from two species and one control (culture medium only) [6 files]

# 3 Format

The files are in the open Hierarchical Data Format ([HDF5](https://www.hdfgroup.org)). To limit the size of the data and speed up the analysis in demo examples, the raw data are truncated in the m/z dimension within the range \([20.4, 21.6] \cup [50, 150]\) for individuals, and \([20.4, 21.6] \cup [56.4, 90.6]\) for mycobacteria.

# 4 Processing

The ptairMS package (also available on Bioconductor) is devoted to the processing of PTR-TOF-MS data.

# 5 Session info

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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] digest_0.6.37       R6_2.6.1            bookdown_0.45
#>  [4] fastmap_1.2.0       xfun_0.54           cachem_1.1.0
#>  [7] knitr_1.50          htmltools_0.5.8.1   rmarkdown_2.30
#> [10] lifecycle_1.0.4     cli_3.6.5           sass_0.4.10
#> [13] jquerylib_0.1.4     compiler_4.5.1      tools_4.5.1
#> [16] evaluate_1.0.5      bslib_0.9.0         yaml_2.3.10
#> [19] BiocManager_1.30.26 jsonlite_2.0.0      rlang_1.1.6
```