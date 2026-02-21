# EpiDISH - Epigenetic Dissection of Intra-Sample-Heterogeneity

Shijie C. Zheng, Andrew E. Teschendorff

#### 2025-10-29

#### Package

EpiDISH 2.26.0

# Contents

* [1 Introduction](#introduction)
* [2 How to estimate cell-type fractions in blood](#how-to-estimate-cell-type-fractions-in-blood)
* [3 How to estimate generic cell-type fractions in a solid tissue](#how-to-estimate-generic-cell-type-fractions-in-a-solid-tissue)
* [4 How to estimate immune cell-type fractions in a solid tissue using HEpiDISH](#how-to-estimate-immune-cell-type-fractions-in-a-solid-tissue-using-hepidish)
* [5 More info about different methods for cell-type fractions estimation](#more-info-about-different-methods-for-cell-type-fractions-estimation)
* [6 How to identify differentially methylated cell-types in EWAS](#how-to-identify-differentially-methylated-cell-types-in-ewas)
* [7 Sessioninfo](#sessioninfo)
* [References](#references)

# 1 Introduction

The **EpiDISH** package provides tools to infer the fractions of a priori known cell subtypes present in a DNA methylation (DNAm) sample representing a mixture of such cell-types. Inference proceeds via one of 3 methods (Robust Partial Correlations-RPC(A. E. Teschendorff et al. [2017](#ref-EpiDISH)), Cibersort-CBS(Newman et al. [2015](#ref-CBS)), Constrained Projection-CP(Houseman et al. [2012](#ref-CP))), as determined by the user. Besides, we also provide a function - CellDMC which allows the identification of differentially methylated cell-types in Epigenome-Wide Association Studies(EWAS)(Zheng, Breeze, et al. [2018](#ref-CellDMC)). For now, *the package contains 7 DNAm reference matrices*, three of which are designed for *adult whole blood* (A. E. Teschendorff et al. [2017](#ref-EpiDISH)) and (Luo et al. [2023](#ref-MetaEWAS)), and one which is designed for blood tissue of any age, including cord-blood and blood from infants, children, adolescents and adults.

1. `centDHSbloodDMC.m`: This DNAm reference matrix for blood will estimate fractions for 7 immune cell types (B-cells, NK-cells, CD4T and CD8T-cells, Monocytes, Neutrophils and Eosinophils).
2. `cent12CT.m`: This DNAm reference matrix for blood and EPIC-arrays will estimate fractions for 12 immune-cell types (naive and mature B-cells, naive and mature CD4T-cells, naive and mature B-cells, T-regulatory cells, NK-cells, Neutrophils, Monocytes, Eosinophils, Basophils).
3. `cent12CT450k.m`: This DNAm reference matrix for blood and Illumina 450k-arrays will estimate fractions for 12 immune-cell types (naive and mature B-cells, naive and mature CD4T-cells, naive and mature B-cells, T-regulatory cells, NK-cells, Neutrophils, Monocytes, Eosinophils, Basophils).
4. `centUniLIFE.m`: This DNAm reference matrix for blood-tissue of any age will estimate fractions for 19 immune-cell types including 7 youthful cord-blood subtypes (B-cells, NK-cells, Granulocytes, Monocytes, nRBCs, CD4T and CD8T-cells) and 12 adult immune cell types (naive and mature B-cells, naive and mature CD4T-cells, naive and mature B-cells, T-regulatory cells, NK-cells, Neutrophils, Monocytes, Eosinophils, Basophils).

The other 3 DNAm reference matrices are designed for solid tissue-types (Zheng, Webster, et al. [2018](#ref-HEpiDISH)):

1. `centEpiFibIC.m`: This DNAm reference matrix is designed for a generic solid tissue that is dominated by an epithelial, stromal and immune-cell component. It will estimate fractions for 3 broad cell-types: a generic epithelial, fibroblast and immune-cell type.
2. `centBloodSub.m`: This DNAm reference matrix is designed for a solid tissue-type and will estimate immune cell infiltration for 7 immune cell subtypes. This DNAm reference matrix is meant to be applied after `centEpiFibIC.m` to yield proportions for 7 immune cell subtypes alongside the total epithelial and total fibroblast fractions.
3. `centEpiFibFatIC.m`: This DNAm reference matrix is a more specialised version for breast tissue and will estimate total epithelial, fibroblast, immune-cell and fat fractions.

# 2 How to estimate cell-type fractions in blood

We show an example of using our package to estimate 7 immune cell-type fractions in adult whole blood. We use a subset beta value matrix of GSE42861 (detailed description in manual page of *LiuDataSub.m*). First, we read in the required objects:

```
library(EpiDISH)
data(centDHSbloodDMC.m)
data(LiuDataSub.m)
```

```
BloodFrac.m <- epidish(beta.m = LiuDataSub.m, ref.m = centDHSbloodDMC.m, method = "RPC")$estF
```

We can easily check the inferred fractions with boxplots. From the boxplots, we observe that just as we expected, the major cell-type in whole blood is neutrophil.

```
boxplot(BloodFrac.m)
```

![](data:image/png;base64...)

If we wanted to infer fractions at a higher resolution of 12 immune cell subtypes, we would replace `centDHSbloodDMC.m` in the above with `cent12CT450k.m` because this is a 450k DNAm dataset. For an EPIC whole blood dataset, you would use `cent12CT.m`.

# 3 How to estimate generic cell-type fractions in a solid tissue

To illustrate how this works, we first read in a dummy beta value matrix *DummyBeta.m*, which contains 2000 CpGs and 10 samples, representing a solid tissue:

```
data(centEpiFibIC.m)
data(DummyBeta.m)
```

Notice that *centEpiFibIC.m* has 3 columns, with names of the columns as EPi, Fib and IC. We go ahead and use *epidish* function with *RPC* mode to infer the cell-type fractions.

```
out.l <- epidish(beta.m = DummyBeta.m, ref.m = centEpiFibIC.m, method = "RPC")
```

Then, we check the output list. *estF* is the matrix of estimated cell-type fractions. *ref* is the reference centroid matrix used, and *dataREF* is the subset of the input data matrix over the probes defined in the reference matrix.

```
out.l$estF
```

```
##            Epi        Fib           IC
## S1  0.08836819 0.06109607 0.8505357378
## S2  0.07652115 0.57326994 0.3502089007
## S3  0.15417391 0.75663136 0.0891947251
## S4  0.77082647 0.04171941 0.1874541181
## S5  0.03960599 0.31921224 0.6411817742
## S6  0.12751711 0.79642919 0.0760537000
## S7  0.18144315 0.72889883 0.0896580171
## S8  0.20220823 0.40929344 0.3884983293
## S9  0.19398079 0.80540932 0.0006098973
## S10 0.27976647 0.23671333 0.4835201992
```

```
dim(out.l$ref)
```

```
## [1] 599   3
```

```
dim(out.l$dataREF)
```

```
## [1] 599  10
```

Note: As part of the quality control step in DNAm data preprocessing, we might have to remove bad probes; consequently, not all probes in the reference matrix may be available in a given dataset. By checking *ref* and *dataREF*, we can extract the probes actually used for estimating cell-type fractions. As shown by us (Zheng, Webster, et al. [2018](#ref-HEpiDISH)), if the proportion of missing reference matrix probes is more than a third, then estimated fractions may be unreliable.

# 4 How to estimate immune cell-type fractions in a solid tissue using HEpiDISH

HEpiDISH is an iterative hierarchical procedure of EpiDISH designed for solid tissues with significant immune-cell infiltration. HEpiDISH uses two distinct DNAm references, a primary reference for the estimation of total epithelial, fibroblast and immune-cell fractions, and a separate secondary non-overlapping DNAm reference for the estimation of underlying immune cell subtype fractions.
![Fig1. HEpiDISH workflow](data:image/jpeg;base64...)
In this example, the third cell-type in the primary DNAm reference matrix is the total immune cell fraction. We would like to know the fractions of 7 immune cell subtypes, in adddition to the epithelial and fibroblast fractions. So we use a secondary reference, which contains 7 immnue cell subtypes, and let **hepidish** function know that the third column of primary reference should correspond to the secondary DNAm reference matrix. (We only include 3 cell-types of the *centBloodSub.m* reference because we mixed those three cell-types to generate the dummy beta value matrix.)

```
data(centBloodSub.m)
frac.m <- hepidish(beta.m = DummyBeta.m, ref1.m = centEpiFibIC.m, ref2.m = centBloodSub.m[,c(1, 2, 5)], h.CT.idx = 3, method = 'RPC')
frac.m
```

```
##            Epi        Fib            B           NK       Mono
## S1  0.08836819 0.06109607 0.6446835622 0.0945693668 0.11128281
## S2  0.07652115 0.57326994 0.0502766152 0.2999322854 0.00000000
## S3  0.15417391 0.75663136 0.0381194625 0.0134501813 0.03762508
## S4  0.77082647 0.04171941 0.1434958145 0.0211681974 0.02279011
## S5  0.03960599 0.31921224 0.0167748647 0.1912747358 0.43313217
## S6  0.12751711 0.79642919 0.0286647024 0.0252778983 0.02211110
## S7  0.18144315 0.72889883 0.0515861314 0.0228453164 0.01522657
## S8  0.20220823 0.40929344 0.1908434542 0.1772700742 0.02038480
## S9  0.19398079 0.80540932 0.0003521377 0.0002577596 0.00000000
## S10 0.27976647 0.23671333 0.2546961632 0.1008399798 0.12798406
```

# 5 More info about different methods for cell-type fractions estimation

We compared CP and RPC in (A. E. Teschendorff et al. [2017](#ref-EpiDISH)). And we also published a review article(A. E. Teschendorff and Zheng [2017](#ref-review)) which discusses most of algorithms for tackling cell heterogeneity in Epigenome-Wide Association Studies(EWAS). Refer to references section for more details.

# 6 How to identify differentially methylated cell-types in EWAS

After estimating cell-type fractions, we can then identify differentially methylated cell-types and their directions of change using **CellDMC** (Zheng, Breeze, et al. [2018](#ref-CellDMC))function. The workflow of **CellDMC** is shown below.
![Fig2. CellDMC workflow](data:image/jpeg;base64...)

We use a binary phenotype vector here, with half of them representing controls and other half representing cases.

```
pheno.v <- rep(c(0, 1), each = 5)
celldmc.o <- CellDMC(DummyBeta.m, pheno.v, frac.m)
```

The DMCTs prediction is given(pls note this is faked data. The sample size is too small to find DMCTs.):

```
head(celldmc.o$dmct)
```

```
##            DMC Epi Fib B NK Mono
## cg17506061   0   0   0 0  0    0
## cg09300980   0   0   0 0  0    0
## cg18886245   0   0   0 0  0    0
## cg17470327   0   0   0 0  0    0
## cg26082174   0   0   0 0  0    0
## cg14737131   0   0   0 0  0    0
```

The estimated coefficients for each cell-type are given in the *celldmc.o$coe*.
Pls refer to help page of **CellDMC** for more info.

# 7 Sessioninfo

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] EpiDISH_2.26.0   BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] vctrs_0.6.5         cli_3.6.5           knitr_1.50
##  [4] magick_2.9.0        rlang_1.1.6         xfun_0.53
##  [7] stringi_1.8.7       jsonlite_2.0.0      glue_1.8.0
## [10] e1071_1.7-16        htmltools_0.5.8.1   tinytex_0.57
## [13] sass_0.4.10         rmarkdown_2.30      quadprog_1.5-8
## [16] grid_4.5.1          evaluate_1.0.5      jquerylib_0.1.4
## [19] MASS_7.3-65         fastmap_1.2.0       yaml_2.3.10
## [22] locfdr_1.1-8        lifecycle_1.0.4     bookdown_0.45
## [25] stringr_1.5.2       BiocManager_1.30.26 compiler_4.5.1
## [28] Rcpp_1.1.0          lattice_0.22-7      digest_0.6.37
## [31] R6_2.6.1            class_7.3-23        parallel_4.5.1
## [34] splines_4.5.1       magrittr_2.0.4      bslib_0.9.0
## [37] Matrix_1.7-4        proxy_0.4-27        tools_4.5.1
## [40] matrixStats_1.5.0   cachem_1.1.0
```

# References

Houseman, Eugene Andres, William P Accomando, Devin C Koestler, Brock C Christensen, Carmen J Marsit, Heather H Nelson, John K Wiencke, and Karl T Kelsey. 2012. “DNA methylation arrays as surrogate measures of cell mixture distribution.” *BMC Bioinformatics* 13 (1): 86.

Luo, Q, VB Dwaraka, Q Chen, H Tong, T Zhu, K Seale, JM Raffaele, et al. 2023. “A meta-analysis of immune-cell fractions at high resolution reveals novel associations with common phenotypes and health outcomes.” *Genome Med* 15 (1): 59.

Newman, Aaron M, Chih Long Liu, Michael R Green, Andrew J Gentles, Weiguo Feng, Yue Xu, Chuong D Hoang, Maximilian Diehn, and Ash A Alizadeh. 2015. “Robust enumeration of cell subsets from tissue expression profiles.” *Nature Methods* 12 (5): 453–57.

Teschendorff, Andrew E, Charles E Breeze, Shijie C Zheng, and Stephan Beck. 2017. “A comparison of reference-based algorithms for correcting cell-type heterogeneity in Epigenome-Wide Association Studies.” *BMC Bioinformatics* 18 (1): 105.

Teschendorff, Andrew E, and Shijie C Zheng. 2017. “Cell-type deconvolution in epigenome-wide association studies: a review and recommendations.” *Epigenomics* 9 (5): 757–68.

Zheng, Shijie C, Charles E Breeze, Stephan Beck, and Andrew E Teschendorff. 2018. “Identification of differentially methylated cell-types in Epigenome-Wide Association Studies.” *Nature Methods* 15 (12): 1059–66.

Zheng, Shijie C, Amy P Webster, Danyue Dong, Andy Feber, David G Graham, Roisin Sullivan, Sarah Jevons, et al. 2018. “A novel cell-type deconvolution algorithm reveals substantial contamination by immune cells in saliva, buccal and cervix.” *Epigenomics* 10 (7): 925–40.