# doseR

AJ Vaestermark, JR Walters.

#### 2025-10-29

# Contents

* [1 Table of Contents](#table-of-contents)
* [2 Introduction](#introduction)
* [3 Overview](#overview)
  + [3.1 Inputs](#inputs)
  + [3.2 Normalization](#normalization)
  + [3.3 Filtering](#filtering)
  + [3.4 Comparing absolute expression](#comparing-absolute-expression)
  + [3.5 Comparing relative expression](#comparing-relative-expression)
* [4 Example workflow](#example-workflow)
  + [4.1 Installation](#installation)
  + [4.2 Example data: *Heliconius* RNA-seq](#example-data-heliconius-rna-seq)
  + [4.3 Normalization & RPKM](#normalization-rpkm)
  + [4.4 Filtering “unexpressed” loci](#filtering-unexpressed-loci)
  + [4.5 Comparing absolute expression](#comparing-absolute-expression-1)
  + [4.6 Comparing relative expression](#comparing-relative-expression-1)
  + [4.7 Workflow conclusion](#workflow-conclusion)

# 1 Table of Contents

1. Introduction
2. Overview
3. Inputs
4. Normalization
5. Filtering
6. Comparing absolute expression
7. Comparing relative expression
8. Example workflow
9. Installation
10. Normalization & RPKM
11. Filtering “unexpressed” loci
12. Comparing absolute expression
13. Comparing relative expression
14. Workflow conclusion

# 2 Introduction

The doseR package aims to provide a consistent, efficient, and generalizable
analytical framework for assessing sex chromosome dosage compensation using
RNA-seq based read-count data. The study of sex chromosome dosage compensation
has garnered increasing interest in the last 15 years or so. This growth has
been driven in part by the rise of RNA-seq as a method for assaying genome-wide
patterns of gene expression, along with the discovery of a surprising diversity
of dosage compensation patterns across species. Yet despite the growing
interest in the topic of dosage compensation, with many similarities among
the analyses performed in various studies, each subsequent study tends to
employ its own bespoke scripting to analyze and visualize the data. There
has yet to emerge a common computational framework specifically developed
to streamline and increase reproducibility among studies of dosage
compensation. Our hope is for doseR to help fill that void.

Functions provided in doseR offer support for several analytical steps
commonly done in studies of dosage compensation, including:

* Normalizing data relative to library size
* Removing unexpressed or low-abundance transcripts
* Visualizing absolute and relative expression levels across gene sets
* Statistical comparisons between distributions of gene expressions

Many of these elements may be of interest for studies of gene expression
not specifically concerning dosage compensation, and the doseR package is
not meant to be limited only to studies contrasting sex chromosomes versus
autosomes or males versus females. doseR supports any number of comparisons
between biological treatments and groupings of loci.

# 3 Overview

The standard goal of most sex chromosome dosage compensation studies is
to assess whether the sex chromosome (i.e. the X or Z chromosome, depending
on male or female heterogamety) shows a globally distinct pattern of gene
expression between the sexes. On average, autosomal expression is expected to
be comparable between the sexes because autosomes are diploid in both sexes. In
contrast, differences in gene dose between the sexes due to heterogamety may
influence average expression on the X or Z, depending on what compensating
mechanisms have evolved. Thus most contemporary studies of sex chromosome
dosage compensation proceed by using sex-specific RNA-seq data to compare
distributions of normalized gene expression across chromosomes.

## 3.1 Inputs

We assume users are starting with read count data from an RNA-seq experiment,
as is typically generated after employing one of many commonly used alignment
pipelines (e.g. RSEM, Salmon, etc). The doseR workflow starts with read count
data, and not RPKM (or, comparably, FPKM), because RPKM values are calculated
during the analysis after selecting the desired library-size normalization
factor.
RNA-seq data will typically come from distinct treatments (e.g. male, female)
and may have one or more replicates per treatment. Users also provide lengths
(in basepairs) for each transcript assayed. Finally, annotations indicating
the groupings of loci (e.g. chromosome) are also needed.

## 3.2 Normalization

Accounting for differences in library size (i.e. depth of sequencing) between
samples is an important step in most statistical analyses involving RNA-seq
data.
doseR provides a variety of methods for defining the library size for each
sample.
After defining library sizes, read counts are scaled both by library size
and transcript length to give RPKM values that can be meaningfully compared
between loci and between samples.

## 3.3 Filtering

One notable concern and potential artifact in dosage compensation analysis
is the filtering of “unexpressed” loci. In theory, it is ideal to remove
loci prior to analysis since we should be primarily concerned only with
actively expressed genes. In practice, however, it is far from clear how
best to do this or what criteria should be employed. When “unexpressed”
loci are disproportionately represented among chromosomes (or other gene
groups), failing to effectively remove them can cause spurious results.
At the other extreme, overly aggressive removal of low-abundance transcripts
can artificially compress distributions of gene expression, masking true
differences in the data. A variety of approaches have been implement in doseR
for filtering out loci considered to be “unexpressed”.

## 3.4 Comparing absolute expression

One informative way to assess dosage compensation is to consider the
distribution of expression levels within sex between groups of genes,
typically for genes on the X or Z versus the autosomes. This is done
separately in each sex (or other treatments), providing a direct
inference of absolute differences in gene expression among chromosomes
(or other gene groupings). However, this approach is limited in that
it does not easily support a direct comparison between sexes (or
other treatments). doseR includes functions for visualization and
statistical tests of differences in absolute gene expression.

## 3.5 Comparing relative expression

Examining the distribution of expression ratios (e.g. Male:Female)
between treatments across chromosomes (or other gene groupings) is
an alternative approach to assess whether global expression biases
exist for particular sets of genes, such as might be expected for
uncompensated X or Z chromosomes. While this approach can provide
nuanced assessment of dosage effects, it does not indicate what
absolute changes in gene expression may be occurring that underlie
shifts in expression ratio. doseR provides functions for
visualizing and statistically testing variation in expression
ratios across chromosomes (or other gene groupings), complementing
functions for examining absolute differences in expression among
groupings within treatment.

---

# 4 Example workflow

To demonstrate a typical workflow using doseR, we will use a subset
of data from a study in Heliconius butterflies. H. melpomene
has 20 autosomes with chromosome 21 being the “Z” sex chromosome.
Like all Lepidoptera, this is a female-heterogametic species, so males
are diploid for the Z while females have a single Z and W chromosomes.
The relevant data are included in the doseR package, which must be installed.

## 4.1 Installation

doseR can be installed from Bioconductor directly using the `BiocManager`.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("doseR")
```

Once installed, you must load the package.

```
library(doseR)
library(SummarizedExperiment)
#> Loading required package: MatrixGenerics
#> Loading required package: matrixStats
#>
#> Attaching package: 'MatrixGenerics'
#> The following objects are masked from 'package:matrixStats':
#>
#>     colAlls, colAnyNAs, colAnys, colAvgsPerRowSet, colCollapse,
#>     colCounts, colCummaxs, colCummins, colCumprods, colCumsums,
#>     colDiffs, colIQRDiffs, colIQRs, colLogSumExps, colMadDiffs,
#>     colMads, colMaxs, colMeans2, colMedians, colMins, colOrderStats,
#>     colProds, colQuantiles, colRanges, colRanks, colSdDiffs, colSds,
#>     colSums2, colTabulates, colVarDiffs, colVars, colWeightedMads,
#>     colWeightedMeans, colWeightedMedians, colWeightedSds,
#>     colWeightedVars, rowAlls, rowAnyNAs, rowAnys, rowAvgsPerColSet,
#>     rowCollapse, rowCounts, rowCummaxs, rowCummins, rowCumprods,
#>     rowCumsums, rowDiffs, rowIQRDiffs, rowIQRs, rowLogSumExps,
#>     rowMadDiffs, rowMads, rowMaxs, rowMeans2, rowMedians, rowMins,
#>     rowOrderStats, rowProds, rowQuantiles, rowRanges, rowRanks,
#>     rowSdDiffs, rowSds, rowSums2, rowTabulates, rowVarDiffs, rowVars,
#>     rowWeightedMads, rowWeightedMeans, rowWeightedMedians,
#>     rowWeightedSds, rowWeightedVars
#> Loading required package: GenomicRanges
#> Loading required package: stats4
#> Loading required package: BiocGenerics
#> Loading required package: generics
#>
#> Attaching package: 'generics'
#> The following objects are masked from 'package:base':
#>
#>     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
#>     setequal, union
#>
#> Attaching package: 'BiocGenerics'
#> The following objects are masked from 'package:stats':
#>
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#>
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
#>     as.data.frame, basename, cbind, colnames, dirname, do.call,
#>     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
#>     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
#>     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
#>     unsplit, which.max, which.min
#> Loading required package: S4Vectors
#>
#> Attaching package: 'S4Vectors'
#> The following object is masked from 'package:utils':
#>
#>     findMatches
#> The following objects are masked from 'package:base':
#>
#>     I, expand.grid, unname
#> Loading required package: IRanges
#> Loading required package: Seqinfo
#> Loading required package: Biobase
#> Welcome to Bioconductor
#>
#>     Vignettes contain introductory material; view with
#>     'browseVignettes()'. To cite Bioconductor, see
#>     'citation("Biobase")', and for packages 'citation("pkgname")'.
#>
#> Attaching package: 'Biobase'
#> The following object is masked from 'package:MatrixGenerics':
#>
#>     rowMedians
#> The following objects are masked from 'package:matrixStats':
#>
#>     anyMissing, rowMedians
```

## 4.2 Example data: *Heliconius* RNA-seq

The primary data used by doseR are read counts from RNA-seq data,
in this case generated from legs of H. melpomene, with three
biological replicates each for male and female. Read count data
should be formatted as a matrix, with replicates in columns and
transcripts in rows. We also need a vector of corresponding transcript
lengths. Finally, data indicating gene groupings are needed. Here we
have a vector giving chromosomal linkage for each transcript (note
that these data are limited to only one representative transcript per gene).

```
data(hmel.data.doser)
```

These three data elements are used to populate a new `SummarizedExperiment`,
which is the core data structure for the doseR package. This object
contains and organizes the read counts, RPKM values, segment lengths,
and annotations of gene groupings. However, there are some further data
manipulations required before we can create a new object.

First, we need to create a vector indicating to the replicate structure
in the data, in this case three male and three female replicates, as
organized in the counts matrix.

```
reps <- c("Male", "Male", "Male", "Female", "Female", "Female")
```

Second, we must create a dataframe to hold the annotation of gene
groupings. In doing this, we will also convert the numeric
annotation vector into a factor, which facilitates
proper ordering of gene groups in later plotting.
Additionally, we will recode the chromosomal linkage information as
being Z-linked or autosomal.

```
annotxn <- data.frame("Chromosome" = factor(hmel.dat$chromosome,
levels = 1:21))
annotxn$ZA <- factor(ifelse(hmel.dat$chromosome == 21, "Z", "A"),
levels = c("A", "Z"))
```

Now we are ready to populate a new `SummarizedExperiment` object.

```
counts <- hmel.dat$readcounts
colData <- S4Vectors::DataFrame(Treatment=as.factor(reps),
row.names=colnames(hmel.dat$readcounts))
rowData <- S4Vectors::DataFrame(annotation = annotxn,
seglens = hmel.dat$trxLength,
row.names=rownames(hmel.dat$readcounts) )
se2 <- SummarizedExperiment(assays=list(counts=counts),
colData=colData, rowData=rowData)
```

## 4.3 Normalization & RPKM

Next we select a method for calculating the library size (sometimes
called scaling factors) so that data are normalized for depth of
sequencing. Various methods for calculating a library size are provided,
but we will use the most straightforward method of summing total read counts.

```
SummarizedExperiment::colData(se2)$Libsizes <- getLibsizes3(se2,
estimationType = "total")
```

With library sizes now stored in the `SummExperiment` object, we can calculate
RPKM values for each locus in each sample and store them in the RPKM slot.

```
SummarizedExperiment::assays(se2)$rpkm <- make_RPKM(se2)

# se2 now equals se...

data(hmel.se)  # loads hmel.dat list

# MD5 checksum equivalence:
#library(digest)
digest::digest(se) == digest::digest(se2)
#> [1] FALSE
```

It is always wise when first working with comparisons between genome-wide
expression data sets like this to check that there are not clear biases or
other artifacts showing up in the data, and that the normalization seems
reasonable. Making [MA plots](https://en.wikipedia.org/wiki/MA_plot) is one
important visualization to guard agains such problems.

```
plotMA.se(se, samplesA ="Male", samplesB = "Female", cex = .2 ,
pch = 19, col = rgb(0,0,0, .2), xlab = "Log2(Average RPKM)",
ylab = "Log2(Male:Female)")
```

![](data:image/png;base64...)

## 4.4 Filtering “unexpressed” loci

It is generally good practice to remove loci considered to be “unexpressed”.
In this case we will apply a filter so that included loci must have a mean RPKM
value across samples greather than 0.01. Many other approaches to filtering
are provided in doseR, and it is generally wise to explore how filtering
choices affect assessments of dosage compensation.

```
f_se <- simpleFilter(se, mean_cutoff = 0.01, counts = FALSE)
#> Filtering removed 4035 (29.63%).
```

## 4.5 Comparing absolute expression

Having generated filtered RPKM values, we can proceed to comparing
distributions of expression among different groupings of genes, as
indicated in the annotation slot of the `SummExperiment` object. Biological
replicates are averaged to give a single representative RPKM value per gene.
In this case it is clear that the gene expression is reduced on the Z
chromosome relative to autosomes in both sexes.

```
plotExpr(f_se, groupings = "annotation.ZA", clusterby_grouping = FALSE,
col=c("grey80","red","grey80","red"), notch=TRUE, ylab = "Log2(RPKM)")
```

![](data:image/png;base64...)

Beyond visualizing with boxplots, we will also want statistical
summaries and tests applied to these data, which can be done with
the `generateStats()` function. Here we will want to
subset the `SummarizedExperiment` object so that tests are applied
using only data from a single treatment.
The function returns a list of three items:

1. A distributional summary for each grouping of genes analyzed
2. The results from applying a Kruskal-Wallis test, a non-parametric
   test of differences among groups
3. The values used for generating 1 & 2, i.e. the average values
   across replicates for each gene in each group.

Here we demonstrate this only for male samples, but a full analysis
would also require the same be done for the female samples.

```
se.male <- f_se[, colData(f_se)$Treatment == "Male"]
male_ZvA <- generateStats(se.male , groupings = "annotation.ZA", LOG2 = FALSE)
#> View output: outlist$kruskal, outlist$summary
male_ZvA$summary  # distributional summary statistics
#>                    A           Z
#> Min.        0.000000    0.000000
#> 1st Qu.     1.837499    1.093565
#> Median      8.715750    5.795021
#> Mean       54.737996   37.759261
#> 3rd Qu.    23.573567   16.577152
#> Max.    20065.669794 4351.420842
male_ZvA$kruskal  # htest class output from kruskal.test()
#>
#>  Kruskal-Wallis rank sum test
#>
#> data:  tmp
#> Kruskal-Wallis chi-squared = 19.006, df = 1, p-value = 1.303e-05
lapply(male_ZvA$data, head) # a record of values used for statistics.
#> $A
#>  HMEL000002  HMEL000003  HMEL000004  HMEL000006  HMEL000007  HMEL000008
#> 10.71571713  0.09353976 41.72790716 21.12032979  0.00000000  4.87423582
#>
#> $Z
#> HMEL002056 HMEL002096 HMEL002142 HMEL002143 HMEL002145 HMEL002156
#>  4.9311162  0.4912925 27.8965294  6.1170531  1.8668670 99.4424234
```

It may be of interest to examine other groupings of genes. For instance,
how variable are the distributions of expression across chromosomes?
Again, we’ll limit this only to males for the sake of demonstration.

```
plotExpr(f_se, groupings = "annotation.Chromosome", col=c(rep("grey80", 20),
"red"), notch=TRUE, ylab = "Log2(RPKM)", las = 2, treatment = "Male",
clusterby_grouping = TRUE )
```

![](data:image/png;base64...)

## 4.6 Comparing relative expression

Similarly to the plots and statistics given above for absolute expression,
doseR provides functions for examing relative expression between pairs of
treatments. For instance, we may want to assess whether there is a dosage
effect on gene expression for the Z chromosome. This would manifest as a
positive shift in the distribution of Male:Female expression levels on the
Z relative to autosomes.

We can examine this using boxplots, similar to absolute expression, above.

```
plotRatioBoxes(f_se, groupings = "annotation.ZA", treatment1 = "Male",
treatment2 = "Female", outline = FALSE, col = c("grey80", "red"),
ylab = "Log(Male:Female)" )
```

![](data:image/png;base64...)

Alternatively, there is a widely used convention in the dosage compensation
literature to visualize these distributions using a density plot, so this
functionality is also provided.

```
plotRatioDensity(f_se, groupings = "annotation.ZA", treatment1 = "Male",
treatment2 = "Female", type = "l", xlab = "Log(Male:Female)", ylab = "Density")
#> Current order of levels:  A Z
```

![](data:image/png;base64...)

As above, we can apply the same plotting to the chromosomal
annotation if desired.

```
par(mfrow = c(1,2))
plotRatioBoxes(f_se, groupings = "annotation.Chromosome", treatment1 =
"Male", treatment2 = "Female", outline = FALSE, col=c(rep("grey80", 20),
"red"), ylab = "Log(Male:Female)", xlab = "Chromosome" )

plotRatioDensity(f_se, groupings = "annotation.Chromosome", treatment1 =
"Male", treatment2 = "Female", type = "l", xlab = "Log(Male:Female)",
ylab = "Density", col=c(rep("grey80", 20), "red"), lty = 1)
#> Current order of levels:  15 18 21 13 7 19 8 3 11 16 9 1 17 6 20 10 5 12 4 14 2
```

![](data:image/png;base64...)

Beyond plotting, we also want to know whether there are statistical
differences between the groupings indicated. The `test_diffs()` function
summarizes the distributions of expression ratios among groups and applies
a non-parametric Kruskal-Wallis test.

```
za.ratios.test <- test_diffs(f_se, groupings = "annotation.ZA",
treatment1 = "Male", treatment2 = "Female", LOG2 = FALSE )
#> View output: outlist$kruskal, outlist$summary
za.ratios.test$summary  # summary statistics for each grouping
#>                   A          Z
#> Min.      0.0000000  0.0000000
#> 1st Qu.   0.6788987  0.7821321
#> Median    0.8677571  1.0212513
#> Mean      0.9956633  1.1136910
#> 3rd Qu.   1.0628770  1.2781894
#> Max.     81.7647412  7.6471211
#> NA's    211.0000000 19.0000000
za.ratios.test$kruskal  # htest class output from kruskal.test()
#>
#>  Kruskal-Wallis rank sum test
#>
#> data:  tmp
#> Kruskal-Wallis chi-squared = 65.132, df = 1, p-value = 7.003e-16
lapply(za.ratios.test$data, head) # values used for summaries and tests
#> $A
#> HMEL000002 HMEL000003 HMEL000004 HMEL000006 HMEL000007 HMEL000008
#>  0.8597425  0.3492448  1.6905856  0.4615780  0.0000000  1.3637461
#>
#> $Z
#> HMEL002056 HMEL002096 HMEL002142 HMEL002143 HMEL002145 HMEL002156
#>  1.0500235  3.9418081  1.2663384  1.0861082  0.6493254  1.6593288
```

## 4.7 Workflow conclusion

As can be seen from these plots and statistics, these data reveal
a distinct reduction in absolute expression for Z linked loci, relative
to autosomes, for both sexes. Furthermore, there is a modest but
statistically significant dosage effect causing a male-bias in the
male:female ratio expression on the Z chromosome. The functions
support various comparisons between treatments and among any set
of gene groupings, as specified in the annotations.

In some cases, when analyzing more than two gene groupings (e.g.
across individual chromosomes), users may want to extend statistical
analyses to specific pairwise comparisons. For instance, is the
average Z expression specifically different from chromosome 14 in
particular? Because the Kruskal-Wallis test is a “global” test for
inequality among groups (analogous to an ANOVA), you may want to apply
a follow-up non-parametric post-hoc test for specific pairwise comparisons
after a significant Kruskal-Wallis test. Several such tests, such as the
[Nemenyi](https://en.wikipedia.org/wiki/Nemenyi_test), are implemented
in the [PMCMRplus]
(<https://cran.r-project.org/web/packages/PMCMRplus/index.html>) package.