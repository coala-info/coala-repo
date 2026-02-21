# roastgsa vignette (gene set collections)

Adria Caballe-Mestres

#### 30 October 2025

# Contents

* [1 Installation](#installation)
* [2 Using gene set collections for battery testing](#using-gene-set-collections-for-battery-testing)
  + [2.1 Gene set collections](#gene-set-collections)
  + [2.2 Usage of Hallmarks in another example with real data](#usage-of-hallmarks-in-another-example-with-real-data)
* [3 sessionInfo](#sessioninfo)
* [4 References](#references)
* **Appendix**

# 1 Installation

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("roastgsa")
```

# 2 Using gene set collections for battery testing

## 2.1 Gene set collections

Several gene set databases are publicly available and can be used
for gene set analysis as part of the screening of bulk data for
hypothesis generation. The Hallmark gene set database [1] provides a
well-curated gene set list of
biological states which can be used to obtain an overall
characterization of the data. Other Human Molecular Signatures
Database (MSigDB) collections including
gene ontology pathways (Biological Process, Cellular Component,
Molecular Function), immunologic signature gene sets or regulatory
target gene sets can be employed for `roastgsa` analysis to identify
the most relevant expression changes between experimental conditions
for highly specific biological functions. These broad collections and
sub-collections can be downloaded through
<https://www.gsea-msigdb.org/gsea/msigdb/collections.jsp>.
Other public collections that can be employed for battery testing such
as the KEGG pathway database (<https://www.genome.jp/kegg/pathway.html>) [2]
or reactome (<https://reactome.org/>) [3] provide a
broad representation of gene sets for human diseases, metabolism or
cellular processes among others.

These gene set collections can be considered for `roastgsa` either by (1)
R loading the gene sets in a `list` object, each element containing
the gene identifiers for the testing set or (2) saving a `.gmt` file
with the whole collection in a specific folder, i.e.,

```
# DO NOT RUN
# gspath = "path/to/folder/of/h.all.v7.2.symbols.gmt"
# gsetsel = "h.all.v7.2.symbols.gmt"
```

## 2.2 Usage of Hallmarks in another example with real data

We download publicly available arrays from GEO, accession ‘GSE145603’, which
contain LGR5 and POLI double tumor cell populations in colorectal
cancer [4]

```
# DO NOT RUN
# library(GEOquery)
# data <- getGEO('GSE145603')
# normdata <- (data[[1]])
# pd <- pData(normdata)
# pd$group_LGR5 <- pd[["lgr5:ch1"]]
```

We are interested in screening the hallmarks with the largests changes
between LGR5 negative and LGR5 positive samples. The hallmark gene sets
are stored in `gspath` with the file name specified in `gsetsel`
(see specifications above).

The formula, design matrix and the corresponding contrast can be
obtained as follows

```
# DO NOT RUN
# form <- "~ -1 + group_LGR5"
# design <- model.matrix(as.formula(form),pd)
# cont.mat <- data.frame(Lgr5.high_Lgr5.neg = c(1,-1))
# rownames(cont.mat) <- colnames(design)
```

In microarrays, the expression values for each gene can be measured
in several probesets. To perform gene set analysis, we select the probeset
with maximum variability for every gene:

```
# DO NOT RUN
# mads <- apply(exprs(normdata), 1, mad)
# gu <- strsplit(fData(normdata)[["Gene Symbol"]], split=' \\/\\/\\/ ')
# names(gu) <- rownames(fData(normdata))
# gu <- gu[sapply(gu, length)==1]
# gu <- gu[gu!='' & !is.na(gu) & gu!='---']
# ps <- rep(names(gu), sapply(gu, length))
# gs <- unlist(gu)
# pss <- tapply(ps, gs, function(o) names(which.max(mads[o])))
# psgen.mvar <- pss
```

The `roastgsa` function is used for competitive gene set analysis testing:

```
# DO NOT RUN
# roast1 <- roastgsa(exprs(normdata), form = form, covar = pd,
#                    psel = psgen.mvar, contrast = cont.mat[, 1],
#                    gspath = gspath, gsetsel = gsetsel, nrot = 1000,
#                    mccores = 7, set.statistic = "maxmean")
#
# print(roast1)
#
```

Summary tables can be presented following the `roastgsa::htmlrgsa`
documentation.

# 3 sessionInfo

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
##  [1] DESeq2_1.50.0               SummarizedExperiment_1.40.0
##  [3] Biobase_2.70.0              MatrixGenerics_1.22.0
##  [5] matrixStats_1.5.0           GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [11] generics_0.1.4              roastgsa_1.8.0
## [13] knitr_1.50                  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6        xfun_0.53           bslib_0.9.0
##  [4] ggplot2_4.0.0       caTools_1.18.3      lattice_0.22-7
##  [7] vctrs_0.6.5         tools_4.5.1         bitops_1.0-9
## [10] parallel_4.5.1      tibble_3.3.0        pkgconfig_2.0.3
## [13] Matrix_1.7-4        KernSmooth_2.23-26  RColorBrewer_1.1-3
## [16] S7_0.2.0            lifecycle_1.0.4     compiler_4.5.1
## [19] farver_2.1.2        gplots_3.2.0        statmod_1.5.1
## [22] tinytex_0.57        codetools_0.2-20    htmltools_0.5.8.1
## [25] sass_0.4.10         yaml_2.3.10         pillar_1.11.1
## [28] jquerylib_0.1.4     BiocParallel_1.44.0 cachem_1.1.0
## [31] DelayedArray_0.36.0 limma_3.66.0        magick_2.9.0
## [34] abind_1.4-8         gtools_3.9.5        tidyselect_1.2.1
## [37] locfit_1.5-9.12     digest_0.6.37       dplyr_1.1.4
## [40] bookdown_0.45       labeling_0.4.3      fastmap_1.2.0
## [43] grid_4.5.1          cli_3.6.5           SparseArray_1.10.0
## [46] magrittr_2.0.4      S4Arrays_1.10.0     dichromat_2.0-0.1
## [49] withr_3.0.2         scales_1.4.0        rmarkdown_2.30
## [52] XVector_0.50.0      evaluate_1.0.5      rlang_1.1.6
## [55] Rcpp_1.1.0          glue_1.8.0          BiocManager_1.30.26
## [58] jsonlite_2.0.0      R6_2.6.1
```

# 4 References

# Appendix

[1] A. Liberzon, C. Birger, H. Thorvaldsdottir, M. Ghandi, J. P. Mesirov,
and P. Tamayo. The Molecular Signatures Database Hallmark Gene Set
Collection. Cell Systems, 1(6):417-425, 2015.

[2] M. Kanehisa et al. KEGG as a reference resource for gene and protein
annotation, Nucleic Acids Research, Volume 44, Issue D1, 4 January 2016,
D457–D462, <https://doi.org/10.1093/nar/gkv1070>

[3] M. Gillespie et al. The reactome pathway knowledgebase 2022, Nucleic
Acids Research, 2021;, gkab1028, <https://doi.org/10.1093/nar/gkab1028>

[4] Morral C, Stanisavljevic J, Hernando-Momblona X, et al. Zonation
of Ribosomal DNA Transcription Defines a Stem Cell Hierarchy in
Colorectal Cancer. Cell Stem
Cell. 2020;26(6):845-861.e12. doi:10.1016/j.stem.2020.04.012