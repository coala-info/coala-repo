# Differential Composition Analysis with DCATS

Xinyi LIN

#### 2025-10-29

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Usage](#usage)
  + [3.1 Simulate Data](#simulate-data)
  + [3.2 Esitimate the Simlarity Matrix](#esitimate-the-simlarity-matrix)
  + [3.3 Differential Abundance Anlysis](#differential-abundance-anlysis)
  + [3.4 Other Models for Testing](#other-models-for-testing)
  + [3.5 Use reference cell types as normalization term](#use-reference-cell-types-as-normalization-term)

# 1 Introduction

Single-cell RNA sequencing (scRNA-seq) has been widely used to deepen our
understanding of various biological processes, including cell differentiation,
tumor development and disease occurrence. However, it remains challenging to
effectively detect differential compositions of cell types when comparing
samples coming from different conditions or along with continuous covariates,
partly due to the small number of replicates and high uncertainty of cell
clustering.

This vignette provides an introduction to the `DCATS` package, which contains
methods to detect the differential composition abundances between multiple
conditions in singel-cell experiments. It can be easily incooperated with
existing single cell data analysis pipeline and contribute to the whole
analysis process.

# 2 Installation

To install `DCATS`, first make sure that you have the devtools package installed:

```
if (!requireNamespace("devtools", quietly = TRUE))
  install.packages("BiocManager")
```

Then, install `DCATS` using the following command:

```
BiocManager::install("DCTAS")
```

# 3 Usage

To use DCATS, start by loading the package:

```
library(DCATS)
```

## 3.1 Simulate Data

Here, we used a built-in simulator in `DCATS` to simulate the data for following analysis. We simulate count data for four samples coming from the first condition with total cell counts 100, 800, 1300, and 600. We simulate another three samples coming from the second condition with total cell counts 250, 700, 1100.

In this simulator function, a proportion of different cell types is simulate following [a dirichlet distribution](https://en.wikipedia.org/wiki/Dirichlet_distribution) decided by \(\{p\_i\} \times c\) where \(\{p\_i\}\) is the true proportion vector and \(c\) is a concentration parameter indicating how far way the simulated proportion can be. The larger the \(c\), the higher probability to simulate a proportion vector close to the true proportion. Then the cell counts are generated from the multinomial distribution with self-defined total cell counts and simulated proportions.

```
set.seed(6171)
K <- 3
totals1 = c(100, 800, 1300, 600)
totals2 = c(250, 700, 1100)
diri_s1 = rep(1, K) * 20
diri_s2 = rep(1, K) * 20
simil_mat = create_simMat(K, confuse_rate=0.2)
sim_dat <- DCATS::simulator_base(totals1, totals2, diri_s1, diri_s2, simil_mat)
```

The output of `simulator_base` is the cell counts matrices of two conditions.

```
print(sim_dat$numb_cond1)
#>      [,1] [,2] [,3]
#> [1,]   36   35   29
#> [2,]  271  279  250
#> [3,]  518  379  403
#> [4,]  152  220  228
print(sim_dat$numb_cond2)
#>      [,1] [,2] [,3]
#> [1,]   84   87   79
#> [2,]  259  203  238
#> [3,]  345  376  379
```

## 3.2 Esitimate the Simlarity Matrix

`DCATS` provides three methods to get the similarity matrix which indicates the misclassification rate between different cell types. Currently, `DCATS` provides three ways to estimate the similarity matrix.

The first one describes an unbiased misclassification across all the cell types. It means that one cell from a cell type have equal chance to be assigned to rest other cell types. When the numbers of biological replicates are the same in two conditions and are relatively large, other unbiased random error will contribute more to the difference between the observed proportions and the true proportions. In this case, using this uniform confusion matrix is a better choice.

We use the function `create_simMat` to create a similarity matrix describe above. We need to specify the number of cell types \(K\) and the confuse rate which indicates the proportion of cells from one cell type being assigned to other cell types.

```
simil_mat = create_simMat(K = 3, confuse_rate = 0.2)
print(simil_mat)
#>      [,1] [,2] [,3]
#> [1,]  0.8  0.1  0.1
#> [2,]  0.1  0.8  0.1
#> [3,]  0.1  0.1  0.8
```

The second kind of confusion matrix is estimated from the knn matrix provided by [Seurat](https://satijalab.org/seurat/). It calculates the proportion of neighborhoods that are regarded as other cell types. In this case, DCATS corrects cell proportions mainly based on the information of similarity between different cell types and variety within each cell types.

The input of this function should be a ‘Graph’ class from [SeuratObject](https://cran.r-project.org/web/packages/SeuratObject/index.html) and a factor vector containing the cell type information of each cell. We can estimate the knn similarity matrix for the `simulation` dataset included in the `DCATS` package.

```
data(simulation)
print(simulation$knnGraphs[1:10, 1:10])
#> Loading required namespace: SeuratObject
#> 10 x 10 sparse Matrix of class "dgCMatrix"
#>   [[ suppressing 10 column names 'Cell7247', 'Cell2462', 'Cell7731' ... ]]
#>
#> Cell7247  1 .         .         . .          .         . . .          .
#> Cell2462  . 1.0000000 0.1428571 . .          0.1111111 . . .          .
#> Cell7731  . 0.1428571 1.0000000 . .          .         . . .          .
#> Cell10644 . .         .         1 .          .         . . .          .
#> Cell6352  . .         .         . 1.00000000 .         . . 0.08108108 .
#> Cell202   . 0.1111111 .         . .          1.0000000 . . .          .
#> Cell3763  . .         .         . .          .         1 . .          .
#> Cell11305 . .         .         . .          .         . 1 .          .
#> Cell1619  . .         .         . 0.08108108 .         . . 1.00000000 .
#> Cell7073  . .         .         . .          .         . . .          1
head(simulation$labels, 10)
#>  Cell7247  Cell2462  Cell7731 Cell10644  Cell6352   Cell202  Cell3763 Cell11305
#>         B         B         B         A         B         B         A         B
#>  Cell1619  Cell7073
#>         B         A
#> Levels: A B C D
## estimate the knn matrix
knn_mat = knn_simMat(simulation$knnGraphs, simulation$labels)
print(knn_mat)
#>            B          A           D           C
#> B 0.90559742 0.04834084 0.032695520 0.013366219
#> A 0.02978309 0.93819202 0.020730191 0.011294702
#> D 0.04262080 0.04386126 0.905574534 0.007943405
#> C 0.01688846 0.02316331 0.007699363 0.952248861
```

The third way to estimate a confusion matrix is to use a support vector machine classifier. The input for estimating the confusion matrix will be a data frame containing a set of variables that the user believe will influence the result of the clustering process as well as the cell type labels for each cell. We then use 5-fold cross validation and support vector machine as the classifier to predict cell type labels. By comparing given labels and predicted labels, we can get a confusion matrix.

**Noted**: Two packages `tidyverse` and `tidymodels` should be attached.

```
data(Kang2017)
head(Kang2017$svmDF)
#>            PC_1         PC_2        PC_3       PC_4       PC_5       PC_6
#> 25666  3.886605  0.371065498  0.45612412 -2.2158043  0.8367050 -0.5005777
#> 21949 -4.892706  0.005013112 -0.14214031 -2.0263140 -9.1630543 -5.6146838
#> 20993  8.128727  3.413183866  0.77332521 -0.7947297 -0.1259194  1.4354282
#> 12800 -5.291259  1.086436116  0.09297087 -0.3688472  1.2591707  1.1448220
#> 20529  1.348189 -1.540491799 -1.11063041 -0.7533303 -0.1772481 -2.2803474
#> 2260  -4.674048  0.987198436 -0.24743392 -1.1894792  0.7813787  1.7889641
#>             PC_7       PC_8        PC_9       PC_10      PC_11      PC_12
#> 25666  0.7803348  0.4800115  3.44807316 -0.74869915 -0.2709463  0.1902547
#> 21949 -1.6259713  1.1843184 -0.34606758  0.06381662 -1.6661260  1.2609511
#> 20993 -0.3926234 -2.9391317 -0.18758445 -1.32352232 -9.5720590 -0.0816473
#> 12800 -0.1894140 -0.3941355 -0.07409775 -0.42776692  0.8500834 -0.1766672
#> 20529 -0.7090460  0.9702130  1.21294621  0.06270241  0.8655038 -1.1263086
#> 2260  -0.2910701 -0.5315665  0.64824174  0.10549453  1.5398666 -0.3199010
#>              PC_13      PC_14      PC_15      PC_16       PC_17       PC_18
#> 25666 -0.021474926 -2.0987058 -1.2426865 -1.1569523 -0.03833244  0.09700686
#> 21949  1.216625428 -0.2886003 -0.1862753  1.0963970  1.31225447 -0.89871374
#> 20993 -2.902801030  7.0283078  0.4110564 -2.8937657 -1.43682307 -4.22447218
#> 12800 -0.193047413 -0.1697745 -0.6363052  0.1382581  0.47646661 -0.71018124
#> 20529  0.001359746  0.8215608  1.6677901 -1.1598547 -0.61119430  0.41836462
#> 2260  -1.154064248 -0.6361448  0.4637186  0.4661563  1.40395389 -0.95124980
#>             PC_19      PC_20       PC_21      PC_22      PC_23      PC_24
#> 25666 -0.25524675  1.1443263 -0.22962253 -1.1924297 -0.3969562  0.4462946
#> 21949 -0.10255959 -0.2396403  0.08226689  1.3234882 -0.1730629  0.8658607
#> 20993  0.68097214 -4.2858702  5.54567343  3.8301645  0.4483186 -1.9667036
#> 12800  0.07136216  0.1128140  0.37217345  0.2601427  0.4763722  0.2402885
#> 20529  1.13865990  0.6297999 -1.47643207  0.6574216 -1.2929223 -0.8044571
#> 2260  -0.52253534 -0.5443369  0.96723500 -0.4688763  1.0660959  0.4273633
#>            PC_25      PC_26      PC_27        PC_28      PC_29       PC_30
#> 25666 -0.3862561 -1.2606189 -0.8322474  1.553621371  0.1971527 -1.55214561
#> 21949 -1.6100130  0.8802375 -2.5770211 -1.332021381 -0.6425592 -0.64571058
#> 20993 -2.3599685  0.4662246  0.9815318  0.190612316  1.0932119  1.32292269
#> 12800  0.2302071 -0.1369112 -0.1914076 -0.006736424 -0.5333921  0.74430509
#> 20529  0.1209402  0.3862782  0.7380538 -1.592696959  1.2786249 -0.95457380
#> 2260   0.6038350 -0.1864475 -0.1897286  0.282929965  1.3877823 -0.04619324
#>       condition        clusterRes
#> 25666      ctrl   CD14+ Monocytes
#> 21949      stim          NK cells
#> 20993      stim FCGR3A+ Monocytes
#> 12800      ctrl       CD4 T cells
#> 20529      ctrl   CD14+ Monocytes
#> 2260       stim       CD4 T cells
```

```
library(tidyverse)
library(tidymodels)
## estimate the svm matrix
svm_mat = svm_simMat(Kang2017$svmDF)
print(svm_mat)
```

```
#>
#>                          B cells CD14+ Monocytes  CD4 T cells  CD8 T cells
#>   B cells           0.9214804566    0.0096650338 0.0092441099 0.0015343306
#>   CD14+ Monocytes   0.0076098236    0.8290745399 0.0054810209 0.0038358266
#>   CD4 T cells       0.0349360083    0.0140341586 0.9460078534 0.0698120445
#>   CD8 T cells       0.0065721204    0.0039719317 0.0274869110 0.7974683544
#>   Dendritic cells   0.0134901418    0.0274063286 0.0011452880 0.0003835827
#>   FCGR3A+ Monocytes 0.0093393290    0.1028730306 0.0028632199 0.0015343306
#>   Megakaryocytes    0.0048426150    0.0074142725 0.0048265707 0.0003835827
#>   NK cells          0.0017295054    0.0055607044 0.0029450262 0.1250479478
#>
#>                     Dendritic cells FCGR3A+ Monocytes Megakaryocytes
#>   B cells              0.0376569038      0.0009124088   0.0237388724
#>   CD14+ Monocytes      0.0418410042      0.0310218978   0.1364985163
#>   CD4 T cells          0.0000000000      0.0045620438   0.1364985163
#>   CD8 T cells          0.0000000000      0.0027372263   0.0207715134
#>   Dendritic cells      0.8744769874      0.0018248175   0.0059347181
#>   FCGR3A+ Monocytes    0.0418410042      0.9562043796   0.0267062315
#>   Megakaryocytes       0.0041841004      0.0018248175   0.6142433234
#>   NK cells             0.0000000000      0.0009124088   0.0356083086
#>
#>                         NK cells
#>   B cells           0.0014224751
#>   CD14+ Monocytes   0.0033191086
#>   CD4 T cells       0.0109056425
#>   CD8 T cells       0.0796586060
#>   Dendritic cells   0.0000000000
#>   FCGR3A+ Monocytes 0.0014224751
#>   Megakaryocytes    0.0018966335
#>   NK cells          0.9013750593
```

## 3.3 Differential Abundance Anlysis

Here we used the simulated result to demonstrate the usage of `dcats_GLM`. We combine two cell counts matrices to create the count matrix, and create a corresponding data frame indicating the condition of those samples. `dcats_GLM` can give results based on the count matrix and design matrix.

**Noted** Even though we call it design matrix, we allow it to be both `matrix` and `data.frame`.

```
sim_count = rbind(sim_dat$numb_cond1, sim_dat$numb_cond2)
print(sim_count)
#>      [,1] [,2] [,3]
#> [1,]   36   35   29
#> [2,]  271  279  250
#> [3,]  518  379  403
#> [4,]  152  220  228
#> [5,]   84   87   79
#> [6,]  259  203  238
#> [7,]  345  376  379
sim_design = data.frame(condition = c("g1", "g1", "g1", "g1", "g2", "g2", "g2"))
print(sim_design)
#>   condition
#> 1        g1
#> 2        g1
#> 3        g1
#> 4        g1
#> 5        g2
#> 6        g2
#> 7        g2
dcats_GLM(sim_count, sim_design, similarity_mat = simil_mat)
#> $ceoffs
#>               condition
#> cell_type_1  0.03661816
#> cell_type_2 -0.06993872
#> cell_type_3  0.05830053
#>
#> $coeffs_err
#>              condition
#> cell_type_1 0.04897174
#> cell_type_2 0.02251655
#> cell_type_3 0.01511024
#>
#> $LR_vals
#>              condition
#> cell_type_1 0.02731556
#> cell_type_2 0.21580226
#> cell_type_3 0.21884571
#>
#> $LRT_pvals
#>             condition
#> cell_type_1 0.8687282
#> cell_type_2 0.6422572
#> cell_type_3 0.6399208
#>
#> $fdr
#>             condition
#> cell_type_1 0.8687282
#> cell_type_2 0.8687282
#> cell_type_3 0.8687282
```

The `ceoffs` indicates the estimated values of coefficients, the `coeffs_err` indicates the standard errors of coefficients, the `LRT_pvals` indicates the p-values calculated from the likelihood ratio test, and the `fdr` indicates the adjusted p-values given by [Benjamini & Hochberg method](https://www.jstor.org/stable/2346101?seq=1#metadata_info_tab_contents).

**Noted**: You might sometime receive a warning like `Possible convergence problem. Optimization process code: 10 (see ?optim).` It is caused by the low number of replicates and won’t influence the final results.

## 3.4 Other Models for Testing

When doing the differential abundance analysis in `DCATS`, we used generalized linear model assuming the cell counts follow beta-binomial distribution. `DCATS` provides p-values for each cluster considering each factor in the design matrix. The default model is comparing a model with only the tested factor and the null model. In this case, factors are tested independently.

We can also choose to compare the full model and a model without the tested factor. In this case, factors are tested when controlling the rest factors.

```
## add another factor for testing
set.seed(123)
sim_design = data.frame(condition = c("g1", "g1", "g1", "g1", "g2", "g2", "g2"),
                        gender = sample(c("Female", "Male"), 7, replace = TRUE))
dcats_GLM(sim_count, sim_design, similarity_mat = simil_mat, base_model='FULL')
#> $ceoffs
#>              condition      gender
#> cell_type_1  0.1948918 -0.38905567
#> cell_type_2 -0.1003737  0.06189625
#> cell_type_3 -0.1723674  0.40591227
#>
#> $coeffs_err
#>                condition       gender
#> cell_type_1 0.0386976000 0.0385575207
#> cell_type_2 0.0284446849 0.0283368344
#> cell_type_3 0.0007620465 0.0006001116
#>
#> $LR_vals
#>             condition     gender
#> cell_type_1 0.9040969  3.0970425
#> cell_type_2 0.3443648  0.1313372
#> cell_type_3 3.0111465 12.3540360
#>
#> $LRT_pvals
#>              condition       gender
#> cell_type_1 0.34168556 0.0784346670
#> cell_type_2 0.55732056 0.7170496021
#> cell_type_3 0.08269378 0.0004400341
#>
#> $fdr
#>             condition      gender
#> cell_type_1 0.5125283 0.165387560
#> cell_type_2 0.6687847 0.717049602
#> cell_type_3 0.1653876 0.002640205
```

When fitting the beta binomial model, we have a parameter \(\phi\) to describe the over-dispersion of data. The default setting of `DCATS` is to fit \(\phi\) for each cell type. This might leads to over-fitting. Here we can use the `getPhi` function to estimate a global \(\phi\) for all cell types and set `fixphi = TRUE` to apply this global \(\phi\) to all cell types.

In this case, `coeffs_err` is not available.

```
sim_design = data.frame(condition = c("g1", "g1", "g1", "g1", "g2", "g2", "g2"))
phi = DCATS::getPhi(sim_count, sim_design)
dcats_GLM(sim_count, sim_design, similarity_mat = simil_mat, fix_phi = phi)
#> $ceoffs
#>               condition
#> cell_type_1  0.02732541
#> cell_type_2 -0.06575758
#> cell_type_3  0.05803205
#>
#> $coeffs_err
#>             condition
#> cell_type_1        NA
#> cell_type_2        NA
#> cell_type_3        NA
#>
#> $LR_vals
#>              condition
#> cell_type_1 0.04776539
#> cell_type_2 0.27685545
#> cell_type_3 0.21489868
#>
#> $LRT_pvals
#>             condition
#> cell_type_1 0.8269983
#> cell_type_2 0.5987697
#> cell_type_3 0.6429547
#>
#> $fdr
#>             condition
#> cell_type_1 0.8269983
#> cell_type_2 0.8269983
#> cell_type_3 0.8269983
```

The `LRT_pvals` can be used to define whether one cell type shows differential proportion among different conditions by setting threshold as 0.05 or 0.01.

## 3.5 Use reference cell types as normalization term

DCATS also supports the use of known unchanged cell types as reference cell types. We recommend using 1) more than one cell type; 2) more than 20% of total cells as the reference group. Here, we named three simulated cell types as A, B, C, and use the cell type A, B as the reference cell types.

```
colnames(sim_count) = c("A", "B", "C")
dcats_GLM(sim_count, sim_design, similarity_mat = simil_mat, reference = c("A", "B"))
#> $ceoffs
#>     condition
#> A  0.04318527
#> B -0.02668661
#> C  0.05748545
#>
#> $coeffs_err
#>    condition
#> A 0.01600641
#> B 0.01633854
#> C 0.01529722
#>
#> $LR_vals
#>    condition
#> A 0.11817121
#> B 0.04383267
#> C 0.21072459
#>
#> $LRT_pvals
#>   condition
#> A 0.7310265
#> B 0.8341652
#> C 0.6462001
#>
#> $fdr
#>   condition
#> A 0.8341652
#> B 0.8341652
#> C 0.8341652
```

Even though it is not recommended, DCATS allows the use of one cell type as the reference cell type. Especially when we are interested in the ratio relationship between two cell types (for eaxmple A and B).

```
dcats_GLM(sim_count, sim_design, similarity_mat = simil_mat, reference = c("A"))
#> Warning in aod::betabin(formula_fm1, ~1, data = df_tmp, warnings = FALSE):
#> Possible convergence problem. Optimization process code: 10 (see ?optim).
#> $ceoffs
#>      condition
#> A -0.004533535
#> B -0.083349329
#> C  0.008707148
#>
#> $coeffs_err
#>    condition
#> A 0.00485482
#> B 0.05644594
#> C 0.05138848
#>
#> $LR_vals
#>      condition
#> A -0.005172729
#> B  0.122209029
#> C  0.001515344
#>
#> $LRT_pvals
#>   condition
#> A 1.0000000
#> B 0.7266509
#> C 0.9689483
#>
#> $fdr
#>   condition
#> A         1
#> B         1
#> C         1
```

When we have no idea which cell types can be used as reference cell types, DCATS supports detection of reference cell types automatically using the function `detect_reference`. This function returns a vector with ordered cell types and a meesage indicating how many cell types should be selected as the reference group. Cell types are ordered by an estimation of their proportion difference. The order indicating how they are recommended to be selected as reference cell types. We recommend to select top cell types.

Nonetheless, this kind of tasks is challenging and we suggest users perform the reference cell selection with caution.

```
reference_cell = detect_reference(sim_count, sim_design, similarity_mat = simil_mat)
#> Please check the 'min_celltypeN' for the number of minimum cell types recommend.
print(reference_cell)
#> $min_celltypeN
#> [1] 2
#>
#> $ordered_celltype
#> [1] "A" "B" "C"
dcats_GLM(sim_count, sim_design, similarity_mat = simil_mat, reference = reference_cell$ordered_celltype[1:2])
#> $ceoffs
#>     condition
#> A  0.04423357
#> B -0.02718748
#> C  0.05830053
#>
#> $coeffs_err
#>    condition
#> A 0.01611672
#> B 0.01641139
#> C 0.01511024
#>
#> $LR_vals
#>    condition
#> A 0.12191851
#> B 0.04545546
#> C 0.21884571
#>
#> $LRT_pvals
#>   condition
#> A 0.7269629
#> B 0.8311687
#> C 0.6399208
#>
#> $fdr
#>   condition
#> A 0.8311687
#> B 0.8311687
#> C 0.8311687
```

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
#> [1] DCATS_1.8.0      BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] Matrix_1.7-4        future.apply_1.20.0 jsonlite_2.0.0
#>  [4] compiler_4.5.1      BiocManager_1.30.26 Rcpp_1.1.0
#>  [7] SeuratObject_5.2.0  MatrixModels_0.5-4  parallel_4.5.1
#> [10] jquerylib_0.1.4     globals_0.18.0      splines_4.5.1
#> [13] yaml_2.3.10         fastmap_1.2.0       lattice_0.22-7
#> [16] coda_0.19-4.1       R6_2.6.1            generics_0.1.4
#> [19] MCMCpack_1.7-1      robustbase_0.99-6   knitr_1.50
#> [22] MASS_7.3-65         dotCall64_1.2       future_1.67.0
#> [25] bookdown_0.45       bslib_0.9.0         rlang_1.1.6
#> [28] sp_2.2-0            cachem_1.1.0        xfun_0.53
#> [31] sass_0.4.10         aod_1.3.3           cli_3.6.5
#> [34] progressr_0.17.0    mcmc_0.9-8          digest_0.6.37
#> [37] grid_4.5.1          quantreg_6.1        spam_2.11-1
#> [40] lifecycle_1.0.4     DEoptimR_1.1-4      evaluate_1.0.5
#> [43] SparseM_1.84-2      listenv_0.9.1       codetools_0.2-20
#> [46] survival_3.8-3      parallelly_1.45.1   rmarkdown_2.30
#> [49] matrixStats_1.5.0   tools_4.5.1         htmltools_0.5.8.1
```