# MEB Tutorial

Yan Zhou, Jiadi Zhu

#### 2025-10-30

#### Package

MEB 1.24.0

# Contents

* [1 Introduction](#introduction)
* [2 The steps of the SFMEB method](#the-steps-of-the-sfmeb-method)
  + [2.1 Preparations](#preparations)
  + [2.2 Data format](#data-format)
  + [2.3 Training a model for the training genes](#training-a-model-for-the-training-genes)
  + [2.4 Discriminating a gene whether a DE gene](#discriminating-a-gene-whether-a-de-gene)
* [3 The usage of the scMEB method](#the-usage-of-the-scmeb-method)

# 1 Introduction

This package includes two methods for differentially expressed genes (DEGs)
detection in RNA-seq and scRNA-seq datasets, respectively. The first method is
the SFMEB that is used to identify DEGs in the same or different species
RNA-seq dataset. Given that non-DE genes have some similarities in features,
the SFMEB covers those non-DE genes in feature space, then those DE genes,
which are enormously different from non-DE genes, being regarded as outliers
and rejected outside the ball. The method on this package are described in the
article *A scaling-free minimum enclosing ball method to detect differentially
expressed genes for RNA-seq data* by Zhou, Y., Yang, B., Wang, J. et al.
BMC Genomics, 22, 479 (2021). The second method is the scMEB which is the
extension of the SFMEB. The scMEB is a novel and fast method for detecting
single-cell DEGs without prior cell clustering results. The details about the
scMEB could be refered to the article *scMEB: A fast and clustering-independent
method for detecting differentially expressed genes in single-cell RNA-seq
data* by Zhu, J.D and Yang, Y.L. (2023, pending publication)

# 2 The steps of the SFMEB method

The SFMEB method is developed for detecting differential expression genes in
the same or different species.
Compared with existing methods, it is no need to normalize data in advance.
Besides, the SFMEB method could be easily applied to the same or different
species data and without changing too much. We have implemented the SFMEB
method via an R function `NIMEB()`. The method consists three steps.

**Step 1**: Data Pre-processing;

**Step 2**: Training a model for the training genes;

**Step 3**: Discriminating a gene whether a DE gene.

We employ a simulation and real dataset for the same and different species to
illustrate the usage of the SFMEB method.

## 2.1 Preparations

To install the MEB package into your R environment, start R and
enter:

```
install.packages("BiocManager")
BiocManager::install("MEB")
```

Then, the MEB package is ready to load.

```
library(MEB)
```

## 2.2 Data format

In order to show the usage of SFMEB method, we introduce the example data sets,
which includes the simulation and real data for the same and different species.
The next we will show the introduction of datasets in the package.

There are six datasets in the data subdirectory of MEB package, in which four
datasets are linked to the SFMEB method. To consistent
with standard Bioconductor representations, we transform the format of dataset
as *SummarizedExperiment*, please refer R package *SummarizedExperiment* for
details. The four datasets are **sim\_data\_sp**, **sim\_data\_dsp**,
**real\_data\_sp** and **real\_data\_dsp**.

**real\_data\_sp** is a real dataset for the same species, which comes from
*RNA-seq: an assessment of technical reproducibility and comparisonwith gene
expression arrays* by Marioni J.C., Mason C.E., et al. (2008). Genome Res.
18(9), 1509–1517.

**real\_data\_dsp** is a real dataset for the different
species, which comes from *The evolution of gene expression levels in
mammalian organs* by Brawand, D., Soumillon, M.,
Necsulea, A. and Julien, P. et al. (2011). Nature, 478, 343-348.

**sim\_data\_sp** and **sim\_data\_dsp** are two simulation datasets for the same
and different species, respectively. Refering *A scaling-free minimum enclosing
ball method to detect differentially
expressed genes for RNA-seq data* by Zhou, Y., Yang, B., Wang, J. et al.
BMC Genomics, 22, 479 (2021) for the generation procedure.

```
data(sim_data_sp)
sim_data_sp
```

```
## class: SummarizedExperiment
## dim: 10943 2
## metadata(0):
## assays(1): ''
## rownames(10943): 1 2 ... 10942 10943
## rowData names(0):
## colnames(2): sample1 sample2
## colData names(0):
```

**sim\_data\_sp.RData** includes 2 columns,

* the first column is the RNA-seq short read counts for the first sample;
* the second column is the RNA-seq short read counts for the second sample;
* each row represents a gene, and the first 1000 genes are housekeeping
  genes.

```
data(real_data_sp)
real_data_sp
```

```
## class: SummarizedExperiment
## dim: 16519 10
## metadata(0):
## assays(1): ''
## rownames(16519): ENSG00000149925 ENSG00000102144 ... ENSG00000012817
##   ENSG00000198692
## rowData names(0):
## colnames(10): R1L1Kidney R1L2Liver ... R2L3Liver R2L6Kidney
## colData names(0):
```

**real\_data\_sp** includes 10 columns,

* there are two samples about kidney and liver, and each with five biological
  replicates;
* each row represents a gene, and the first 530 genes are housekeeping genes.

```
data(sim_data_dsp)
sim_data_dsp
```

```
## class: SummarizedExperiment
## dim: 18472 4
## metadata(0):
## assays(1): ''
## rownames(18472): 1 2 ... 18471 18472
## rowData names(0):
## colnames(4): genelength1 count1 genelength2 count2
## colData names(0):
```

**sim\_data\_dsp.RData** includes 4 columns,

* the first and the third columns are the gene length for two species;
* the second and the fouth columns are the RNA-seq short read counts for two
  species;
* each row represents an orthologous gene, and the first 1000 genes are the
  conserved genes.

```
data(real_data_dsp)
real_data_dsp
```

```
## class: SummarizedExperiment
## dim: 19330 4
## metadata(0):
## assays(1): ''
## rownames(19330): 85 190 ... 20928 20929
## rowData names(2): Ensembl.Gene.ID Mouse.Ensembl.Gene.ID
## colnames(4): ExonicLength Human_Brain_Male1 ExonicLength.1
##   Mouse_Brain_Male1
## colData names(0):
```

**real\_data\_dsp.RData** includes 4 columns,

* the first and the third columns are the gene length for human and mouse;
* the second and the fouth columns are the RNA-seq short read counts for human
  and mouse;
* each row represents an orthologous gene, and the first 143 genes are the
  conserved genes.

## 2.3 Training a model for the training genes

Based on a part of known housekeeping and conserved genes, we can train our
model for the above four datasets. The next we will show how to use the
`NIMEB()` function to train a model.

1. Simulation data for the same species

```
library(SummarizedExperiment)
```

```
data(sim_data_sp)
gamma <- seq(1e-06,5e-05,1e-06)
sim_model_sp <- NIMEB(countsTable=assay(sim_data_sp), train_id=1:1000, gamma,
nu = 0.01, reject_rate = 0.05, ds = FALSE)
```

2. Real data for the same species

```
data(real_data_sp)
gamma <- seq(1e-06,5e-05,1e-06)
real_model_sp <- NIMEB(countsTable=assay(real_data_sp), train_id=1:530,
gamma, nu = 0.01, reject_rate = 0.1, ds = FALSE)
```

3. Simulation data for the different species

```
data(sim_data_dsp)
gamma <- seq(1e-07,2e-05,1e-06)
sim_model_dsp <- NIMEB(countsTable=assay(sim_data_dsp), train_id=1:1000, gamma,
nu = 0.01, reject_rate = 0.1, ds = TRUE)
```

4. Real data for the different species

```
data(real_data_dsp)
gamma <- seq(5e-08,5e-07,1e-08)
real_model_dsp <- NIMEB(countsTable=assay(real_data_dsp), train_id=1:143,
                        gamma, nu = 0.01, reject_rate = 0.1, ds = TRUE)
```

The output for *NIMEB()* includes “*model*”, “*gamma*” and *train\_error*.
*model* is the model we used to discriminate a new gene, *gamma* represents the
selected gamma parameters in model NIMEB, *train\_error* represents the
corresponding train\_error when the value of gamma changed.

## 2.4 Discriminating a gene whether a DE gene

Giving the model, we could predict a gene and find out whether DE gene. For
example, in *sim\_data\_sp* data, we predict the discrimination results as
follows:

```
sim_model_sp_pred <- predict(sim_model_sp$model, assay(sim_data_sp))
summary(sim_model_sp_pred)
```

```
##    Mode   FALSE    TRUE
## logical    4008    6935
```

Based on the model we trained, we could discriminate each genes whether DE
gene, if the discrimination result is *TRUE*/*FALSE*, the gene is non-DE/DE
gene.

# 3 The usage of the scMEB method

We add a new function `scMEB()` for detecting differential expressed genes in
scRNA-seq data without prior clustering results. There is a example to
introduce the usage of this function:

1. Load the package and example scRNA-seq data

```
library(SingleCellExperiment)
```

The simulation data is generated by splatter package (Zappia L, et al. 2017).
The data include 5,000 genes and 100 cells.

```
data(sim_scRNA_data)
sim_scRNA_data
```

```
## class: SingleCellExperiment
## dim: 5000 100
## metadata(0):
## assays(1): counts
## rownames(5000): Gene1 Gene2 ... Gene4999 Gene5000
## rowData names(6): Gene BaseGeneMean ... DEFacGroup1 DEFacGroup2
## colnames(100): Cell1 Cell2 ... Cell99 Cell100
## colData names(0):
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

We randomly sample 1,000 stable genes from the simulation data.

```
data(stable_gene)
head(stable_gene)
```

```
## [1] "Gene2635" "Gene4243" "Gene1318" "Gene2218" "Gene4753" "Gene4661"
```

```
length(stable_gene)
```

```
## [1] 1000
```

2. Training a model for the simulation scRNA-seq data

```
sim_scRNA <- scMEB(sce=sim_scRNA_data, stable_idx=stable_gene,
filtered = TRUE, gamma = seq(1e-04,0.001,1e-05), nu = 0.01,
reject_rate = 0.1)
```

```
## Warning in (function (A, nv = 5, nu = nv, maxit = 1000, work = nv + 7, reorth =
## TRUE, : You're computing too large a percentage of total singular values, use a
## standard svd instead.
```

Predict a gene and find out whether DE gene. For *sim\_data\_sp* data, we predict
the discrimination results as
follows:

```
sim_scRNA_pred <- predict(sim_scRNA$model, sim_scRNA$dat_pca)
summary(sim_scRNA_pred)
```

```
##    Mode   FALSE    TRUE
## logical      85    4915
```

The discrimination result *TRUE*/*FALSE* correspond that gene is non-DE/DE
gene.

scMEB also provides a metric for ranking the genes, that is, the distance
between the gene and the sphere of the ball in the feature space. And the
larger the distance is, the more likely it is that the gene is a DEG.

```
table(sim_scRNA$dist>0)
```

```
##
## FALSE  TRUE
##    85  4915
```

```
sim_scRNA_dist <- data.frame(Gene=rownames(sim_scRNA_data),
                             Distance=sim_scRNA$dist)
head(sim_scRNA_dist)
```

```
##    Gene   Distance
## 1 Gene1 0.08242580
## 2 Gene2 0.08384064
## 3 Gene3 0.11974964
## 4 Gene4 0.12406556
## 5 Gene5 0.01890732
## 6 Gene6 0.09735843
```

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
##  [1] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [3] Biobase_2.70.0              GenomicRanges_1.62.0
##  [5] Seqinfo_1.0.0               IRanges_2.44.0
##  [7] S4Vectors_0.48.0            BiocGenerics_0.56.0
##  [9] generics_0.1.4              MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0           MEB_1.24.0
## [13] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1    viridisLite_0.4.2   dplyr_1.1.4
##  [4] vipor_0.4.7         farver_2.1.2        viridis_0.6.5
##  [7] S7_0.2.0            fastmap_1.2.0       digest_0.6.37
## [10] rsvd_1.0.5          lifecycle_1.0.4     statmod_1.5.1
## [13] magrittr_2.0.4      compiler_4.5.1      rlang_1.1.6
## [16] sass_0.4.10         tools_4.5.1         yaml_2.3.10
## [19] knitr_1.50          S4Arrays_1.10.0     DelayedArray_0.36.0
## [22] wrswoR_1.1.1        RColorBrewer_1.1-3  abind_1.4-8
## [25] BiocParallel_1.44.0 grid_4.5.1          beachmat_2.26.0
## [28] e1071_1.7-16        edgeR_4.8.0         ggplot2_4.0.0
## [31] logging_0.10-108    scales_1.4.0        dichromat_2.0-0.1
## [34] cli_3.6.5           rmarkdown_2.30      scuttle_1.20.0
## [37] ggbeeswarm_0.7.2    cachem_1.1.0        proxy_0.4-27
## [40] parallel_4.5.1      BiocManager_1.30.26 XVector_0.50.0
## [43] vctrs_0.6.5         Matrix_1.7-4        jsonlite_2.0.0
## [46] bookdown_0.45       BiocSingular_1.26.0 BiocNeighbors_2.4.0
## [49] ggrepel_0.9.6       irlba_2.3.5.1       beeswarm_0.4.0
## [52] scater_1.38.0       locfit_1.5-9.12     limma_3.66.0
## [55] jquerylib_0.1.4     glue_1.8.0          codetools_0.2-20
## [58] gtable_0.3.6        ScaledMatrix_1.18.0 tibble_3.3.0
## [61] pillar_1.11.1       htmltools_0.5.8.1   R6_2.6.1
## [64] evaluate_1.0.5      lattice_0.22-7      bslib_0.9.0
## [67] class_7.3-23        Rcpp_1.1.0          gridExtra_2.3
## [70] SparseArray_1.10.0  xfun_0.53           pkgconfig_2.0.3
```