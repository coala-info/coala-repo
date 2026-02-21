# Shearwater ML

#### Inigo Martincorena and Moritz Gerstung

#### 6 March 2015

# Shearwater ML

#### Inigo Martincorena and Moritz Gerstung

6 March 2015

ShearwaterML is a maximum-likelihood adaptation of the original Shearwater algorithm. Unlike the original algorithm, ShearwaterML does not use prior information and yields p-values, instead of Bayes factors, using a Likelihood-Ratio Test. This allows using standard multiple testing correction methods to obtain a list of significant variants with a controlled false discovery rate.

For a detailed description of the algorithm see:

Martincorena I, Roshan A, Gerstung M, et al. (2015). High burden and pervasive positive selection of somatic mutations in normal human skin. *Science* (2015).

Load data from `deepSNV` example

```
library(deepSNV)
```

```
## Loading required package: parallel
```

```
## Loading required package: IRanges
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: generics
```

```
##
## Attaching package: 'generics'
```

```
## The following objects are masked from 'package:base':
##
##     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
##     setequal, union
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
##     as.data.frame, basename, cbind, colnames, dirname, do.call,
##     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
##     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
##     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
##     unsplit, which.max, which.min
```

```
## Loading required package: S4Vectors
```

```
## Loading required package: stats4
```

```
##
## Attaching package: 'S4Vectors'
```

```
## The following object is masked from 'package:utils':
##
##     findMatches
```

```
## The following objects are masked from 'package:base':
##
##     I, expand.grid, unname
```

```
## Loading required package: GenomicRanges
```

```
## Loading required package: Seqinfo
```

```
## Loading required package: SummarizedExperiment
```

```
## Loading required package: MatrixGenerics
```

```
## Loading required package: matrixStats
```

```
##
## Attaching package: 'MatrixGenerics'
```

```
## The following objects are masked from 'package:matrixStats':
##
##     colAlls, colAnyNAs, colAnys, colAvgsPerRowSet, colCollapse,
##     colCounts, colCummaxs, colCummins, colCumprods, colCumsums,
##     colDiffs, colIQRDiffs, colIQRs, colLogSumExps, colMadDiffs,
##     colMads, colMaxs, colMeans2, colMedians, colMins, colOrderStats,
##     colProds, colQuantiles, colRanges, colRanks, colSdDiffs, colSds,
##     colSums2, colTabulates, colVarDiffs, colVars, colWeightedMads,
##     colWeightedMeans, colWeightedMedians, colWeightedSds,
##     colWeightedVars, rowAlls, rowAnyNAs, rowAnys, rowAvgsPerColSet,
##     rowCollapse, rowCounts, rowCummaxs, rowCummins, rowCumprods,
##     rowCumsums, rowDiffs, rowIQRDiffs, rowIQRs, rowLogSumExps,
##     rowMadDiffs, rowMads, rowMaxs, rowMeans2, rowMedians, rowMins,
##     rowOrderStats, rowProds, rowQuantiles, rowRanges, rowRanks,
##     rowSdDiffs, rowSds, rowSums2, rowTabulates, rowVarDiffs, rowVars,
##     rowWeightedMads, rowWeightedMeans, rowWeightedMedians,
##     rowWeightedSds, rowWeightedVars
```

```
## Loading required package: Biobase
```

```
## Welcome to Bioconductor
##
##     Vignettes contain introductory material; view with
##     'browseVignettes()'. To cite Bioconductor, see
##     'citation("Biobase")', and for packages 'citation("pkgname")'.
```

```
##
## Attaching package: 'Biobase'
```

```
## The following object is masked from 'package:MatrixGenerics':
##
##     rowMedians
```

```
## The following objects are masked from 'package:matrixStats':
##
##     anyMissing, rowMedians
```

```
## Loading required package: Biostrings
```

```
## Loading required package: XVector
```

```
##
## Attaching package: 'Biostrings'
```

```
## The following object is masked from 'package:base':
##
##     strsplit
```

```
## Loading required package: VGAM
```

```
## Loading required package: splines
```

```
## Loading required package: VariantAnnotation
```

```
## Loading required package: Rsamtools
```

```
##
## Attaching package: 'VariantAnnotation'
```

```
## The following object is masked from 'package:base':
##
##     tabulate
```

```
##
## Attaching package: 'deepSNV'
```

```
## The following objects are masked from 'package:VGAM':
##
##     dbetabinom, pbetabinom
```

```
## The following object is masked from 'package:BiocGenerics':
##
##     normalize
```

```
regions <- GRanges("B.FR.83.HXB2_LAI_IIIB_BRU_K034", IRanges(start = 3120, end=3140))
files <- c(system.file("extdata", "test.bam", package="deepSNV"), system.file("extdata", "control.bam", package="deepSNV"))
counts <- loadAllData(files, regions, q=30)
```

ShearwaterML: “betabinLRT” calculates p-values for each possible mutation

```
pvals <- betabinLRT(counts, rho=1e-4, maxtruncate = 1)$pvals
qvals <- p.adjust(pvals, method="BH")
dim(qvals) = dim(pvals)
vcfML = qvals2Vcf(qvals, counts, regions, samples = files, mvcf = TRUE)
```

Original Shearwater: “bbb” computes the original Bayes factors

```
bf <- bbb(counts, model = "OR", rho=1e-4)
vcfBF <- bf2Vcf(bf, counts, regions, samples = files, prior = 0.5, mvcf = TRUE)

plot(pvals[1,,], bf[1,,]/(1+bf[1,,]), log="xy")
```

![](data:image/png;base64...)