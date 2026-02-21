# HIBAG – an R Package for HLA Genotype Imputation with Attribute Bagging

#### Dr. Xiuwen Zheng

#### May 3, 2018

* [Overview](#overview)
* [Features](#features)
* [Examples](#examples)
  + [Pre-fit HIBAG Models for HLA Imputation](#pre-fit-hibag-models-for-hla-imputation)
  + [Build a HIBAG Model for HLA Genotype Imputation](#build-a-hibag-model-for-hla-genotype-imputation)
  + [Build and Predict in Parallel](#build-and-predict-in-parallel)
  + [Evaluate Overall Accuracy, Sensitivity, Specificity, etc](#evaluate-overall-accuracy-sensitivity-specificity-etc)
    - [Evaluation in Figures](#evaluation-in-figures)
    - [Report in Text](#report-in-text)
    - [Report in Markdown](#report-in-markdown)
    - [Report in LaTeX](#report-in-latex)
  + [Release HIBAG Models without Confidential Information](#release-hibag-models-without-confidential-information)
  + [Release a Collection of HIBAG Models](#release-a-collection-of-hibag-models)
* [Resources](#resources)
* [Session Info](#session-info)
* [References](#references)

# Overview

The human leukocyte antigen (HLA) system, located in the major histocompatibility complex (MHC) on chromosome 6p21.3, is highly polymorphic. This region has been shown to be important in human disease, adverse drug reactions and organ transplantation (Shiina et al. 2009). HLA genes play a role in the immune system and autoimmunity as they are central to the presentation of antigens for recognition by T cells. Since they have to provide defense against a great diversity of environmental microbes, HLA genes must be able to present a wide range of peptides. Evolutionary pressure at these loci have given rise to a great deal of functional diversity. For example, the *HLA–B* locus has 1,898 four-digit alleles listed in the April 2012 release of the IMGT-HLA Database (Robinson et al. 2013) (<https://www.ebi.ac.uk/ipd/imgt/hla/>).

Classical HLA genotyping methodologies have been predominantly developed for tissue typing purposes, with sequence based typing (SBT) approaches currently considered the gold standard. While there is widespread availability of vendors offering HLA genotyping services, the complexities involved in performing this to the standard required for diagnostic purposes make using a SBT approach time-consuming and cost-prohibitive for most research studies wishing to look in detail at the involvement of classical HLA genes in disease.

Here we introduce a new prediction method for **H**LA **I**mputation using attribute **BAG**ging, HIBAG, that is highly accurate, computationally tractable, and can be used with published parameter estimates, eliminating the need to access large training samples (Zheng et al. 2014). It relies on a training set with known HLA and SNP genotypes, and combines the concepts of attribute bagging with haplotype inference from unphased SNPs and HLA types. Attribute bagging is a technique for improving the accuracy and stability of classifier ensembles using bootstrap aggregating and random variable selection (Breiman 1996, 2001; Bryll, Gutierrez-Osuna, and Quek 2003). In this case, individual classifiers are created which utilize a subset of SNPs to predict HLA types and haplotype frequencies estimated from a training data set of SNPs and HLA types. Each of the classifiers employs a variable selection algorithm with a random component to select a subset of the SNPs. HLA type predictions are determined by maximizing the average posterior probabilities from all classifiers.

# Features

* HIBAG can be used by researchers with published parameter estimates ( <https://hibag.s3.amazonaws.com/hlares_index.html>) instead of requiring access to large training sample datasets.
* A typical HIBAG parameter file contains only haplotype frequencies at different SNP subsets rather than individual training genotypes.
* SNPs within the xMHC region (chromosome 6) are used for imputation.
* HIBAG employs unphased genotypes of unrelated individuals as a training set.
* HIBAG supports parallel computing with R.

# Examples

```
library(HIBAG)
```

```
## HIBAG (HLA Genotype Imputation with Attribute Bagging)
```

```
## Kernel Version: v1.5 (64-bit, AVX512BW)
```

## Pre-fit HIBAG Models for HLA Imputation

```
# load the published parameter estimates from European ancestry
#   e.g., filename <- "HumanOmniExpressExome-European-HLA4-hg19.RData"
#   here, we use example data in the package
filename <- system.file("extdata", "ModelList.RData", package="HIBAG")
model.list <- get(load(filename))

# HLA imputation at HLA-A
hla.id <- "A"
model <- hlaModelFromObj(model.list[[hla.id]])
summary(model)
```

```
## Gene: HLA-A
## Training dataset: 60 samples X 266 SNPs
##     # of HLA alleles: 14
##     # of individual classifiers: 100
##     total # of SNPs used: 245
##     avg. # of SNPs in an individual classifier: 15.92
##         (sd: 2.43, min: 10, max: 24, median: 16.00)
##     avg. # of haplotypes in an individual classifier: 39.89
##         (sd: 14.28, min: 18, max: 87, median: 37.00)
##     avg. out-of-bag accuracy: 93.77%
##         (sd: 4.56%, min: 78.95%, max: 100.00%, median: 94.74%)
## Genome assembly: hg19
```

```
plot(model)    # show the frequency of SNP marker in the model
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the HIBAG package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was generated.
```

![](data:image/png;base64...)

```
# SNPs in the model
head(model$snp.id)
```

```
## [1] "rs2523442" "rs9257863" "rs2107191" "rs4713226" "rs2746150" "rs1233492"
```

```
head(model$snp.position)
```

```
## [1] 29417816 29425583 29434294 29434413 29442700 29458476
```

```
#########################################################################
# Import your PLINK BED file
#
yourgeno <- hlaBED2Geno(bed.fn=".bed", fam.fn=".fam", bim.fn=".bim")
summary(yourgeno)

# best-guess genotypes and all posterior probabilities
pred.guess <- hlaPredict(model, yourgeno, type="response+prob")
summary(pred.guess)

pred.guess$value
pred.guess$postprob
```

## Build a HIBAG Model for HLA Genotype Imputation

```
library(HIBAG)

# load HLA types and SNP genotypes in the package
data(HLA_Type_Table, package="HIBAG")
data(HapMap_CEU_Geno, package="HIBAG")

# a list of HLA genotypes
# e.g., train.HLA <- hlaAllele(sample.id, H1=c("01:02", "05:01", ...),
#                        H2=c("02:01", "03:01", ...), locus="A")
#     the HLA type of the first individual is 01:02/02:01,
#                 the second is 05:01/03:01, ...
hla.id <- "A"
train.HLA <- hlaAllele(HLA_Type_Table$sample.id,
    H1 = HLA_Type_Table[, paste(hla.id, ".1", sep="")],
    H2 = HLA_Type_Table[, paste(hla.id, ".2", sep="")],
    locus=hla.id, assembly="hg19")

# training genotypes
#   import your PLINK BED file,
#   e.g., train.geno <- hlaBED2Geno(bed.fn=".bed", fam.fn=".fam", bim.fn=".bim")
#   and select the SNPs in the flanking region of 500kb on each side
region <- 500    # kb
train.geno <- hlaGenoSubsetFlank(HapMap_CEU_Geno, hla.id, region*1000, assembly="hg19")
summary(train.geno)

# train a HIBAG model
set.seed(100)
model <- hlaAttrBagging(train.HLA, train.geno, nclassifier=100)
```

```
summary(model)
```

```
## Gene: HLA-A
## Training dataset: 60 samples X 266 SNPs
##     # of HLA alleles: 14
##     # of individual classifiers: 100
##     total # of SNPs used: 245
##     avg. # of SNPs in an individual classifier: 15.92
##         (sd: 2.43, min: 10, max: 24, median: 16.00)
##     avg. # of haplotypes in an individual classifier: 39.89
##         (sd: 14.28, min: 18, max: 87, median: 37.00)
##     avg. out-of-bag accuracy: 93.77%
##         (sd: 4.56%, min: 78.95%, max: 100.00%, median: 94.74%)
## Genome assembly: hg19
```

## Build and Predict in Parallel

```
library(HIBAG)
library(parallel)

# load HLA types and SNP genotypes in the package
data(HLA_Type_Table, package="HIBAG")
data(HapMap_CEU_Geno, package="HIBAG")

# a list of HLA genotypes
# e.g., train.HLA <- hlaAllele(sample.id, H1=c("01:02", "05:01", ...),
#                        H2=c("02:01", "03:01", ...), locus="A")
#     the HLA type of the first individual is 01:02/02:01,
#                 the second is 05:01/03:01, ...
hla.id <- "A"
train.HLA <- hlaAllele(HLA_Type_Table$sample.id,
    H1 = HLA_Type_Table[, paste(hla.id, ".1", sep="")],
    H2 = HLA_Type_Table[, paste(hla.id, ".2", sep="")],
    locus=hla.id, assembly="hg19")

# training genotypes
#   import your PLINK BED file,
#   e.g., train.geno <- hlaBED2Geno(bed.fn=".bed", fam.fn=".fam", bim.fn=".bim")
#   and select the SNPs in the flanking region of 500kb on each side
region <- 500    # kb
train.geno <- hlaGenoSubsetFlank(HapMap_CEU_Geno, hla.id, region*1000, assembly="hg19")
summary(train.geno)

# Multithreading
cl <- 2    # 2 -- # of threads

# Building ...
set.seed(1000)
hlaParallelAttrBagging(cl, train.HLA, train.geno, nclassifier=100,
    auto.save="AutoSaveModel.RData")
model.obj <- get(load("AutoSaveModel.RData"))
model <- hlaModelFromObj(model.obj)
summary(model)
```

```
# best-guess genotypes and all posterior probabilities
pred.guess <- hlaPredict(model, yourgeno, type="response+prob", cl=cl)
```

## Evaluate Overall Accuracy, Sensitivity, Specificity, etc

The function `hlaReport()` can be used to automatically generate a tex or HTML report when a validation dataset is available.

```
library(HIBAG)

# load HLA types and SNP genotypes in the package
data(HLA_Type_Table, package="HIBAG")
data(HapMap_CEU_Geno, package="HIBAG")

# make a list of HLA types
hla.id <- "A"
hla <- hlaAllele(HLA_Type_Table$sample.id,
    H1 = HLA_Type_Table[, paste(hla.id, ".1", sep="")],
    H2 = HLA_Type_Table[, paste(hla.id, ".2", sep="")],
    locus=hla.id, assembly="hg19")

# divide HLA types randomly
set.seed(100)
hlatab <- hlaSplitAllele(hla, train.prop=0.5)
names(hlatab)
```

```
## [1] "training"   "validation"
```

```
summary(hlatab$training)
```

```
## Gene: HLA-A
## Range: [29910247bp, 29913661bp] on hg19
## # of samples: 34
## # of unique HLA alleles: 14
## # of unique HLA genotypes: 23
```

```
summary(hlatab$validation)
```

```
## Gene: HLA-A
## Range: [29910247bp, 29913661bp] on hg19
## # of samples: 26
## # of unique HLA alleles: 12
## # of unique HLA genotypes: 14
```

```
# SNP predictors within the flanking region on each side
region <- 500   # kb
snpid <- hlaFlankingSNP(HapMap_CEU_Geno$snp.id,
    HapMap_CEU_Geno$snp.position, hla.id, region*1000, assembly="hg19")
length(snpid)
```

```
## [1] 275
```

```
# training and validation genotypes
train.geno <- hlaGenoSubset(HapMap_CEU_Geno,
    snp.sel = match(snpid, HapMap_CEU_Geno$snp.id),
    samp.sel = match(hlatab$training$value$sample.id,
        HapMap_CEU_Geno$sample.id))
summary(train.geno)
```

```
## SNP genotypes:
##     34 samples X 275 SNPs
##     SNPs range from 29417816bp to 30410205bp on hg19
## Missing rate per SNP:
##     min: 0, max: 0.0882353, mean: 0.0863102, median: 0.0882353, sd: 0.0124152
## Missing rate per sample:
##     min: 0, max: 0.974545, mean: 0.0863102, median: 0, sd: 0.280474
## Minor allele frequency:
##     min: 0, max: 0.5, mean: 0.218176, median: 0.193548, sd: 0.136552
## Allelic information:
## C/T A/G G/T A/C
## 125  97  32  21
```

```
test.geno <- hlaGenoSubset(HapMap_CEU_Geno, samp.sel=match(
    hlatab$validation$value$sample.id, HapMap_CEU_Geno$sample.id))
```

```
# train a HIBAG model
set.seed(100)
model <- hlaAttrBagging(hlatab$training, train.geno, nclassifier=100)
```

```
summary(model)
```

```
## Gene: HLA-A
## Training dataset: 34 samples X 266 SNPs
##     # of HLA alleles: 14
##     # of individual classifiers: 100
##     total # of SNPs used: 244
##     avg. # of SNPs in an individual classifier: 14.60
##         (sd: 2.76, min: 10, max: 21, median: 14.00)
##     avg. # of haplotypes in an individual classifier: 39.68
##         (sd: 16.31, min: 15, max: 84, median: 37.50)
##     avg. out-of-bag accuracy: 83.80%
##         (sd: 8.69%, min: 62.50%, max: 100.00%, median: 84.62%)
## Matching proportion:
##         Min.     0.1% Qu.       1% Qu.      1st Qu.       Median      3rd Qu.         Max.         Mean
## 0.0009366995 0.0009474879 0.0010445837 0.0054325672 0.0100158851 0.0158869387 0.4092814785 0.0388578948
##           SD
## 0.0926409732
## Genome assembly: hg19
```

```
# validation
pred <- hlaPredict(model, test.geno)
```

```
## HIBAG model for HLA-A:
##     100 individual classifiers
##     266 SNPs
##     14 unique HLA alleles: 01:01, 02:01, 02:06, ...
## Prediction:
##     based on the averaged posterior probabilities
## Model assembly: hg19, SNP assembly: hg19
## Matching the SNPs between the model and the test data:
##     match.type="--"   missing SNPs #
##            Position         0 (0.0%) *being used [1]
##          Pos+Allele         0 (0.0%)             [2]
##     RefSNP+Position         0 (0.0%)
##              RefSNP         0 (0.0%)
##       [1]: useful if ambiguous strands on array-based platforms
##       [2]: suggested if the model and test data have been matched to the same reference genome
##     Model platform: not applicable
## No allelic strand or A/B allele is flipped.
## # of samples: 26
## CPU flags: 64-bit, AVX512BW
## # of threads: 1
## Predicting (2025-10-30 00:26:06) 0%
## Predicting (2025-10-30 00:26:06) 100%
```

```
summary(pred)
```

```
## Gene: HLA-A
## Range: [29910247bp, 29913661bp] on hg19
## # of samples: 26
## # of unique HLA alleles: 12
## # of unique HLA genotypes: 14
## Posterior probability:
##   [0,0.25) [0.25,0.5) [0.5,0.75)   [0.75,1]
##   2 (7.7%)   2 (7.7%)   2 (7.7%) 20 (76.9%)
## Matching proportion of SNP haplotype:
##      Min.   1st Qu.    Median      Mean   3rd Qu.      Max.
## 0.0004095 0.0053788 0.0085626 0.0287638 0.0271491 0.4000244
## Dosages:
## $dosage - num [1:14, 1:26] 1.78e-02 1.30e-02 5.25e-02 9.42e-01 6.24e-07 ...
##  - attr(*, "dimnames")=List of 2
##   ..$ : chr [1:14] "01:01" "02:01" "02:06" "03:01" ...
##   ..$ : chr [1:26] "NA11881" "NA11992" "NA11994" "NA12249" ...
```

```
# compare
comp <- hlaCompareAllele(hlatab$validation, pred, allele.limit=model, call.threshold=0)
comp$overall
```

```
##   total.num.ind crt.num.ind crt.num.haplo   acc.ind acc.haplo call.threshold n.call call.rate
## 1            26          24            50 0.9230769 0.9615385              0     26         1
```

### Evaluation in Figures

The distance matrix is calculated based on the haplotype similarity carrying HLA alleles:

```
# hierarchical cluster analysis
d <- hlaDistance(model)
p <- hclust(as.dist(d))
plot(p, xlab="HLA alleles")
```

![](data:image/png;base64...)

```
# violin plot
hlaReportPlot(pred, model=model, fig="matching")
```

![](data:image/png;base64...) Matching proportion is a measure or proportion describing how the SNP profile matches the SNP haplotypes observed in the training set, i.e., the likelihood of SNP profile in a random-mating population consisting of training haplotypes. It is not directly related to confidence score, but a very low value of matching indicates that it is underrepresented in the training set.

```
hlaReportPlot(pred, hlatab$validation, fig="call.rate")
```

![](data:image/png;base64...)

```
hlaReportPlot(pred, hlatab$validation, fig="call.threshold")
```

![](data:image/png;base64...)

### Report in Text

Output to plain text format:

```
# report overall accuracy, per-allele sensitivity, specificity, etc
hlaReport(comp, type="txt")
```

```
## Allele   Num.    Freq.   Num.    Freq.   CR  ACC SEN SPE PPV NPV Miscall
##  Train   Train   Valid.  Valid.  (%) (%) (%) (%) (%) (%) (%)
## ----
## Overall accuracy: 96.2%, Call rate: 100.0%
## 01:01 14 0.2059 12 0.2308 100.0 98.1 100.0 97.5 92.3 100.0 --
## 02:01 23 0.3382 22 0.4231 100.0 98.1 95.5 100.0 100.0 96.8 29:02 (100)
## 02:06 1 0.0147 0 0 -- -- -- -- -- -- --
## 03:01 4 0.0588 5 0.0962 100.0 100.0 100.0 100.0 100.0 100.0 --
## 11:01 3 0.0441 2 0.0385 100.0 100.0 100.0 100.0 100.0 100.0 --
## 23:01 2 0.0294 2 0.0385 100.0 100.0 100.0 100.0 100.0 100.0 --
## 24:02 6 0.0882 3 0.0577 100.0 98.1 66.7 100.0 100.0 98.0 01:01 (100)
## 24:03 1 0.0147 0 0 -- -- -- -- -- -- --
## 25:01 3 0.0441 1 0.0192 100.0 100.0 100.0 100.0 100.0 100.0 --
## 26:01 2 0.0294 1 0.0192 100.0 100.0 100.0 100.0 100.0 100.0 --
## 29:02 3 0.0441 1 0.0192 100.0 98.1 100.0 98.0 50.0 100.0 --
## 31:01 2 0.0294 1 0.0192 100.0 100.0 100.0 100.0 100.0 100.0 --
## 32:01 2 0.0294 1 0.0192 100.0 100.0 100.0 100.0 100.0 100.0 --
## 68:01 2 0.0294 1 0.0192 100.0 100.0 100.0 100.0 100.0 100.0 --
```

### Report in Markdown

Output to a markdown file:

```
# report overall accuracy, per-allele sensitivity, specificity, etc
hlaReport(comp, type="markdown")
```

**Overall accuracy: 96.2%, Call rate: 100.0%**

| Allele | # Train | Freq. Train | # Valid. | Freq. Valid. | CR (%) | ACC (%) | SEN (%) | SPE (%) | PPV (%) | NPV (%) | Miscall (%) |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 01:01 | 14 | 0.2059 | 12 | 0.2308 | 100.0 | 98.1 | 100.0 | 97.5 | 92.3 | 100.0 | – |
| 02:01 | 23 | 0.3382 | 22 | 0.4231 | 100.0 | 98.1 | 95.5 | 100.0 | 100.0 | 96.8 | 29:02 (100) |
| 02:06 | 1 | 0.0147 | 0 | 0 | – | – | – | – | – | – | – |
| 03:01 | 4 | 0.0588 | 5 | 0.0962 | 100.0 | 100.0 | 100.0 | 100.0 | 100.0 | 100.0 | – |
| 11:01 | 3 | 0.0441 | 2 | 0.0385 | 100.0 | 100.0 | 100.0 | 100.0 | 100.0 | 100.0 | – |
| 23:01 | 2 | 0.0294 | 2 | 0.0385 | 100.0 | 100.0 | 100.0 | 100.0 | 100.0 | 100.0 | – |
| 24:02 | 6 | 0.0882 | 3 | 0.0577 | 100.0 | 98.1 | 66.7 | 100.0 | 100.0 | 98.0 | 01:01 (100) |
| 24:03 | 1 | 0.0147 | 0 | 0 | – | – | – | – | – | – | – |
| 25:01 | 3 | 0.0441 | 1 | 0.0192 | 100.0 | 100.0 | 100.0 | 100.0 | 100.0 | 100.0 | – |
| 26:01 | 2 | 0.0294 | 1 | 0.0192 | 100.0 | 100.0 | 100.0 | 100.0 | 100.0 | 100.0 | – |
| 29:02 | 3 | 0.0441 | 1 | 0.0192 | 100.0 | 98.1 | 100.0 | 98.0 | 50.0 | 100.0 | – |
| 31:01 | 2 | 0.0294 | 1 | 0.0192 | 100.0 | 100.0 | 100.0 | 100.0 | 100.0 | 100.0 | – |
| 32:01 | 2 | 0.0294 | 1 | 0.0192 | 100.0 | 100.0 | 100.0 | 100.0 | 100.0 | 100.0 | – |
| 68:01 | 2 | 0.0294 | 1 | 0.0192 | 100.0 | 100.0 | 100.0 | 100.0 | 100.0 | 100.0 | – |

### Report in LaTeX

Output to a tex file, and please add `\usepackage{longtable}` to your tex file:

```
# report overall accuracy, per-allele sensitivity, specificity, etc
hlaReport(comp, type="tex", header=FALSE)
```

```
## % -------- BEGIN TABLE --------
## \begin{longtable}{rrrrr | rrrrrrl}
## \caption{The sensitivity (SEN), specificity (SPE), positive predictive value (PPV), negative predictive value (NPV) and call rate (CR).}
## \label{tab:accuracy} \\
## Allele & Num. & Freq. & Num. & Freq. & CR & ACC & SEN & SPE & PPV & NPV & Miscall \\
##  & Train & Train & Valid. & Valid. & (\%) & (\%) & (\%) & (\%) & (\%) & (\%) & (\%) \\
## \hline\hline
## \endfirsthead
## \multicolumn{12}{c}{{\normalsize \tablename\ \thetable{} -- Continued from previous page}} \\
## Allele & Num. & Freq. & Num. & Freq. & CR & ACC & SEN & SPE & PPV & NPV & Miscall \\
##  & Train & Train & Valid. & Valid. & (\%) & (\%) & (\%) & (\%) & (\%) & (\%) & (\%) \\
## \hline\hline
## \endhead
## \hline
## \multicolumn{12}{r}{Continued on next page ...} \\
## \hline
## \endfoot
## \hline\hline
## \endlastfoot
## \multicolumn{12}{l}{\it Overall accuracy: 96.2\%, Call rate: 100.0\%} \\
## 01:01 & 14 & 0.2059 & 12 & 0.2308 & 100.0 & 98.1 & 100.0 & 97.5 & 92.3 & 100.0 & -- \\
## 02:01 & 23 & 0.3382 & 22 & 0.4231 & 100.0 & 98.1 & 95.5 & 100.0 & 100.0 & 96.8 & 29:02 (100) \\
## 02:06 & 1 & 0.0147 & 0 & 0 & -- & -- & -- & -- & -- & -- & -- \\
## 03:01 & 4 & 0.0588 & 5 & 0.0962 & 100.0 & 100.0 & 100.0 & 100.0 & 100.0 & 100.0 & -- \\
## 11:01 & 3 & 0.0441 & 2 & 0.0385 & 100.0 & 100.0 & 100.0 & 100.0 & 100.0 & 100.0 & -- \\
## 23:01 & 2 & 0.0294 & 2 & 0.0385 & 100.0 & 100.0 & 100.0 & 100.0 & 100.0 & 100.0 & -- \\
## 24:02 & 6 & 0.0882 & 3 & 0.0577 & 100.0 & 98.1 & 66.7 & 100.0 & 100.0 & 98.0 & 01:01 (100) \\
## 24:03 & 1 & 0.0147 & 0 & 0 & -- & -- & -- & -- & -- & -- & -- \\
## 25:01 & 3 & 0.0441 & 1 & 0.0192 & 100.0 & 100.0 & 100.0 & 100.0 & 100.0 & 100.0 & -- \\
## 26:01 & 2 & 0.0294 & 1 & 0.0192 & 100.0 & 100.0 & 100.0 & 100.0 & 100.0 & 100.0 & -- \\
## 29:02 & 3 & 0.0441 & 1 & 0.0192 & 100.0 & 98.1 & 100.0 & 98.0 & 50.0 & 100.0 & -- \\
## 31:01 & 2 & 0.0294 & 1 & 0.0192 & 100.0 & 100.0 & 100.0 & 100.0 & 100.0 & 100.0 & -- \\
## 32:01 & 2 & 0.0294 & 1 & 0.0192 & 100.0 & 100.0 & 100.0 & 100.0 & 100.0 & 100.0 & -- \\
## 68:01 & 2 & 0.0294 & 1 & 0.0192 & 100.0 & 100.0 & 100.0 & 100.0 & 100.0 & 100.0 & -- \\
## \end{longtable}
## % -------- END TABLE --------
```

## Release HIBAG Models without Confidential Information

```
library(HIBAG)

# make a list of HLA types
hla.id <- "DQA1"
hla <- hlaAllele(HLA_Type_Table$sample.id,
    H1 = HLA_Type_Table[, paste(hla.id, ".1", sep="")],
    H2 = HLA_Type_Table[, paste(hla.id, ".2", sep="")],
    locus = hla.id, assembly = "hg19")

# training genotypes
region <- 500   # kb
snpid <- hlaFlankingSNP(HapMap_CEU_Geno$snp.id, HapMap_CEU_Geno$snp.position,
    hla.id, region*1000, assembly="hg19")
train.geno <- hlaGenoSubset(HapMap_CEU_Geno,
    snp.sel = match(snpid, HapMap_CEU_Geno$snp.id),
    samp.sel = match(hla$value$sample.id, HapMap_CEU_Geno$sample.id))

set.seed(1000)
model <- hlaAttrBagging(hla, train.geno, nclassifier=100)
summary(model)

# remove unused SNPs and sample IDs from the model
mobj <- hlaPublish(model,
    platform = "Illumina 1M Duo",
    information = "Training set -- HapMap Phase II",
    warning = NULL,
    rm.unused.snp=TRUE, anonymize=TRUE)

save(mobj, file="Your_HIBAG_Model.RData")
```

## Release a Collection of HIBAG Models

```
# assume the HIBAG models are stored in R objects: mobj.A, mobj.B, ...

ModelList <- list()
ModelList[["A"]] <- mobj.A
ModelList[["B"]] <- mobj.B
...

# save to an R data file
save(ModelList, file="HIBAG_Model_List.RData")
```

# Resources

* Allele Frequency Net Database (AFND): <http://www.allelefrequencies.net>.
* IMGT/HLA Database: <https://www.ebi.ac.uk/ipd/imgt/hla/>.
* HLA Nomenclature: [G Codes](http://hla.alleles.org/alleles/g_groups.html) and [P Codes](http://hla.alleles.org/alleles/p_groups.html) for reporting of ambiguous allele typings.

# Session Info

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
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB
##  [4] LC_COLLATE=C               LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C
## [10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] HIBAG_1.46.0
##
## loaded via a namespace (and not attached):
##  [1] crayon_1.5.3          vctrs_0.6.5           cli_3.6.5             knitr_1.50
##  [5] rlang_1.1.6           xfun_0.53             generics_0.1.4        S7_0.2.0
##  [9] jsonlite_2.0.0        labeling_0.4.3        RcppParallel_5.1.11-1 glue_1.8.0
## [13] htmltools_0.5.8.1     sass_0.4.10           scales_1.4.0          rmarkdown_2.30
## [17] grid_4.5.1            tibble_3.3.0          evaluate_1.0.5        jquerylib_0.1.4
## [21] fastmap_1.2.0         yaml_2.3.10           lifecycle_1.0.4       compiler_4.5.1
## [25] dplyr_1.1.4           RColorBrewer_1.1-3    pkgconfig_2.0.3       farver_2.1.2
## [29] digest_0.6.37         R6_2.6.1              tidyselect_1.2.1      dichromat_2.0-0.1
## [33] pillar_1.11.1         magrittr_2.0.4        bslib_0.9.0           withr_3.0.2
## [37] tools_4.5.1           gtable_0.3.6          ggplot2_4.0.0         cachem_1.1.0
```

# References

Breiman, Leo. 1996. “Bagging Predictors.” *Mach. Learn.* 24 (2): 123–40. [https://doi.org/10.1023/A:1018054314350](https://doi.org/10.1023/A%3A1018054314350).

———. 2001. “Random Forests.” *Mach. Learn.* 45 (1): 5–32. [https://doi.org/10.1023/A:1010933404324](https://doi.org/10.1023/A%3A1010933404324).

Bryll, Robert, Ricardo Gutierrez-Osuna, and Francis Quek. 2003. “Attribute Bagging: Improving Accuracy of Classifier Ensembles by Using Random Feature Subsets.” *Pattern Recognition* 36 (6): 1291–1302. [https://doi.org/10.1016/S0031-3203(02)00121-8](https://doi.org/10.1016/S0031-3203%2802%2900121-8).

Robinson, James, Jason A. Halliwell, Hamish McWilliam, Rodrigo Lopez, Peter Parham, and Steven G. E. Marsh. 2013. “The IMGT/HLA Database.” *Nucleic Acids Res* 41 (Database issue): 1222–7. <https://doi.org/10.1093/nar/gks949>.

Shiina, Takashi, Kazuyoshi Hosomichi, Hidetoshi Inoko, and Jerzy Kulski. 2009. “The HLA Genomic Loci Map: Expression, Interaction, Diversity and Disease.” *Journal of Human Genetics* 54 (1): 15–39. <https://doi.org/10.1038/jhg.2008.5>.

Zheng, Xiuwen, Judong Shen, Charles Cox, Jonathan C. Wakefield, Margaret G. Ehm, Matthew R. Nelson, and Bruce S. Weir. 2014. “HIBAG – HLA Genotype Imputation with Attribute Bagging.” *Pharmacogenomics J*. <https://doi.org/10.1038/tpj.2013.18>.