# GSALightning: Ultra-fast Permutation-based Gene Set Analysis

#### Billy Heung Wing Chang

#### 2025-10-30

* [1. Introduction](#introduction)
* [2. Installation and Quick Start](#installation-and-quick-start)
  + [2.1 Installing GSALightning](#installing-gsalightning)
  + [2.2 Running GSALightning](#running-gsalightning)
* [3. The Inputs for GSALight()](#the-inputs-for-gsalight)
* [4. GSALight()](#gsalight)
  + [4.1 Preliminiary Data Check](#preliminiary-data-check)
  + [4.2 Most Commonly Considered Arguments for GSALight()](#most-commonly-considered-arguments-for-gsalight)
  + [4.3 The Maxmean, Mean, and Absolute Mean Statistics](#the-maxmean-mean-and-absolute-mean-statistics)
  + [4.4 Outputs of GSALight()](#outputs-of-gsalight)
  + [4.5 Default Number of Permutations](#default-number-of-permutations)
  + [4.6 Restandardization](#restandardization)
* [5. Other Functions in GSALightning](#other-functions-in-gsalightning)
  + [5.1 Single Gene Permutation Test](#single-gene-permutation-test)
  + [5.2 Mann-Whitney U Test for Single Gene Testing](#mann-whitney-u-test-for-single-gene-testing)
  + [5.3 Gene Set Analysis for Paired Design](#gene-set-analysis-for-paired-design)
* [References](#references)

## 1. Introduction

GSALightning is an ultra-fast implementation of permutation-based gene set analysis. Similar to existing methods, GSALightning takes as inputs a gene expression data set and a set of gene sets. The functionality is similar to the GSA algorithm of (Efron 2007), and performs permutation tests using a combined Student-T test statistics. In particular, GSALightning retains the “mean”, “absmean”, “maxmean” statistics, supports unpaired and paired two sample-tests, and the restandardization procedure of GSA. The speed of GSALightning, however, is much faster, particularly when the number of gene sets and the number of permutations are large.

R implementation of GSA-Lightning is available at Bioconductor and on Github at <https://github.com/billyhw/GSALightning>.

This document begins with an installation and quick-start guide for users. This document then goes deeper into the various functions and features of GSALightning.

## 2. Installation and Quick Start

### 2.1 Installing GSALightning

We recommend installing GSA-Lightning using the R “devtools” package. To do this, install the R “devtools” package, and then in R type:

```
library(devtools)
install_github("billyhw/GSALightning")
```

### 2.2 Running GSALightning

We begin by first loading the GSA-Lightning package:

```
library(GSALightning)
```

We now read in a breast cancer expression data set and the patients’ status data. The data set is obtained from The Cancer Genome Atlas (TCGA) consortium (The Cancer Genome Atlas 2012), processed by the Pan-Cancer Project group (Weinstein 2013), and downloaded using the Bioconductor package ELMER (Yao 2015). The gene names have been converted to gene symbols in this data set.

```
data(expression)
data(sampleInfo)
```

We next read in the gene sets. This gene sets contain the target genes of 104,636 distal regulatory elements, obtained from the supplementary materials of (Lu 2015).

```
data(targetGenes)
```

We next remove genes with 0 sample variance:

```
expression <- expression[apply(expression,1,sd) != 0,]
```

The main function of GSALightning is GSALight(). Skipping the details for now, we will run GSALight using the most of the default settings, and look at the results:

```
GSALightResults <- GSALight(eset = expression, fac = factor(sampleInfo$TN), gs = targetGenes,
                           nperm = 1000, minsize = 10, rmGSGenes = 'gene')
```

```
## Some genes within the gene sets are not contained in the expression data set.
##  These genes are removed from the gene sets since rmGSGenes == 'gene'.
```

```
## After gene set size filtering, there are 707 gene sets,
##  containing a total of 909 genes for analysis.
```

```
## Obtaining observed gene set statistics.
```

```
## Permutation done. Evaluating P-values.
```

```
head(GSALightResults)
```

```
##        p-value:up-regulated in Experiment p-value:up-regulated in Control
## 110168                              0.088                           0.912
## 171518                              0.797                           0.203
## 171519                              0.951                           0.049
## 171520                              0.654                           0.346
## 171521                              0.714                           0.286
## 192692                              0.063                           0.937
##        q-value:up-regulated in Experiment q-value:up-regulated in Control
## 110168                          0.8792179                       0.9974318
## 171518                          0.9952230                       0.8492245
## 171519                          0.9952230                       0.8157692
## 171520                          0.9952230                       0.8492245
## 171521                          0.9952230                       0.8492245
## 192692                          0.8792179                       0.9974318
##        statistics: up-regulated in Control # genes
## 110168                         -0.44376901      13
## 171518                          0.27760439      12
## 171519                          0.64692667      11
## 171520                          0.09136959      12
## 171521                          0.17147761      11
## 192692                         -0.68288140      13
```

As a reminder, in R, if a function’s arguments are unspecified, the default settings for the arguments will be used. To explore the various arguments of GSALight(), type:

```
? GSALight
```

## 3. The Inputs for GSALight()

There are three main inputs to GSALight(): an expression data set, the subject classes, and the gene sets.

The expression data set is a matrix, where each row represents a gene and each column represents a subject. The expression data set is passed into GSALight() using the argument “eset”:

```
data(expression)
expression[1:4,1:3]
```

```
##        TCGA-A8-A07B-01A-11R-A00Z-07 TCGA-A8-A08B-01A-11R-A00Z-07
## RBFOX1                       0.0000                       0.0000
## ABCA12                     246.8301                     634.2756
## ABCA1                     1691.4624                     202.2968
## ABCB11                       0.0000                       3.5336
##        TCGA-A8-A08P-01A-11R-A00Z-07
## RBFOX1                       0.0000
## ABCA12                     246.8838
## ABCA1                     1390.4302
## ABCB11                       0.0000
```

*Note: The rows and columns of the expression data matrix must be names for GSALightning to work.*

The subject classes is a factor of classes for the subjects.

```
data(sampleInfo)
head(sampleInfo$TN)
```

```
## [1] Experiment Experiment Experiment Experiment Experiment Experiment
## Levels: Control Experiment
```

In the given sampleInfo data set, the third column “TN” contains the subject classes. In the GSALight() call in the earlier section, the “TN” column is passed into GSALight() as a factor vector through the argument “fac”.

The third input for GSALight() are the gene sets:

```
data(targetGenes)
targetGenes[1:3]
```

```
## $`784`
## [1] "MEGF6" "SSU72"
##
## $`785`
## [1] "MEGF6" "SSU72"
##
## $`796`
## [1] "MEGF6"
```

In the demonstration above, the gene sets are stored in “targetGenes”" as a list, where each element is a vector of genes belonging to a gene set. The gene sets are passed into GSALight() through the option “gs”.

*Advanced usage: alternatively, the gene sets can be a data.table, where the first column (must be named “geneSet”) contains the names of the gene set, and the second column (must be named “gene”) are the gene set genes. The gene sets can also be a binary sparse matrix, where each row is a gene set, and each column is a gene. For each row (i.e. a gene set), the row entry is 1 if the corresponding gene belongs to the gene set, and 0 otherwise.*

## 4. GSALight()

The main function of GSA-Lightning is GSALight(), which performs permutation-based gene set analysis.

### 4.1 Preliminiary Data Check

Prior to beginning the permutation, GSALight() will check for (1) if there are missing data in the expression data, (2) if any gene has zero sample variance, and (3) if there are genes in a gene set without expression measurements in the expression matrix. If any one of (1), (2), and (3) is true, GSALight() will return an error.

Users are therefore recommended to ensure that missing data in the expression data is appropriately handled (e.g. through imputation) before running GSALight(). Also please ensure genes with zero (or small) sample variance are removed prior to running GSALight().

To handle genes within gene sets with no expression measurements in the expression data, users can use the “rmGSGenes” argument. By setting “rmGSGenes = ‘gene’”, GSALight() will remove genes without expression measurement from the gene sets. Alternative, by setting “rmGSGenes = ‘gs’”, GSALight() will exclude gene sets with unmeasured genes entirely from the analysis.

*Recommendation: before setting rmGSGenes = ‘gene’, please consider whether removing a gene from a gene set will alter the implications of the results.*

If we run GSALight() as follows, an error will return because there are genes with zero sample variance:

```
data(expression)
data(sampleInfo)
data(targetGenes)
GSALightResults <- GSALight(eset = expression, fac = factor(sampleInfo$TN), gs = targetGenes)
```

```
## Error in GSALight(eset = expression, fac = factor(sampleInfo$TN), gs = targetGenes): Some genes within the gene sets are not contained in the expression data set.
##  Set rmGSGenes = 'gene' or 'gs' to remove respectively the missing genes or gene sets.
```

If we remove the genes with zero sample variance and rerun GSALight(), another error will be reported since genes within some gene sets without expression measurements:

```
expression <- expression[apply(expression,1,sd) != 0,]
GSALightResults <- GSALight(eset = expression, fac = factor(sampleInfo$TN), gs = targetGenes)
```

```
## Error in GSALight(eset = expression, fac = factor(sampleInfo$TN), gs = targetGenes): Some genes within the gene sets are not contained in the expression data set.
##  Set rmGSGenes = 'gene' or 'gs' to remove respectively the missing genes or gene sets.
```

We will remove the genes without expression measurements from those gene sets by setting “rmGSGenes = ‘gene’”. GSALight() will now run and finish the permutation:

```
GSALightResults <- GSALight(eset = expression, fac = factor(sampleInfo$TN), gs = targetGenes,
                           nperm = 1000, rmGSGenes = 'gene')
```

```
## Some genes within the gene sets are not contained in the expression data set.
##  These genes are removed from the gene sets since rmGSGenes == 'gene'.
```

```
## After gene set size filtering, there are 71778 gene sets,
##  containing a total of 909 genes for analysis.
```

```
## Obtaining observed gene set statistics.
```

```
## Permutation done. Evaluating P-values.
```

```
head(GSALightResults)
```

```
##        p-value:up-regulated in Experiment p-value:up-regulated in Control
## 100018                              0.551                           0.449
## 100020                              0.551                           0.449
## 100120                              0.837                           0.163
## 100127                              0.285                           0.715
## 100129                              0.551                           0.449
## 100137                              0.551                           0.449
##        q-value:up-regulated in Experiment q-value:up-regulated in Control
## 100018                                  1                       0.8317416
## 100020                                  1                       0.8317416
## 100120                                  1                       0.8128194
## 100127                                  1                       0.9205774
## 100129                                  1                       0.8317416
## 100137                                  1                       0.8317416
##        statistics: up-regulated in Control # genes
## 100018                          0.08045635       1
## 100020                          0.08045635       1
## 100120                          0.85943190       1
## 100127                         -0.27737502       1
## 100129                          0.08045635       1
## 100137                          0.08045635       1
```

### 4.2 Most Commonly Considered Arguments for GSALight()

Below is a call to GSALight() where some commonly considered arguments are explicitly specified:

```
GSALightResults <- GSALight(eset = expression, fac = factor(sampleInfo$TN), gs = targetGenes,
                           nperm = 1000, method = 'maxmean', restandardize = FALSE, minsize = 10,
                           maxsize = 30, rmGSGenes = 'gene', verbose = FALSE)
```

In the above:

*eset = expression*: the expression data set, with rows being the genes.

*fac = factor(sampleInfo$TN)*: the subject class labels.

*gs = targetGenes*: the list of gene sets.

*nperm = 1000*: the number of permutations for the permutation test.

*method = “maxmean”*: the test statistics. Other choices include “mean” and “maxmean”.

*restandardize = FALSE*: whether restandardization will be performed. More on this later.

*minsize = 10*: the minimum number of genes a gene set must contained to be included in the analysis.

*maxsize = 30*: the maximum number of genes a gene set must contained to be included in the analysis.

*rmGSGenes = ‘gene’*: as discussed previously, this removes genes without expression measurements from the gene set.

*verbose = TRUE*: GSALight() will report progress while running.

### 4.3 The Maxmean, Mean, and Absolute Mean Statistics

GSALight() offers three ways to combine the individual gene statistics into a gene set statistics. The default “maxmean” is the statistics proposed and recommended by Efron (2007). Other options are “mean”, i.e. the mean of the statistics of the genes inside a gene set, and “absmean”, the mean of the absolute value of the statistics.

For example, to use the “mean” statistics, call:

```
GSALightResultsMean <- GSALight(eset = expression, fac = factor(sampleInfo$TN), gs = targetGenes,
                           nperm = 1000, method = 'mean', restandardize = FALSE, minsize = 10,
                           maxsize = 30, rmGSGenes = 'gene', verbose = FALSE)
```

To use the “absmean” statistics, call:

```
GSALightResultsAbs <- GSALight(eset = expression, fac = factor(sampleInfo$TN), gs = targetGenes,
                           nperm = 1000, method = 'absmean', restandardize = FALSE, minsize = 10,
                           maxsize = 30, rmGSGenes = 'gene', verbose = FALSE)
```

### 4.4 Outputs of GSALight()

If the argument “method” is set to either “maxmean” or “mean”, the output of GSALight() is a matrix with six columns:

```
head(GSALightResults)
```

```
##        p-value:up-regulated in Experiment p-value:up-regulated in Control
## 110168                                  1                               0
## 171518                                  1                               0
## 171519                                  1                               0
## 171520                                  1                               0
## 171521                                  1                               0
## 192692                                  1                               0
##        q-value:up-regulated in Experiment q-value:up-regulated in Control
## 110168                                  1                               0
## 171518                                  1                               0
## 171519                                  1                               0
## 171520                                  1                               0
## 171521                                  1                               0
## 192692                                  1                               0
##        statistics: up-regulated in Control # genes
## 110168                            3.760459      13
## 171518                           10.098408      12
## 171519                           13.592400      11
## 171520                            8.336525      12
## 171521                            9.094391      11
## 192692                            3.654907      13
```

```
head(GSALightResultsMean)
```

```
##        p-value:up-regulated in Experiment p-value:up-regulated in Control
## 110168                                  1                               0
## 171518                                  1                               0
## 171519                                  1                               0
## 171520                                  1                               0
## 171521                                  1                               0
## 192692                                  1                               0
##        q-value:up-regulated in Experiment q-value:up-regulated in Control
## 110168                                  1                               0
## 171518                                  1                               0
## 171519                                  1                               0
## 171520                                  1                               0
## 171521                                  1                               0
## 192692                                  1                               0
##        statistics: up-regulated in Control # genes
## 110168                            2.201118      13
## 171518                            9.841780      12
## 171519                           13.312442      11
## 171520                            8.005286      12
## 171521                            8.835396      11
## 192692                            1.676000      13
```

Each row represents the results for a gene set. As the column names suggest, the first two columns are the p-values for testing up-regulation in the two different subject classes. The next two columns are the q-values (that control for false discovery rate) for testing up-regulation in the two different subject classes. The fifth column is the gene set statistics, and the final column shows the number of genes within each gene set.

If “method” is ‘absmean’, the output of GSALight() is a matrix with four columns:

```
head(GSALightResultsAbs)
```

```
##        p-value q-value statistics # genes
## 110168       0       0   5.319801      13
## 171518       0       0  10.355037      12
## 171519       0       0  13.872358      11
## 171520       0       0   8.667764      12
## 171521       0       0   9.353386      11
## 192692       0       0   5.633813      13
```

The first and second columns are respectively the p-values and q-values for each gene set. The third column is the gene set statistics, and the fourth column shows the number of genes within each gene set. The p-values and q-values are not seperately reported for up-regulation in different conditions. This is because the absolute mean statistics results in a two-sided test, hence GSALight() only report the two-sided p-value and q-value, and do not distinguished between the direction of the expression changes.

### 4.5 Default Number of Permutations

In the previous function call, the number of permutations was set at 1000. In practice this is not enough for producing accurate p-values. By leaving the number of permutation unspecified, GSALight will automatically set the number of permutations to:

(number of gene sets)/0.05 \(\times\) 2

This number of permutations will suffice for accurate p-values estimation, when the significance level is set at 0.05, even after Bonferroni correction.

We now run GSALight() using the default number of permutations. Here, we set “nperm” to NULL (alternatively, we may remove the “nperm” argument). In this case GSALight() will calculate the number of permutations using the formula above. Also to minimize outputs, we set “verbose” to FALSE to suppress outputs from GSALight().

*Caution: the following will take some time to run.*

```
GSALightResults <- GSALight(eset = expression, fac = factor(sampleInfo$TN), gs = targetGenes,
                           nperm = NULL, method = 'maxmean', restandardize = FALSE, minsize = 10,
                           rmGSGenes = 'gene', verbose = FALSE)
```

```
## Number of permutations is not specified. Automatically set to 28280.
```

Note that the number of permutation is automatically set to 194,760 here, which is 4869/0.05 \(\times\) 2, where 4869 are the number of gene sets with 7 genes or more included in the analysis.

### 4.6 Restandardization

We now investigate the p-values distribution from the results of the pervious call:

```
hist(GSALightResults[,'p-value:up-regulated in Control'], main=NULL, xlab='p-value')
```

![](data:image/png;base64...)

From the histogram of the p-values, we observe that many gene sets have very small p-values. Assuming that most gene sets should be insignificant, the p-values are expected to be more uniformly distributed. (Efron 2007) has discussed this problem, and suggested restandardization as a remedial method.

GSALight() can perform the restandardization method of (Efron 2007) by setting the argument “restandardization” to “TRUE”. We now run GSALight() with restandardization, and investigate the p-values distribution:

```
GSALightResultsReStand <- GSALight(eset = expression, fac = factor(sampleInfo$TN), gs = targetGenes,
                           nperm = NULL, method = 'maxmean', restandardize = TRUE, minsize = 10,
                           rmGSGenes = 'gene', verbose = FALSE)
```

```
## Number of permutations is not specified. Automatically set to 28280.
```

```
hist(GSALightResultsReStand[,'p-value:up-regulated in Control'], main=NULL, xlab='p-value')
```

![](data:image/png;base64...)

Notice that the p-values are now more uniformly distributed compared to the previous non-restandardized results.

Let’s find the top ten most significantly up-regulated gene sets in the control group according to the p-values:

```
GSALightResultsReStand[order(GSALightResultsReStand[,'p-value:up-regulated in Control'],decreasing=F)[1:10], c(2,4)]
```

```
##        p-value:up-regulated in Control q-value:up-regulated in Control
## 815216                     0.004349364                       0.8518229
## 821284                     0.005622348                       0.8518229
## 863174                     0.006117397                       0.8518229
## 810251                     0.011881188                       0.8518229
## 810252                     0.014144272                       0.8518229
## 816967                     0.014674682                       0.8518229
## 740716                     0.015594059                       0.8518229
## 820559                     0.016018388                       0.8518229
## 942977                     0.016690240                       0.8518229
## 817956                     0.019059406                       0.8518229
```

The name of the gene sets are represented by the row names. With 4869 gene sets being analyzed, the Bonferroni-adjusted p-value threshold is approximately 0.00001. Since the smallest p-value is 0.00198, no gene set can be deemed significant. The q-values provide a threshold for controlling false discovery rate. q-value = 0.1 is one commonly used threshold. However, the smallest q-value is 0.836, and therefore no gene set can be deemed significant according to the q-value neither.

## 5. Other Functions in GSALightning

### 5.1 Single Gene Permutation Test

A fast implementation of single-gene permutation test is also included in the GSALightning package, taking advantage of the fast permutation test implementation used in GSALight(). To run single-gene testing, use the permTestLight() function, as follows:

```
singleGeneAnalysis <- permTestLight(eset = expression, fac = factor(sampleInfo$TN),
                                     nperm = 1000,  method = 'mean', verbose = TRUE)
```

```
## Note that permTestLight() simply runs GSALight() by treating each individual gene as a gene set.
```

```
## After gene set size filtering, there are 909 gene sets,
##  containing a total of 909 genes for analysis.
```

```
## Obtaining observed gene set statistics.
```

```
## Permutation done. Evaluating P-values.
```

```
head(singleGeneAnalysis)
```

```
##        p-value:up-regulated in Experiment p-value:up-regulated in Control
## RBFOX1                              0.949                           0.051
## ABCA12                              0.000                           1.000
## ABCA1                               1.000                           0.000
## ABCB11                              1.000                           0.000
## ABI3BP                              1.000                           0.000
## ACOX2                               0.025                           0.975
##        q-value:up-regulated in Experiment q-value:up-regulated in Control
## RBFOX1                              1.000                      0.09969677
## ABCA12                              0.000                      1.00000000
## ABCA1                               1.000                      0.00000000
## ABCB11                              1.000                      0.00000000
## ABI3BP                              1.000                      0.00000000
## ACOX2                               0.101                      1.00000000
##        statistics: up-regulated in Control
## RBFOX1                            3.089081
## ABCA12                           -2.814674
## ABCA1                            19.457356
## ABCB11                            5.857852
## ABI3BP                           19.473927
## ACOX2                            -1.780874
```

As in GSALight(), a default number of permutations can be set by setting “nperm” to NULL.

*Note: The “maxmean” statistics is not defined for single gene testing, and hence is not available for permTestLight.*

### 5.2 Mann-Whitney U Test for Single Gene Testing

In addition to permutation tests, the GSALightning package also offer the Mann-Whitney U test for single-gene testing. Briefly, Mann-Whitney U test is the non-parametric version of the independent t-test for two-sample problem. To perform the Mann-Whitney U test, call the wilcoxTest() function:

```
singleWilcox <- wilcoxTest(eset = expression, fac = factor(sampleInfo$TN),
                                     tests = "unpaired")
head(singleWilcox)
```

```
##        p-value:up-regulated in Control p-value:up-regulated in Experiment
## RBFOX1                    7.134098e-12                       1.000000e+00
## ABCA12                    9.999991e-01                       8.780865e-07
## ABCA1                     4.740034e-29                       1.000000e+00
## ABCB11                    5.547438e-24                       1.000000e+00
## ABI3BP                    2.116375e-45                       1.000000e+00
## ACOX2                     2.756319e-05                       9.999724e-01
##        q-value:up-regulated in Control q-value:up-regulated in Experiment
## RBFOX1                    1.400625e-11                       1.000000e+00
## ABCA12                    1.000000e+00                       7.981806e-06
## ABCA1                     1.527905e-28                       1.000000e+00
## ABCB11                    1.551576e-23                       1.000000e+00
## ABI3BP                    1.414548e-44                       1.000000e+00
## ACOX2                     4.547175e-05                       1.000000e+00
```

### 5.3 Gene Set Analysis for Paired Design

Thus far this guide has only covered independent two-sample tests. In fact, all main functions in GSALightning, i.e. GSALight(), permTestLight(), and wilcoxTest(), also support paired two-sample test.

To illustrate, this example uses GSALight() to perform paired-test. We will set up a set synthetic classes:

```
fac <- 1:(ncol(expression)/2)
fac <- c(fac, -fac)
head(fac)
```

```
## [1] 1 2 3 4 5 6
```

```
tail(fac)
```

```
## [1] -604 -605 -606 -607 -608 -609
```

Notice how the classes are defined for paired-tests: the classes vector must be an integer vector of 1,-1,2,-2,3,-3,…, where each number represents a pair, and the sign represents the conditions.

To use GSALight() to perform paired-test, set the “tests” argument to ‘paired’:

```
GSALightResultsPaired <- GSALight(eset = expression, fac = fac, gs = targetGenes,
                           nperm = 1000, tests = 'paired', method = 'maxmean', restandardize = TRUE, minsize = 10,
                           rmGSGenes = 'gene', verbose = FALSE)
head(GSALightResultsPaired)
```

```
##        p-value:up-regulated in positives p-value:up-regulated in negatives
## 110168                             0.416                             0.584
## 171518                             0.479                             0.521
## 171519                             0.548                             0.452
## 171520                             0.268                             0.732
## 171521                             0.458                             0.542
## 192692                             0.027                             0.973
##        q-value:up-regulated in positives q-value:up-regulated in negatives
## 110168                         0.9316822                         0.9525895
## 171518                         0.9316822                         0.9525895
## 171519                         0.9316822                         0.9525895
## 171520                         0.9316822                         0.9525895
## 171521                         0.9316822                         0.9525895
## 192692                         0.9316822                         0.9813281
##        statistics (up-regulated in positives) # genes
## 110168                             0.06236347      13
## 171518                             0.02467642      12
## 171519                            -0.03222792      11
## 171520                             0.20010013      12
## 171521                             0.04848599      11
## 192692                             0.84612248      13
```

The result is a matrix with six columns. Each row represents the results for a gene set. As the column names suggest, the first two columns are the p-values for testing up-regulation in the two different subjects classes. Here, “positives” denotes the class labeled with a positive integer, and “negatives” denotes the class labeled with a negative integer. The next two columns are the q-values (that control for false discovery rate) for testing up-regulation in the two different classes. The fifth column is the gene set statistics, and the final column shows the number of genes within each gene set.

## References

BHW Chang and W Tian (2015). GSA-Lightning: Ultra Fast Permutation-based Gene Set Analysis. Bioinformatics. doi: 10.1093/bioinformatics/btw349.

B Efron and RJ Tibshirani (2007). “On testing the significance of sets of genes.” The annals of applied statistics 1(1):107-129.

The Cancer Genome Atlas (2012) Comprehensive molecular characterization of human colon and rectal cancer. Nature 487:330-337.

Weinstein, John N., et al. “The cancer genome atlas pan-cancer analysis project.” Nature genetics 45.10 (2013): 1113-1120.

L Yao et. al. (2015) Inferring regulatory element landscapes and transcription factor networks from cancer methylomes. Genome Biology 16:105

Lu, Yulan, Yuanpeng Zhou, and Weidong Tian. “Combining Hi-C data with phylogenetic correlation to predict the target genes of distal regulatory elements in human genome.” Nucleic acids research (2013): gkt785.