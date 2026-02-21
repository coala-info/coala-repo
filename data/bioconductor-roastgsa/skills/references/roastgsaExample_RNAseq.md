# roastgsa vignette (RNAseq)

Adria Caballe-Mestres

#### 30 October 2025

# Contents

* [1 Installation](#installation)
* [2 roastgsa in RNA-seq data](#roastgsa-in-rna-seq-data)
* [3 Data: RNA-seq experiment from GSEABenchmarkeR](#data-rna-seq-experiment-from-gseabenchmarker)
* [4 Data normalization and filtering](#data-normalization-and-filtering)
* [5 Gene sets](#gene-sets)
* [6 Enrichment analysis](#enrichment-analysis)
  + [6.1 Visualization of the results](#visualization-of-the-results)
  + [6.2 sessionInfo](#sessioninfo)
* [7 References](#references)
* **Appendix**

# 1 Installation

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("roastgsa")
```

# 2 roastgsa in RNA-seq data

This vignette explains broadly the main functions for applying `roastgsa`
in RNA-seq data. A more exhaustive example to explore the `roastgsa`
functionality is presented in the “roastgsa vignette (main)”. All the analyses
explained in the main vignette can be reproduced for RNA-seq data, after
undertaking the steps covered here in the section
“Data normalization and filtering”.

```
library( roastgsa )
```

# 3 Data: RNA-seq experiment from GSEABenchmarkeR

We consider the first dataset available in the `tcga` compendium
from the `GSEABenchmarkeR` package [1], which consists of a RNA-seq study
with 19 tumor Bladder Urothelial Carcinoma samples and 19 adjacent
healthy tissues.

```
#library(GSEABenchmarkeR)
#tcga <- loadEData("tcga", nr.datasets=1,cache = TRUE)
#ysel <- assays(tcga[[1]])$expr
#fd <-  rowData(tcga[[1]])
#pd <- colData(tcga[[1]])
data(fd.tcga)
data(pd.tcga)
data(expr.tcga)

fd <- fd.tcga
ysel <- expr.tcga
pd <- pd.tcga
N  <- ncol(ysel)

head(pd)
```

```
## DataFrame with 6 rows and 4 columns
##                                              sample     type     GROUP
##                                         <character> <factor> <numeric>
## TCGA-K4-A3WV-01A-11R-A22U-07 TCGA-K4-A3WV-01A-11R..     BLCA         1
## TCGA-BT-A20W-01A-21R-A14Y-07 TCGA-BT-A20W-01A-21R..     BLCA         1
## TCGA-K4-A5RI-01A-11R-A28M-07 TCGA-K4-A5RI-01A-11R..     BLCA         1
## TCGA-BT-A20N-01A-11R-A14Y-07 TCGA-BT-A20N-01A-11R..     BLCA         1
## TCGA-BL-A13J-01A-11R-A277-07 TCGA-BL-A13J-01A-11R..     BLCA         1
## TCGA-BT-A20U-01A-11R-A14Y-07 TCGA-BT-A20U-01A-11R..     BLCA         1
##                                     BLOCK
##                               <character>
## TCGA-K4-A3WV-01A-11R-A22U-07 TCGA-K4-A3WV
## TCGA-BT-A20W-01A-21R-A14Y-07 TCGA-BT-A20W
## TCGA-K4-A5RI-01A-11R-A28M-07 TCGA-K4-A5RI
## TCGA-BT-A20N-01A-11R-A14Y-07 TCGA-BT-A20N
## TCGA-BL-A13J-01A-11R-A277-07 TCGA-BL-A13J
## TCGA-BT-A20U-01A-11R-A14Y-07 TCGA-BT-A20U
```

```
cnames <- c("BLOCK","GROUP")
covar <- data.frame(pd[,cnames,drop=FALSE])
covar$GROUP <- as.factor(covar$GROUP)
colnames(covar) <- cnames
print(table(covar$GROUP))
```

```
##
##  0  1
## 19 19
```

# 4 Data normalization and filtering

To apply `roastgsa`, the expression data should be approximately normally
distributed, at least in their univariate form. Depending on the user’s
preferred method for differential expression analysis, counts transformation
methods such as `rlog` or `vst` (`DESeq2`) [2], `zscoreDGE` (`edgeR`) [3] or
`voom` (`limma`) [4], can be applied. In the paper we explored the type I
and type II errors when applying the `rlog` or `vst` transformation followed by
`roastgsa`, showing both good control of type I errors and decent true
discovery rates. In the example presented here we transform the expression
data with `vst` function from `DESeq2` R package

```
library(DESeq2)
dds1 <- DESeqDataSetFromMatrix(countData=ysel,colData=pd,
    design= ~ BLOCK + GROUP)
dds1 <- estimateSizeFactors(dds1)
ynorm <- assays(vst(dds1))[[1]]
colnames(ynorm) <- rownames(covar) <- paste0("s",1:ncol(ynorm))
```

Another key step before using the roastgsa methods for enrichment analysis
is to filter out low expressed genes, where coverage might be a
limitation for detecting true differentially expressed genes. For the
TCGA data considered here, the default filter employed by the authors when
loading the data was to exclude genes with cpm < 2 in more than half of
the samples. A short discussion about the relationship between gene coverage
and statistical power for the `roastgsa` approach is available in our article
presenting the `roastgsa` package.

```
threshLR <- 10
dim(ysel)
```

```
## [1] 3621   38
```

```
min(apply(ysel,1,mean))
```

```
## [1] 88.26316
```

# 5 Gene sets

We consider a classic repository of general biological functions for battery
gene set analysis such as broad hallmarks [5]. The gene sets for human are saved
within the roastgsa package and can be loaded by

```
data(hallmarks.hs)
head(names(hallmarks.hs))
```

```
## [1] "HALLMARK_TNFA_SIGNALING_VIA_NFKB"    "HALLMARK_HYPOXIA"
## [3] "HALLMARK_CHOLESTEROL_HOMEOSTASIS"    "HALLMARK_MITOTIC_SPINDLE"
## [5] "HALLMARK_WNT_BETA_CATENIN_SIGNALING" "HALLMARK_TGF_BETA_SIGNALING"
```

In this case, `hallmarks.hs` contains gene symbols whereas the row
names for `ynorm` are entrez identifiers. We can set the row names to
symbols, which in this case presents a one-to-one relationship

```
rownames(ynorm) <-fd[rownames(ynorm),1]
```

Other gene set databases that could be applied to these data for battery
testing are presented in the `roastgsa` vignette (gene set collections).

# 6 Enrichment analysis

The comparison of interest can be specified by a numeric vector with
length matching the number of columns in the design.

```
form <- as.formula(paste0("~ ", paste0(cnames, collapse = "+")))
design <- model.matrix(form , data = covar)
terms <- colnames(design)
contrast <- rep(0, length(terms))
contrast[length(colnames(design))] <- 1
```

Below, there is the standard `roastgsa` instruction (under competitive
testing) for `maxmean` and `mean` statistics.

```
fit.maxmean <- roastgsa(ynorm, form = form, covar = covar,
    contrast = contrast, index = hallmarks.hs, nrot = 500,
    mccores = 1, set.statistic = "maxmean",
    self.contained = FALSE, executation.info = FALSE)
f1 <- fit.maxmean$res
rownames(f1) <- gsub("HALLMARK_","",rownames(f1))
head(f1)
```

```
##                           total_genes measured_genes        est       nes
## E2F_TARGETS                       200            194  1.4694371  3.878426
## G2M_CHECKPOINT                    200            188  1.1752646  3.813388
## MYOGENESIS                        200            155 -0.8304752 -2.923398
## UV_RESPONSE_DN                    144            134 -0.6095027 -2.570113
## MYC_TARGETS_V1                    200            192  0.7727287  2.479889
## UNFOLDED_PROTEIN_RESPONSE         113            104  0.3749170  2.478753
##                                  pval  adj.pval
## E2F_TARGETS               0.001996008 0.0499002
## G2M_CHECKPOINT            0.001996008 0.0499002
## MYOGENESIS                0.005988024 0.0998004
## UV_RESPONSE_DN            0.013972056 0.1441561
## MYC_TARGETS_V1            0.017964072 0.1441561
## UNFOLDED_PROTEIN_RESPONSE 0.025948104 0.1441561
```

```
fit.mean <- roastgsa(ynorm, form = form, covar = covar,
    contrast = contrast, index = hallmarks.hs, nrot = 500,
    mccores = 1, set.statistic = "mean",
    self.contained = FALSE, executation.info = FALSE)
f2 <- fit.mean$res
rownames(f2) <- gsub("HALLMARK_","",rownames(f2))
head(f2)
```

```
##                           total_genes measured_genes        est       nes
## E2F_TARGETS                       200            194  1.1896796  2.976495
## G2M_CHECKPOINT                    200            188  0.9287256  2.829703
## UNFOLDED_PROTEIN_RESPONSE         113            104  0.4270303  2.548109
## MYOGENESIS                        200            155 -0.7076989 -2.326108
## DNA_REPAIR                        150            139  0.4878909  2.312800
## UV_RESPONSE_DN                    144            134 -0.5941011 -2.258786
##                                  pval  adj.pval
## E2F_TARGETS               0.001996008 0.0332668
## G2M_CHECKPOINT            0.001996008 0.0332668
## UNFOLDED_PROTEIN_RESPONSE 0.013972056 0.1164338
## MYOGENESIS                0.001996008 0.0332668
## DNA_REPAIR                0.013972056 0.1164338
## UV_RESPONSE_DN            0.013972056 0.1164338
```

## 6.1 Visualization of the results

Several graphics can be obtained to complement the table results in
`f1` and `f2`. Here we only show the heatmaps that summarize the
expression patterns obtained for all tested hallmarks. Full description
and usage of all graphical options available in the `roastgsa` package
are considered in the `roastgsa` vignette for arrays data and the
`roastgsa` manual

```
hm1 <- heatmaprgsa_hm(fit.maxmean, ynorm, intvar = "GROUP", whplot = 1:50,
        toplot = TRUE, pathwaylevel = TRUE, mycol = c("orange","green",
        "white"), sample2zero = FALSE)
```

![](data:image/png;base64...)

```
hm2 <- heatmaprgsa_hm(fit.mean, ynorm, intvar = "GROUP", whplot = 1:50,
        toplot = TRUE, pathwaylevel = TRUE, mycol = c("orange","green",
        "white"), sample2zero = FALSE)
```

![](data:image/png;base64...)

## 6.2 sessionInfo

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

# 7 References

# Appendix

[1] Geistlinger L, Csaba G, Santarelli M, Schiffer L, Ramos M, Zimmer R,
Waldron L (2019). GSEABenchmarkeR: Reproducible GSEA Benchmarking. R package
version 1.6.0, <https://github.com/waldronlab/GSEABenchmarkeR>.

[2] Love MI, Huber W, Anders S (2014). Moderated estimation of fold change
and dispersion for RNA-seq data with DESeq2. Genome Biology, 15, 550.
doi:10.1186/s13059-014-0550-8.

[3] Robinson MD, McCarthy DJ, Smyth GK (2010). edgeR: a Bioconductor package
for differential expression analysis of digital gene expression data.
Bioinformatics, 26(1), 139-140. doi:10.1093/bioinformatics/btp616.

[4] M. E. Ritchie, B. Phipson, D. Wu, Y. Hu, C. W. Law, W. Shi, and
G. K. Smyth. limma powers differential expression analyses for RNAsequencing
and microarray studies. Nucleic acids research, 43(7):e47,
2015.

[5] A. Liberzon, C. Birger, H. Thorvaldsdottir, M. Ghandi, J. P. Mesirov,
and P. Tamayo. The Molecular Signatures Database Hallmark Gene Set
Collection. Cell Systems, 1(6):417-425, 2015.