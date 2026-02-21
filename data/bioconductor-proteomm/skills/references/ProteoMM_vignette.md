# ProteoMM - Multi-Dataset Model-based Differential Expression Proteomics Platform

### 2025-10-30

\newline

# Introduction

ProteoMM is a platform for peptide-level differential expression analysis of single or multiple proteomic datasets simultaneously. ProteoMM provides a single p-value and a single effect size estimate for the differences in protein abundances. A test statistic is computed as a sum of F-statistics produced for each individual dataset. A p-value is then estimated via a permutation test as the distribution of the sum of the F-statistics does not have a closed form solution. Simultaneous utilization of all available peptides within proteins in multiple datasets increases statistical power to detect differences among conditions or treatments. In addition, in ProteoMM package, we build on our previous research and provide functionality for normalization, model-based imputation of missing peptide abundances and peptide-level differential protein expression analysis [1, 2].

Currently, combined analysis of multiple datasets is limited to utilizing a multi-dataset t-test [3]. Since in proteomics, protein abundances are measured in terms of the constitutive peptides a t-test would require averaging or “rolling-up” the peptide abundances into protein abundances prior to analysis with a multi-dataset t-test. We have previously shown that such reduction in the number of observations leads to the reduced statistical power and reduced ability to detect differentially expressed proteins [1]. ProteoMM provides a flexible pipeline from raw peptide abundances to protein quantification for multiple as well as single datasets in bottom-up mass spectrometry-based proteomics studies.

This tutorial will walk the readers through an example analysis of two simulated
datasets. For function definitions and descriptions please use “?” command in R.

\newline

# Installation

ProteoMM can be installed from Bioconductor:

```
source("https://bioconductor.org/biocLite.R")
biocLite("ProteoMM")
library(ProteoMM)
```

Alternatively ProteoMM can be installed from GitHub:

```
devtools::install_github("YuliyaLab/ProteoMM")
library(ProteoMM)
```

# ProteoMM Analysis Pipeline

ProteoMM Pipeline includes six steps, which we suggest are performed in the
following order:

\newline

Load Data -> EigenMS Normalization -> Model-Based Imputation ->
Model-Based Differential Expression Analysis & Presence/Absence Analysis ->
Visualization & Table Output.

\newline

Individual steps such as normalization, imputation or presence/absence analysis
can be skipped but care must be taken to assure that peptides passed into
Model-Based Differential Expression Analysis step contain a sufficient number of observations.

The example we provide in this tutorial follows the suggested ProteoMM analysis
outline in Figure 1 with additional data visualization that we find useful in
proteomics data analysis.

\newline

# EigenMS normalization

The data used in this example is a subset of a proteomics experiment where
peptide IDs (sequences) have been shuffled and protein and gene IDs were
replaced by fake ‘Prot\_#’ name.
This document provides an example of the code and data structures that are
necessary to run Multi-Matrix analysis, including EigenMS normalization,
Model-Based imputation and Multi-Matrix statistical analysis.

For non-proteomics data, such as metabolomics data, 2 columns with identical
information can be provided.

Start by loading the data and defining the parameter `prot.info`, a two column
data framewith IDs for metabolites or peptides in case of matabolites the 2
columns are identical.
For peptides, 1st column must contain unique peptide ID (usually peptide
sequences), 2nd column can contain protein IDs, (not used in EigenMS)
and any other metadata columns that will be propagated through the analysis
pipeline.

## Human

Human dataset contains 695 peptides with 13 columns where 6 columns contain
intensities and the rest are metadata describing the proteins/peptides.
There are six samples with three samples in each of the two treatment groups:
CG and mCG.

We replace 0’s with NA’s and log2 transform the intensities as 0’s should not
be used in place of the missing observations. Such replacement will severely
skew the distribution of intensities and produce invalid differential expression
results. For more information see Karpievitch et al. 2009 [1,2].

```
# Load data for human, then mouse
data("hs_peptides") # loads variable hs_peptides
dim(hs_peptides)  # 695 x 13
```

```
## [1] 695  13
```

```
intsCols = 8:13   # column indices that contain intensities
m_logInts = make_intencities(hs_peptides, intsCols)

# replace 0's with NA's, NA's are more appropriate for analysis & log2 transform
m_logInts = convert_log2(m_logInts)
metaCols = 1:7 # column indices for metadata such as protein IDs and sequences
m_prot.info = make_meta(hs_peptides, metaCols)

# m_prot.info - 2+ column data frame with peptide IDs and protein IDs
head(m_prot.info)
```

```
##                         Sequence MatchedID  ProtID  GeneID     ProtName
## 1            CLLAASPENEAGGLKLDGR         3   Prot3   Gene3   Prot3 Name
## 2                  HNIEGIFTFVDHR         3   Prot3   Gene3   Prot3 Name
## 3 RLFSGTQISTIAESEDSQESVDSVTDSQKR       501 Prot501 Gene501 Prot501 Name
## 4             LREQYGLGPYEAVTPLTK       501 Prot501 Gene501 Prot501 Name
## 5                  LINNNPEIFGPLK       502 Prot502 Gene502 Prot502 Name
## 6                     ENMELEEKEK        14  Prot14  Gene14  Prot14 Name
##     ProtIDLong   GeneIDLong
## 1   Prot3 long   Gene3 long
## 2   Prot3 long   Gene3 long
## 3 Prot501 long Gene501 long
## 4 Prot501 long Gene501 long
## 5 Prot502 long Gene502 long
## 6  Prot14 long  Gene14 long
```

```
dim(m_logInts) # 695 x 6
```

```
## [1] 695   6
```

```
grps = as.factor(c('CG','CG','CG', 'mCG','mCG','mCG')) # 3 samples for CG & mCG

# check the number of missing values
m_nummiss = sum(is.na(m_logInts))
m_nummiss
```

```
## [1] 1597
```

```
m_numtot = dim(m_logInts)[1] * dim(m_logInts)[2] #  total # of observations
m_percmiss = m_nummiss/m_numtot  # % missing observations
m_percmiss # 38.29% missing values, representative of the true larger dataset
```

```
## [1] 0.3829736
```

```
# plot number of missing values for each sample
par(mfcol=c(1,1))
barplot(colSums(is.na(m_logInts)),
        main="Numbers of missing values in Human samples (group order)")
```

![Numbers of missing values in each of the Human samples.](data:image/png;base64...)

Note that the mCG treatment group has more missing values. Next identify bias
trends with `eig_norm1()`.

```
hs_m_ints_eig1 = eig_norm1(m=m_logInts,treatment=grps,prot.info=m_prot.info)
```

```
## Warning in eig_norm1(m = m_logInts, treatment = grps, prot.info = m_prot.info): This function uses random namber generator. For reproducibility use
##     set.seed(12345) with your choce of parameter
```

```
## Data dimentions: 6956
```

```
## Treatment groups: CGCGCGmCGmCGmCG
```

```
## Selecting complete peptides
```

```
## Got 2+ treatment grps
```

```
## Computing SVD, estimating Eigentrends...
```

```
## Number of treatments: 2
```

```
## Number of complete peptides (and samples) used in SVD
```

```
## 1966
```

```
## Number of treatment groups (in svd.id): 2
```

```
## Starting Bootstrap.....
```

```
## Iteration 50
```

```
## Iteration 100
```

```
## Iteration 150
```

```
## Iteration 200
```

```
## Iteration 250
```

```
## Iteration 300
```

```
## Iteration 350
```

```
## Iteration 400
```

```
## Iteration 450
```

```
## Iteration 500
```

```
## Number of bias trends automatically detected 1
```

```
## Preparing to plot...
```

![Eigentrends for raw and residual peptide intensities in Human samples. Dots at positions 1-6 correspond to the 6 samples. The top trend in the raw data (left panel) shows a pattern representative of the differences between the two groups. Top trend in the Residual Data (right panel) shows that sample 2 and 5 have higher similarity to each other, as well as, 1, 3, 4 and 6 whereas in reality samples 1-3 are from the same treatment group and 3-6 are from the other.](data:image/png;base64...)

```
names(hs_m_ints_eig1)
```

```
##  [1] "m"             "treatment"     "my.svd"        "pres"
##  [5] "n.treatment"   "n.u.treatment" "h.c"           "present"
##  [9] "prot.info"     "complete"      "toplot1"       "Tk"
## [13] "ncompl"        "grp"
```

Our simulated dataset is small, and only 1 bias trend was identified in the
peptides with no missing values. But visually it seems that there are at least 2.

```
hs_m_ints_eig1$h.c
```

```
## [1] 1
```

Run EigenMS normalization to eliminate 1 bias trend

```
hs_m_ints_norm_1bt = eig_norm2(rv=hs_m_ints_eig1)
```

```
## Unique number of treatment combinations:2
```

```
## Normalizing...
```

```
## Processing peptide 100
```

```
## Processing peptide 200
```

```
## Processing peptide 300
```

```
## Processing peptide 400
```

![Eigetrends for raw and normalized peptide intensities in Human samples. Dots at positions 1-6 correspond to the 6 samples. Top trend in the normalized data (right panel) shows a pattern representative of the differences between the two groups (eigen trends can be rotated around the x-axis).](data:image/png;base64...)

```
## Done with normalization!!!
```

There is a 15% increase in percent variance explained by the trend as is
indicated by the percentage in the upper right corner. But
the next (middle) trend explains 18% of variation, so bias effect of this trend
may need to be removed.

```
names(hs_m_ints_eig1)
```

```
##  [1] "m"             "treatment"     "my.svd"        "pres"
##  [5] "n.treatment"   "n.u.treatment" "h.c"           "present"
##  [9] "prot.info"     "complete"      "toplot1"       "Tk"
## [13] "ncompl"        "grp"
```

```
# how many peptides with no missing values (complete) are in the data?
dim(hs_m_ints_eig1$complete)# bias trend identification is based on 196 peptides
```

```
## [1] 196   6
```

Our simulated dataset is small, with only 196 peptides with no missing values,
which are used to identify bias trends. Only one bias trend was identified,
but visually it seems that there are at least two. So here we manually set h.c
to 2 trestnds that are going to be eliminated.

```
hs_m_ints_eig1$h.c = 2 # visually there are more than 1 bias trend, set to 2
```

```
hs_m_ints_norm = eig_norm2(rv=hs_m_ints_eig1)
```

```
## Unique number of treatment combinations:2
```

```
## Normalizing...
```

```
## Processing peptide 100
```

```
## Processing peptide 200
```

```
## Processing peptide 300
```

```
## Processing peptide 400
```

![Eigetrends for raw and normalized peptide intensities in Human samples with the effects of two bias trends removed. Dots at positions 1-6 correspond to the 6 samples. Top trend in the Normalized Data (Figure 4, right panel) shows a pattern representative of the differences between the two groups (eigen trends can be rotated around x-axis).](data:image/png;base64...)

```
## Done with normalization!!!
```

Figure 4 shows a 28% increase in percent variance explained by the trend where
differences between the groups explaining 71% of total variation in the data
as is indicated by the percentage in the upper right corner.
The next (middle) trend explains 16% of variation, but removing the effect of
more trends may overnormalize, thus this we will use normalized data with two
bias trends eliminated.

\newpage

## Mouse

The mouse dataset contains 1102 peptides with 13 columns where 6 column contain
intensities and the rest are metadata describing the proteins/peptides.

There are six samples with three samples in each of the two treatment groups:
CG and mCG. The data preparation is similar to what we have done for Human data.

```
data("mm_peptides") # loads variable mm_peptides
dim(mm_peptides)
```

```
## [1] 1102   13
```

```
dim(mm_peptides) # 1102 x 13
```

```
## [1] 1102   13
```

```
head(mm_peptides)
```

```
##                              Sequence MatchedID ProtID GeneID    ProtName
## 1             GFAYVQFEDVRDAEDALYNLNRK        64 Prot64 Gene64 Prot64 Name
## 2                   SKCEELSSLHGQLKEAR        61 Prot61 Gene61 Prot61 Name
## 3    QDAGSEPVTPASLAALQSDVQPVGHDYVEEVR        61 Prot61 Gene61 Prot61 Name
## 4         TGDQEERQDYINLDESEAAAFDDEWRR         1  Prot1  Gene1  Prot1 Name
## 5              IPAYFITVHDPAVPPGEDPDGR        60 Prot60 Gene60 Prot60 Name
## 6 GGTPGSGAAAAAGSKPPPSSSASASSSSSSFAQQR        60 Prot60 Gene60 Prot60 Name
##    ProtIDLong  GeneIDLong      CG1      CG2      CG3     mCG1     mCG2     mCG3
## 1 Prot64 long Gene64 long  3725900 11642000  4872400        0 12850000  3751700
## 2 Prot61 long Gene61 long 19699000 38055000 30661000 15896000 55187000 20356000
## 3 Prot61 long Gene61 long        0        0        0  5277500        0 38698000
## 4  Prot1 long  Gene1 long        0        0        0        0        0        0
## 5 Prot60 long Gene60 long  9391200        0        0  4689800  8305300        0
## 6 Prot60 long Gene60 long        0        0 20406000  5809800        0        0
```

```
intsCols = 8:13 # may differ for each dataset, users need to adjust
m_logInts = make_intencities(mm_peptides, intsCols)  # reuse the name m_logInts
m_logInts = convert_log2(m_logInts)
metaCols = 1:7
m_prot.info = make_meta(mm_peptides, metaCols)

head(m_prot.info)
```

```
##                              Sequence MatchedID ProtID GeneID    ProtName
## 1             GFAYVQFEDVRDAEDALYNLNRK        64 Prot64 Gene64 Prot64 Name
## 2                   SKCEELSSLHGQLKEAR        61 Prot61 Gene61 Prot61 Name
## 3    QDAGSEPVTPASLAALQSDVQPVGHDYVEEVR        61 Prot61 Gene61 Prot61 Name
## 4         TGDQEERQDYINLDESEAAAFDDEWRR         1  Prot1  Gene1  Prot1 Name
## 5              IPAYFITVHDPAVPPGEDPDGR        60 Prot60 Gene60 Prot60 Name
## 6 GGTPGSGAAAAAGSKPPPSSSASASSSSSSFAQQR        60 Prot60 Gene60 Prot60 Name
##    ProtIDLong  GeneIDLong
## 1 Prot64 long Gene64 long
## 2 Prot61 long Gene61 long
## 3 Prot61 long Gene61 long
## 4  Prot1 long  Gene1 long
## 5 Prot60 long Gene60 long
## 6 Prot60 long Gene60 long
```

```
dim(m_logInts)# 1102 x 6
```

```
## [1] 1102    6
```

```
# check numbers of missing values in Mouse samples
m_nummiss = sum(is.na(m_logInts))
m_nummiss
```

```
## [1] 2698
```

```
m_numtot = dim(m_logInts)[1] * dim(m_logInts)[2] #  total observations
m_percmiss = m_nummiss/m_numtot  # % missing observations
m_percmiss # 40.8% missing values, representative of the true larger dataset
```

```
## [1] 0.408046
```

```
# plot number of missing values for each sample
par(mfcol=c(1,1))
barplot(colSums(is.na(m_logInts)),
        main="Numbers of missing values in Mouse samples (group order)")
```

![Numbers of missing values in each of the Human samples. mCG treatment group has more missing values.](data:image/png;base64...)

```
mm_m_ints_eig1 = eig_norm1(m=m_logInts,treatment=grps,prot.info=m_prot.info)
```

```
## Warning in eig_norm1(m = m_logInts, treatment = grps, prot.info = m_prot.info): This function uses random namber generator. For reproducibility use
##     set.seed(12345) with your choce of parameter
```

```
## Data dimentions: 11026
```

```
## Treatment groups: CGCGCGmCGmCGmCG
```

```
## Selecting complete peptides
```

```
## Got 2+ treatment grps
```

```
## The following object is masked from TREATS (pos = 3):
##
##     TREATS
```

```
## Computing SVD, estimating Eigentrends...
```

```
## Number of treatments: 2
```

```
## Number of complete peptides (and samples) used in SVD
```

```
## 2706
```

```
## Number of treatment groups (in svd.id): 2
```

```
## Starting Bootstrap.....
```

```
## Iteration 50
```

```
## Iteration 100
```

```
## Iteration 150
```

```
## Iteration 200
```

```
## Iteration 250
```

```
## Iteration 300
```

```
## Iteration 350
```

```
## Iteration 400
```

```
## Iteration 450
```

```
## Iteration 500
```

```
## Number of bias trends automatically detected 1
```

```
## Preparing to plot...
```

![Eigentrends for raw and residual peptide intensities in mouse samples. Dots at positions 1-6 correspond to the 6 samples. The top trend in the normalized data (right panel) shows a pattern representative of the differences between the two groups (eigen trends can be rotated around x-axis).](data:image/png;base64...)

The eigentrend that explains most of the variation (45%) in the Mouse data is
not representative of the treatment group differences (Figure 5). The second
trend in the raw data explains only 22% of the total variation that resembles
treatment group differences necessitating normalization. Variation in the data
as is indicated by the percentage in the upper right corner.

```
mm_m_ints_eig1$h.c
```

```
## [1] 1
```

```
mm_m_ints_norm_1bt = eig_norm2(rv=mm_m_ints_eig1)
```

```
## Unique number of treatment combinations:2
```

```
## Normalizing...
```

```
## Processing peptide 100
```

```
## Processing peptide 200
```

```
## Processing peptide 300
```

```
## Processing peptide 400
```

```
## Processing peptide 500
```

```
## Processing peptide 600
```

```
## Processing peptide 700
```

![Eigentrends for raw and normalized peptide intensities in mouse samples with the effects of one bias trends removed. Dots at positions 1-6 correspond to the 6 samples. The top trend in the normalized data (Figure 7, right panel) shows a pattern representative of the differences between the two groups.](data:image/png;base64...)

```
## Done with normalization!!!
```

The eigentrend that explains most of the variation (43%) in the normalized mouse
data is representative of the treatment group differences. The second trend in
the raw data explains only 27% of the total variation and should be considered
as bias.

```
mm_m_ints_eig1$h.c = 2
```

```
mm_m_ints_norm = eig_norm2(rv=mm_m_ints_eig1)
```

```
## Unique number of treatment combinations:2
```

```
## Normalizing...
```

```
## Processing peptide 100
```

```
## Processing peptide 200
```

```
## Processing peptide 300
```

```
## Processing peptide 400
```

```
## Processing peptide 500
```

```
## Processing peptide 600
```

```
## Processing peptide 700
```

![Eigentrends for raw and normalized peptide intensities in mouse samples with the effects of two bias trends removed. Dots at positions 1-6 correspond to the 6 samples. Top trend in the Normalized Data (right panel) shows a pattern representative of the differences between the two groups.](data:image/png;base64...)

```
## Done with normalization!!!
```

```
# 190 petides with no missing values were used to id bais trends ($complete)
```

The eigentrend that explains most of the variation in the normalized mouse data
representative of the treatment group differences now explains 58% of variation.
The second trend in the normalized data explains less of variation that in
Figure 6 (24%) which is still a bit high, but we will use these data for analysis
to avoid overfitting.

```
length(mm_m_ints_eig1$prot.info$MatchedID)          # 1102 - correct
```

```
## [1] 1102
```

```
length(hs_m_ints_eig1$prot.info$MatchedID)          # 695 - can normalize all
```

```
## [1] 695
```

```
length(unique(mm_m_ints_eig1$prot.info$MatchedID) ) # 69
```

```
## [1] 69
```

```
length(unique(hs_m_ints_eig1$prot.info$MatchedID) ) # 69
```

```
## [1] 69
```

```
# 787 peptides were normalized, rest eliminated due to low # of observations
dim(mm_m_ints_norm$norm_m)
```

```
## [1] 787   6
```

```
dim(hs_m_ints_norm$norm_m) # 480 peptides were normalized
```

```
## [1] 480   6
```

\newpage

\newline

# Model-based imputation

Model-based imputation uses a statistical model that accounts for the
informative missingness in peptide intensities and provides an unbiased,
model-based, protein-level differential expression analysis performed at peptide
level [1].

Model-based imputation models two missingness mechanisms, one missing completely
at random and the other abundance-dependent. Completely random missingness
occurs when the fact that a peptide was unobserved in a sample has nothing to
do with its abundance or the abundance of any other peptides. This usually
affects a small proportion of the peptides considered in the analysis. From
our past experience it is near 5% or all observations. Abundance-dependent
missingness occurs due to left-censoring, where a peptide is either not present
or is present at too low concentration to be detected by the instrument.
In this case, we have partial information for the peptide intensity, in that
we know it must be less than the rest of the observed peptide intensities.

## Human

We need to set up metadata and intensities to use for the imputation.
We will impute based on ProtID - position in the matrix for the Protein
Identifier. In this example datasets, ProtID and MatchedID can be used
interchangeably.

```
hs_prot.info = hs_m_ints_norm$normalized[,metaCols]
hs_norm_m =  hs_m_ints_norm$normalized[,intsCols]
head(hs_prot.info)
```

```
##                                                      Sequence MatchedID  ProtID
## CLLAASPENEAGGLKLDGR                       CLLAASPENEAGGLKLDGR         3   Prot3
## HNIEGIFTFVDHR                                   HNIEGIFTFVDHR         3   Prot3
## RLFSGTQISTIAESEDSQESVDSVTDSQKR RLFSGTQISTIAESEDSQESVDSVTDSQKR       501 Prot501
## LINNNPEIFGPLK                                   LINNNPEIFGPLK       502 Prot502
## ENMELEEKEK                                         ENMELEEKEK        14  Prot14
## GHEFYNPQKK                                         GHEFYNPQKK        14  Prot14
##                                 GeneID     ProtName   ProtIDLong   GeneIDLong
## CLLAASPENEAGGLKLDGR              Gene3   Prot3 Name   Prot3 long   Gene3 long
## HNIEGIFTFVDHR                    Gene3   Prot3 Name   Prot3 long   Gene3 long
## RLFSGTQISTIAESEDSQESVDSVTDSQKR Gene501 Prot501 Name Prot501 long Gene501 long
## LINNNPEIFGPLK                  Gene502 Prot502 Name Prot502 long Gene502 long
## ENMELEEKEK                      Gene14  Prot14 Name  Prot14 long  Gene14 long
## GHEFYNPQKK                      Gene14  Prot14 Name  Prot14 long  Gene14 long
```

```
head(hs_norm_m)
```

```
##                                     CG1      CG2      CG3     mCG1     mCG2
## CLLAASPENEAGGLKLDGR            24.16344 25.11800 25.39066 24.73530 24.47494
## HNIEGIFTFVDHR                  21.81538       NA 21.42956 21.90027 21.74596
## RLFSGTQISTIAESEDSQESVDSVTDSQKR 23.52846 22.73723 23.53173 23.03903 23.51463
## LINNNPEIFGPLK                        NA 22.34531 21.88714       NA 21.09684
## ENMELEEKEK                     27.31511 26.85826 27.39201 27.89371 28.18741
## GHEFYNPQKK                     24.69609 24.27661 24.96221 24.42590 24.74535
##                                    mCG3
## CLLAASPENEAGGLKLDGR            24.65338
## HNIEGIFTFVDHR                        NA
## RLFSGTQISTIAESEDSQESVDSVTDSQKR 22.95478
## LINNNPEIFGPLK                  21.24429
## ENMELEEKEK                     27.83388
## GHEFYNPQKK                     24.34182
```

```
dim(hs_norm_m) # 480 x 6, raw: 695, 215 peptides were eliminated due to lack of
```

```
## [1] 480   6
```

```
               # observations
length(unique(hs_prot.info$MatchedID)) # 59
```

```
## [1] 59
```

```
length(unique(hs_prot.info$ProtID))    # 59
```

```
## [1] 59
```

```
imp_hs = MBimpute(hs_norm_m, grps, prot.info=hs_prot.info, pr_ppos=3,
                  my.pi=0.05, compute_pi=FALSE) # use default pi
# historically pi=.05 has been representative of the % missing
# observations missing completely at random
```

```
# check some numbers after the imputation
length(unique(imp_hs$imp_prot.info$MatchedID)) # 59 - MatchedID IDs
```

```
## [1] 59
```

```
length(unique(imp_hs$imp_prot.info$ProtID))    # 59 - Protein IDs
```

```
## [1] 59
```

```
length(unique(imp_hs$imp_prot.info$GeneID))    # 59
```

```
## [1] 59
```

```
dim(imp_hs$imp_prot.info) # 480 x 7 imputed peptides
```

```
## [1] 480   7
```

```
dim(imp_hs$y_imputed)     # 480 x 6
```

```
## [1] 480   6
```

```
# plot one of the protiens to check normalization and imputation visually
mylabs = c( 'CG','CG','CG', 'mCG','mCG','mCG') # same as grps this is a string
prot_to_plot = 'Prot32' # 43
gene_to_plot = 'Gene32'
plot_3_pep_trends_NOfile(as.matrix(hs_m_ints_eig1$m), hs_m_ints_eig1$prot.info,
                         as.matrix(hs_norm_m), hs_prot.info, imp_hs$y_imputed,
                         imp_hs$imp_prot.info, prot_to_plot, 3, gene_to_plot,
                         4, mylabs)
```

![All peptides within protein Prot32 in raw, normalized, and imputed form.](data:image/png;base64...)

## Mouse

```
mm_prot.info = mm_m_ints_norm$normalized[,1:7]
mm_norm_m =  mm_m_ints_norm$normalized[,8:13]
head(mm_prot.info)
```

```
##                                                                Sequence
## GFAYVQFEDVRDAEDALYNLNRK                         GFAYVQFEDVRDAEDALYNLNRK
## SKCEELSSLHGQLKEAR                                     SKCEELSSLHGQLKEAR
## IPAYFITVHDPAVPPGEDPDGR                           IPAYFITVHDPAVPPGEDPDGR
## GGTPGSGAAAAAGSKPPPSSSASASSSSSSFAQQR GGTPGSGAAAAAGSKPPPSSSASASSSSSSFAQQR
## NLGGNYPEK                                                     NLGGNYPEK
## ISCAGPQTYKEHLEGQKHK                                 ISCAGPQTYKEHLEGQKHK
##                                     MatchedID ProtID GeneID    ProtName
## GFAYVQFEDVRDAEDALYNLNRK                    64 Prot64 Gene64 Prot64 Name
## SKCEELSSLHGQLKEAR                          61 Prot61 Gene61 Prot61 Name
## IPAYFITVHDPAVPPGEDPDGR                     60 Prot60 Gene60 Prot60 Name
## GGTPGSGAAAAAGSKPPPSSSASASSSSSSFAQQR        60 Prot60 Gene60 Prot60 Name
## NLGGNYPEK                                  28 Prot28 Gene28 Prot28 Name
## ISCAGPQTYKEHLEGQKHK                        53 Prot53 Gene53 Prot53 Name
##                                      ProtIDLong  GeneIDLong
## GFAYVQFEDVRDAEDALYNLNRK             Prot64 long Gene64 long
## SKCEELSSLHGQLKEAR                   Prot61 long Gene61 long
## IPAYFITVHDPAVPPGEDPDGR              Prot60 long Gene60 long
## GGTPGSGAAAAAGSKPPPSSSASASSSSSSFAQQR Prot60 long Gene60 long
## NLGGNYPEK                           Prot28 long Gene28 long
## ISCAGPQTYKEHLEGQKHK                 Prot53 long Gene53 long
```

```
head(mm_norm_m)
```

```
##                                          CG1      CG2      CG3     mCG1
## GFAYVQFEDVRDAEDALYNLNRK             21.99076 22.78591 22.74153       NA
## SKCEELSSLHGQLKEAR                   24.24259 24.78175 25.25876 24.56999
## IPAYFITVHDPAVPPGEDPDGR              23.13090       NA       NA 22.56945
## GGTPGSGAAAAAGSKPPPSSSASASSSSSSFAQQR       NA       NA 24.28249 22.47006
## NLGGNYPEK                           24.19505 24.89556 24.52888       NA
## ISCAGPQTYKEHLEGQKHK                       NA 22.50866 23.56617 23.18408
##                                         mCG2     mCG3
## GFAYVQFEDVRDAEDALYNLNRK             22.68752 22.83741
## SKCEELSSLHGQLKEAR                   24.76317 24.58578
## IPAYFITVHDPAVPPGEDPDGR              22.63033       NA
## GGTPGSGAAAAAGSKPPPSSSASASSSSSSFAQQR       NA       NA
## NLGGNYPEK                                 NA 24.74703
## ISCAGPQTYKEHLEGQKHK                       NA 22.84175
```

```
dim(mm_norm_m) # 787 x 6, raw had: 1102 peptides/rows
```

```
## [1] 787   6
```

```
length(unique(mm_prot.info$MatchedID)) # 56
```

```
## [1] 56
```

```
length(unique(mm_prot.info$ProtID))    # 56
```

```
## [1] 56
```

```
set.seed(12131) # set random number generator seed for reproducibility,
# otherwise will get various imputed values for repeated attempts
# as for Human, impute based on ProtID - position in the matrix for the Protein Identifier
imp_mm = MBimpute(mm_norm_m, grps, prot.info=mm_prot.info, pr_ppos=3,
                  my.pi=0.05, compute_pi=FALSE)
```

```
## Imputing...
```

```
                  # pi =.05 is usually a good estimate
```

Check if returned number of rows corresponds to the same number of rows in
normalized data.

```
dim(imp_mm$imp_prot.info) # 787 x 7 - imputed peptides & 787 were normalized
```

```
## [1] 787   7
```

```
dim(imp_mm$y_imputed)     # 787 x 6
```

```
## [1] 787   6
```

\newpage

\newline

# Model-Based Differential Expression Analysis

We will do combined model-based differential expression analysis for proteins
detected in both mouse and human datasets. For proteins that were only
identified in one of the two datasets analysis will be performed for that
particular species separately. Combined analysis of multiple datasets will have
higher sensitivity to detect differentially expressed proteins due to the
increase in the numbers of observations.

## Combined Model-Based Differential Expression Analysis

Multi Matrix analysis is generalizable to 2 or more datasets thus parallel
lists are used to store intensities, metadata, and treatment group information.
Second column metadata data frame must be a protein identifier that is present
in both datasets. In this simulated dataset ProtIDs as well as matchedID, will
match across Human and Mouse, in reality, protein IDs will differ, as human and
mouse protein IDs are different for the same protein. Gene IDs will generally
differ by only by upper vs. lower case, with a few genes having different IDs for
the unknown to us reason. Thus when comparing protein abundances across
different organisms ProtID is not a good identifier to use across different
organisms, instead, protein IDs can be matched based on Ensembl IDs.

We will start by making parallel lists to pass as parameters to teh differential
expression function prot\_level\_multi\_part().
Start by dividing the data into a list of proteins that are common to both
datasets (can be more than 2) and proteins present only in one or the other
(unique to one or the other). Here we will analyze the proteins that were
observed only in one of the datasets,
Note that “grps”” variable is the same for both simulated dataset here, but for
useres number and order of samples ned to checked and grps variable set to the
appropriate factors for each dataset. Also note that treatment group order
should be the same in all datasets. Do not set groups to

*contr contr contr treat treat treat*

in one sample and

*treat treat treat contr contr contr*

in the other.

```
# make parallel lists to pass as parameters
mms = list()
treats = list()
protinfos = list()
mms[[1]] = imp_mm$y_imputed
mms[[2]] = imp_hs$y_imputed
treats[[1]] = grps
treats[[2]] = grps

protinfos[[1]] = imp_mm$imp_prot.info
protinfos[[2]] = imp_hs$imp_prot.info

subset_data = subset_proteins(mm_list=mms, prot.info=protinfos, 'MatchedID')
names(subset_data)
```

```
## [1] "sub_mm_list"          "sub_prot.info"        "sub_unique_mm_list"
## [4] "sub_unique_prot.info" "common_list"
```

```
mm_dd_only = subset_data$sub_unique_prot.info[[1]]
hs_dd_only = subset_data$sub_unique_prot.info[[2]]

ugene_mm_dd = unique(mm_dd_only$MatchedID)
ugene_hs_dd = unique(hs_dd_only$MatchedID)
length(ugene_mm_dd) # 24 - in Mouse only
```

```
## [1] 24
```

```
length(ugene_hs_dd) # 27 - Human only
```

```
## [1] 27
```

```
nsets = length(mms)
nperm = 50   # number of permutations should be 500+ for publication quality
```

```
ptm = proc.time()
set.seed=(12357)
comb_MBDE = prot_level_multi_part(mm_list=mms, treat=treats,prot.info=protinfos,
                                  prot_col_name='ProtID', nperm=nperm,
                                  dataset_suffix=c('MM', 'HS'))
```

```
## Computing statistics
```

```
## Perfoming permutation test
```

```
## Dataset 1
```

```
## Dataset 2
```

```
proc.time() - ptm  # shows how long it takes to run the test
```

```
mybreaks = seq(0,1, by=.05)
# adjustment for permutation test is done by stretching out values on the
# interval [0 1]  as expected in a theoretical p-value distribution
par(mfcol=c(1,3)) # always check out p-values
# bunched up on interval [0 .5]
hist(comb_MBDE$P_val, breaks=mybreaks, xlab='unadjusted p-values', main='')
# adjusted p-values look good
hist(comb_MBDE$BH_P_val, breaks=mybreaks, xlab='adjusted p-values', main='')
# bunched up on interval [0 .5]
hist(p.adjust(comb_MBDE$P_val, method='BH'), breaks=mybreaks,
     xlab='BH adjusted p-values', main='')
```

![P-value distributions for unadjusted and adjusted p-values. Adjusted p-values (top right) look as expected according to the theory with a peak near 0 and an approximately uniform distribution throughout the interval [0 1]. Benjamini-Hochberg adjusted p-values (bottom left) do not look according to the theoretical distribution, thus Benjamini-Hochberg adjusted may not be appropriate.](data:image/png;base64...)

```
# horizontal streaks correspond to where a permutation test produces 0 or
# very small value, these are reset to improve visualization
par(mfcol=c(1,1)) # Volcano generally look better for larger dataset...
plot_volcano_wLab(comb_MBDE$FC, comb_MBDE$BH_P_val, comb_MBDE$GeneID,
                  FC_cutoff=1.2, PV_cutoff=.05, 'CG vs mCG')
```

![Distribution of p-values and fold changes for combined multi-matrix analysis of Mouse and Human.](data:image/png;base64...)

## Model-Based Differential Expression Analysis for proteins observed only in Human

There are Human (HS) specific proteins that can be analyzed with Model-Based
Differential Expression Analysis, so no analysis for this subset.

## Model-Based Differential Expression Analysis for proteins observed only in Mouse

```
# subset_data contains "sub_unique_mm_list"  "sub_unique_prot.info" lists
# for each dataset in the order provided to subset function
mms_mm_dd = subset_data$sub_unique_mm_list[[1]] # Mouse
dim(mms_mm_dd)  # 258 x 6,
```

```
## [1] 258   6
```

```
protinfos_mm_dd = subset_data$sub_unique_prot.info[[1]]

length(unique(protinfos_mm_dd$ProtID))    # 24
```

```
## [1] 24
```

```
length(unique(protinfos_mm_dd$GeneID))    # 24
```

```
## [1] 24
```

```
length(unique(protinfos_mm_dd$MatchedID)) # 24
```

```
## [1] 24
```

```
DE_mCG_CG_mm_dd = peptideLevel_DE(mms_mm_dd, grps, prot.info=protinfos_mm_dd,
                                  pr_ppos=2)

# volcano plot
FCval = 1.2 # change this value for alternative fold change cutoff
plot_volcano_wLab(DE_mCG_CG_mm_dd$FC, DE_mCG_CG_mm_dd$BH_P_val,
                  DE_mCG_CG_mm_dd$GeneID, FC_cutoff=FCval,
                  PV_cutoff=.05, 'Mouse specific - CG vs mCG')
```

![Distribution of p-values and fold changes for differential expression analysis in Mouse.](data:image/png;base64...)

\newpage

\newline

# Presence-Absence Analysis

## Combined Mouse and Human Analysis

In the Presence-Absence Analysis, we use only proteins that are NOT in the
normalized data. For example, some peptides may have been eliminated for some
proteins due to many missing values, but if some peptides remained in the
Model-Based Differential Expression Analysis, we do not analyze a subset of
peptides in the Presence-Absence Analysis as we would obtain 2 p-values.
We strongly believe that Model-Based Differential Expression Analysis is a
more sensitive approach and thus it is a preferred method of analysis for
proteins that have sufficient number of observations
in both treatment groups.

```
# make data structures suitable for get_presAbs_prots() function
raw_list = list()
norm_imp_prot.info_list = list()
raw_list[[1]] = mm_m_ints_eig1$m
raw_list[[2]] = hs_m_ints_eig1$m
norm_imp_prot.info_list[[1]] = mm_m_ints_eig1$prot.info
norm_imp_prot.info_list[[2]] = hs_m_ints_eig1$prot.info

protnames_norm_list = list()
protnames_norm_list[[1]] = unique(mm_m_ints_norm$normalized$MatchedID) #56/69
protnames_norm_list[[2]] = unique(hs_m_ints_norm$normalized$MatchedID) #59

presAbs_dd = get_presAbs_prots(mm_list=raw_list,
                               prot.info=norm_imp_prot.info_list,
                               protnames_norm=protnames_norm_list,
                               prot_col_name=2)
```

```
## Number of peptides normalized: 1072
```

```
## Number of peptides Pres/Abs: 30
```

```
## Number of peptides normalized: 663
```

```
## Number of peptides Pres/Abs: 32
```

```
ints_presAbs = list()
protmeta_presAbs = list()
ints_presAbs[[1]] = presAbs_dd[[1]][[1]] # Mouse
ints_presAbs[[2]] = presAbs_dd[[1]][[2]] # HS
protmeta_presAbs[[1]] = presAbs_dd[[2]][[1]]
protmeta_presAbs[[2]] = presAbs_dd[[2]][[2]]

dim(protmeta_presAbs[[2]]) # 32 x 7 peptides
```

```
## [1] 32  7
```

```
length(unique(protmeta_presAbs[[2]]$MatchedID))  # 10 - proteins
```

```
## [1] 10
```

```
dim(protmeta_presAbs[[1]]) # 30 x 7 peptides
```

```
## [1] 30  7
```

```
length(unique(protmeta_presAbs[[1]]$MatchedID))  # 13 - proteins
```

```
## [1] 13
```

```
 # grps are the same for all analyses
subset_presAbs = subset_proteins(mm_list=ints_presAbs,
                                 prot.info=protmeta_presAbs,'MatchedID')
names(subset_presAbs)
```

```
## [1] "sub_mm_list"          "sub_prot.info"        "sub_unique_mm_list"
## [4] "sub_unique_prot.info" "common_list"
```

```
dim(subset_presAbs$sub_unique_prot.info[[1]])
```

```
## [1] 17  7
```

```
dim(subset_presAbs$sub_unique_prot.info[[2]])
```

```
## [1] 14  7
```

```
dim(subset_presAbs$sub_prot.info[[1]])
```

```
## [1] 13  7
```

```
dim(subset_presAbs$sub_prot.info[[2]])
```

```
## [1] 18  7
```

```
nperm = 50  # set to 500+ for publication
ptm = proc.time()
set.seed=(123372)
presAbs_comb=prot_level_multiMat_PresAbs(mm_list=subset_presAbs$sub_mm_list,
                                         treat=treats,
                                         prot.info=subset_presAbs$sub_prot.info,
                                         prot_col_name='MatchedID', nperm=nperm,
                                         dataset_suffix=c('MM', 'HS') )
```

```
## Warning in prot_level_multiMat_PresAbs(mm_list = subset_presAbs$sub_mm_list, : This function uses random namber generator. For reproducibility use
##           set.seed(12345) with your choce of parameter
```

```
## Computing statistics
```

```
## Perfoming permutation test
```

```
## Dataset 1
```

```
## Dataset 2
```

```
proc.time() - ptm
```

```
plot_volcano_wLab(presAbs_comb$FC, presAbs_comb$BH_P_val, presAbs_comb$GeneID,
                  FC_cutoff=.5, PV_cutoff=.05, 'Combined Pres/Abs CG vs mCG')
```

![Distribution of p-values and fold changes for differential expression in the combined analysis of Human and Mouse data in CG context.](data:image/png;base64...)

```
# just checking the numbers here
dim(subset_presAbs$sub_unique_mm_list[[1]])
```

```
## [1] 17  6
```

```
dim(subset_presAbs$sub_unique_mm_list[[2]])
```

```
## [1] 14  6
```

```
unique(subset_presAbs$sub_unique_prot.info[[1]]$ProtID)# 8
```

```
## [1] Prot55 Prot58 Prot45 Prot37 Prot46 Prot69 Prot63 Prot62
## 69 Levels: Prot1 Prot10 Prot11 Prot12 Prot13 Prot14 Prot15 Prot16 ... Prot9
```

```
unique(subset_presAbs$sub_unique_prot.info[[2]]$ProtID)# 5
```

```
## [1] Prot523 Prot525 Prot527 Prot529 Prot530
## 69 Levels: Prot1 Prot10 Prot11 Prot12 Prot13 Prot14 Prot15 Prot16 ... Prot9
```

## Presence/Absence analysis for proteins found only in Mouse

```
mm_presAbs = peptideLevel_PresAbsDE(subset_presAbs$sub_unique_mm_list[[1]],
                                    treats[[1]],
                                    subset_presAbs$sub_unique_prot.info[[1]],
                                    pr_ppos=3)

plot_volcano_wLab(mm_presAbs$FC, mm_presAbs$BH_P_val, mm_presAbs$GeneID,
                  FC_cutoff=.5, PV_cutoff=.05, 'MM Pres/Abs CG vs mCG')
```

![Distribution of p-values and fold changes for the presence/absence analysis in Mouse data in CG context.](data:image/png;base64...)

## Presence/Absence analysis for proteins found only in Human

```
hs_presAbs = peptideLevel_PresAbsDE(subset_presAbs$sub_unique_mm_list[[2]],
                                    treats[[2]],
                                    subset_presAbs$sub_unique_prot.info[[2]],
                                    pr_ppos=3)

plot_volcano_wLab(hs_presAbs$FC, hs_presAbs$BH_P_val, hs_presAbs$GeneID,
                  FC_cutoff=.5, PV_cutoff=.05, 'HS Pres/Abs CG vs mCG')
```

![plot of chunk Distribution of p-values and fold changes for the presence/absence analysis in Human data in CG context.](figure/Distribution of p-values and fold changes for the presence/absence analysis in Human data in CG context.-1.png)

\newline

# References

1. Karpievitch, Y.V., et al., A statistical framework for protein quantitation in
   bottom-up MS-based proteomics. Bioinformatics, 2009. 25(16): p. 2028-34.
2. Karpievitch, Y.V., et al., Normalization of peak intensities in bottom-up
   MS-based proteomics using singular value decomposition. Bioinformatics, 2009. 25(19): p. 2573-80.
3. Taylor, S.L., et al., Multivariate two-part statistics for analysis of
   correlated mass spectrometry data from multiple biological specimens.
   Bioinformatics, 2017. 33(1): p. 17-25.

\newline

# R Session Information

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] ProteoMM_1.28.0
##
## loaded via a namespace (and not attached):
##  [1] vctrs_0.6.5        cli_3.6.5          knitr_1.50         rlang_1.1.6
##  [5] xfun_0.53          ggrepel_0.9.6      generics_0.1.4     S7_0.2.0
##  [9] gtools_3.9.5       labeling_0.4.3     glue_1.8.0         scales_1.4.0
## [13] grid_4.5.1         evaluate_1.0.5     tibble_3.3.0       lifecycle_1.0.4
## [17] compiler_4.5.1     dplyr_1.1.4        RColorBrewer_1.1-3 Rcpp_1.1.0
## [21] pkgconfig_2.0.3    farver_2.1.2       R6_2.6.1           dichromat_2.0-0.1
## [25] tidyselect_1.2.1   pillar_1.11.1      magrittr_2.0.4     withr_3.0.2
## [29] tools_4.5.1        gtable_0.3.6       matrixStats_1.5.0  ggplot2_4.0.0
```