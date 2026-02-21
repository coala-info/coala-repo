# ROCpAI: ROC Partial Area Indexes for evaluating classifiers

Manuel Franco1, Juana-María Vivo1 and Juan Pedro García-Ortiz1

1Department of Statistics and Operations Research, University of Murcia, IMIB-Arrixaca, 30100, Murcia, Spain

#### 2020-01-15

#### Abstract

R package **ROCpAI** how-to guide

#### Package

ROCpAI 1.22.0

# 1 Introduction

The **ROCpAI** package allows to calculate the area under the ROC curve (AUC) and the partial area under the ROC curve (pAUC) as well as partial area indexes related with the pAUC over a restricted false positive interval of interest even if the ROC curve is improper.

To do this, the package calculates the specificty and sensibility from a classification model with the function **points.curve**, after that, it calculates the partia area and two standardized: the McClish index (McClish [1989](#ref-McClish1989)) with the **mcpAUC** if the ROC curve is proper over the restricted interval, and the **tpAUC** index according for any shape of the ROC curve over such interval, even if it is improper.
Moreover,the functions **tpAUCboot** and **mcpAUCboot** apply bootstrap resampling (Davison and Hinkley [1997](#ref-DavisonHinkley1997)) to calculate the empiral standard deviation and the confidence interval of these standardized indexes.

## 1.1 Installation

The installation of **ROCpAI** package is performed via Github:

```
devtools::install_github("juanpegarcia/ROCpAI")
```

## 1.2 Prerequisites

The package **ROCpAI** depends on the following Bioconductor package:
`SummarizedExperiment` (Morgan et al. [2019](#ref-SummarizedExperiment2019)) and `boot` (Angelo and Ripley [2019](#ref-boot2019)),

# 2 Using ROCpAI

The **fission** dataset (Leong et al. [2014](#ref-Leongetal2014)) contains the data of 36 samples of yeast and 7039 genes in a RangedSummarizedExperiment object type. These 36 samples are divided in 18 native samples and 18 mutated samples.

Data.frame example

```
genes
```

```
##            Strain Gene1 Gene2 Gene3 Gene4 Gene5
## GSM1368273      1   105     0    12    95    37
## GSM1368274      1    35     0     3    29     5
## GSM1368275      1    35     2     2    67    21
## GSM1368276      1    21     0     0    40    27
## GSM1368277      1    36     0     0    44     6
## GSM1368278      1    14     0     6    27     4
## GSM1368279      1    41     0     7    60    33
## GSM1368280      1    24     0     5    51    32
## GSM1368281      1    34    40    11    39    54
## GSM1368282      1    15     0     2    25    10
## GSM1368283      1    86     1    15   103    32
## GSM1368284      1    38    15     7    57    23
## GSM1368285      1    50     0    10    65    25
## GSM1368286      1    57     1     1    32    10
## GSM1368287      1    16     4     3    25    18
## GSM1368288      1    62     0     2    32    25
## GSM1368289      1    57     0     8    43    29
## GSM1368290      1    36     0     4    28    17
## GSM1368291      2    41     0    13   106    19
## GSM1368292      2    84     1     6   190    43
## GSM1368293      2    95     6    16   215    92
## GSM1368294      2    48     6    21    74    38
## GSM1368295      2    54     5    15   155    25
## GSM1368296      2    47     4     8    56    33
## GSM1368297      2    59    30    10   162   139
## GSM1368298      2    66    12    24    92    94
## GSM1368299      2    42    25    18   107   115
## GSM1368300      2    64     4    14   133    82
## GSM1368301      2    72    18    10   112    81
## GSM1368302      2    62     9     9    97    59
## GSM1368303      2    44     4    14    87    44
## GSM1368304      2    60     7    13    69    68
## GSM1368305      2    46     9    17    78    62
## GSM1368306      2    46     7    18    70    51
## GSM1368307      2    48     4     7    58    33
## GSM1368308      2    17     1     8    48    29
```

# 3 Functions:

## 3.1 PointCurves

This function generates the points of the ROC curve given by the pairs of the true positive rate (sensitibity) and false positive rate (1-specificity) for each possible cut-off point. **pointsCurve** needs 2 parameters: x and y. The first parameter correspond to a vector with the cases’ tags, while the second one is a vector with the value of each case. This function returns a matrix with the sensibility and specifity.

```
pointsCurve(genes[,1], genes[,2])
```

```
##        fpr.point  sen.point
##  [1,] 0.00000000 0.00000000
##  [2,] 0.05555556 0.00000000
##  [3,] 0.05555556 0.05555556
##  [4,] 0.11111111 0.05555556
##  [5,] 0.11111111 0.11111111
##  [6,] 0.11111111 0.16666667
##  [7,] 0.11111111 0.22222222
##  [8,] 0.11111111 0.27777778
##  [9,] 0.11111111 0.27777778
## [10,] 0.16666667 0.33333333
## [11,] 0.16666667 0.38888889
## [12,] 0.16666667 0.44444444
## [13,] 0.16666667 0.44444444
## [14,] 0.27777778 0.44444444
## [15,] 0.27777778 0.50000000
## [16,] 0.33333333 0.50000000
## [17,] 0.33333333 0.50000000
## [18,] 0.33333333 0.61111111
## [19,] 0.33333333 0.66666667
## [20,] 0.33333333 0.66666667
## [21,] 0.33333333 0.77777778
## [22,] 0.33333333 0.83333333
## [23,] 0.33333333 0.88888889
## [24,] 0.33333333 0.88888889
## [25,] 0.38888889 0.94444444
## [26,] 0.44444444 0.94444444
## [27,] 0.44444444 0.94444444
## [28,] 0.55555556 0.94444444
## [29,] 0.55555556 0.94444444
## [30,] 0.66666667 0.94444444
## [31,] 0.72222222 0.94444444
## [32,] 0.77777778 0.94444444
## [33,] 0.83333333 0.94444444
## [34,] 0.83333333 1.00000000
## [35,] 0.88888889 1.00000000
## [36,] 0.94444444 1.00000000
## [37,] 1.00000000 1.00000000
```

## 3.2 mcpAUC

This function calculates the pAUC its standardised partial area index given by (McClish [1989](#ref-McClish1989)). This function has five parameters. The first one is a data.frame or a RangedSummarizedExperiment object, if it is a data.frame object, the “Gold Standard” must be in the first column. The other four parameters are optionals; low.value and up.value are the false positive rate values that the function will use to calculate the pAUC. If low.value is NULL the function will take 0 as the lower limit. If up.value is NULL the function will use 1 as the upper value. The parameter plot generates a graph with the ROC curves generated. The last parameter is called “selection” and is only used if the parameter “dataset” is a RangedSummarizedExperiment object. This parameter is used to select the variables that will be analysed. If this parameter is NULL the function will analyse all the variables in the dataset.
The function returns as RangedSummarizedExperiment object with the pAUC and the mcpAUC scores,and the TPR and FPR values for each ROC curve generated.

```
resultMc <- mcpAUC(genes, low.value = 0, up.value = 0.25, plot=TRUE)
resultMc
```

```
## class: SummarizedExperiment
## dim: 4 1
## metadata(0):
## assays(1): ''
## rownames(4): St_pAUC pAUC Sensitivity FPR
## rowData names(1): metrics
## colnames: NULL
## colData names(0):
```

![](data:image/png;base64...)

```
test.Mc<- assay(resultMc)
test.Mc$St_pAUC
```

```
## [[1]]
## [1] NA
##
## [[2]]
## [1] NA
##
## [[3]]
## [1] 0.7654321
##
## [[4]]
## [1] 0.8130511
##
## [[5]]
## [1] 0.8412698
```

```
test.Mc$pAUC
```

```
## [[1]]
## [1] 0.05709877
##
## [[2]]
## [1] 0.119213
##
## [[3]]
## [1] 0.1473765
##
## [[4]]
## [1] 0.1682099
##
## [[5]]
## [1] 0.1805556
```

## 3.3 tpAUC

This function calculates the pAUC and its standardised pAUC by the tighter partial area index (tpAUC) (Vivo, Franco, and Vicari [2018](#ref-Vivoetal2018)). This function has five parameters. The first one is a data.frame or a RangedSummarizedExperiment object, if it is a data.frame object the “Gold Standard” must be in the first column. The other four parameters are optionals; low.value and up.value are the false positive rate values that the function will use to calculate the pAUC. If low. value is NULL the function will take 0 as the lower limit. If up.value is NULL the function will use 1 as the upper value. The parameter plot generates a graph for each ROC curve generated. The last parameter is called “selection” and is only used if the parameter “dataset” is a RangedSummarizedExperiment object. This parameter is used to select the variables that will be analysed. If this parameter is NULL the function will do a ROC curve with all the variables in the object.
The function returns as RangedSummarizedExperiment object with the pAUC and the tpAUC scores,and the TPR and FPR values for each ROC curve generated

```
resultsT <- tpAUC(genes, low.value = 0, up.value = 0.25, plot=TRUE)
resultsT
```

```
## class: SummarizedExperiment
## dim: 4 1
## metadata(0):
## assays(1): ''
## rownames(4): St_pAUC pAUC Sensitivity FPR
## rowData names(1): metrics
## colnames: NULL
## colData names(0):
```

![](data:image/png;base64...)

```
test.tpAUC <- assay(resultsT)
```

```
test.tpAUC$St_pAUC
```

```
## [[1]]
## [1] 0.7569444
##
## [[2]]
## [1] 0.7768817
##
## [[3]]
## [1] 0.8278867
##
## [[4]]
## [1] 0.8074074
##
## [[5]]
## [1] 0.8666667
```

```
test.tpAUC$pAUC
```

```
## [[1]]
## [1] 0.05709877
##
## [[2]]
## [1] 0.119213
##
## [[3]]
## [1] 0.1473765
##
## [[4]]
## [1] 0.1682099
##
## [[5]]
## [1] 0.1805556
```

## 3.4 tpAUCboot

This function use the R package `boot` to calculate the variability of the tpAUC for each classifier over the restricted fpr interval of interest, and its confidence interval based on the methods of the boot.ci function. The tpAUCboot function uses 7 parameters: dataset, low.value, up.value, r, seed, level and type.interval. Dataset is a matrix or a SummarizedExperiment object. The first column must be the condition of each case, while the following columns are the values of the variables or classifiers. The **low.value** and **up.value** are the FPR limits for the pAUC. The parameter **r** is the name of iterations. The parameter **level** is the value used for the confidence interval (per default is 0.95) and the **type.interval** defines the method applied by boot.ci, which can be “norm”, “basic”, “stud”, “perc” or “bca”. The last parameter is called “selection” and is only used if the parameter “dataset” is a RangedSummarizedExperiment object. This parameter is used to select the genes that will be analysed. If this parameter is NULL, the function will display a ROC curve with all the variables in the object.
This function returns a SummarizedExperiment object with the tpAUC, the standard desviation, and the lower and upper limits of the confidence interval

```
resultstboot<- tpAUCboot(genes,low.value = 0, up.value = 0.25)
```

```
test.tpAUCboot <- assay(resultstboot)
resultT <- t(as.data.frame(cbind(test.tpAUCboot$Tp_AUC,test.tpAUCboot$sd,test.tpAUCboot$lwr,test.tpAUCboot$upr)))
colnames(resultT) <- c("Gene1", "Gene2", "Gene3", "Gene4", "Gene5")
rownames(resultT) <- c("Tp_AUC","sd","lwr","upr")
```

```
resultT
```

```
##            Gene1 Gene2 Gene3 Gene4 Gene5
## Tp_AUC 0.7569444     0     0     0     0
## sd     0.1362004     0     0     0     0
## lwr    0.1924971     0     0     0     0
## upr    0.9000000     0     0     0     0
```

## 3.5 mcpAUCboot

This function use the R package `boot` to calculate the variability of the mcpAUC for each classifier over the restricted fpr interval of interest, and its confidence interval based on the methods of the boot.ci function. The mcpAUCboot function uses 7 parameters: dataset, low.value, up.value, r, seed, level and type.interval. Dataset is a matrix or a SummarizedExperiment object. The first column must be the condition of each case, while the following columns are the values of the variables or classifiers. The **low.value** and **up.value** are the FPR limits for the pAUC.The parameter **r** is the name of iterations. The parameter **level** is the value used for the confidence interval (per default is 0.95) and the **type.interval** defines the method applied by boot.ci, which can be “norm”, “basic”, “stud”, “perc” or “bca”. The last parameter is called “selection” and is only used if the parameter “dataset” is a RangedSummarizedExperiment object. This parameter is used to select the genes that will be analysed. If this parameter is NULL, the function will display a ROC curve with all the variables in the object.
This function returns a SummarizedExperiment object with the mcpAUC, the standard desviation, and the lower and upper limits of the confidence interval.

```
resultsMcboot <- mcpAUCboot(genes,low.value = 0, up.value = 0.25)
```

```
test.mcpAUCboot <- assay(resultsMcboot)
resultMc <- t(as.data.frame(cbind(test.mcpAUCboot$MCp_AUC,test.mcpAUCboot$sd,test.mcpAUCboot$lwr,test.mcpAUCboot$upr)))
colnames(resultMc) <- c("Gene1", "Gene2", "Gene3", "Gene4", "Gene5")
rownames(resultMc) <- c("MCp_AUC","sd","lwr","upr")
```

```
resultMc
```

```
##         Gene1 Gene2 Gene3 Gene4 Gene5
## MCp_AUC    NA     0     0     0     0
## sd         NA     0     0     0     0
## lwr        NA     0     0     0     0
## upr        NA     0     0     0     0
```

# 4 Information

## 4.1 Contact

The source code is available at **github**. For bug/error reports please refer
to ROCpAI github issues <https://github.com/juanpegarcia/ROCpAI/issues>.

## 4.2 License

The package `ROCpAI` is licensed under GPL-3.

## 4.3 How to cite

Currently there is no literature for `ROCpAI`. Please cite the R package, the
github. This package will be updated as soon as a citation is
available.

## 4.4 Session information

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
##  [1] ROCpAI_1.22.0               knitr_1.50
##  [3] fission_1.29.0              SummarizedExperiment_1.40.0
##  [5] Biobase_2.70.0              GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [11] generics_0.1.4              MatrixGenerics_1.22.0
## [13] matrixStats_1.5.0           boot_1.3-32
## [15] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] Matrix_1.7-4        jsonlite_2.0.0      compiler_4.5.1
##  [4] BiocManager_1.30.26 Rcpp_1.1.0          tinytex_0.57
##  [7] magick_2.9.0        jquerylib_0.1.4     yaml_2.3.10
## [10] fastmap_1.2.0       lattice_0.22-7      R6_2.6.1
## [13] XVector_0.50.0      S4Arrays_1.10.0     DelayedArray_0.36.0
## [16] bookdown_0.45       bslib_0.9.0         rlang_1.1.6
## [19] cachem_1.1.0        xfun_0.53           sass_0.4.10
## [22] SparseArray_1.10.0  cli_3.6.5           magrittr_2.0.4
## [25] digest_0.6.37       grid_4.5.1          lifecycle_1.0.4
## [28] evaluate_1.0.5      abind_1.4-8         rmarkdown_2.30
## [31] tools_4.5.1         htmltools_0.5.8.1
```

## Bibliography

Angelo, Canty, and B. D. Ripley. 2019. *Boot: Bootstrap R (S-Plus) Functions*.

Davison, A. C., and D. V. Hinkley. 1997. *Bootstrap Methods and Their Applications*. Cambridge: Cambridge University Press. <http://statwww.epfl.ch/davison/BMA/>.

Leong, Hui Sun, Keren Dawson, Chris Wirth, Yaoyong Li, Yvonne Connolly, Duncan L Smith, Caroline R M Wilkinson, and Crispin J Miller. 2014. “A Global Non-Coding Rna System Modulates Fission Yeast Protein Levels in Response to Stress.” *Nature Communications* 5: 3947.

McClish, Donna Katzman. 1989. “Analyzing a Portion of the Roc Curve.” *Medical Decision Making* 9 (3): 190–95.

Morgan, Martin, Valerie Obenchain, Jim Hester, and Hervé Pagès. 2019. *SummarizedExperiment: SummarizedExperiment Container*.

Vivo, Juana-Marı́a, Manuel Franco, and Donatella Vicari. 2018. “Rethinking an Roc Partial Area Index for Evaluating the Classification Performance at a High Specificity Range.” *Advances in Data Analysis and Classification* 12 (3): 683–704.