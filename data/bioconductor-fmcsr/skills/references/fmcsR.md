# *fmcsR*: Mismatch Tolerant Maximum Common Substructure Detection for Advanced Compound Similarity Searching

Authors: Yan Wang, Tyler Backman, Kevin Horan, [Thomas Girke](mailto:thomas.girke@ucr.edu)

#### Last update: 30 October, 2025

#### Package

fmcsR 1.52.0

Note: the most recent version of this tutorial can be found [here](https://htmlpreview.github.io/?https://github.com/girke-lab/fmcsR/blob/master/vignettes/fmcsR.html) and a short overview slide show [here](http://faculty.ucr.edu/~tgirke/HTML_Presentations/Manuals/Workshop_Dec_5_8_2014/Rcheminfo/Cheminfo.pdf).

# 1 Introduction

Maximum common substructure (MCS) algorithms rank among the most
sensitive and accurate methods for measuring structural similarities
among small molecules. This utility is critical for many research areas
in drug discovery and chemical genomics. The MCS problem is a
graph-based similarity concept that is defined as the largest
substructure (sub-graph) shared among two compounds (Wang et al. [2013](#ref-Wang2013a); Cao, Jiang, and Girke [2008](#ref-Cao2008a)).
It fundamentally differs from the
structural descriptor-based strategies like fingerprints or structural
keys. Another strength of the MCS approach is the identification of the
actual MCS that can be mapped back to the source compounds in order to
pinpoint the common and unique features in their structures. This output
is often more intuitive to interpret and chemically more meaningful than
the purely numeric information returned by descriptor-based approaches.
Because the MCS problem is NP-complete, an efficient algorithm is
essential to minimize the compute time of its extremely complex search
process. The `fmcsR` package implements an efficient backtracking algorithm that
introduces a new flexible MCS (FMCS) matching strategy to identify MCSs
among compounds containing atom and/or bond mismatches. In contrast to
this, other MCS algorithms find only exact MCSs that are perfectly
contained in two molecules. The details about the FMCS algorithm are
described in the Supplementary Materials Section of the associated
publication (Wang et al. [2013](#ref-Wang2013a)). The package provides several utilities to
use the FMCS algorithm for pairwise compound comparisons, structure
similarity searching and clustering. To maximize performance, the time
consuming computational steps of `fmcsR` are implemented in C++. Integration
with the `ChemmineR` package provides visualization functionalities of MCSs and
consistent structure and substructure data handling routines (Cao et al. [2008](#ref-Cao2008c); Backman, Cao, and Girke [2011](#ref-Backman2011a)).
The following gives an overview of the most important functionalities provided by
`fmcsR`.

# 2 Installation

The R software for running `fmcsR` and `ChemmineR` can be downloaded from CRAN
(<http://cran.at.r-project.org/>). The `fmcsR` package can be installed from an
open R session using the `BiocManager::install()` command.

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("fmcsR")
```

# 3 Quick Overview

To demo the main functionality of the `fmcsR` package, one can load its sample
data stored as `SDFset` object. The generic `plot` function can be used to visualize the
corresponding structures.

```
library(fmcsR)
data(fmcstest)
plot(fmcstest[1:3], print=FALSE)
```

![](data:image/png;base64...)

The `fmcs` function computes the MCS/FMCS shared among two compounds, which can
be highlighted in their structure with the `plotMCS` function.

```
test <- fmcs(fmcstest[1], fmcstest[2], au=2, bu=1)
plotMCS(test,regenCoords=TRUE)
```

![](data:image/png;base64...)

# 4 Documentation

```
library("fmcsR") # Loads the package
```

```
library(help="fmcsR") # Lists functions/classes provided by fmcsR
library(help="ChemmineR") # Lists functions/classes from ChemmineR
vignette("fmcsR") # Opens this PDF manual
vignette("ChemmineR") # Opens ChemmineR PDF manual
```

The help documents for the different functions and container classes can
be accessed with the standard R help syntax.

```
?fmcs
?"MCS-class"
?"SDFset-class"
```

# 5 MCS of Two Compounds

## 5.1 Data Import

The following loads the sample data set provided by the `fmcsR` package. It
contains the SD file (SDF) of 3 molecules stored in an `SDFset` object.

```
data(fmcstest)
sdfset <- fmcstest
sdfset
```

```
## An instance of "SDFset" with 3 molecules
```

Custom compound data sets can be imported and exported with the `read.SDFset`
and `write.SDF` functions, respectively. The following demonstrates this by
exporting the `sdfset` object to a file named `sdfset.sdf`. The latter is then reimported
into R with the `read.SDFset` function.

```
write.SDF(sdfset, file="sdfset.sdf")
mysdf <- read.SDFset(file="sdfset.sdf")
```

## 5.2 Compute MCS

The `fmcs` function accepts as input two molecules provided as `SDF` or `SDFset` objects. Its
output is an S4 object of class `MCS`. The default printing behavior
summarizes the MCS result by providing the number of MCSs it found, the
total number of atoms in the query compound \(a\), the total number of
atoms in the target compound \(b\), the number of atoms in their MCS \(c\)
and the corresponding *Tanimoto Coefficient*. The latter is a widely
used similarity measure that is defined here as \(c/(a+b-c)\). In
addition, the *Overlap Coefficient* is provided, which is defined as
\(c/min(a,b)\). This coefficient is often useful for detecting
similarities among compounds with large size differences.

```
mcsa <- fmcs(sdfset[[1]], sdfset[[2]])
mcsa
```

```
## An instance of "MCS"
##  Number of MCSs: 7
##  CMP1: 14 atoms
##  CMP2: 33 atoms
##  MCS: 8 atoms
##  Tanimoto Coefficient: 0.20513
##  Overlap Coefficient: 0.57143
```

```
mcsb <- fmcs(sdfset[[1]], sdfset[[3]])
mcsb
```

```
## An instance of "MCS"
##  Number of MCSs: 1
##  CMP1: 14 atoms
##  CMP2: 25 atoms
##  MCS: 14 atoms
##  Tanimoto Coefficient: 0.56
##  Overlap Coefficient: 1
```

If `fmcs` is run with `fast=TRUE` then it returns the numeric summary information in a
named `vector`.

```
fmcs(sdfset[1], sdfset[2], fast=TRUE)
```

```
##           Query_Size          Target_Size             MCS_Size Tanimoto_Coefficient
##           14.0000000           33.0000000            8.0000000            0.2051282
##  Overlap_Coefficient
##            0.5714286
```

## 5.3 Class Usage

The `MCS` class contains three components named `stats`, `mcs1` and `mcs2`. The `stats` slot stores the
numeric summary information, while the structural MCS information for
the query and target structures is stored in the `mcs1` and `mcs2` slots,
respectively. The latter two slots each contain a `list` with two
subcomponents: the original query/target structures as `SDFset` objects as well
as one or more numeric index vector(s) specifying the MCS information in
form of the row positions in the atom block of the corresponding `SDFset`. A
call to `fmcs` will often return several index vectors. In those cases the
algorithm has identified alternative MCSs of equal size.

```
slotNames(mcsa)
```

```
## [1] "stats" "mcs1"  "mcs2"
```

Accessor methods are provided to return the different data components of
the `MCS` class.

```
stats(mcsa) # or mcsa[["stats"]]
```

```
##           Query_Size          Target_Size             MCS_Size Tanimoto_Coefficient
##           14.0000000           33.0000000            8.0000000            0.2051282
##  Overlap_Coefficient
##            0.5714286
```

```
mcsa1 <- mcs1(mcsa) # or mcsa[["mcs1"]]
mcsa2 <- mcs2(mcsa) # or mcsa[["mcs2"]]
mcsa1[1] # returns SDFset component
```

```
## $query
## An instance of "SDFset" with 1 molecules
```

```
mcsa1[[2]][1:2] # return first two index vectors
```

```
## $CMP1_fmcs_1
## [1]  3  8  7  4  9  5 11  1
##
## $CMP1_fmcs_2
## [1]  3  8  7  4  9  5  1 13
```

The `mcs2sdfset` function can be used to return the substructures stored in an
`MCS` instance as `SDFset` object. If `type='new'` new atom numbers will be assigned to the
subsetted SDF, while `type='old'` will maintain the atom numbers from its source. For
details consult the help documents `?mcs2sdfset` and `?atomsubset`.

```
mcstosdfset <- mcs2sdfset(mcsa, type="new")
plot(mcstosdfset[[1]], print=FALSE)
```

![](data:image/png;base64...)

To construct an `MCS` object manually, one can provide the required data
components in a `list`.

```
mylist <- list(stats=stats(mcsa), mcs1=mcs1(mcsa), mcs2=mcs2(mcsa))
as(mylist, "MCS")
```

```
## An instance of "MCS"
##  Number of MCSs: 7
##  CMP1: 14 atoms
##  CMP2: 33 atoms
##  MCS: 8 atoms
##  Tanimoto Coefficient: 0.20513
##  Overlap Coefficient: 0.57143
```

# 6 FMCS of Two Compounds

If `fmcs` is run with its default paramenters then it returns the MCS of two
compounds, because the mismatch parameters are all set to zero. To
identify FMCSs, one has to increase the number of upper bound atom mismatches `au`
and/or bond mismatches `bu` to interger values above zero.

```
plotMCS(fmcs(sdfset[1], sdfset[2], au=0, bu=0))
```

![](data:image/png;base64...)

```
plotMCS(fmcs(sdfset[1], sdfset[2], au=1, bu=1))
```

![](data:image/png;base64...)

```
plotMCS(fmcs(sdfset[1], sdfset[2], au=2, bu=2))
```

![](data:image/png;base64...)

```
plotMCS(fmcs(sdfset[1], sdfset[3], au=0, bu=0))
```

![](data:image/png;base64...)

# 7 FMCS Search Functionality

The `fmcsBatch` function provides FMCS search functionality for compound collections
stored in `SDFset` objects.

```
data(sdfsample) # Loads larger sample data set
sdf <- sdfsample
fmcsBatch(sdf[1], sdf[1:30], au=0, bu=0)
```

```
##       Query_Size Target_Size MCS_Size Tanimoto_Coefficient Overlap_Coefficient
## CMP1          33          33       33            1.0000000           1.0000000
## CMP2          33          26       11            0.2291667           0.4230769
## CMP3          33          26       10            0.2040816           0.3846154
## CMP4          33          32        9            0.1607143           0.2812500
## CMP5          33          23       14            0.3333333           0.6086957
## CMP6          33          19       13            0.3333333           0.6842105
## CMP7          33          21        9            0.2000000           0.4285714
## CMP8          33          31        8            0.1428571           0.2580645
## CMP9          33          21        9            0.2000000           0.4285714
## CMP10         33          21        8            0.1739130           0.3809524
## CMP11         33          36       15            0.2777778           0.4545455
## CMP12         33          26       12            0.2553191           0.4615385
## CMP13         33          26       11            0.2291667           0.4230769
## CMP14         33          16       12            0.3243243           0.7500000
## CMP15         33          34       15            0.2884615           0.4545455
## CMP16         33          25        8            0.1600000           0.3200000
## CMP17         33          19        8            0.1818182           0.4210526
## CMP18         33          24       10            0.2127660           0.4166667
## CMP19         33          25       14            0.3181818           0.5600000
## CMP20         33          26       10            0.2040816           0.3846154
## CMP21         33          25       15            0.3488372           0.6000000
## CMP22         33          21       11            0.2558140           0.5238095
## CMP23         33          26       11            0.2291667           0.4230769
## CMP24         33          17        6            0.1363636           0.3529412
## CMP25         33          27        9            0.1764706           0.3333333
## CMP26         33          24       13            0.2954545           0.5416667
## CMP27         33          26       11            0.2291667           0.4230769
## CMP28         33          20       10            0.2325581           0.5000000
## CMP29         33          20        8            0.1777778           0.4000000
## CMP30         33          18        7            0.1590909           0.3888889
```

# 8 Clustering with FMCS

The `fmcsBatch` function can be used to compute a similarity matrix for clustering
with various algorithms available in R. The following example uses the
FMCS algorithm to compute a similarity matrix that is used for
hierarchical clustering with the `hclust` function and the result is plotted in
form of a dendrogram.

```
sdf <- sdf[1:7]
d <- sapply(cid(sdf), function(x) fmcsBatch(sdf[x], sdf, au=0, bu=0, matching.mode="aromatic")[,"Overlap_Coefficient"])
d
```

```
##           CMP1      CMP2      CMP3      CMP4      CMP5      CMP6      CMP7
## CMP1 1.0000000 0.2307692 0.2307692 0.2812500 0.5217391 0.6842105 0.2857143
## CMP2 0.2307692 1.0000000 0.4230769 0.5384615 0.2173913 0.4736842 0.2857143
## CMP3 0.2307692 0.4230769 1.0000000 0.3076923 0.2173913 0.4736842 0.9047619
## CMP4 0.2812500 0.5384615 0.3076923 1.0000000 0.3043478 0.5263158 0.2857143
## CMP5 0.5217391 0.2173913 0.2173913 0.3043478 1.0000000 0.5789474 0.2380952
## CMP6 0.6842105 0.4736842 0.4736842 0.5263158 0.5789474 1.0000000 0.3157895
## CMP7 0.2857143 0.2857143 0.9047619 0.2857143 0.2380952 0.3157895 1.0000000
```

```
hc <- hclust(as.dist(1-d), method="complete")
plot(as.dendrogram(hc), edgePar=list(col=4, lwd=2), horiz=TRUE)
```

![](data:image/png;base64...)

The FMCS shared among compound pairs of interest can be visualized
with `plotMCS`, here for the two most similar compounds from the previous tree:

```
plotMCS(fmcs(sdf[3], sdf[7], au=0, bu=0, matching.mode="aromatic"))
```

![](data:image/png;base64...)

# 9 Version Information

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
## [1] ChemmineOB_1.48.0 fmcsR_1.52.0      ChemmineR_3.62.0  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10         generics_0.1.4      bitops_1.0-9        digest_0.6.37
##  [5] magrittr_2.0.4      evaluate_1.0.5      grid_4.5.1          RColorBrewer_1.1-3
##  [9] bookdown_0.45       fastmap_1.2.0       jsonlite_2.0.0      DBI_1.2.3
## [13] tinytex_0.57        gridExtra_2.3       BiocManager_1.30.26 scales_1.4.0
## [17] codetools_0.2-20    jquerylib_0.1.4     cli_3.6.5           rlang_1.1.6
## [21] base64enc_0.1-3     cachem_1.1.0        yaml_2.3.10         tools_4.5.1
## [25] parallel_4.5.1      dplyr_1.1.4         ggplot2_4.0.0       DT_0.34.0
## [29] vctrs_0.6.5         R6_2.6.1            png_0.1-8           magick_2.9.0
## [33] lifecycle_1.0.4     rsvg_2.7.0          htmlwidgets_1.6.4   pkgconfig_2.0.3
## [37] pillar_1.11.1       bslib_0.9.0         gtable_0.3.6        glue_1.8.0
## [41] Rcpp_1.1.0          xfun_0.53           tibble_3.3.0        tidyselect_1.2.1
## [45] knitr_1.50          dichromat_2.0-0.1   farver_2.1.2        rjson_0.2.23
## [49] htmltools_0.5.8.1   rmarkdown_2.30      compiler_4.5.1      S7_0.2.0
## [53] RCurl_1.98-1.17
```

# References

Backman, T W, Y Cao, and T Girke. 2011. “ChemMine tools: an online service for analyzing and clustering small molecules.” *Nucleic Acids Res* 39 (Web Server issue): 486–91. <https://doi.org/10.1093/nar/gkr320>.

Cao, Y, A Charisi, L C Cheng, T Jiang, and T Girke. 2008. “ChemmineR: a compound mining framework for R.” *Bioinformatics* 24 (15): 1733–4. <https://doi.org/10.1093/bioinformatics/btn307>.

Cao, Y, T Jiang, and T Girke. 2008. “A maximum common substructure-based algorithm for searching and predicting drug-like compounds.” *Bioinformatics* 24 (13): 366–74. <https://doi.org/10.1093/bioinformatics/btn186>.

Wang, Y, T W Backman, K Horan, and T Girke. 2013. “fmcsR: Mismatch Tolerant Maximum Common Substructure Searching in R.” *Bioinformatics*, August. <https://doi.org/10.1093/bioinformatics/btt475>.