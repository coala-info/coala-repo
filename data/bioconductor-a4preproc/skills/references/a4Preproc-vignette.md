# Vignette of the a4Preproc package

#### 2025-10-29

# 1 Introduction

This document explains the functionalities available in the **a4Preproc** package.

This package contains utility functions to pre-process data for the Automated Affymetrix Array Analysis suite of packages.

# 2 Get feature annotation for an ExpressionSet

The feature annotation for a specific dataset, as required by the pipeline is extracted with the `addGeneInfo` function.

```
library(ALL)
data(ALL)
a4ALL <- addGeneInfo(eset = ALL)
print(head(fData(a4ALL)))
```

```
##           ENTREZID       ENSEMBLID  SYMBOL
## 1000_at       5595 ENSG00000102882   MAPK3
## 1001_at       7075 ENSG00000066056    TIE1
## 1002_f_at     1557 ENSG00000165841 CYP2C19
## 1003_s_at      643 ENSG00000160683   CXCR5
## 1004_at        643 ENSG00000160683   CXCR5
## 1005_at       1843 ENSG00000120129   DUSP1
##                                                                  GENENAME
## 1000_at                                mitogen-activated protein kinase 3
## 1001_at   tyrosine kinase with immunoglobulin like and EGF like domains 1
## 1002_f_at                  cytochrome P450 family 2 subfamily C member 19
## 1003_s_at                                C-X-C motif chemokine receptor 5
## 1004_at                                  C-X-C motif chemokine receptor 5
## 1005_at                                    dual specificity phosphatase 1
```

```
print(head(featureData(a4ALL)))
```

```
## An object of class 'AnnotatedDataFrame'
##   featureNames: 1000_at 1001_at ... 1005_at (6 total)
##   varLabels: ENTREZID ENSEMBLID SYMBOL GENENAME
##   varMetadata: labelDescription
```

# 3 Appendix

## 3.1 Session information

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
##  [1] hgu95av2.db_3.13.0   org.Hs.eg.db_3.22.0  AnnotationDbi_1.72.0
##  [4] IRanges_2.44.0       S4Vectors_0.48.0     ALL_1.51.0
##  [7] Biobase_2.70.0       BiocGenerics_0.56.0  generics_0.1.4
## [10] a4Preproc_1.58.0
##
## loaded via a namespace (and not attached):
##  [1] bit_4.6.0         jsonlite_2.0.0    compiler_4.5.1    crayon_1.5.3
##  [5] blob_1.2.4        Biostrings_2.78.0 jquerylib_0.1.4   Seqinfo_1.0.0
##  [9] png_0.1-8         yaml_2.3.10       fastmap_1.2.0     R6_2.6.1
## [13] XVector_0.50.0    knitr_1.50        DBI_1.2.3         bslib_0.9.0
## [17] rlang_1.1.6       KEGGREST_1.50.0   cachem_1.1.0      xfun_0.53
## [21] sass_0.4.10       bit64_4.6.0-1     RSQLite_2.4.3     memoise_2.0.1
## [25] cli_3.6.5         digest_0.6.37     lifecycle_1.0.4   vctrs_0.6.5
## [29] evaluate_1.0.5    rmarkdown_2.30    httr_1.4.7        tools_4.5.1
## [33] pkgconfig_2.0.3   htmltools_0.5.8.1
```