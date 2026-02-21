# BioQC Algorithm: Speeding up the Wilcoxon-Mann-Whitney Test

#### Gregor Sturm and Jitao David Zhang

#### 2025-10-29

In this vignette, we explain the underlaying algorithmic details of our implementation of the Wilcoxon-Mann-Whitney test. The source code used to produce this document can be found in the github repository [BioQC](https://github.com/Accio/BioQC/vignettes).

*BioQC* is a R/Bioconductor package to detect tissue heterogeneity from high-throughput gene expression profiling data. It implements an efficient Wilcoxon-Mann-Whitney test, and offers tissue-specific gene signatures that are ready to use ‘out of the box’.

## Algorithmic improvements

The Wilcoxon-Mann-Whitney (WMW) test is a non-parametric statistical test to test if median values of two population are equal or not. Unlike the t-test, it does not require the assumption of normal distributions, which makes it more robust against noise.

We improved the computational efficiency of the Wilcoxon-Mann-Whitney test in comparison to the native R implementation based on three modifications:

1. The approximative WMW-statistic (Zar, J. H. (1999). Biostatistical analysis. Pearson Education India. *pp.* 174-177) is used. The differences to the exact version are negligible for high-throughput gene expression data.
2. The core algorithm is implemented in C instead of R as programming language.
3. BioQC avoids futile expensive sorting operations.

While (1) and (2) are straightforward, we elaborate (3) in the following.

Let \(W\_{a,b}\) be the approximative WMW test of two gene vectors \(a,b\), where \(a\) is the gene set of interest, typically containing less than a few hundreds of genes, and \(b\) is the set of all genes outside the gene set (*background genes*) typically containing \(>10000\) genes. In the context of BioQC, the gene sets are referred to as *tissue signatures*.

Given an \(m \times n\) input matrix of gene expression data with \(m\) genes and \(n\) samples \(s\_1, \dots, s\_n\), and \(k\) gene sets \(d\_1, \dots, d\_k\), the WMW-test needs to be applied for each sample \(s\_i, i \in 1..n\) and each gene set \(d\_j, j \in 1..k\). The runtime of the WMW-test is essentially determined by the sorting operation on the two input vectors. Using native R `wilcox.test`, the vectors \(a\) and \(b\) are sorted individually for each gene set. However, in the context of gene set analysis, this is futile, as the (large) background set changes insignificantly in relation to the (small) gene set, when testing different gene sets on the same sample.

Therefore, we approximate the WMW-test by extending \(b\) to all genes in the sample, keeping the background unchanged when testing multiple gene sets. Like this, \(b\) has to be sorted only once per sample. The individual gene sets still need to be sorted, which is not a major issue, as they are small in comparison to the set of background genes.

![BioQC speeds up the Wilcoxon-Mann-Whitney test by avoiding futile sorting operations on the same sample.](wmw-speedup.png)

BioQC speeds up the Wilcoxon-Mann-Whitney test by avoiding futile sorting operations on the same sample.

## Time benchmark

To demonstrate BioQC’s superior performance, we apply both BioQC and the native R `wilcox.test` to random expression matrices and measure the runtime.

We setup random expression matrices of 193512 human genes of 1, 5, 10, 50, or 100 samples. Genes are \(i.i.d\) distributed following \(\mathcal{N}(0,1)\). The native R and the *BioQC* implementations of the Wilcoxon-Mann-Whitney test are applied to the matrices respectively.

The numeric results of both implementations, `bioqcNumRes` (from *BioQC*) and `rNumRes` (from *R*), are equivalent, as shown by the next command.

```
expect_equal(bioqcNumRes, rNumRes)
```

The *BioQC* implementation is more than 500 times faster: while it takes about one second for BioQC to calculate enrichment scores of all 155 signatures in 100 samples, the native R implementation takes about 20 minutes:

![**Figure 2**: Time benchmark results of BioQC and R implementation of Wilcoxon-Mann-Whitney test. Left panel: elapsed time in seconds (logarithmic Y-axis). Right panel: ratio of elapsed time by two implementations. All results achieved by a single thread on in a RedHat Linux server.](bioqc-efficiency_files/figure-html/time_benchmark_vis-1.png)

**Figure 2**: Time benchmark results of BioQC and R implementation of Wilcoxon-Mann-Whitney test. Left panel: elapsed time in seconds (logarithmic Y-axis). Right panel: ratio of elapsed time by two implementations. All results achieved by a single thread on in a RedHat Linux server.

## Conclusion

We have shown that *BioQC* achieves identical results as the native implementation in two orders of magnitude less time. This renders *BioQC* a highly efficient tool for quality control of large-scale high-throughput gene expression data.

## R Session Info

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
##  [1] rbenchmark_1.0.0     gplots_3.2.0         gridExtra_2.3
##  [4] latticeExtra_0.6-31  lattice_0.22-7       org.Hs.eg.db_3.22.0
##  [7] AnnotationDbi_1.72.0 IRanges_2.44.0       S4Vectors_0.48.0
## [10] testthat_3.2.3       limma_3.66.0         RColorBrewer_1.1-3
## [13] BioQC_1.38.0         Biobase_2.70.0       BiocGenerics_0.56.0
## [16] generics_0.1.4       knitr_1.50
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0    gtable_0.3.6       xfun_0.53          bslib_0.9.0
##  [5] caTools_1.18.3     vctrs_0.6.5        tools_4.5.1        bitops_1.0-9
##  [9] RSQLite_2.4.3      blob_1.2.4         pkgconfig_2.0.3    KernSmooth_2.23-26
## [13] desc_1.4.3         lifecycle_1.0.4    compiler_4.5.1     deldir_2.0-4
## [17] Biostrings_2.78.0  brio_1.1.5         statmod_1.5.1      Seqinfo_1.0.0
## [21] htmltools_0.5.8.1  sass_0.4.10        yaml_2.3.10        crayon_1.5.3
## [25] jquerylib_0.1.4    cachem_1.1.0       gtools_3.9.5       locfit_1.5-9.12
## [29] digest_0.6.37      rprojroot_2.1.1    fastmap_1.2.0      grid_4.5.1
## [33] cli_3.6.5          magrittr_2.0.4     edgeR_4.8.0        bit64_4.6.0-1
## [37] rmarkdown_2.30     XVector_0.50.0     httr_1.4.7         jpeg_0.1-11
## [41] bit_4.6.0          interp_1.1-6       png_0.1-8          memoise_2.0.1
## [45] evaluate_1.0.5     rlang_1.1.6        Rcpp_1.1.0         glue_1.8.0
## [49] DBI_1.2.3          pkgload_1.4.1      jsonlite_2.0.0     R6_2.6.1
```