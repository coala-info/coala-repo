# New Implementation of the HIBAG Algorithm with Latest Intel Intrinsics

#### Dr. Xiuwen Zheng

#### Sep, 2020

* [Benchmarks on building the training models](#benchmarks-on-building-the-training-models)
  + [1) Speedup factor using small training sets](#speedup-factor-using-small-training-sets)
  + [2) Speedup factor using medium training sets](#speedup-factor-using-medium-training-sets)
  + [3) Speedup factor using large training sets](#speedup-factor-using-large-training-sets)
* [Multithreading](#multithreading)
* [Session Info](#session-info)
* [References](#references)

## Benchmarks on building the training models

Benchmarks were run on the compute nodes of Cascade Lake microarchitecture (Intel Xeon Gold 6248 CPU@2.50GHz). The HIBAG package was compiled with GCC v8.3.0 in R-v4.0.2. In HIBAG (>= v1.26.1), users can use `hlaSetKernelTarget()` to select the target intrinsics, or `hlaSetKernelTarget("max")` for maximizing the algorithm efficiency.

**GCC (>= v6.0)** is recommended to compile the HIBAG package. In the benchmarks, the kernel version of HIBAG\_v1.24 is v1.4, and the kernel version of newer package is v1.5.

```
# continue without interrupting
IgnoreError <- function(cmd) tryCatch(cmd, error=function(e) { message("Not support"); invisible() })
```

```
IgnoreError(hlaSetKernelTarget("sse4"))
```

```
## [1] "64-bit, SSE4.2, POPCNT"
## [2] "13.3.0, GNUG_v13.3.0"
## [3] "Algorithm SIMD: SSE2 SSE4.2 AVX AVX2 AVX512F AVX512BW AVX512VPOPCNTDQ"
```

```
IgnoreError(hlaSetKernelTarget("avx"))
```

```
## [1] "64-bit, AVX"
## [2] "13.3.0, GNUG_v13.3.0"
## [3] "Algorithm SIMD: SSE2 SSE4.2 AVX AVX2 AVX512F AVX512BW AVX512VPOPCNTDQ"
```

```
IgnoreError(hlaSetKernelTarget("avx2"))
```

```
## [1] "64-bit, AVX2"
## [2] "13.3.0, GNUG_v13.3.0"
## [3] "Algorithm SIMD: SSE2 SSE4.2 AVX AVX2 AVX512F AVX512BW AVX512VPOPCNTDQ"
```

```
IgnoreError(hlaSetKernelTarget("avx512f"))
```

```
## [1] "64-bit, AVX512F"
## [2] "13.3.0, GNUG_v13.3.0"
## [3] "Algorithm SIMD: SSE2 SSE4.2 AVX AVX2 AVX512F AVX512BW AVX512VPOPCNTDQ"
```

```
IgnoreError(hlaSetKernelTarget("avx512bw"))
```

```
## [1] "64-bit, AVX512BW"
## [2] "13.3.0, GNUG_v13.3.0"
## [3] "Algorithm SIMD: SSE2 SSE4.2 AVX AVX2 AVX512F AVX512BW AVX512VPOPCNTDQ"
```

The CPU may reduce the frequency of the cores dynamically to keep power usage of AVX512 within bounds, `hlaSetKernelTarget("auto.avx2")` can automatically select AVX2 even if the CPU supports the AVX512F and AVX512BW intrinsics. Please check the CPU throttling with AVX512 intrinsics.

### 1) Speedup factor using small training sets

![](data:image/png;base64...)

### 2) Speedup factor using medium training sets

![](data:image/png;base64...)

### 3) Speedup factor using large training sets

![](data:image/png;base64...)

## Multithreading

The multi-threaded implementation can be enabled by specifying the number of threads via `nthread` in the function `hlaAttrBagging()`, or `hlaParallelAttrBagging(cl=nthread, ...)`.

Here are the performance of multithreading and the comparison between AVX2 and AVX512BW:

![](data:image/png;base64...)

# Session Info

```
sessionInfo()
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
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB
##  [4] LC_COLLATE=C               LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C
## [10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] ggplot2_4.0.0 HIBAG_1.46.0
##
## loaded via a namespace (and not attached):
##  [1] crayon_1.5.3          vctrs_0.6.5           cli_3.6.5             knitr_1.50
##  [5] rlang_1.1.6           xfun_0.53             generics_0.1.4        S7_0.2.0
##  [9] jsonlite_2.0.0        labeling_0.4.3        RcppParallel_5.1.11-1 glue_1.8.0
## [13] htmltools_0.5.8.1     sass_0.4.10           scales_1.4.0          rmarkdown_2.30
## [17] grid_4.5.1            tibble_3.3.0          evaluate_1.0.5        jquerylib_0.1.4
## [21] fastmap_1.2.0         yaml_2.3.10           lifecycle_1.0.4       compiler_4.5.1
## [25] dplyr_1.1.4           RColorBrewer_1.1-3    pkgconfig_2.0.3       farver_2.1.2
## [29] digest_0.6.37         R6_2.6.1              tidyselect_1.2.1      dichromat_2.0-0.1
## [33] pillar_1.11.1         magrittr_2.0.4        bslib_0.9.0           withr_3.0.2
## [37] tools_4.5.1           gtable_0.3.6          cachem_1.1.0
```

# References

* Zheng X, *et al*. (2014). HIBAG – HLA Genotype Imputation with Attribute Bagging. *The Pharmacogenomics Journal*. <https://doi.org/10.1038/tpj.2013.18>.
* Zheng X (2018). Imputation-based HLA Typing with SNPs in GWAS Studies. *Methods in Molecular Biology*. <https://doi.org/10.1007/978-1-4939-8546-3_11>.
* Intel AVX2 intrinsics: <https://www.intel.com/content/www/us/en/develop/documentation/cpp-compiler-developer-guide-and-reference/top/compiler-reference/intrinsics/intrinsics-for-avx2.html>.
* Intel AVX-512 overview: <https://www.intel.com/content/www/us/en/architecture-and-technology/avx-512-overview.html>.
* National Center for Supercomputing Applications (UIUC): <https://www.ncsa.illinois.edu>.