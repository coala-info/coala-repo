## Jack Fu

### 2025-10-30

## Overview

MDTS provides the necessary infrastructure to take raw bam files of targeted
sequencing trios to produce de novo deletion calls of high sensitivity and low
false positives. Our method benefits tremendously from pooling information from
across many trios to determine regions of interest, normalize read-depth, and to
filter candidate deletion signals.

MDTS is broken down into the following major steps:

1. Calculating the MDTS bins
2. Determinig the read-depth of the bins for each sample
3. Normalizing the read-depth
4. Creating the Minimum Distance for each trio
5. Call de novo deletions and filter

## Raw Data

Preprocessed sample data is included with the package `MDTS`, but should you be
interested in the raw files, they can be found in the github repo
`jmf47/MDTSdata`. It includes:

1. 21 simulated bam files (7 trios)
   * Sequencing read length of 100bp
   * 1 true de novo deletion in family F4
2. A bw file that includes the 100mer mappability of chr1
3. A pedigree file
   * Records the trio kinships
   * Records the file paths to the raw bam files of each sample

```
##    subj_id family_id father_id mother_id      bam_path
## 1     F1_1        F1      F1_2      F1_3 125968958.bam
## 2     F1_3        F1         0         0 125970229.bam
## 3     F1_2        F1         0         0 125970675.bam
## 4     F2_1        F2      F2_2      F2_3 124770343.bam
## 5     F2_3        F2         0         0 124770335.bam
## 6     F2_2        F2         0         0 124770213.bam
## 7     F3_1        F3      F3_2      F3_3 125012972.bam
## 8     F3_3        F3         0         0 125012237.bam
## 9     F3_2        F3         0         0 125017898.bam
## 10    F4_1        F4      F4_2      F4_3 126330731.bam
## 11    F4_3        F4         0         0 126319754.bam
## 12    F4_2        F4         0         0 126320843.bam
## 13    F5_1        F5      F5_2      F5_3 126328714.bam
## 14    F5_3        F5         0         0 126310263.bam
## 15    F5_2        F5         0         0 126298916.bam
## 16    F6_1        F6      F6_2      F6_3 125659861.bam
## 17    F6_3        F6         0         0 125651281.bam
## 18    F6_2        F6         0         0 125651256.bam
## 19    F7_1        F7      F7_2      F7_3 124413356.bam
## 20    F7_3        F7         0         0 124411059.bam
## 21    F7_2        F7         0         0 124412226.bam
```

## 1. Calculating MDTS Bins

One innovation of our method is that the bins to determine sequencing read depth
is calculated based on the empirical capture. These bins can be significantly
different from the standard practice of using probe design coordinates to create
bins. Furthermore, our binning process allows the bins to be smaller in regions
of high capture, and vice verse in low capture. This dynamic scaling of the bin
size makes efficient use of varying depths of coverage - allowing us to call
deletions with finer resolution in areas of higher coverage.

The general approach is first to examine the mapped coverage of a subset of the
full dataset across the entire genome. Basepairs that are covered passed a
certain threshold in at least one sample is selected as a proto-region.
Proto-regions are subdvided into non-overlapping bins such that the median
number of reads falling into each bin meets a specified level spcified by the
*medianCoverage* parameter. The choice of *medianCoverage* is a tradeoff between
sensitivity and false positives. A larger *medianCoverage* decreases sensitivity
and false positives. For our publication, we used *medianCoverage=160*, and for
this example we used *medianCoverage=150*.

Information on GC content and mappability of the bins are also calculated at
this stage. As a result, MDTS requires a BSgenome object that is consistent with
the reference annotation the bam files were aligned to, as well as a mappability
bigwig that contains mappability information in windows consistent with
sequencing read length. In our example, we require `BSgenome.Hsapiesn.UCSC.hg19`
and 100mer mappability.

\*\* In general you will need a bw file that contains the information for all
autosomes 1-22 (unlike the bw file only for chr1 included in the example). \*\*
This is the link to some hg19 mappability bw files:
<http://rohsdb.cmb.usc.edu/GBshape/cgi-bin/hgFileUi?db=hg19&g=wgEncodeMapability>

This portion of the vignette example uses raw data from `MDTSData`. However
the resulting bins are included in the `data` directory of MDTS as a `.RData`.

```
library(MDTS); library(BSgenome.Hsapiens.UCSC.hg19)
# Using the raw data from MDTSData
devtools::install_github("jmf47/MDTSData")
setwd(system.file("data", package="MDTSData"))

# Importing the pedigree file that includes information on where to locate the
# raw bam files
pD <- getMetaData("pD.ped")

# Information on the GC content and mappability to estimate GC and mappability
# for the MDTS bins
genome <- BSgenome.Hsapiens.UCSC.hg19; map_file = "chr1.map.bw"

# This command now subsets 5 samples to determine MDTS bins
# pD is the metaData matrix from getMetaData()
# n is the number of samples to examine to calculate the bins
# readLength is the sequencing read length
# minimumCoverage is the minimum read depth for a location to be included
#     in a proto region
# medianCoverage is the median number of reads across the n samples in a bin
bins <- calcBins(metaData=pD, n=5, readLength=100, minimumCoverage=5,
                medianCoverage=150, genome=genome, mappabilityFile=map_file)
```

## 2. Calculating coverage of MDTS bins

Given a set of dynamic MDTS bins, we can proceed to calculate the number of
reads that fall into these bins for the entirety of our sample. We organize the
number of reads as a matrix, where each column is a sample, and each row
corresponds to a bin. This portion of the vignette is a continuation of the
usage of the raw data from `MDTSdata` above. However the resulting `counts`
matrix is also shipped as a `rda` in `MDTS`.

```
# pD is the phenotype matrix
# bins is the previously calculated MDTS bins
# rl is the sequencing read length
counts = calcCounts(pD, bins, rl=100)
```

The MDTS bins, raw counts, and pedigree files are included with `MDTS` and can
be loaded as follows:

```
load(system.file("extdata", 'bins.RData', package = "MDTS"))
load(system.file("extdata", 'counts.RData', package = "MDTS"))
load(system.file("extdata", 'pD.RData', package = "MDTS"))
```

The MDTS bins are

```
bins
```

```
## GRanges object with 78 ranges and 3 metadata columns:
##        seqnames              ranges strand | median_count        GC mappability
##           <Rle>           <IRanges>  <Rle> |    <numeric> <numeric>   <numeric>
##    [1]        1 209943004-209943263      * |       150.65  0.523077    1.000000
##    [2]        1 209943264-209943466      * |       150.43  0.527094    0.938272
##    [3]        1 209943467-209943569      * |       150.18  0.456311    1.000000
##    [4]        1 209943570-209943629      * |       152.35  0.366667    1.000000
##    [5]        1 209943630-209943672      * |       152.50  0.418605    1.000000
##    ...      ...                 ...    ... .          ...       ...         ...
##   [74]        1 209948780-209948982      * |       150.23  0.581281    1.000000
##   [75]        1 209948983-209949159      * |       150.55  0.581921    1.000000
##   [76]        1 209949160-209949278      * |       150.72  0.436975    1.000000
##   [77]        1 209949279-209949388      * |       150.38  0.436364    0.752723
##   [78]        1 209949524-209950091      * |       238.77  0.369718    1.000000
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

The count matrix where each column is a sample and each row is a bin:

```
head(counts)
```

```
##        F1_1   F1_3   F1_2   F2_1   F2_3   F2_2   F3_1   F3_3   F3_2   F4_1
## [1,] 150.65 129.31 123.43 155.43 175.73 172.14 132.65 125.79 149.64 180.47
## [2,] 149.78 159.53 150.24 214.15 228.59 209.85 191.18 179.33 205.24 225.10
## [3,] 149.75 129.33 135.42 163.86 173.12 145.15 123.50 153.89 151.25 160.07
## [4,] 152.17 134.68 137.09 172.25 173.66 128.36 117.48 130.53 123.95 142.79
## [5,] 150.15 133.17 125.89 166.29 159.87 108.33 115.97 109.10 109.76 116.64
## [6,] 150.79 139.37 125.16 164.06 147.14 103.33 112.28 103.94 109.27 105.01
##        F4_3   F4_2   F5_1   F5_3   F5_2   F6_1   F6_3   F6_2   F7_1   F7_3
## [1,] 202.95 193.24 175.25 145.44  93.71 194.01 143.39 217.66 130.45  97.91
## [2,] 319.39 261.59 216.44 235.70 130.92 244.54 197.36 277.79 219.76 137.03
## [3,] 201.72 193.93 182.86 131.51  96.68 146.45 112.56 171.25 151.83 106.12
## [4,] 176.34 157.19 149.99 116.01  76.67 124.17  82.20 122.93 162.17  92.42
## [5,] 163.30 125.39 128.20  98.95  62.08 106.35  55.15  96.66 180.02  96.59
## [6,] 165.16 117.32 121.60  96.84  62.22  94.17  51.05  82.90 199.33 102.37
##        F7_2
## [1,] 150.64
## [2,] 199.95
## [3,] 180.00
## [4,] 190.07
## [5,] 170.62
## [6,] 155.58
```

## 3. Normalizing the read-depth

After obtaining the raw read-depth matrix, MDTS calculates a vector M score
matrix of the same organization - each row corresponds to a row and each column
a sample. The M score is based on a log2 transformation, followed by median
polish, and GC and mappability adjust via a loess smoother. The resulting M
scores have critical values where (0, -1, <-4) are generally consistent with 2,
1, and 0 copy numbers [barring Copy Number Polymorphisms].

```
# counts is the raw read depth of [MDTS bins x samples]
# bins is the previously calculated MDTS bins
mCounts <- normalizeCounts(counts, bins)
```

```
## Log Transforming Counts
```

```
## GC Adjust
```

```
## Mappability Adjust
```

## 4. Creating the Minimum Distance for each trio

The second advantage of MDTS is the use of Minimum Distances for candidate de
novo deletion identification. The assumption underlying the development of the
Minimum Distance is that it is vastly more likely for a deletion to be inherited
than de novo if the proband shares a deletion with one of the parents in the
trio. Based on that assumption, the Minimum Distance is calculated per family -
bin combination. For each bin, the Minimum Distance is smallest (in absolute
terms) difference between the proband’s M score and both parents’.

For example, if the M scores are (-1, -1, 0) for a proband and the 2 parents
respectively, a situation consistent with an inherited deletion in the proband
from parent 1, the Minimum Distance of the 2 possible pairwise comparisons is 0.
On the other hand, if the M scores are (-1, 0, 0) for the proband and the 2
parents, the Minimum Distance stands out at -1, and is consistent with a de novo
deletion.

To calculate the Minimum Distance of the dataset, MDTS takes as input the M
score matrix. The output matrix is organized where each row corresponds still to
a bin, but each column now refers to a trio.

```
# mCounts is the normalized read depth of [MDTS bins x samples]
# bins is the previously calculated MDTS bins
# pD is the phenotype matrix
md <- calcMD(mCounts, pD)
```

## 5. Call de novo deletions and filter

Using the Minimum Distance matrix calculated above, MDTS uses the tried and true
Circular Binary Segmentation method to infer deletion states. Inferred candidate
de novo deletions are further filtered to remove likely false positive signals
that arose out of regions of highly variable read-depth (generally indicative of
sequence artifacts or polymorphic events).

```
# md is the Minimum Distance of [MDTS bins x trio]
# bins is the previously calculated MDTS bins
# mCounts is the normalized read depth of [MDTS bins x samples]
cbs <- segmentMD(md=md, bins=bins)
```

```
## Analyzing: F1_1
```

```
## Analyzing: F2_1
```

```
## Analyzing: F3_1
```

```
## Analyzing: F4_1
```

```
## Analyzing: F5_1
```

```
## Analyzing: F6_1
```

```
## Analyzing: F7_1
```

```
denovo <- denovoDeletions(cbs, mCounts, bins)
```

```
## [1] "Selecting Candidate de Novo deletions"
## [1] "Calculating problematic bins"
## [1] "Filtering candidates by problematic bins"
```

In our example, the output is a single detected de novo deletion in family F4:

```
denovo
```

```
## GRanges object with 0 ranges and 2 metadata columns:
##    seqnames    ranges strand |         m       famid
##       <Rle> <IRanges>  <Rle> | <numeric> <character>
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

No signals were picked up from the CNP region or elsewhere.

## 6. SessionInfo

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
##  [1] BSgenome.Hsapiens.UCSC.hg19_1.4.3 BSgenome_1.78.0
##  [3] rtracklayer_1.70.0                BiocIO_1.20.0
##  [5] Biostrings_2.78.0                 XVector_0.50.0
##  [7] GenomicRanges_1.62.0              Seqinfo_1.0.0
##  [9] IRanges_2.44.0                    S4Vectors_0.48.0
## [11] BiocGenerics_0.56.0               generics_0.1.4
## [13] MDTS_1.30.0
##
## loaded via a namespace (and not attached):
##  [1] Matrix_1.7-4                rjson_0.2.23
##  [3] compiler_4.5.1              crayon_1.5.3
##  [5] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [7] Rsamtools_2.26.0            bitops_1.0-9
##  [9] GenomicAlignments_1.46.0    parallel_4.5.1
## [11] yaml_2.3.10                 BiocParallel_1.44.0
## [13] lattice_0.22-7              DNAcopy_1.84.0
## [15] R6_2.6.1                    S4Arrays_1.10.0
## [17] curl_7.0.0                  knitr_1.50
## [19] XML_3.99-0.19               DelayedArray_0.36.0
## [21] MatrixGenerics_1.22.0       xfun_0.53
## [23] SparseArray_1.10.0          grid_4.5.1
## [25] evaluate_1.0.5              codetools_0.2-20
## [27] cigarillo_1.0.0             RCurl_1.98-1.17
## [29] abind_1.4-8                 restfulr_0.0.16
## [31] httr_1.4.7                  matrixStats_1.5.0
## [33] tools_4.5.1
```