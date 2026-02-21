# Comparing the Wilcoxon-Mann-Whitney to alternative statistical tests

#### 2025-10-29

In this document, we show that the Wilcoxon-Mann-Whitney test is comparable or superior to alternative methods.

Two alternative methods could be compared with the Wilcoxon-Mann-Whitney (WMW) test proposed by BioQC: the Kolmogorov-Smirnov (KS) test, and the Student’s t-test, or more particularly, the Welch’s test which does not assume equal sample number or equal variance, which is appropriate in the setting of gene expression studies.

1. It is documented in statistics literature that the WMW test offers a higher power than the Kolmogorov-Smirnov test[1](#fn1),[2](#fn2).
2. Compared with parameterized test methods such as the t-test, the WMW test is (a) resistance to monotone transformation, (b) suffers less from outliers, and (c) provides higher efficiency when many genes are profiled and the distribution of gene expression deviates from the normal distribution, which are important criteria in genome-wide expression data.

Based on these considerations, BioQC implements a computationally efficient version of the WMW test. In order not to confuse end-users, no alternative methods are implemented.

Nevertheless, in order to demonstrate the power of WMW test in comparison with the KS-test or the t-test, we performed the sensitivity benchmark described in the [simulation studies](bioqc-simulation.html), for the two alternative tests respectively.

![**Figure 1:** Sensitivity benchmark. Expression levels of genes in the ovary signature are dedicately sampled randomly from normal distributions with different mean values. The lines show the enrichment score for the Wilcoxon-Mann-Whitney test, the t-test and the Kolmogorov-Smirnov test respectively. In the right panel, outliers were added by adding a random value to 1% of the simulated genes. ](bioqc-wmw-test-performance_files/figure-html/sensitivity_benchmark_fig-1.png)

**Figure 1:** Sensitivity benchmark. Expression levels of genes in the ovary signature are dedicately sampled randomly from normal distributions with different mean values. The lines show the enrichment score for the Wilcoxon-Mann-Whitney test, the t-test and the Kolmogorov-Smirnov test respectively. In the right panel, outliers were added by adding a random value to 1% of the simulated genes.

As expected, the results suggest, that both the KS-test and the WMW-test are robust to noise, while the performance of the t-test drops significantly on noisy data. Additionally, the WMW-test appears to be superior to the KS-test for low expression differences.

## Computational Performance

Since the KS-test is so slow, we did not replicate the sensitivity benchmark from the [simulation studies](bioqc-simulation.html) using the enrichment score rank. While it takes BioQC about 4 seconds on a single thread to test all 155 signatures, it already takes the KS-test about 3 seconds to test a single signature.

```
##       test replications elapsed relative
## 2  runKS()            5  12.759    1.000
## 1 runWMW()            5  17.679    1.386
```

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
##  [1] ggplot2_4.0.0         plyr_1.8.9            reshape2_1.4.4
##  [4] hgu133plus2.db_3.13.0 rbenchmark_1.0.0      gplots_3.2.0
##  [7] gridExtra_2.3         latticeExtra_0.6-31   lattice_0.22-7
## [10] org.Hs.eg.db_3.22.0   AnnotationDbi_1.72.0  IRanges_2.44.0
## [13] S4Vectors_0.48.0      testthat_3.2.3        limma_3.66.0
## [16] RColorBrewer_1.1-3    BioQC_1.38.0          Biobase_2.70.0
## [19] BiocGenerics_0.56.0   generics_0.1.4        knitr_1.50
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1   dplyr_1.1.4        farver_2.1.2       blob_1.2.4
##  [5] Biostrings_2.78.0  S7_0.2.0           bitops_1.0-9       fastmap_1.2.0
##  [9] digest_0.6.37      lifecycle_1.0.4    statmod_1.5.1      KEGGREST_1.50.0
## [13] RSQLite_2.4.3      magrittr_2.0.4     compiler_4.5.1     rlang_1.1.6
## [17] sass_0.4.10        tools_4.5.1        yaml_2.3.10        labeling_0.4.3
## [21] interp_1.1-6       bit_4.6.0          pkgload_1.4.1      KernSmooth_2.23-26
## [25] withr_3.0.2        desc_1.4.3         grid_4.5.1         caTools_1.18.3
## [29] edgeR_4.8.0        scales_1.4.0       gtools_3.9.5       dichromat_2.0-0.1
## [33] cli_3.6.5          rmarkdown_2.30     crayon_1.5.3       httr_1.4.7
## [37] DBI_1.2.3          cachem_1.1.0       stringr_1.5.2      XVector_0.50.0
## [41] vctrs_0.6.5        jsonlite_2.0.0     bit64_4.6.0-1      jpeg_0.1-11
## [45] locfit_1.5-9.12    jquerylib_0.1.4    glue_1.8.0         stringi_1.8.7
## [49] gtable_0.3.6       deldir_2.0-4       tibble_3.3.0       pillar_1.11.1
## [53] htmltools_0.5.8.1  Seqinfo_1.0.0      brio_1.1.5         R6_2.6.1
## [57] rprojroot_2.1.1    evaluate_1.0.5     png_0.1-8          memoise_2.0.1
## [61] bslib_0.9.0        Rcpp_1.1.0         xfun_0.53          pkgconfig_2.0.3
```

## References

---

1. Irizarry, Rafael A., et al. “Gene set enrichment analysis made simple.”Statistical methods in medical research 18.6 (2009): 565-575.[↩︎](#fnref1)
2. Filion, Guillaume J. “The signed Kolmogorov-Smirnov test: why it should not be used.” GigaScience 4.1 (2015): 1.[↩︎](#fnref2)