# **Analyses of high-throughput data from heterogeneous samples with TOAST**

Ziyi Li\* and Hao Wu\*\*

\*zli16@mdanderson.org
\*\*hao.wu@emory.edu

#### 30 October 2025

#### Abstract

This vignette introduces the usage of the R package TOAST (TOols for the Analysis of heterogeneouS Tissues). It is designed for the analyses of high-throughput data from heterogeneous tissues that are mixtures of different cell types. TOAST offers functions for detecting cell-type specific differential expression (csDE) or differential methylation (csDM), as well as improving reference-free deconvolution based on cross-cell type differential analysis. TOAST is based on rigorous staitstical framework, and provides great flexibility and superior computationl performance.

#### Package

TOAST 1.24.0

# Contents

* [1 Introduction](#introduction)
* [2 Installation and quick start](#installation-and-quick-start)
  + [2.1 Install TOAST](#install-toast)
  + [2.2 How to get help for TOAST](#how-to-get-help-for-toast)
  + [2.3 Quick start on detecting cell type-specific differential signals](#quick-start-on-detecting-cell-type-specific-differential-signals)
* [3 Example dataset](#example-dataset)
* [4 Estimate mixing proportions](#estimate-mixing-proportions)
  + [4.1 Reference-based deconvolution using least square method](#section:RB)
  + [4.2 Reference-free deconvolution using RefFreeEWAS](#reference-free-deconvolution-using-reffreeewas)
  + [4.3 Improve reference-free deconvolution with cross-cell type differential analysis](#section:ImpRF)
    - [4.3.1 Improved-RF with myRefFreeCellMix](#section:RFimp)
    - [4.3.2 Improved-RF with use-defined RF function](#improved-rf-with-use-defined-rf-function)
  + [4.4 Partial reference-free deconvolution (TOAST/-P and TOAST/+P)](#section:PRF)
    - [4.4.1 Choose cell type-specific markers](#choose-cell-type-specific-markers)
    - [4.4.2 PRF deconvolution without prior (TOAST/-P)](#prf-deconvolution-without-prior-toast-p)
    - [4.4.3 PRF deconvolution with prior (TOAST/+P)](#prf-deconvolution-with-prior-toastp)
  + [4.5 Complete deconvolution using a geometric approach](#section:Tsisal)
* [5 Detect cell type-specific and cross-cell type differential signals](#section:csDE)
  + [5.1 Detect cell type-specific differential signals under two-group comparison](#section:csDEbasic)
    - [5.1.1 Testing one parameter (e.g. disease) in one cell type.](#testing-one-parameter-e.g.-disease-in-one-cell-type.)
    - [5.1.2 Testing one parameter in all cell types.](#testing-one-parameter-in-all-cell-types.)
    - [5.1.3 Testing one parameter in all cell types by incorporating DE/DM state correlation among cell types](#testing-one-parameter-in-all-cell-types-by-incorporating-dedm-state-correlation-among-cell-types)
  + [5.2 Detect cell type-specific differential signals from a general experimental design](#detect-cell-type-specific-differential-signals-from-a-general-experimental-design)
    - [5.2.1 Testing one parameter in one cell type](#testing-one-parameter-in-one-cell-type)
    - [5.2.2 Testing the joint effect of single parameter in all cell types.](#testing-the-joint-effect-of-single-parameter-in-all-cell-types.)
  + [5.3 Detect cross-cell type differential signals](#detect-cross-cell-type-differential-signals)
    - [5.3.1 Testing cross-cell type differential signals in cases (or in controls).](#testing-cross-cell-type-differential-signals-in-cases-or-in-controls.)
    - [5.3.2 Testing the overall cross-cell type differences in all samples.](#testing-the-overall-cross-cell-type-differences-in-all-samples.)
    - [5.3.3 Testing the differences of two cell types over different values of one phenotype (higher-order test).](#testing-the-differences-of-two-cell-types-over-different-values-of-one-phenotype-higher-order-test.)
  + [5.4 A few words about variance bound and Type I error.](#a-few-words-about-variance-bound-and-type-i-error.)
    - [5.4.1 Variance bound](#variance-bound)
    - [5.4.2 Type I error](#type-i-error)
* [Session info](#session-info)

# 1 Introduction

High-throughput technologies have revolutionized
the genomics research. The early
applications of the technologies were largely on
cell lines. However, there is an increasing number
of larger-scale, population level clinical studies
in recent years, hoping to identify diagnostic
biomarkers and therapeutic targets. The samples
collected in these studies, such as blood, tumor,
or brain tissue, are mixtures of a number of different
cell types. The sample mixing complicates data analysis
because the experimental data from the high-throughput
experiments are weighted averages of signals from multiple
cell types. For these data, traditional analysis methods that ignores
the cell mixture
will lead to results with low resolution, biased, or
even errorneous results.
For example, it has been discovered that in epigenome-wide
association studies (EWAS), the mixing proportions
can be confounded with the experimental factor of
interest (such as age). Ignoring the cell mixing
will lead to false positives.
On the other hand, cell type specific changes
under different conditions could be associated
with disease pathogenesis and progressions, which are of
great interests to researchers.

For heterogeneous samples, it is possible to profile the
pure cell types through experimental techniques.
They are, however, laborious and expensive that cannot
be applied to large scale studies.
Computational tools for analzying the mixed data have been developed
for proportion estimation and cell type
specific signal detection.

There are two fundamental questions in this type of analyses:

1. How to estimate mixing proportions?

There are a number of existing methods
devoted to solve this question. These methods mainly can be categorized
to two groups: **reference-based** (require
pure cell type profiles) and **reference-free**
(does not require pure cell type profiles).
It has been found that reference-based
deconvolution is more accurate and reliable
than reference-free deconvolution.
However, the reference panels required
for reference-based deconvolution can be
difficult to obtain, thus reference-free method has wider application.

2. with available mixing proportions,
   how to detect cell-type specific DE/DM?

TOAST is a package designed to answer these
questions and serve the research communities
with tools for the analysis of heterogenuous
tissues. Currently TOAST provides functions
to detect cell-type specific DE/DM, as well
as differences across different cell types.
TOAST also has functions to improve the
accuracy of reference-free deconvolutions through better feature selection.
If cell type-specific markers (or prior knowledge of cell compositions)
are available, TOAST provides partial reference-free
deconvolution function, which is more accuracte than RF methods
and works well even for very small sample size (e.g.<10).

# 2 Installation and quick start

## 2.1 Install TOAST

To install this package, start R (version “3.6”) and enter:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("TOAST")
```

## 2.2 How to get help for TOAST

Any TOAST questions should be posted
to the GitHub Issue section of TOAST
homepage at <https://github.com/ziyili20/TOAST/issues>.

## 2.3 Quick start on detecting cell type-specific differential signals

Here we show the key steps for a cell
type-specific different analysis. This
code chunk assumes you have an expression
or DNA methylation matrix called `Y_raw`,
a data frame of sample information called
`design`, and a table of cellular composition
(i.e. mixing proportions)
called `prop`. Instead of a data matrix,
`Y_raw` could also be a `SummarizedExperiment` object.
If the cellular composition
is not available, the following sections
will discuss about how to obtain mixing
proportions using reference-free deconvolution
or reference-based deconvolution.

```
Design_out <- makeDesign(design, Prop)
fitted_model <- fitModel(Design_out, Y_raw)
fitted_model$all_coefs # list all phenotype names
fitted_model$all_cell_types # list all cell type names
# coef should be one of above listed phenotypes
# cell_type should be one of above listed cell types
res_table <- csTest(fitted_model, coef = "age",
                    cell_type = "Neuron", contrast_matrix = NULL)
head(res_table)
```

# 3 Example dataset

TOAST provides two sample dataset.

The first example dataset is 450K
DNA methylation data. We obtain and process
this dataset based
on the raw data provided by GSE42861. This
is a DNA methylation 450K data for Rheumatoid
Arthiritis patients and controls.
The original dataset has 485577 features
and 689 samples. We have reduced the dataset
to 3000 CpGs for randomly selected 50 RA patients
and 50 controls.

```
library(TOAST)
```

```
## Loading required package: EpiDISH
```

```
## Loading required package: limma
```

```
## Loading required package: nnls
```

```
## Loading required package: quadprog
```

```
data("RA_100samples")
Y_raw <- RA_100samples$Y_raw
Pheno <- RA_100samples$Pheno
Blood_ref <- RA_100samples$Blood_ref
```

Check matrix including beta values for
3000 CpG by 100 samples.

```
dim(Y_raw)
```

```
## [1] 3000  100
```

```
Y_raw[1:4,1:4]
```

```
##            GSM1051525 GSM1051526 GSM1051527  GSM1051528
## cg14521995  0.8848926  0.8654487  0.8172092 0.004429362
## cg11738485  0.9306579  0.9189274  0.5486962 0.039545301
## cg06193597  0.1388632  0.7127654  0.6925506 0.677185017
## cg14323910  0.8282483  0.8528023  0.8449638 0.828873689
```

Check phenotype of these 100 samples.

```
dim(Pheno)
```

```
## [1] 100   3
```

```
head(Pheno, 3)
```

```
##            age gender disease
## GSM1051525  67      2       1
## GSM1051526  49      2       1
## GSM1051527  53      2       1
```

Our example dataset also contain blood
reference matrix for the matched 3000
CpGs (obtained from bioconductor
package *[FlowSorted.Blood.450k](https://bioconductor.org/packages/3.22/FlowSorted.Blood.450k)*.

```
dim(Blood_ref)
```

```
## [1] 3000    6
```

```
head(Blood_ref, 3)
```

```
##                 CD8T      CD4T        NK     Bcell      Mono      Gran
## cg14521995 0.9321049 0.9245206 0.9184654 0.9178081 0.8902820 0.9314544
## cg11738485 0.3745548 0.2916655 0.3144788 0.2985633 0.3027369 0.2911957
## cg06193597 0.4157621 0.4292540 0.4104737 0.4335429 0.4789953 0.4747334
```

The second example dataset is microarray gene
expression data. We obtain and process
this dataset based
on the raw data provided by GSE65133. This
microarary data is from 20 PBMC samples.
The original dataset has 47323 probes. We mapped
the probes into 21626 genes and then further
reduced the dataset to 511 genes by
selecting the genes that have matches
in reference panel.

```
data("CBS_PBMC_array")
CBS_mix <- CBS_PBMC_array$mixed_all
LM_5 <- CBS_PBMC_array$LM_5
CBS_trueProp <- CBS_PBMC_array$trueProp
prior_alpha <- CBS_PBMC_array$prior_alpha
prior_sigma <- CBS_PBMC_array$prior_sigma
```

Check the PBMC microarray gene expression
data and true proportions

```
dim(CBS_mix)
```

```
## [1] 511  20
```

```
CBS_mix[1:4,1:4]
```

```
##       X17.002 X17.006 X17.019 X17.023
## ABCB4    96.0  107.50  110.00    92.3
## ABCB9    98.3  109.75  103.85    92.1
## ACAP1   196.8  217.80  351.00   140.7
## ACHE     92.7   97.20   87.10    87.1
```

```
head(CBS_trueProp, 3)
```

```
##            Bcells      CD8T      CD4T    NKcells      Monos
## 17-002 0.16201354 0.2364636 0.2453469 0.17533841 0.18083756
## 17-006 0.05279853 0.3279443 0.4698660 0.09106723 0.05832395
## 17-019 0.21897143 0.2041143 0.1468571 0.33874286 0.09131429
```

Check reference matrix for 5 immune cell types

```
head(LM_5, 3)
```

```
##          BCells       CD8T        CD4T   NK cells  Monocytes
## ABCB4 283.22884    4.31128    6.685426   9.119776   6.202496
## ABCB9  18.84917   24.22372   34.725041  19.129933  20.309426
## ACAP1 268.46349 1055.61338 1017.711114 450.109326 190.879024
```

Check prior knowledge for the 5 cell types

```
prior_alpha
```

```
## [1] 0.09475324 0.23471057 0.33231687 0.09689958 0.24131974
```

```
prior_sigma
```

```
## [1] 0.0996325 0.1441782 0.1602440 0.1006351 0.1455614
```

The third example dataset is a list containing two matrices, one of
which is methylation 450K array data of 3000 CpG sites on 50 samples, the other is
methylation 450K array data of 3000 matched CpG sites on three immune cell types.
The first dataset is generated by simulation. It originally has 459226 features and 50 samples.We reduce it to 3000 CpGs by random selection.

```
data("beta_emp")
Ybeta = beta_emp$Y.raw
ref_m = beta_emp$ref.m
```

Check matrix including beta values for
3000 CpG by 50 samples.

```
dim(Ybeta)
```

```
## [1] 3000   50
```

```
Ybeta[1:4,1:4]
```

```
##                  [,1]       [,2]       [,3]       [,4]
## cg08752431 0.76611838 0.76117075 0.79835014 0.79239766
## cg14555682 0.09677872 0.08096398 0.11906131 0.10553938
## cg23086843 0.88824253 0.88740138 0.92060008 0.92240033
## cg20308511 0.02863965 0.03976921 0.04269377 0.02678175
```

Check reference matrix for 3000 CpGs by three immune cell types

```
head(ref_m, 3)
```

```
##                  CD4T      CD8T     BCell
## cg08752431 0.77118808 0.7546620 0.7589832
## cg14555682 0.09960192 0.1201291 0.1006569
## cg23086843 0.90647715 0.8810441 0.9065662
```

# 4 Estimate mixing proportions

If you have mixing proportions available,
you can directly go to Section [5](#section:csDE).

In many situations, mixing proportions
are not readily available. There are a number of deconvolution methods
available to solve this problem. To name a few:

* For DNA methylation: The R package RefFreeEWAS
  (Houseman et al. 2016) is reference-free,
* For gene expression: qprog (Gong et al. 2011),
  deconf (Repsilber et al. 2010),
  lsfit (Abbas et al. 2009)
  and *[DSA](https://CRAN.R-project.org/package%3DDSA)* (Zhong et al. 2013).

In addition, [CellMix](https://github.com/rforge/cellmix)
package has summarized a number of deconvolution
methods and is a good resource to look up.

Here we demonstrate two ways to estimate
mixing proportions, one using
RefFreeEWAS (Houseman et al. 2016), representing the
class of reference-free methods, and the other
using *[EpiDISH](https://bioconductor.org/packages/3.22/EpiDISH)* (Teschendorff et al. 2017) as a
representation of reference-based methods.

We also provide function to improve reference-free
deconvolution performance in Section [4.3](#section:ImpRF), which
works for both gene expression data and DNA methylation data.
The example in Section [4.3](#section:ImpRF) demonstrates
the usage of this. Note that we have only
3000 features in the Y\_raw from RA\_100samples dataset,
thus the proportion estimation
is not very accurate. Real 450K dataset should
have around 485,000 features. More features generally
lead to better estimation, because there
are more information in the data.

In Secion [4.4](#section:PRF), we demonstrate the usage of partial
reference-free (PRF) deconvolution. Compared to RB methods,
PRF does not require reference panel thus can be more
wdiely applied. Compared to RF methods, PRF uses additional
biological information, which improves the estimation accuracy
and automatically assign cell type labels.

## 4.1 Reference-based deconvolution using least square method

1. Select the top 1000 most variant
   features by `findRefinx()`.
   To select the top features with
   largest coefficients of variations,
   one can use `findRefinx(..., sortBy = "cv")`.
   Default `sortBy` argument is `"var"`. Here, instead of
   a data matrix, `Y_raw` could
   also be a `SummarizedExperiment` object.

```
refinx <- findRefinx(Y_raw, nmarker = 1000)
```

2. Subset data and reference panel.

```
Y <- Y_raw[refinx,]
Ref <- as.matrix(Blood_ref[refinx,])
```

3. Use EpiDISH to solve cellular
   proportions and use post-hoc constraint.

```
library(EpiDISH)
outT <- epidish(beta.m = Y, ref.m = Ref, method = "RPC")
estProp_RB <- outT$estF
```

***A word about Step 1***

For step 1, one can also use `findRefinx(..., sortBy = "cv")`
to select features based on coefficient of variantion.
The choice of `sortby = "cv"` and `sortBy = "var"`
depends on whether the feature variances of your data
correlates with the means.
For RNA-seq counts, the variance-mean correlation is strong,
thus `sortBy = "cv"` is recommended.
For log-counts, the variance-mean correlation
largely disappears, so both `sortBy = "cv"` and `sortBy = "var"`
would work similarly. In DNA methylation data, this correlation is not
strong, either `sortBy = "cv"` or `sortBy = "var"`
can be used. In this case, we recommend `sortBy = "var"` because we find it
has better feature selection for DNA methylation
data than `sortBy = "cv"` (unpublished results).

```
refinx = findRefinx(Y_raw, nmarker=1000, sortBy = "var")
```

## 4.2 Reference-free deconvolution using RefFreeEWAS

1. Similar to Reference-based deconvolution
   we also select the top 1000 most variant
   features by `findRefinx()`. And then subset data.

```
refinx <- findRefinx(Y_raw, nmarker = 1000)
Y <- Y_raw[refinx,]
```

2. Do reference-free deconvolution on the RA dataset.

```
K <- 6
outT <- myRefFreeCellMix(Y, mu0=myRefFreeCellMixInitialize(Y, K = K))
estProp_RF <- outT$Omega
```

4. Comparing the reference-free method versus
   reference-base method

```
# first we align the cell types from RF
# and RB estimations using pearson's correlation
estProp_RF <- assignCellType(input=estProp_RF,
                             reference=estProp_RB)
mean(diag(cor(estProp_RF, estProp_RB)))
```

```
## [1] 0.1967946
```

## 4.3 Improve reference-free deconvolution with cross-cell type differential analysis

Feature selection is an important step
before RF deconvolution and is directly
related with the estimation quality of
cell composition. `findRefinx()` and
`findRefinx(..., sortBy = "var")` simply select the markers
with largest CV or largest variance,
which may not always result in a good
selection of markers. Here, we propose
to improve RF deconvolution marker
selection through cross-cell type
differential analysis. We implement
two versions of such improvement,
one is for DNA methylation microarray
data using `myRefFreeCellMix` originally from R package [RefFreeEWAS](https://cran.r-project.org/web/packages/RefFreeEWAS/index.html),
the other one is for gene
expression microarray data using `deconf`
from [CellMix](https://github.com/rforge/cellmix) package.
To implement this, [CellMix](https://github.com/rforge/cellmix)
need to be installed first.

### 4.3.1 Improved-RF with myRefFreeCellMix

1. Load TOAST package.

```
library(TOAST)
```

2. Do reference-free deconvolution using
   improved-RF implemented with RefFreeCellMix.
   The default deconvolution function implemented
   in `csDeconv()` is `RefFreeCellMix_wrapper()`.
   Here, instead of
   a data matrix, `Y_raw` could
   also be a `SummarizedExperiment` object.

```
K=6
set.seed(1234)
outRF1 <- csDeconv(Y_raw, K, TotalIter = 30, bound_negative = TRUE)
```

3. Comparing udpated RF estimations versus RB results.

```
## check the accuracy of deconvolution
estProp_RF_improved <- assignCellType(input=outRF1$estProp,
                                      reference=estProp_RB)
mean(diag(cor(estProp_RF_improved, estProp_RB)))
```

```
## [1] 0.2254084
```

*****A word about Step 2*****

For step 2, initial features (instead of automatic
selection by largest variation) can be provided to
function `RefFreeCellMixT()`. For example

```
refinx <- findRefinx(Y_raw, nmarker = 1000, sortBy = "cv")
InitNames <- rownames(Y_raw)[refinx]
csDeconv(Y_raw, K = 6, nMarker = 1000,
         InitMarker = InitNames, TotalIter = 30)
```

*****A word about bounding the negative estimators*****

Since all the parameters represent the mean observation levels for
each cell type, it may not be reasonable to have negative estimators.
As such, we provide options to bound negative estimated parameters to zero
through the `bound_negative` argument in `csDeconv()` function. Although
we find bounding negative estimators has minimum impact on the performance,
the users could choose to bound or not bound the negative values in the function.
The default value for `bound_negative` is FALSE.

### 4.3.2 Improved-RF with use-defined RF function

In order to use other RF functions, users can
wrap the RF function a bit first to make it
accept Y (raw data) and K (number of cell types)
as input, and return a N (number of cell types)
by K proportion matrix. We take `myRefFreeCellMix()`
as an example. Other deconvolution methods can be
used similarly.

```
mydeconv <- function(Y, K){
     if (is(Y, "SummarizedExperiment")) {
          se <- Y
          Y <- assays(se)$counts
     } else if (!is(Y, "matrix")) {
          stop("Y should be a matrix
               or a SummarizedExperiment object!")
     }

     if (K<0 | K>ncol(Y)) {
         stop("K should be between 0 and N (samples)!")
     }
     outY = myRefFreeCellMix(Y,
               mu0=myRefFreeCellMixInitialize(Y,
               K = K))
     Prop0 = outY$Omega
     return(Prop0)
}
set.seed(1234)
outT <- csDeconv(Y_raw, K, FUN = mydeconv, bound_negative = TRUE)
```

## 4.4 Partial reference-free deconvolution (TOAST/-P and TOAST/+P)

Similar to DSA, our PRF method requires
the knowledge of **cell type-specific markers**.
Such markers can be selected from pure
cell type gene expression
profiles from same or different platforms (through
function `ChooseMarker()`). They can also
be manually specified
(see function manual `?MDeconv` for more explanation).
The **prior knowledge of cell compositions**
are optional, but
highly recommended. We find prior
knowledge of cell compositions (`alpha` and `sigma`)
help calibrate the scales of the estimations,
and reduce estimation bias. Such information
can be estimated from previous cell sorting
experiments or single cell study.
We currently provide prior knowledge for five
tissue types: “human pbmc”,“human
liver”, “human brain”, “human pancreas”, “human skin”,
which can be directly specified in `MDeconv()` function.

### 4.4.1 Choose cell type-specific markers

We provide functions to choose cell type-specific markers
from pure cell type profiles or single cell RNA-seq data.
Here we demonstrate how to select markers from
PBMC pure cell type gene expression profile.

```
## create cell type list:
CellType <- list(Bcells = 1,
                 CD8T = 2,
                 CD4T = 3,
                 NK = 4,
                 Monocytes = 5)
## choose (up to 20) significant markers
## per cell type
myMarker <- ChooseMarker(LM_5,
                         CellType,
                         nMarkCT = 20,
                         chooseSig = TRUE,
                         verbose = FALSE)
lapply(myMarker, head, 3)
```

```
## $Bcells
## [1] "BANK1"  "MS4A1"  "IGLL3P"
##
## $CD8T
## [1] "CD8B" "CD8A" "GZMK"
##
## $CD4T
## [1] "IL9"   "CTLA4" "IL3"
##
## $NK
## [1] "KIR3DL2" "IL18RAP" "KLRF1"
##
## $Monocytes
## [1] "FCN1"   "P2RY13" "NCF2"
```

### 4.4.2 PRF deconvolution without prior (TOAST/-P)

```
resCBS0 <- MDeconv(CBS_mix, myMarker,
                epsilon = 1e-3, verbose = FALSE)
```

```
## Deconvolution without prior information.
```

```
diag(cor(CBS_trueProp, t(resCBS0$H)))
```

```
## [1] 0.5333925 0.5647335 0.7027891 0.6484607 0.7116513
```

```
mean(abs(as.matrix(CBS_trueProp) - t(resCBS0$H)))
```

```
## [1] 0.1313198
```

### 4.4.3 PRF deconvolution with prior (TOAST/+P)

We allow manually input the prior knowledge of all cell types,
or select from currently supported tissues (“human pbmc”,“human
liver”, “human brain”, “human pancreas”, “human skin”). Note
that order of cell types in prior knowledge here should
match the order in marker list.

Here is an example of manually specifying alpha and sigma:

```
prior_alpha <- c(0.09475, 0.23471, 0.33232, 0.0969, 0.24132)
prior_sigma <- c(0.09963, 0.14418, 0.16024, 0.10064, 0.14556)
names(prior_alpha) <- c("B cells", "CD8T", "CD4T",
                        "NK cells", "Monocytes")
names(prior_sigma) <- names(prior_alpha)
```

Here is to see alpha and sigma for supported tisuses using
`GetPrior()`:

```
thisprior <- GetPrior("human pbmc")
thisprior
```

```
## $alpha_prior
##   B cells      CD8T      CD4T  NK cells Monocytes
##   0.09475   0.23471   0.33232   0.09690   0.24132
##
## $sigma_prior
##   B cells      CD8T      CD4T  NK cells Monocytes
##   0.09963   0.14418   0.16024   0.10064   0.14556
```

Deconvolution using manually input alpha and sigma:

```
resCBS1 <- MDeconv(CBS_mix, myMarker,
                alpha = prior_alpha,
                sigma = prior_sigma,
                epsilon = 1e-3, verbose = FALSE)
```

```
## Deconvolution with prior infromation.
```

```
diag(cor(CBS_trueProp, t(resCBS1$H)))
```

```
## [1] 0.5545308 0.5627714 0.6302584 0.6841369 0.7101932
```

```
mean(abs(as.matrix(CBS_trueProp) - t(resCBS1$H)))
```

```
## [1] 0.079472
```

For supported tissues, you can directly specify tissue type
as alpha input:

```
resCBS2 <- MDeconv(CBS_mix, myMarker,
                   alpha = "human pbmc",
                   epsilon = 1e-3, verbose = FALSE)
```

```
## Deconvolution with prior infromation.
```

```
diag(cor(CBS_trueProp, t(resCBS2$H)))
```

```
## [1] 0.5545308 0.5627714 0.6302584 0.6841369 0.7101932
```

```
mean(abs(as.matrix(CBS_trueProp) - t(resCBS2$H)))
```

```
## [1] 0.079472
```

## 4.5 Complete deconvolution using a geometric approach

Tsisal is a complete deconvolution method
which estimates cell compositions from DNA methylation data without
prior knowledge of cell types and their proportions.
Tsisal is a full pipeline to estimate number of cell types,
cell compositions, find cell-type-specific CpG sites,
and assign cell type labels when (full or part of) reference panel is available.

Here is an example of manually specifying K and reference panel:

```
out = Tsisal(Ybeta,K = 4, knowRef = ref_m)
out$estProp[1:3,1:4]
head(out$selMarker)
```

Here is an example where both K and reference panel are unknown:

```
out = Tsisal(Ybeta,K = NULL, knowRef = NULL, possibleCellNumber = 2:5)
out$estProp[1:3,1:out$K]
head(out$selMarker)
out$K
```

Here is an example where K is unknown and reference panel is known:

```
out = Tsisal(Ybeta, K = NULL, knowRef = ref_m, possibleCellNumber = 2:5)
out$estProp[1:3,1:out$K]
head(out$selMarker)
out$K
```

# 5 Detect cell type-specific and cross-cell type differential signals

The csDE/csDM detection function requires
a table of microarray or RNA-seq measurements
from all samples, a table of mixing proportions,
and a design vector representing the status of
subjects.

We demonstrate the usage of TOAST in three common settings.

## 5.1 Detect cell type-specific differential signals under two-group comparison

1. Assuming you have TOAST library and dataset loaded,
   the first step is to generate the study design based on the
   phenotype matrix. Note that all the binary
   (e.g. disease = 0, 1) or categorical
   variable (e.g. gender = 1, 2) should be transformed
   to factor class. Here we use the proportions
   estimated from step [4.3.1](#section:RFimp) as
   input proportion.

```
head(Pheno, 3)
```

```
##            age gender disease
## GSM1051525  67      2       1
## GSM1051526  49      2       1
## GSM1051527  53      2       1
```

```
design <- data.frame(disease = as.factor(Pheno$disease))

Prop <- estProp_RF_improved
colnames(Prop) <- colnames(Ref)
## columns of proportion matrix should have names
```

2. Make model design using the design (phenotype)
   data frame and proportion matrix.

```
Design_out <- makeDesign(design, Prop)
```

3. Fit linear models for raw data and the
   design generated from `Design_out()`. `Y_raw`
   here is a data matrix with dimension P (features)
   by N (samples). Instead of
   a data matrix, `Y_raw` could
   also be a `SummarizedExperiment` object.

```
fitted_model <- fitModel(Design_out, Y_raw)
# print all the cell type names
fitted_model$all_cell_types
```

```
## [1] "CD8T"  "CD4T"  "NK"    "Bcell" "Mono"  "Gran"
```

```
# print all phenotypes
fitted_model$all_coefs
```

```
## [1] "disease"
```

TOAST allows a number of hypotheses to be
tested using `csTest()` in two group setting.

### 5.1.1 Testing one parameter (e.g. disease) in one cell type.

For example, testing disease (patient versus controls)
effect in Gran.

```
res_table <- csTest(fitted_model,
                    coef = "disease",
                    cell_type = "Gran")
```

```
## Test the effect of disease in Gran.
```

```
head(res_table, 3)
```

```
##                  beta   beta_var         mu effect_size f_statistics
## cg03999583 -0.9336162 0.03923521  1.2339749   -1.216966     22.21573
## cg04021544 -0.6798894 0.02899288  0.8520754   -1.327570     15.94356
## cg07755735  0.7132178 0.03332731 -0.1296480    3.142470     15.26315
##                 p_value        fdr
## cg03999583 9.065204e-06 0.02719561
## cg04021544 1.349669e-04 0.15106724
## cg07755735 1.831638e-04 0.15106724
```

```
Disease_Gran_res <- res_table
```

### 5.1.2 Testing one parameter in all cell types.

For example, testing the joint effect of age in all cell types:

```
res_table <- csTest(fitted_model,
                    coef = "disease",
                    cell_type = "joint")
head(res_table, 3)
```

Specifying cell\_type as NULL or not specifying
cell\_type will test the effect in each cell type
and the joint effect in all cell types.

```
res_table <- csTest(fitted_model,
                    coef = "disease",
                    cell_type = NULL)
lapply(res_table, head, 3)

## this is exactly the same as
res_table <- csTest(fitted_model, coef = "disease")
```

### 5.1.3 Testing one parameter in all cell types by incorporating DE/DM state correlation among cell types

Some cell types may show DE/DM state correlation. We can check the existence of such correlation by
plotting the -log10 transformed p-value from TOAST result.

```
res_table <- csTest(fitted_model, coef = "disease",verbose = F)
pval.all <- matrix(NA, ncol= 6, nrow= nrow(Y_raw))
feature.name <- rownames(Y_raw)
rownames(pval.all) = feature.name
colnames(pval.all) = names(res_table)[1:6]
for(cell.ix in 1:6){
  pval.all[,cell.ix] <- res_table[[cell.ix]][feature.name,'p_value']
}
plotCorr(pval = pval.all, pval.thres = 0.05)
```

```
## Detect input of pval.thres; Use pval.thres to calculate odds ratio.
```

```
## -log10(pval) threshold for each cell type:
##  1.303 1.309 1.302 1.302 1.307 1.302
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the TOAST package.
##   Please report the issue at <https://github.com/ziyili20/TOAST/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)
Due to we only randomly included 3,000 features as example, the correlation
between cell types may not represent truth. In above figure, we can see the
Pearson correlation (Corr) between transformed p-values are statistically significant
between CD8T and CD4T, between Bcell and Mono, and between Gran and Mono. In
addition odds ratio (OR) of DM state between cell types confirm the result
(e.g., OR = 2.9 for CD8T and CD4T).

In this way we could incorporate such correlation into csDE/csDM detection to
improve the power, especially in cell types with low abundance.

```
res_cedar <- cedar(Y_raw = Y_raw, prop = Prop, design.1 = design,
                   factor.to.test = 'disease',cutoff.tree = c('pval',0.01),
                   cutoff.prior.prob = c('pval',0.01))
```

```
## No prior inference information, run TOAST for first round inference
```

```
## inference with tree: single
```

```
## inference with tree: full
```

We can have posterior probability of DE for each feature in each cell type:

```
head(res_cedar$tree_res$full$pp)
```

```
##                  CD8T       CD4T         NK      Bcell       Mono       Gran
## cg14521995 0.07516490 0.09639193 0.14745615 0.12552121 0.27625790 0.26488445
## cg11738485 0.03654332 0.05295702 0.03127473 0.03429326 0.06560450 0.03608411
## cg06193597 0.03472336 0.04204641 0.05717360 0.07488522 0.11178107 0.06213274
## cg14323910 0.05329702 0.05791129 0.10387737 0.08355319 0.14677255 0.10429996
## cg24760581 0.03181038 0.03587711 0.03024048 0.02085314 0.03481342 0.04286162
## cg00944631 0.01335784 0.01757725 0.01499369 0.01499007 0.01760662 0.01791435
```

The correlation between cell types was captured by a hierarchical tree estimated
from p-values of TOAST result:

```
res_cedar$tree_res$full$tree_structure
```

```
##                   CD8T CD4T NK Bcell Mono Gran
## 0.667132885929051    1    1  1     1    1    1
## 0.639805109579791    1    1  1     2    2    1
## 0.523830326112511    1    1  2     3    3    2
## 0.497871438887682    1    1  2     3    3    4
## 0.485568645331157    1    2  3     4    4    5
## 0                    1    2  3     4    5    6
```

As can be seen from above result, CD8T and CD4T are clustered together, while
Bcell and Mono are clustered together. Cell types with smaller distance means they
are stronger correlated. Different tree structures could be customized. Another
simpler tree structure is also used for inference:

```
res_cedar$tree_res$single$tree_structure
```

```
##      CD8T CD4T NK Bcell Mono Gran
## [1,]    1    1  1     1    1    1
## [2,]    1    2  3     4    5    6
```

The above tree structure simply assumes that correlation between cell types is
captured by the root node. When sample size is small or technical noise is large,
this tree structure is recommended. In default, the function outputs the results
from both tree structures.

Function cedar() also allows adjusting covariates, using custom similarity calculation
function for tree estimation, and using custom tree structure as input. Please check
the example in cedar() function manual.

## 5.2 Detect cell type-specific differential signals from a general experimental design

1. Assuming you have TOAST library and dataset loaded,
   generate the study design based on the phenotype
   matrix. Note that all the binary variable
   (e.g. disease = 0, 1) or categorical variable
   (e.g. gender = 1, 2) should be transformed
   to factor class.

```
design <- data.frame(age = Pheno$age,
                     gender = as.factor(Pheno$gender),
                     disease = as.factor(Pheno$disease))

Prop <- estProp_RF_improved
colnames(Prop) <- colnames(Ref)
## columns of proportion matrix should have names
```

2. Make model design using the design (phenotype)
   data frame and proportion matrix.

```
Design_out <- makeDesign(design, Prop)
```

3. Fit linear models for raw data and the
   design generated from `Design_out()`.

```
fitted_model <- fitModel(Design_out, Y_raw)
# print all the cell type names
fitted_model$all_cell_types
```

```
## [1] "CD8T"  "CD4T"  "NK"    "Bcell" "Mono"  "Gran"
```

```
# print all phenotypes
fitted_model$all_coefs
```

```
## [1] "age"     "gender"  "disease"
```

TOAST allows a number of hypotheses to be
tested using `csTest()` in two group setting.

### 5.2.1 Testing one parameter in one cell type

For example, testing age effect in Gran.

```
res_table <- csTest(fitted_model,
                    coef = "age",
                    cell_type = "Gran")
```

```
## Test the effect of age in Gran.
```

```
head(res_table, 3)
```

```
##                   beta     beta_var       mu effect_size f_statistics
## cg10785373 -0.03998455 8.795653e-05 2.502370 -0.01610736     18.17675
## cg05364038 -0.03051950 5.682604e-05 2.210576 -0.01390210     16.39108
## cg16611967 -0.02758025 5.284133e-05 1.658134 -0.01677280     14.39536
##                 p_value       fdr
## cg10785373 0.0000572205 0.1716615
## cg05364038 0.0001229534 0.1844301
## cg16611967 0.0002956521 0.2956521
```

We can test disease effect in Bcell.

```
res_table <- csTest(fitted_model,
                    coef = "disease",
                    cell_type = "Bcell")
```

```
## Test the effect of disease in Bcell.
```

```
head(res_table, 3)
```

```
##                  beta   beta_var          mu effect_size f_statistics
## cg07075387 -0.7321689 0.03946395 -0.06071048    1.715505     13.58382
## cg13293535 -0.4776350 0.01825102  0.03636267    2.359218     12.49986
## cg15300101 -0.4525076 0.01625961 -0.13260057    1.260978     11.37536
##                 p_value       fdr
## cg07075387 0.0004255055 0.9330659
## cg13293535 0.0006969280 0.9330659
## cg15300101 0.0011733899 0.9330659
```

Instead of using the names of single coefficient,
you can specify contrast levels, i.e. the comparing
levels in this coefficient. For example, using male
(gender = 1) as reference, testing female (gender = 2)
effect in CD4T:

```
res_table <- csTest(fitted_model,
                    coef = c("gender", 2, 1),
                    cell_type = "CD4T")
```

```
## Test the effect of gender level 2 vs. level 1 in CD4T.
```

```
head(res_table, 3)
```

```
##            f_statistics      p_value       fdr
## cg17959722     15.41598 0.0001881780 0.4919237
## cg15473904     14.16328 0.0003279492 0.4919237
## cg09651654     12.39320 0.0007319324 0.7319324
```

### 5.2.2 Testing the joint effect of single parameter in all cell types.

For example, testing the joint effect of age in all cell types:

```
res_table <- csTest(fitted_model,
                    coef = "age",
                    cell_type = "joint")
head(res_table, 3)
```

Specifying cell\_type as NULL or not specifying
cell\_type will test the effect in each cell type
and the joint effect in all cell types.

```
res_table <- csTest(fitted_model,
                    coef = "age",
                    cell_type = NULL)
lapply(res_table, head, 3)

## this is exactly the same as
res_table <- csTest(fitted_model,
                    coef = "age")
```

## 5.3 Detect cross-cell type differential signals

1. Assuming you have TOAST library and dataset loaded,
   first step is to generate the study design based on the
   phenotype matrix. We allow general design
   matrix such as the following:

```
design <- data.frame(age = Pheno$age,
                     gender = as.factor(Pheno$gender),
                     disease = as.factor(Pheno$disease))

Prop <- estProp_RF_improved
colnames(Prop) <- colnames(Ref)  ## columns of proportion matrix should have names
```

Note that if all subjects belong to one group,
we also allow detecting cross-cell type differences.
In this case, the design matrix can be specified as:

```
design <- data.frame(disease = as.factor(rep(0,100)))
```

2. Make model design using the design (phenotype)
   data frame and proportion matrix.

```
Design_out <- makeDesign(design, Prop)
```

3. Fit linear models for raw data and the
   design generated from `Design_out()`.

```
fitted_model <- fitModel(Design_out, Y_raw)
# print all the cell type names
fitted_model$all_cell_types
```

```
## [1] "CD8T"  "CD4T"  "NK"    "Bcell" "Mono"  "Gran"
```

```
# print all phenotypes
fitted_model$all_coefs
```

```
## [1] "age"     "gender"  "disease"
```

For cross-cell type differential signal detection,
TOAST also allows multiple ways for testing.
For example

### 5.3.1 Testing cross-cell type differential signals in cases (or in controls).

For example, testing the differences between
CD8T and B cells in case group

```
test <- csTest(fitted_model,
               coef = c("disease", 1),
               cell_type = c("CD8T", "Bcell"),
               contrast_matrix = NULL)
```

```
## Test the differences of CD8T vs. Bcell in disease:1.
```

```
head(test, 3)
```

```
##            f_statistics      p_value       fdr
## cg22692549     12.81337 0.0006037238 0.5101987
## cg10543947     12.64785 0.0006512032 0.5101987
## cg00079898     12.62378 0.0006584236 0.5101987
```

Or testing the differences between
CD8T and B cells in control group

```
test <- csTest(fitted_model,
               coef = c("disease", 0),
               cell_type = c("CD8T", "Bcell"),
               contrast_matrix = NULL)
```

```
## Test the differences of CD8T vs. Bcell in disease:0.
```

```
head(test, 3)
```

```
##            f_statistics     p_value       fdr
## cg00079898     14.85597 0.000240920 0.6052438
## cg06888460     11.64838 0.001033055 0.6052438
## cg16661522     11.52106 0.001096201 0.6052438
```

### 5.3.2 Testing the overall cross-cell type differences in all samples.

For example, testing the overall differences
between Gran and CD4T in all samples,
regardless of phenotypes.

```
test <- csTest(fitted_model,
               coef = "joint",
               cell_type = c("Gran", "CD4T"),
               contrast_matrix = NULL)
```

```
## Test the joint effect of Gran vs. CD4T.
```

```
head(test, 3)
```

```
##            f_statistics      p_value       fdr
## cg05364038     17.55640 7.448377e-05 0.1770472
## cg14036627     16.48538 1.180315e-04 0.1770472
## cg10785373     15.37910 1.912542e-04 0.1912542
```

If you do not specify `coef` but only
the two cell types to be compared, TOAST
will test the differences of these
two cell types in each coef parameter
and the overall effect.

```
test <- csTest(fitted_model,
               coef = NULL,
               cell_type = c("Gran", "CD4T"),
               contrast_matrix = NULL)
```

```
## Test the difference of Gran vs. CD4T in different values of age.
```

```
## Test the difference of Gran vs. CD4T in different values of gender.
```

```
## Test the difference of Gran vs. CD4T in different values of disease.
```

```
## Test the joint effect of Gran vs. CD4T.
```

```
lapply(test, head, 3)
```

```
## $age
##            f_statistics      p_value       fdr
## cg14036627     16.73995 0.0001057335 0.1820143
## cg05364038     15.77666 0.0001606611 0.1820143
## cg10785373     15.49181 0.0001820143 0.1820143
##
## $gender
##            f_statistics     p_value       fdr
## cg23622369     10.71461 0.001601029 0.9997172
## cg19801747     10.66346 0.001640256 0.9997172
## cg19962075     10.32512 0.001926138 0.9997172
##
## $disease
##            f_statistics      p_value        fdr
## cg04021544     22.20766 1.083840e-05 0.03251519
## cg12036633     16.95815 9.624687e-05 0.14437031
## cg09982942     12.65167 6.500670e-04 0.41857616
##
## $joint
##            f_statistics      p_value       fdr
## cg05364038     17.55640 7.448377e-05 0.1770472
## cg14036627     16.48538 1.180315e-04 0.1770472
## cg10785373     15.37910 1.912542e-04 0.1912542
```

### 5.3.3 Testing the differences of two cell types over different values of one phenotype (higher-order test).

For example, testing the differences
between Gran and CD4T in disease patients
versus in controls.

```
test <- csTest(fitted_model,
               coef = "disease",
               cell_type = c("Gran", "CD4T"),
               contrast_matrix = NULL)
```

```
## Test the difference of Gran vs. CD4T in different values of disease.
```

```
head(test, 3)
```

```
##            f_statistics      p_value        fdr
## cg04021544     22.20766 1.083840e-05 0.03251519
## cg12036633     16.95815 9.624687e-05 0.14437031
## cg09982942     12.65167 6.500670e-04 0.41857616
```

For another example, testing the differences
between Gran and CD4T in males versus females.

```
test <- csTest(fitted_model,
               coef = "gender",
               cell_type = c("Gran", "CD4T"),
               contrast_matrix = NULL)
```

```
## Test the difference of Gran vs. CD4T in different values of gender.
```

```
head(test, 3)
```

```
##            f_statistics     p_value       fdr
## cg23622369     10.71461 0.001601029 0.9997172
## cg19801747     10.66346 0.001640256 0.9997172
## cg19962075     10.32512 0.001926138 0.9997172
```

## 5.4 A few words about variance bound and Type I error.

### 5.4.1 Variance bound

There is an argument in `csTest()` called
`var_shrinkage`. `var_shrinkage` is whether
to apply shrinkage on estimated mean squared
errors (MSEs) from the regression.
Based on our experience, extremely
small variance estimates sometimes cause
unstable test statistics. In our implementation,
use the 10% quantile value to bound the smallest MSEs.
We recommend to use the default opinion
`var_shrinkage = TRUE`.

### 5.4.2 Type I error

For all the above tests, we implement them
using F-test. In our own experiments, we
observe inflated type I errors from using
F-test. As a result, we recommend to perform
a permutation test to validate the significant
signals identified are “real”.

# Session info

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
## [1] TOAST_1.24.0     quadprog_1.5-8   nnls_1.6         limma_3.66.0
## [5] EpiDISH_2.26.0   BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            dplyr_1.1.4
##  [3] farver_2.1.2                S7_0.2.0
##  [5] fastmap_1.2.0               GGally_2.4.0
##  [7] digest_0.6.37               lifecycle_1.0.4
##  [9] statmod_1.5.1               magrittr_2.0.4
## [11] compiler_4.5.1              rlang_1.1.6
## [13] sass_0.4.10                 tools_4.5.1
## [15] yaml_2.3.10                 knitr_1.50
## [17] S4Arrays_1.10.0             labeling_0.4.3
## [19] DelayedArray_0.36.0         RColorBrewer_1.1-3
## [21] abind_1.4-8                 withr_3.0.2
## [23] purrr_1.1.0                 BiocGenerics_0.56.0
## [25] grid_4.5.1                  stats4_4.5.1
## [27] e1071_1.7-16                ggplot2_4.0.0
## [29] scales_1.4.0                iterators_1.0.14
## [31] MASS_7.3-65                 dichromat_2.0-0.1
## [33] tinytex_0.57                SummarizedExperiment_1.40.0
## [35] cli_3.6.5                   rmarkdown_2.30
## [37] crayon_1.5.3                generics_0.1.4
## [39] cachem_1.1.0                proxy_0.4-27
## [41] stringr_1.5.2               splines_4.5.1
## [43] parallel_4.5.1              BiocManager_1.30.26
## [45] XVector_0.50.0              matrixStats_1.5.0
## [47] vctrs_0.6.5                 Matrix_1.7-4
## [49] jsonlite_2.0.0              bookdown_0.45
## [51] IRanges_2.44.0              S4Vectors_0.48.0
## [53] magick_2.9.0                foreach_1.5.2
## [55] jquerylib_0.1.4             tidyr_1.3.1
## [57] glue_1.8.0                  ggstats_0.11.0
## [59] codetools_0.2-20            stringi_1.8.7
## [61] gtable_0.3.6                locfdr_1.1-8
## [63] GenomicRanges_1.62.0        tibble_3.3.0
## [65] pillar_1.11.1               htmltools_0.5.8.1
## [67] Seqinfo_1.0.0               R6_2.6.1
## [69] doParallel_1.0.17           evaluate_1.0.5
## [71] lattice_0.22-7              Biobase_2.70.0
## [73] corpcor_1.6.10              bslib_0.9.0
## [75] class_7.3-23                Rcpp_1.1.0
## [77] SparseArray_1.10.0          xfun_0.53
## [79] MatrixGenerics_1.22.0       pkgconfig_2.0.3
```