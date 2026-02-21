# Main vignette: Aberrant expression and splicing analysis

Alexandre Segers, Jeroen Gilis, Mattias Van Heetvelde, Elfride De Baere and Lieven Clement

#### 23/08/2023

#### Abstract

Main vignette for the saseR package. This vignette aims to provide a detailed
description of an aberrant expression and splicing analysis using saseR.
Also, we show how to perform differential usage analysis using adapted
offsets in DESeq2 and edgeR.

#### Package

saseR 1.6.0

# Contents

* [1 Introduction](#introduction)
* [2 Aberrant expression and splicing workflow](#aberrant-expression-and-splicing-workflow)
  + [2.1 Package installation](#package-installation)
  + [2.2 Load libraries](#load-libraries)
  + [2.3 Transforming BAM to count matrices.](#transforming-bam-to-count-matrices.)
  + [2.4 Aberrant expression analysis](#aberrant-expression-analysis)
  + [2.5 Aberrant splicing analysis](#aberrant-splicing-analysis)
* [3 Differential usage/splicing using adapted offsets in DESeq2 and edgeR](#differential-usagesplicing-using-adapted-offsets-in-deseq2-and-edger)
  + [3.1 Load libraries](#load-libraries-1)
  + [3.2 Load example data](#load-example-data)
* [4 Session info](#session-info)
* [References](#references)

# 1 Introduction

`saseR` is a R package to perform aberrant expression and splicing analyses
in bulk RNA-seq datasets. It uses adapted offsets to model aberrant splicing
with the negative binomial framework, and estimates the parameters on a
scalable and efficient manner. In this vignette, we first show how the
different functions of the `saseR` package can be used, after which we show
how to perform `differential usage` analysis with adapted offsets in
conventional bulk RNA-seq methods DESeq2 and edgeR.

All details about the `saseR` model, statistical tests, the use of adapted
offsets to model proportions and the adapted parameter estimation are
described in our preprint (Segers et al. [2023](#ref-Segers2023)).

In this vignette, we analyse the data from the `ASpli` package (Mancini et al. [2021](#ref-ASpli)),
to show how a workflow for aberrant expression and splicing is done.
However, we note that this dataset is not specific for aberrant expression or
splicing analyses. The data consists of BAM-files which will be converted into
gene, bin,and junction reads, on which three different `saseR` analysis will
be performed (aberrant expression and two times an aberrant splicing
analysis). Next, we show how a differential usage/splicing analysis can be
done using DESeq2 (Love, Huber, and Anders [2014](#ref-Love)) and edgeR (Robinson, McCarthy, and Smyth [2009](#ref-Robinson)) with adapted offsets.

# 2 Aberrant expression and splicing workflow

The package has two different categories of functions,
with respectively two and three functions.

First, BAM-files need to be transformed to gene, bin or junctions counts. This
is done by:

1. `BamtoAspliCounts`, which transforms BAM-files to different counts using
   adapted functions of the `ASpli` package. The different counts are given in
   a `SummarizedExperiment` object in the metadata slots.
2. `convertAspli` selects the relevant counts (gene, bins or junctions) to
   be further used in the analyses.

Then, the chosen counts can be further used to perform an aberrant expression
or splicing analysis with the following functions:

3. `calculateOffsets`, which calculates the offset matrix used in the analysis.
   These offsets can be ordinary `edgeR` or `DESeq2` offsets when performing an
   aberrant expression analysis, or can be the total bin or junction counts
   aggregated per gene when performing an aberrant splicing analysis.
4. `saseRfindEncodingDim` estimates the optimal number of latent factors to
   control for unknown confounders. This number of latent factors is then further
   used in the final fit.
5. `saseRfit` calculates the mean expression and feature-specific dispersions
   for each feature in each sample, controlling for both known and unknown
   confounders. It calculates p-values which represent how extreme each
   observation is compared to its estimated distribution.

Note that one can do a saseR analysis by using readily available count
matrices, therefore not requiring to start from BAM-files.

## 2.1 Package installation

`saseR` can be installed from Bioconductor with:

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("saseR")
```

Alternatively, the development version of `saseR` can be downloaded with:

```
library(devtools)
devtools::install_github("statOmics/saseR")
```

## 2.2 Load libraries

```
library(saseR)
suppressWarnings(library(ASpli))
library(edgeR)
library(DESeq2)
library(limma)
library(GenomicFeatures)
library(dplyr)
library(PRROC)
library(BiocParallel)
library(data.table)
library(igraph)
library(txdbmaker)
```

## 2.3 Transforming BAM to count matrices.

The following data corresponds to the vignette data from the `ASpli`
package (Mancini et al. [2021](#ref-ASpli)).

The input data required for saseR are BAM-files with corresponding BAI files
and a genome annotation in TxDb format. These BAM-files will be transformed to
gene/bin/junction count matrices. When a count matrix is readily available,
one can just use this to perform an aberrant expression or splicing analysis
(see section 5 and 6) .

First, we specify the path to our GTF file, which we will later transform to
the TxDb format. Also, we include the pathnames of the BAM-files we want to
include in the analysis.

```
gtfFileName <- ASpli::aspliExampleGTF()
BAMFiles <- ASpli::aspliExampleBamList()

gtfFileName
```

```
## [1] "/home/biocbuild/bbs-3.22-bioc/R/site-library/ASpli/extdata/genes.mini.gtf"
```

```
head(BAMFiles)
```

```
## [1] "/home/biocbuild/bbs-3.22-bioc/R/site-library/ASpli/extdata/A_C_0.bam"
## [2] "/home/biocbuild/bbs-3.22-bioc/R/site-library/ASpli/extdata/A_C_1.bam"
## [3] "/home/biocbuild/bbs-3.22-bioc/R/site-library/ASpli/extdata/A_C_2.bam"
## [4] "/home/biocbuild/bbs-3.22-bioc/R/site-library/ASpli/extdata/A_D_0.bam"
## [5] "/home/biocbuild/bbs-3.22-bioc/R/site-library/ASpli/extdata/A_D_1.bam"
## [6] "/home/biocbuild/bbs-3.22-bioc/R/site-library/ASpli/extdata/A_D_2.bam"
```

Then, we define a targets dataframe, which contains the sample names, BAM-file
pathsand experimental factors column. For the case of rare Mendelian disorders
and outlier detection, we choose
these experimental factors to be all equal to A. Note that the experimental
factors included here will not further be used in the final analysis, but are
needed to compute the count matrices with functions from `ASpli`.

```
targets <- data.frame(
  row.names = paste0('Sample',c(1:12)),
  bam = BAMFiles,
  f1 = rep("A",12),
  stringsAsFactors = FALSE)

head(targets)
```

```
##                                                                          bam f1
## Sample1 /home/biocbuild/bbs-3.22-bioc/R/site-library/ASpli/extdata/A_C_0.bam  A
## Sample2 /home/biocbuild/bbs-3.22-bioc/R/site-library/ASpli/extdata/A_C_1.bam  A
## Sample3 /home/biocbuild/bbs-3.22-bioc/R/site-library/ASpli/extdata/A_C_2.bam  A
## Sample4 /home/biocbuild/bbs-3.22-bioc/R/site-library/ASpli/extdata/A_D_0.bam  A
## Sample5 /home/biocbuild/bbs-3.22-bioc/R/site-library/ASpli/extdata/A_D_1.bam  A
## Sample6 /home/biocbuild/bbs-3.22-bioc/R/site-library/ASpli/extdata/A_D_2.bam  A
```

Next, we transform our GTF file to TxDb format, and extract the features from
the annotation using the `binGenome` function from `saseR`, which is an adapted copy from `ASpli` as this function is deprecated. Note that the
binGenome function can take a while.

```
genomeTxDb <- txdbmaker::makeTxDbFromGFF(gtfFileName)
```

```
## Import genomic features from the file as a GRanges object ... OK
## Prepare the 'metadata' data frame ... OK
## Make the TxDb object ...
```

```
## Warning in .makeTxDb_normarg_chrominfo(chrominfo): genome version information
## is not available for this TxDb object
```

```
## OK
```

```
features <- binGenome(genomeTxDb, logTo = NULL)
```

```
## * Number of extracted Genes = 10
```

```
## * Number of extracted Genes = 10
```

```
## * Number of extracted Exon Bins = 38
```

```
## * Number of extracted Exon Bins = 38
```

```
## * Number of extracted intron bins = 34
```

```
## * Number of extracted intron bins = 34
```

```
## * Number of extracted trascripts = 25
```

```
## * Number of extracted trascripts = 25
```

```
## * Number of extracted junctions = 23
```

```
## * Number of extracted junctions = 23
```

```
## * Number of AS bins (not include external) = 17
## * Number of AS bins (include external) = 17
## * Classified as:
##  ES bins = 1 (6%)
##  IR bins = 3 (18%)
##  Alt5'ss bins = 2    (12%)
##  Alt3'ss bins = 2    (12%)
##  Multiple AS bins = 9    (53%)
##  classified as:
##          ES bins = 1 (11%)
##          IR bins = 4 (44%)
##          Alt5'ss bins = 2    (22%)
##          Alt3'ss bins = 1    (11%)
```

```
## * Number of AS bins (not include external) = 17
## * Number of AS bins (include external) = 17
## * Classified as:
##  ES bins = 1 (6%)
##  IR bins = 3 (18%)
##  Alt5'ss bins = 2    (12%)
##  Alt3'ss bins = 2    (12%)
##  Multiple AS bins = 9    (53%)
##  classified as:
##          ES bins = 1 (11%)
##          IR bins = 4 (44%)
##          Alt5'ss bins = 2    (22%)
##          Alt3'ss bins = 1    (11%)
```

```
## Correcting Io ends, this might take a while...
## Genome binning completed
```

Now that we have the `targets` data.frame containing the samples and BAM-file
names, and the `features` extracted from the genome annotation, we can obtain
the count matrices that will be used to detect aberrant expression. This can
done with `BamtoAspliCounts`. Note that the counting procedure (featurecounts)
can take a while. If only one type of analysis is preferred (e.g. only aberrant
expression analysis on the gene counts), one can do the feature counting with a
different method, and start from a count matrix at section
5 and 6. Make sure to
select the right type of `libType` (`SE` for single-end reads, `PE` for
paired-end reads), and the `minReadLength`, which is the minimal number of
bases a read needs to be counted.

```
ASpliSE <- BamtoAspliCounts(
                    features = features,
                    targets = targets,
                    minReadLength = 100,
                    libType = "SE",
                    BPPARAM = MulticoreParam(1L)
                    )
```

```
## Junctions PJU completed
```

```
## Junctions PIR completed
```

```
## Junctions IR PIR completed
```

```
## Junctions AltSS PSI completed
```

```
## Junctions ES PSI completed
```

ASpliSE is a SummarizedExperiment object that contains the gene, bin and
junction counts, together with different annotations in the metadata slots. We
will extract these counts using the `convertASpli` function.

```
SEgenes <- convertASpli(ASpliSE, type = "gene")
SEbins <- convertASpli(ASpliSE, type = "bin")
SEjunctions <- convertASpli(ASpliSE, type = "junction")
```

## 2.4 Aberrant expression analysis

We will show how to perform an aberrant expression analysis based on the gene
level counts. Note that other feature counts (e.g. bin counts) can also be used
to search for aberrant expression. We start from a SummarizedExperiment that
contains the feature counts of interest.

First, a design formula is included in the metadata slot `design`. In this
example, we do not include known covariates, but only introduce an intercept.
If one includes known covariates in the formula, these covariates should be
included in the colData slot.

```
metadata(SEgenes)$design <- ~1
```

For an aberrant expression analysis, we first retain only the genes that have
sufficiently large counts.
Then, we need to calculate the offsets for our analysis. For aberrant
expression analysis, we recommend using `TMM` or `geommean` for edgeR and
DESeq2 normalisation respectively. This results in an offsets matrix in the
assays slot.

Note that for aberrant splicing detection, first offsets are calculated before
filtering features that have low counts.

```
filtergenes <- filterByExpr(SEgenes)
```

```
## Warning in filterByExpr.DGEList(y, design = design, group = group, lib.size =
## lib.size, : All samples appear to belong to the same group.
```

```
SEgenes <- SEgenes[filtergenes,]
```

```
SEgenes <- calculateOffsets(SEgenes, method = "TMM")
```

Having defined the `design` and the `offsets` of the analysis, we can continue
to estimate the optimal `number of latent confounders` included in the
regression framework. This is often needed when performing aberrant expression
or splicing analysis to improve power. We obtain the latent factors by using
`RUV` (Risso et al. [2014](#ref-RUV)), which performs a
`singular value decomposition on the deviance residuals`. Then,
we recommend using the Gavish and Donoho (Gavish and Donoho [2014](#ref-GavishDonoho)) threshold for singular
values (`method = GD`) to choose upon the number of latent factors included in
the final regression model. This is much faster, while having similar
performance compared to using a denoising autoencoder (`method = DAE`).

```
SEgenes <- saseRfindEncodingDim(SEgenes, method = "GD")
```

Having estimated the optimal number of latent factors to include in the
regression framework, we can fit our final model, controlling for both known
confounders (specified in metadata slot `design`) and the latent factors
based on the deviance residuals. The final regression fit can be done with
edgeR (`fit = edgeR`), but is set to default to our fast parameter estimation
(`fit = fast`). This fast parameter estimation uses a overdispersed quadratic
mean-variance relationship, which enables matrix multiplication while keeping
parameter estimation unbiased. This is often required in the context of rare
diseases that need many latent factors to control for, which leads to ordinary
fitting procedures such as DESeq2 and edgeR becoming slow. If the number of
confounders included in the regression model is small (known confounders +
latent factors), edgeR parameter estimation could be used, although it is not
expected to give an increase in performance. `analysis` is specified to `AE`
to choose an aberrant expression analysis.

```
SEgenes <- saseRfit(SEgenes,
                    analysis = "AE",
                    padjust = "BH",
                    fit = "fast")
```

This results in estimates in mean expression, feature specific dispersions
and p-values calculated for each observation in each sample. Further analysing
the top prioritised genes within each sample is possible using for example:

```
order <- apply(assays(SEgenes)$pValue, 2, order, decreasing = FALSE)

topPvalsGenes <- sapply(1:ncol(SEgenes),
                   function(x) {assays(SEgenes)$pValue[order[1:5,x],x]})
rownames(topPvalsGenes) <- NULL

topGenes <- sapply(1:ncol(SEgenes),
                   function(x) {rownames(SEgenes)[order[1:5,x]]})

significantgenes <- sapply(1:ncol(SEgenes),
              function(x) {
                  rownames(SEgenes)[assays(SEgenes)$pValueAdjust[,x] < 0.05]})

head(topPvalsGenes)
```

```
##            [,1]      [,2]      [,3]      [,4]      [,5]       [,6]      [,7]
## [1,] 0.03102749 0.1159464 0.3990040 0.1286522 0.2695281 0.04821107 0.1310854
## [2,] 0.17011462 0.1335962 0.4043607 0.4014844 0.2751492 0.36674082 0.3675906
## [3,] 0.31623422 0.2436769 0.5734204 0.4410169 0.7156347 0.70575353 0.4863269
## [4,] 0.37490428 0.3439380 0.7622561 0.4970871 0.7222973 0.70865388 0.5156083
## [5,] 0.39977621 0.5405994 0.8160304 0.5674733 0.7552254 0.75059475 0.6228496
##           [,8]      [,9]     [,10]      [,11]     [,12]
## [1,] 0.1115451 0.1421563 0.2208241 0.09214189 0.2371822
## [2,] 0.2951036 0.2621759 0.3283615 0.23906661 0.2664025
## [3,] 0.5051797 0.2869709 0.4140313 0.29306342 0.4882280
## [4,] 0.5307402 0.3739860 0.4719410 0.55818088 0.6595572
## [5,] 0.5677993 0.3777315 0.5070343 0.65837916 0.6978440
```

```
head(topGenes)
```

```
##      [,1]     [,2]     [,3]     [,4]     [,5]     [,6]     [,7]     [,8]
## [1,] "GENE07" "GENE09" "GENE04" "GENE09" "GENE03" "GENE09" "GENE05" "GENE05"
## [2,] "GENE05" "GENE05" "GENE07" "GENE01" "GENE05" "GENE01" "GENE02" "GENE07"
## [3,] "GENE10" "GENE07" "GENE09" "GENE05" "GENE06" "GENE08" "GENE06" "GENE02"
## [4,] "GENE04" "GENE01" "GENE02" "GENE03" "GENE09" "GENE03" "GENE08" "GENE04"
## [5,] "GENE09" "GENE03" "GENE10" "GENE08" "GENE04" "GENE10" "GENE07" "GENE03"
##      [,9]     [,10]    [,11]    [,12]
## [1,] "GENE07" "GENE02" "GENE05" "GENE10"
## [2,] "GENE06" "GENE10" "GENE02" "GENE05"
## [3,] "GENE04" "GENE07" "GENE08" "GENE07"
## [4,] "GENE08" "GENE04" "GENE09" "GENE01"
## [5,] "GENE09" "GENE08" "GENE03" "GENE03"
```

```
head(significantgenes)
```

```
## [[1]]
## character(0)
##
## [[2]]
## character(0)
##
## [[3]]
## character(0)
##
## [[4]]
## character(0)
##
## [[5]]
## character(0)
##
## [[6]]
## character(0)
```

## 2.5 Aberrant splicing analysis

We will show how to perform an aberrant splicing analysis based on the bin and
junction level counts. Note that other feature counts can also be used if
proportions of interest are to be modelled, which only requires the use of the
correct offsets. We start from a SummarizedExperiment that contains the
feature counts of interest.

First, a design formula is included in the metadata slot `design`. In this
example, we do not include known covariates, but only introduce an intercept.
If one includes known covariates in the formula, these covariates should be
included in the colData slot.

```
metadata(SEbins)$design <- ~1
metadata(SEjunctions)$design <- ~1
```

Then, we need to calculate the offsets for our analysis. For an aberrant
splicing analysis, `AS` or `proportion` should be used as method to calculate
offsets that allow to model proportions. This results in an offsets matrix in
the assays slot. We specificy the column in the rowData slot which is used
to aggregate feature counts to obtain proper offsets (`aggregation`). This is
the `locus` column for the bins analysis, and the `symbol` or `ASpliCluster`
column for a junctions analysis. For the junctions analysis, it is also
possible to use aggregation based on `symbol` (= gene) whenever an annotated
gene is available, and switch to `ASpliCluster` when the junction is not linked
to a specific gene. This is done by setting `mergeGeneASpli` equal to TRUE.
Note that a new column in the rowData will be made, `locus`, which specifies
the used aggregation.

Note that also other rowData columns can be used to aggregate feature counts,
and also a predefined offsets matrix can be included as `offsets` in the
assays slot.

```
SEbins <- calculateOffsets(SEbins,
                            method = "AS",
                            aggregation = "locus")
```

```
## Using locus column in rowData to calculate offsets.
```

```
## 0 features filtered due to NA, '-', or 'noHit' locus.
```

```
SEjunctions <- calculateOffsets(SEjunctions,
                            method = "AS",
                            aggregation = "symbol",
                            mergeGeneASpli = TRUE)
```

```
## Using symbol column in rowData to calculate offsets.
## 0 features filtered due to NA, '-', or 'noHit' locus.
```

Then, after calculating the offsets for the aberrant splicing analysis, we
filter the features that have very low counts. Note that for aberrant
expression analyses, first the features are filtered, followed by calculating
the offsets.

```
filterbins <- filterByExpr(SEbins)
```

```
## Warning in filterByExpr.DGEList(y, design = design, group = group, lib.size =
## lib.size, : All samples appear to belong to the same group.
```

```
SEbins <- SEbins[filterbins,]

filterjunctions <- filterByExpr(SEjunctions)
```

```
## Warning in filterByExpr.DGEList(y, design = design, group = group, lib.size =
## lib.size, : All samples appear to belong to the same group.
```

```
SEjunctions <- SEjunctions[filterjunctions,]
```

Having defined the `design` and the `offsets` of the analysis, we can continue
to estimate the optimal `number of latent confounders` included in the
regression framework. This is often needed when performing aberrant expression
or splicing analysis to obtain better power. We obtain the latent factors by
using `RUV` (Risso et al. [2014](#ref-RUV)), which performs a
`singular value decomposition on the deviance residuals`. Then, we recommend
using the Gavish and Donoho (Gavish and Donoho [2014](#ref-GavishDonoho)) threshold for
singular values (`method = GD`) to choose upon the number of
latent factors included in the final regression model. This is much faster,
while having similar performance compared to using a denoising autoencoder
(`method = DAE`).

```
SEbins <- saseRfindEncodingDim(SEbins, method = "GD")
SEjunctions <- saseRfindEncodingDim(SEjunctions, method = "GD")
```

Having estimated the optimal number of latent factors to include in the
regression framework, we can fit our final model, controlling for both known
confounders (specified in metadata slot `design`) and the latent factors
based on the deviance residuals. The final regression fit can be done with
edgeR (`fit = edgeR`), but is set to default to our fast parameter estimation
(`fit = fast`). This fast parameter estimation uses a overdispersed quadratic
mean-variance relationship, which enables matrix multiplication while keeping
parameter estimation unbiased.This is often required in the context of rare
diseases that need many latent factors to control for, which leads to ordinary
fitting procedures such as edgeR becoming slow. If the number of confounders
included in the regression model is small (known confounders + latent factors),
edgeR parameter estimation could be used, although it is not expected to give
an increase in performance. `analysis` is specified on `AS` to choose an
aberrant splicing analysis.

```
SEbins <- saseRfit(SEbins,
                    analysis = "AS",
                    padjust = "BH",
                    fit = "fast")

SEjunctions <- saseRfit(SEjunctions,
                    analysis = "AS",
                    padjust = "BH",
                    fit = "fast")
```

This results in estimates in mean expression, feature specific dispersions
and p-values calculated for each observation in each sample. Further analysing
the top prioritised features within each sample is possible using for example:

```
order <- apply(assays(SEbins)$pValue, 2, order, decreasing = FALSE)

topPvalsBins <- sapply(1:ncol(SEbins),
                   function(x) {assays(SEbins)$pValue[order[1:5,x],x]})

rownames(topPvalsBins) <- NULL

topBins <- sapply(1:ncol(SEbins),
                   function(x) {rownames(SEbins)[order[1:5,x]]})

significantBins <- sapply(1:ncol(SEbins),
                   function(x) {
                    rownames(SEbins)[assays(SEgenes)$pValueAdjust[,x] < 0.05]})

head(topPvalsBins)
```

```
##           [,1]      [,2]      [,3]       [,4]       [,5]       [,6]      [,7]
## [1,] 0.2920730 0.2479812 0.1773876 0.03983227 0.03029549 0.07030136 0.2820690
## [2,] 0.3452435 0.2606600 0.3482568 0.12819629 0.20612234 0.09166173 0.3182864
## [3,] 0.4411531 0.2685777 0.3999498 0.13273306 0.28950883 0.27493653 0.3284258
## [4,] 0.4670477 0.3588860 0.4597824 0.16778278 0.29595504 0.28393816 0.4128227
## [5,] 0.5075236 0.4212592 0.4953552 0.18583522 0.31699366 0.28819200 0.4463418
##           [,8]       [,9]     [,10]     [,11]      [,12]
## [1,] 0.1505300 0.06543611 0.1561171 0.1020822 0.01881900
## [2,] 0.2690009 0.14449012 0.2302083 0.1439282 0.06356613
## [3,] 0.3026018 0.14901032 0.2543287 0.3428522 0.16000229
## [4,] 0.3408827 0.19215776 0.2752078 0.4655831 0.17319650
## [5,] 0.3827884 0.28273415 0.3054174 0.4674561 0.21068788
```

```
head(topBins)
```

```
##      [,1]          [,2]          [,3]          [,4]          [,5]
## [1,] "GENE08:E005" "GENE08:E005" "GENE08:E004" "GENE06:E004" "GENE08:E004"
## [2,] "GENE08:E004" "GENE08:E001" "GENE09:E004" "GENE03:E001" "GENE01:E002"
## [3,] "GENE01:E002" "GENE06:E004" "GENE08:E001" "GENE08:E004" "GENE01:E003"
## [4,] "GENE02:E002" "GENE03:E001" "GENE08:E003" "GENE09:E002" "GENE08:E002"
## [5,] "GENE05:E004" "GENE02:E002" "GENE07:E003" "GENE10:E004" "GENE03:E002"
##      [,6]          [,7]          [,8]          [,9]          [,10]
## [1,] "GENE03:E001" "GENE10:E003" "GENE08:E002" "GENE07:E002" "GENE02:E002"
## [2,] "GENE03:E002" "GENE02:E001" "GENE08:E004" "GENE07:E001" "GENE02:E003"
## [3,] "GENE06:E004" "GENE06:E002" "GENE10:E004" "GENE10:E001" "GENE06:E001"
## [4,] "GENE09:E003" "GENE06:E003" "GENE07:E002" "GENE08:E002" "GENE03:E002"
## [5,] "GENE09:E001" "GENE09:E005" "GENE10:E001" "GENE05:E004" "GENE06:E003"
##      [,11]         [,12]
## [1,] "GENE02:E002" "GENE02:E002"
## [2,] "GENE05:E002" "GENE03:E002"
## [3,] "GENE10:E001" "GENE05:E002"
## [4,] "GENE09:E001" "GENE02:E003"
## [5,] "GENE10:E003" "GENE06:E001"
```

```
head(significantBins)
```

```
## [[1]]
## character(0)
##
## [[2]]
## character(0)
##
## [[3]]
## character(0)
##
## [[4]]
## character(0)
##
## [[5]]
## character(0)
##
## [[6]]
## character(0)
```

Furthermore, also aggregated p-values are calculated based on the newly formed
`locus` column in the rowData slot. These are currently the minimal p-value
of each feature belonging to the same aggregation group, and can be found in
the metadata slot under `pValuesLocus`.

```
order <- apply(metadata(SEbins)$pValuesLocus, 2, order, decreasing = FALSE)

topPvalsBinsAggregated <- sapply(1:ncol(SEbins),
                   function(x) {metadata(SEbins)$pValuesLocus[order[1:5,x],x]})
rownames(topPvalsBinsAggregated) <- NULL

topBinsAggregated <- sapply(1:ncol(SEbins),
                   function(x) {
                     rownames(metadata(SEbins)$pValuesLocus)[order[1:5,x]]})

significantBinsAggregated <- sapply(1:ncol(SEbins),
              function(x) {
                  rownames(SEbins)[metadata(SEgenes)$pValuesLocus[,x] < 0.05]})

head(topPvalsBinsAggregated)
```

```
##           [,1]      [,2]      [,3]       [,4]       [,5]       [,6]      [,7]
## [1,] 0.2920730 0.2479812 0.1773876 0.03983227 0.03029549 0.07030136 0.2820690
## [2,] 0.4411531 0.2685777 0.3482568 0.12819629 0.20612234 0.27493653 0.3182864
## [3,] 0.4670477 0.3588860 0.4953552 0.13273306 0.31699366 0.28393816 0.3284258
## [4,] 0.5075236 0.4212592 0.5428406 0.16778278 0.32869031 0.39572189 0.4463418
## [5,] 0.5397520 0.4431609 0.5934711 0.18583522 0.34831266 0.47232361 0.4636188
##           [,8]       [,9]     [,10]     [,11]      [,12]
## [1,] 0.1505300 0.06543611 0.1561171 0.1020822 0.01881900
## [2,] 0.3026018 0.14901032 0.2543287 0.1439282 0.06356613
## [3,] 0.3408827 0.19215776 0.2752078 0.3428522 0.16000229
## [4,] 0.4037764 0.28273415 0.4817044 0.4655831 0.21068788
## [5,] 0.4178444 0.29755667 0.5166177 0.4705838 0.43419989
```

```
head(topBinsAggregated)
```

```
##      [,1]     [,2]     [,3]     [,4]     [,5]     [,6]     [,7]     [,8]
## [1,] "GENE08" "GENE08" "GENE08" "GENE06" "GENE08" "GENE03" "GENE10" "GENE08"
## [2,] "GENE01" "GENE06" "GENE09" "GENE03" "GENE01" "GENE06" "GENE02" "GENE10"
## [3,] "GENE02" "GENE03" "GENE07" "GENE08" "GENE03" "GENE09" "GENE06" "GENE07"
## [4,] "GENE05" "GENE02" "GENE10" "GENE09" "GENE10" "GENE08" "GENE09" "GENE02"
## [5,] "GENE09" "GENE01" "GENE02" "GENE10" "GENE06" "GENE02" "GENE04" "GENE01"
##      [,9]     [,10]    [,11]    [,12]
## [1,] "GENE07" "GENE02" "GENE02" "GENE02"
## [2,] "GENE10" "GENE06" "GENE05" "GENE03"
## [3,] "GENE08" "GENE03" "GENE10" "GENE05"
## [4,] "GENE05" "GENE05" "GENE09" "GENE06"
## [5,] "GENE06" "GENE08" "GENE08" "GENE08"
```

```
head(significantBinsAggregated)
```

```
## [[1]]
## character(0)
##
## [[2]]
## character(0)
##
## [[3]]
## character(0)
##
## [[4]]
## character(0)
##
## [[5]]
## character(0)
##
## [[6]]
## character(0)
```

# 3 Differential usage/splicing using adapted offsets in DESeq2 and edgeR

Here, we show how to perform a differential usage/splicing analysis, using
adapted offsets in conventual bulk RNA-seq tools DESeq2/edgeR. This way, we
avoid modelling both the counts and the other counts, which means that no
sample-specific regression coefficients are estimated. Note that these steps
are similar compared to a conventual DESeq2/edgeR analysis, where different
offsets or normalisation is used. We refer to the DESeq2/edgeR vignettes for
more information upon their package and functions. Also, we refer to the DEXSeq
(Anders, Reyes, and Huber, [n.d.](#ref-Anders)) for more information upon the preprocessing of the annotation.

## 3.1 Load libraries

```
library(ASpli)
library(DESeq2)
library(edgeR)
library(dplyr)
library(GenomicAlignments)
library(GenomicFeatures)
```

## 3.2 Load example data

We use the same example dataset as in the aberrant analyses, and are loaded
from the ASpli package. This includes an annotation file and BAM-files.

```
gtfFileName <- aspliExampleGTF()
BAMFiles <- aspliExampleBamList()
```

Next, we extract the exonic parts from the annotation file using the
`txdbmaker` package.

```
genomeTxDb <- txdbmaker::makeTxDbFromGFF(gtfFileName)
```

```
## Import genomic features from the file as a GRanges object ... OK
## Prepare the 'metadata' data frame ... OK
## Make the TxDb object ...
```

```
## Warning in .makeTxDb_normarg_chrominfo(chrominfo): genome version information
## is not available for this TxDb object
```

```
## OK
```

```
flattenedAnnotation = GenomicFeatures::exonicParts(genomeTxDb,
                                  linked.to.single.gene.only=TRUE )
```

Using `summarizeOverlaps`, we count the number of overlaps with each part of
exonic parts of the annotation file. This way, we obtain a SummarizedExperiment
object with read counts for each bin. These bin counts can then be further used
to model differential usage/splicing. Make sure to use the correct settings
for `singleEnd` and `ignore.strand`.

```
se = GenomicAlignments::summarizeOverlaps(
    flattenedAnnotation,
    BAMFiles,
    singleEnd=TRUE,
    ignore.strand=TRUE )
```

Now that we have a count matrix, we can further specify the known covariates,
whichin this case is the condition between which we will test differential
bin usage.

```
colData(se)$condition <- factor(c(rep(c("control", "case"), each = 6)))
```

Instead of modelling differential usage/splicing by modelling both the counts
and the other counts, we rather calculate the total bin-counts per gene. This
will be further used as offsets in the negative binomial regression, allowing
to model the proportion of bin counts over the total counts overlapping that
gene. We here aggregate the read counts per gene, although the offset can be
chosen flexible depending on the analysis of interest (e.g. aggregating
transcript counts per gene to model differential transcript usage).

```
counts <- assays(se)$counts
offsetsGene <- aggregate(counts,
                     by = list("gene" = rowData(se)$gene_id), FUN = sum)
offsets <- offsetsGene[match(rowData(se)$gene_id, offsetsGene$gene), ] %>%
                     mutate("gene" = NULL) %>%
                     as.matrix()
```

Because currently it is not possible to include offsets that are equal to 0 in
DESeq2/edgeR, we have to change these offsets. Here, we change the counts that
correspond to an offset of 0 (these counts are also equal to 0 in a
differential usage/splicing analysis) to 1, together with the corresponding
offset. It is possible to change the offsets and/or counts to a number of
choice, as long as the offsets are not equal to 0.

```
index <- offsets == 0
counts[index] <- 1
offsets[index] <- 1
```

We can now perform a conventual DESeq2/edgeR analysis, using the custom
offsets. For DESeq2, we include the offsets on the original scale, while for
edgeR, we include these on the log-scale. For the DESeq2 analysis we can use
the following code:

```
dds <- DESeqDataSetFromMatrix(countData = counts,
                              colData = colData(se),
                              rowData = rowData(se),
                              design= ~ condition)
```

```
## converting counts to integer mode
```

```
##   it appears that the last variable in the design formula, 'condition',
##   has a factor level, 'control', which is not the reference level. we recommend
##   to use factor(...,levels=...) or relevel() to set this as the reference level
##   before proceeding. for more information, please see the 'Note on factor levels'
##   in vignette('DESeq2').
```

```
normalizationFactors(dds) <- offsets

dds <- DESeq2::estimateDispersionsGeneEst(dds)
dispersions(dds) <- mcols(dds)$dispGeneEst
dds <- DESeq2::nbinomWaldTest(dds)
results_dds <- DESeq2::results(dds)
```

While for the edgeR analysis we can use the following code:

```
DGE <- DGEList(counts = counts)
DGE$offset <- log(offsets)
design <- model.matrix(~condition, data = colData(se))

DGE <- edgeR::estimateDisp(DGE, design = design)
fitDGE <- edgeR::glmFit(DGE, design= design)
results_DGE <- edgeR::glmLRT(fitDGE, coef = 2)
```

These results now have an interpretation in terms of proportions, with the
interpretation dependent on the offsets used.

# 4 Session info

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
## [1] stats4    parallel  stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] GenomicAlignments_1.46.0    Rsamtools_2.26.0
##  [3] Biostrings_2.78.0           XVector_0.50.0
##  [5] txdbmaker_1.6.0             igraph_2.2.1
##  [7] data.table_1.17.8           BiocParallel_1.44.0
##  [9] PRROC_1.4                   rlang_1.1.6
## [11] dplyr_1.1.4                 GenomicFeatures_1.62.0
## [13] DESeq2_1.50.0               SummarizedExperiment_1.40.0
## [15] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [17] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [19] ASpli_2.20.0                AnnotationDbi_1.72.0
## [21] IRanges_2.44.0              S4Vectors_0.48.0
## [23] Biobase_2.70.0              BiocGenerics_0.56.0
## [25] generics_0.1.4              edgeR_4.8.0
## [27] limma_3.66.0                saseR_1.6.0
## [29] knitr_1.50                  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3       rstudioapi_0.17.1        jsonlite_2.0.0
##   [4] magrittr_2.0.4           farver_2.1.2             rmarkdown_2.30
##   [7] BiocIO_1.20.0            vctrs_0.6.5              memoise_2.0.1
##  [10] RCurl_1.98-1.17          base64enc_0.1-3          htmltools_0.5.8.1
##  [13] S4Arrays_1.10.0          progress_1.2.3           curl_7.0.0
##  [16] SparseArray_1.10.0       Formula_1.2-5            sass_0.4.10
##  [19] bslib_0.9.0              htmlwidgets_1.6.4        plyr_1.8.9
##  [22] Gviz_1.54.0              httr2_1.2.1              cachem_1.1.0
##  [25] lifecycle_1.0.4          pkgconfig_2.0.3          Matrix_1.7-4
##  [28] R6_2.6.1                 fastmap_1.2.0            digest_0.6.37
##  [31] colorspace_2.1-2         Hmisc_5.2-4              RSQLite_2.4.3
##  [34] filelock_1.0.3           httr_1.4.7               abind_1.4-8
##  [37] compiler_4.5.1           withr_3.0.2              bit64_4.6.0-1
##  [40] htmlTable_2.4.3          S7_0.2.0                 backports_1.5.0
##  [43] DBI_1.2.3                UpSetR_1.4.0             biomaRt_2.66.0
##  [46] MASS_7.3-65              rappdirs_0.3.3           DelayedArray_0.36.0
##  [49] rjson_0.2.23             tools_4.5.1              foreign_0.8-90
##  [52] nnet_7.3-20              glue_1.8.0               restfulr_0.0.16
##  [55] grid_4.5.1               checkmate_2.3.3          cluster_2.1.8.1
##  [58] gtable_0.3.6             BSgenome_1.78.0          ensembldb_2.34.0
##  [61] tidyr_1.3.1              hms_1.1.4                pillar_1.11.1
##  [64] stringr_1.5.2            splines_4.5.1            BiocFileCache_3.0.0
##  [67] lattice_0.22-7           deldir_2.0-4             rtracklayer_1.70.0
##  [70] bit_4.6.0                biovizBase_1.58.0        tidyselect_1.2.1
##  [73] locfit_1.5-9.12          gridExtra_2.3            bookdown_0.45
##  [76] ProtGenerics_1.42.0      xfun_0.53                statmod_1.5.1
##  [79] DT_0.34.0                stringi_1.8.7            UCSC.utils_1.6.0
##  [82] lazyeval_0.2.2           yaml_2.3.10              evaluate_1.0.5
##  [85] codetools_0.2-20         cigarillo_1.0.0          interp_1.1-6
##  [88] tibble_3.3.0             BiocManager_1.30.26      cli_3.6.5
##  [91] rpart_4.1.24             pbmcapply_1.5.1          jquerylib_0.1.4
##  [94] dichromat_2.0-0.1        Rcpp_1.1.0               GenomeInfoDb_1.46.0
##  [97] dbplyr_2.5.1             png_0.1-8                XML_3.99-0.19
## [100] ggplot2_4.0.0            blob_1.2.4               prettyunits_1.2.0
## [103] jpeg_0.1-11              latticeExtra_0.6-31      AnnotationFilter_1.34.0
## [106] bitops_1.0-9             VariantAnnotation_1.56.0 scales_1.4.0
## [109] purrr_1.1.0              crayon_1.5.3             KEGGREST_1.50.0
```

# References

Anders, Simon, Alejandro Reyes, and Wolfgang Huber. n.d. “Detecting Differential Usage of Exons from Rna-Seq Data.” *Genome Res* 22 (10): 2008–17. <https://doi.org/10.1101/gr.133744.111>.

Gavish, Matan, and David L. Donoho. 2014. “The Optimal Hard Threshold for Singular Values Is \(4/\sqrt {3}\).” *IEEE Trans. Inf. Theory* 60 (8): 5040–53. <https://doi.org/10.1109/TIT.2014.2323359>.

Love, Michael I., Wolfgang Huber, and Simon Anders. 2014. “Moderated Estimation of Fold Change and Dispersion for Rna-Seq Data with Deseq2.” *Genome Biology* 15 (12): 550. <https://doi.org/10.1186/s13059-014-0550-8>.

Mancini, Estefania, Andres Rabinovich, Javier Iserte, Marcelo Yanovsky, and Ariel Chernomoretz. 2021. “ASpli: integrative analysis of splicing landscapes through RNA-Seq assays.” *Bioinformatics* 37 (17): 2609–16. <https://doi.org/10.1093/bioinformatics/btab141>.

Risso, Davide, John Ngai, Terence P Speed, and Sandrine Dudoit. 2014. “Normalization of Rna-Seq Data Using Factor Analysis of Control Genes or Samples.” *Nat. Biotechnol.* 32 (9): 896–902. <https://doi.org/10.1038/nbt.2931>.

Robinson, Mark D., Davis J. McCarthy, and Gordon K. Smyth. 2009. “EdgeR: A Bioconductor Package for Differential Expression Analysis of Digital Gene Expression Data.” 10.1093/bioinformatics/btp616. *Bioinformatics* 26 (1): 139–40. <https://doi.org/10.1093/bioinformatics/btp616>.

Segers, Alexandre, Jeroen Gilis, Mattias Van Heetvelde, Elfride De Baere, and Lieven Clement. 2023. “Juggling Offsets Unlocks Rna-Seq Tools for Fast Scalable Differential Usage, Aberrant Splicing and Expression Analyses.” *bioRxiv*. <https://doi.org/10.1101/2023.06.29.547014>.