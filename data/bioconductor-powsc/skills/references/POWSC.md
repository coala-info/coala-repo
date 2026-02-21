# ***POWSC: power and sample size snalysis for single-cell RNA-seq***

Kenong Su @Emory, Zhijin Wu @Brown, Hao Wu @Emory

#### 30 October 2025

#### Abstract

This vignette introduces the usage of the Bioconductor package POWSC (POWer analysis for SCrna-seq experiment), which is specifically designed for power estimation and sample size estimation for scRNA-seq data. POWSC is a simulation-based method, to provide power evaluation and sample size recommen- dation for single-cell RNA-sequencing DE analysis. POWSC consists of a data simulator that creates realistic expres- sion data, and a power assessor that provides a comprehensive evaluation and visualization of the power and sam- ple size relationship. The data simulator in POWSC outperforms two other state-of-art simulators in capturing key characteristics of real datasets. The power assessor in POWSC provides a variety of power evaluations including stratified and marginal power analyses for DEs characterized by two forms (phase transition or magnitude tuning), under different comparison scenarios. In addition, POWSC offers information for optimizing the tradeoffs between sample size and sequencing depth with the same total reads.

#### Package

POWSC 1.18.0

## 0.1 Installation and quick start

### 0.1.1 Installation

To install this package, start R (version > “4.1”) and enter:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("POWSC")
```

### 0.1.2 Quick start on using POWSC

We use one scRNA-seq template data about ES-MEF cell types (GSE29087). In this case, we adopt one cell type (*fibro*) for the two-group comparison corresponding to the 1st scenario.

```
suppressMessages(library(POWSC))
data("es_mef_sce")
sce = es_mef_sce[, colData(es_mef_sce)$cellTypes == "fibro"]
set.seed(12)
rix = sample(1:nrow(sce), 500)
sce = sce[rix, ]
est_Paras = Est2Phase(sce)
sim_size = c(100, 200) # A numeric vector
pow_rslt = runPOWSC(sim_size = sim_size, est_Paras = est_Paras,per_DE=0.05, DE_Method = "MAST", Cell_Type = "PW")
```

## 0.2 Background

Determining the sample size for adequate power to detect statistical significance is a crucial step at the design stage for high-throughput experiments. Even though a number of methods and tools are available for sample size calculation for microarray and RNA-seq under the context of differential expression, this topic in the field of single-cell RNA sequencing is understudied. Moreover, the unique data characteristics present in scRNA-seq including sparsity and heterogeneity gain the challenge.

## 0.3 Introduction

`POWSC` is an R package designed for power assessment and sample size estimation in scRNA-seq experiment. It contains three main functionalities:
(1). **Parameter Estimation**: adopted and modified from the core of [SC2P](https://github.com/haowulab/SC2P).
(2). **Data Simulation**: consider two cases: paired-wise comparison and multiple comparisons.
(3). **Power Evaluation**: provide both stratified (detailed) and marginal powers.

For the model assumption, we adopt the mixture of zero-inflated poisson (ZIP) and log-normal poisson (LNP).

The power assessor in POWSC provides a variety of power evaluations including stratified and marginal power analyses for DEs characterized by **two forms** (phase transition or magnitude tuning), under different comparison scenarios. In addition, POWSC offers information for optimizing the tradeoffs between sample size and sequencing depth with the same total reads.

## 0.4 Use POWSC

In the context of differential expression (DE) analysis, scientists are usually interested in two different scenarios: (1) within cell type: comparing the same cell types across biological conditions such as case vs. control, which reveals the expression change of a particular cell type under different contexts. (2) between cell types: comparing different cell types under the same condition, which identifies biomarkers to distinguish cell types. In either case, the experiment starts from a number of cells randomly picked from a tissue sample consisting of a mixture of different cell types. The only factor one can control is the total number of cells.

### 0.4.1 For two-group comparison

In the first scenario, the numbers of cells for a particular cell type in different biological conditions are often similar, barring significant changes in cell composition. It uses one cell type as the benchmark data and perturbs the genes with mixture proportion (\(\pi\)) and log fold changes (\(lfc\)) as the DE genes according two forms.

```
# Users can customize how many cells they need as to change the number of n.
simData = Simulate2SCE(n=100, estParas1 = est_Paras, estParas2 = est_Paras)
de = runDE(simData$sce, DE_Method = "MAST")
estPower1 = Power_Disc(de, simData = simData)
estPower2 = Power_Cont(de, simData = simData)
```

### 0.4.2 For multiple-group comparisons

In the second scenario, the numbers of cells for distinct cell types can be very different, so the power for DE highly depends on the mixing proportions. Here, we use 1000\*57 expression matrix sampled from the patient ID AB\_S7 from the GSE67835 data. The original data GSE67835 can be download here: <https://www.dropbox.com/s/55zdktqfqiwfs3l/GSE67835.RData?dl=0>. In this case, we utilize the most abundant three cell types including oligodendrocytes, hybrid, and neurons. The underlying cell type proportion is 20%, 30%, 50% respectively. We simulate a series of datasets corresponding to different sample sizes. For each dataset, we then perform pairwise comparison and report the power evaluation for each comparison

```
data("GSE67835_AB_S7_sce")
sim_size = 200 # use a large sample is preferrable
cell_per = c(0.2, 0.3, 0.5)
col = colData(sce)
exprs = assays(sce)$counts
(tb = table(colData(sce)$Patients, colData(sce)$cellTypes))
# use AB_S7 patient as example and take three cell types: astrocytes hybrid and neurons
estParas_set = NULL
celltypes = c("oligodendrocytes", "hybrid", "neurons")
for (cp in celltypes){
    print(cp)
    ix = intersect(grep(cp, col$cellTypes), grep("AB_S7", col$Patients))
    tmp_mat = exprs[, ix]
    tmp_paras = Est2Phase(tmp_mat)
    estParas_set[[cp]] = tmp_paras
}
#########
#########  Simulation part
#########
sim = SimulateMultiSCEs(n = sim_size, estParas_set = estParas_set, multiProb = cell_per)

#########
#########  DE analysis part
#########
DE_rslt = NULL
for (comp in names(sim)){
    tmp = runDE(sim[[comp]]$sce, DE_Method = "MAST")
    DE_rslt[[comp]] = tmp
}

#########
######### Summarize the power result
#########
pow_rslt = pow1 = pow2 = pow1_marg = pow2_marg = NULL
TD = CD = NULL
for (comp in names(sim)){
    tmp1 = Power_Disc(DE_rslt[[comp]], sim[[comp]])
    tmp2 = Power_Cont(DE_rslt[[comp]], sim[[comp]])
    TD = c(TD, tmp2$TD); CD = c(CD, tmp2$CD)
    pow1_marg = c(pow1_marg, tmp1$power.marginal)
    pow2_marg = c(pow2_marg, tmp2$power.marginal)
    pow_rslt[[comp]] = list(pow1 = tmp1, pow2 = tmp2)
    pow1 = rbind(pow1, tmp1$power)
    pow2 = rbind(pow2, tmp2$power)
}

#########
######### Demonstrate the result by heatmap
#########
library(RColorBrewer); library(pheatmap)
breaksList = seq(0, 1, by = 0.01)
colors = colorRampPalette(rev(brewer.pal(n = 7, name = "RdYlBu")))(length(breaksList))
dimnames(pow1) = list(names(sim), names(tmp1$CD))
dimnames(pow2) = list(names(sim), names(tmp2$CD))
pheatmap(pow2, display_numbers = TRUE, color=colors, show_rownames = TRUE,
         cellwidth = 30, cellheight = 40, legend = TRUE,
         border_color = "grey96", na_col = "grey",
         cluster_row = FALSE, cluster_cols = FALSE,
         breaks = seq(0, 1, 0.01),
         main = "")
```

![](data:image/png;base64...)

## 0.5 Session Info

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
##  [1] pheatmap_1.0.13             RColorBrewer_1.1-3
##  [3] POWSC_1.18.0                MAST_1.36.0
##  [5] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [7] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [9] IRanges_2.44.0              S4Vectors_0.48.0
## [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [13] Biobase_2.70.0              BiocGenerics_0.56.0
## [15] generics_0.1.4              BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6        xfun_0.53           bslib_0.9.0
##  [4] ggplot2_4.0.0       lattice_0.22-7      vctrs_0.6.5
##  [7] tools_4.5.1         tibble_3.3.0        pkgconfig_2.0.3
## [10] Matrix_1.7-4        data.table_1.17.8   S7_0.2.0
## [13] lifecycle_1.0.4     compiler_4.5.1      farver_2.1.2
## [16] stringr_1.5.2       progress_1.2.3      tinytex_0.57
## [19] statmod_1.5.1       htmltools_0.5.8.1   sass_0.4.10
## [22] yaml_2.3.10         pillar_1.11.1       crayon_1.5.3
## [25] jquerylib_0.1.4     DelayedArray_0.36.0 cachem_1.1.0
## [28] limma_3.66.0        magick_2.9.0        abind_1.4-8
## [31] tidyselect_1.2.1    digest_0.6.37       stringi_1.8.7
## [34] dplyr_1.1.4         reshape2_1.4.4      bookdown_0.45
## [37] fastmap_1.2.0       grid_4.5.1          cli_3.6.5
## [40] SparseArray_1.10.0  magrittr_2.0.4      S4Arrays_1.10.0
## [43] dichromat_2.0-0.1   prettyunits_1.2.0   scales_1.4.0
## [46] rmarkdown_2.30      XVector_0.50.0      hms_1.1.4
## [49] evaluate_1.0.5      knitr_1.50          rlang_1.1.6
## [52] Rcpp_1.1.0          glue_1.8.0          BiocManager_1.30.26
## [55] jsonlite_2.0.0      R6_2.6.1            plyr_1.8.9
```