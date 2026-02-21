# phastCons30way.UCSC.hg38 AnnotationHub Resource Metadata

Robert Castelo1\*

1Dept. of Experimental and Health Sciences, Universitat Pompeu Fabra, Barcelona, Spain

\*robert.castelo@upf.edu

#### 11 June 2025

#### Abstract

Store phastCons30way.UCSC.hg38 AnnotationHub Resource Metadata.

#### Package

phastCons30way.UCSC.hg38 3.13.1

# 1 Retrieval of phastCons30way.UCSC.hg38 genomic scores through AnnotationHub resources

The `phastCons30way.UCSC.hg38` package provides metadata for the
*[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* resources associated with human phastCons
conservation scores calculated from multiple genome alignments of the
human genome with 29 other mammal genomes, including 26 primates. The original data can be
found at the UCSC download [site](http://hgdownload.soe.ucsc.edu/goldenPath/hg38/multiz30way).
Details about how those original data were processed into
*[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* resources can be found in the source
file:

```
phastCons30way.UCSC.hg38/scripts/make-metadata_phastCons30way.UCSC.hg38.R
```

The genomic scores for `phastCons30way.UCSC.hg38` can be retrieved using the
*[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)*,
which is a web resource that provides a central location where genomic files
(e.g., VCF, bed, wig) and other resources from standard (e.g., UCSC, Ensembl) and
distributed sites, can be found. A Bioconductor *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* web
resource creates and manages a local cache of files retrieved by the user,
helping with quick and reproducible access.

While the *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* API can be used to query those resources,
we encourage to use the *[GenomicScores](https://bioconductor.org/packages/3.22/GenomicScores)* API, as follows.
The first step to retrieve genomic scores is to check the ones available to download.

```
availableGScores()
```

```
##  [1] "AlphaMissense.v2023.hg19"          "AlphaMissense.v2023.hg38"
##  [3] "cadd.v1.6.hg19"                    "cadd.v1.6.hg38"
##  [5] "fitCons.UCSC.hg19"                 "linsight.UCSC.hg19"
##  [7] "mcap.v1.0.hg19"                    "phastCons7way.UCSC.hg38"
##  [9] "phastCons27way.UCSC.dm6"           "phastCons30way.UCSC.hg38"
## [11] "phastCons35way.UCSC.mm39"          "phastCons46wayPlacental.UCSC.hg19"
## [13] "phastCons46wayPrimates.UCSC.hg19"  "phastCons60way.UCSC.mm10"
## [15] "phastCons100way.UCSC.hg19"         "phastCons100way.UCSC.hg38"
## [17] "phyloP35way.UCSC.mm39"             "phyloP60way.UCSC.mm10"
## [19] "phyloP100way.UCSC.hg19"            "phyloP100way.UCSC.hg38"
```

The selected resource can be downloaded with the function getGScores().
After the resource is downloaded the first time, the cached copy will
enable a quicker retrieval later.

```
phast <- getGScores("phastCons30way.UCSC.hg38")
```

Finally, the phastCons score of a particular genomic position
is retrieved using the function ‘gscores()’. Please consult the
the documentation of the *[GenomicScores](https://bioconductor.org/packages/3.22/GenomicScores)* package
for details on how to use it.

```
gscores(phast, GRanges(seqnames="chr22", IRanges(start=50967020:50967025, width=1)))
```

## 1.1 Building an annotation package from a GScores object

Retrieving genomic scores through `AnnotationHub` resources requires an internet
connection and we may want to work with such resources offline. For that purpose,
we can create ourselves an annotation package, such as
[phastCons100way.UCSC.hg19](https://bioconductor.org/packages/phastCons100way.UCSC.hg19),
from a `GScores` object corresponding to a downloaded `AnnotationHub` resource.
To do that we use the function `makeGScoresPackage()` as follows:

```
makeGScoresPackage(phast, maintainer="Me <me@example.com>", author="Me", version="1.0.0")
```

```
## Creating package in ./phastCons30way.UCSC.hg38
```

An argument, `destDir`, which by default points to the current working
directory, can be used to change where in the filesystem the package is created.
Afterwards, we should still build and install the package via, e.g.,
`R CMD build` and `R CMD INSTALL`, to be able to use it offline.

# 2 Session information

```
sessionInfo()
```

```
## R version 4.5.0 (2025-04-11)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.2 LTS
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
## [1] BiocStyle_2.37.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37       R6_2.6.1            bookdown_0.43
##  [4] fastmap_1.2.0       xfun_0.52           cachem_1.1.0
##  [7] knitr_1.50          htmltools_0.5.8.1   rmarkdown_2.29
## [10] lifecycle_1.0.4     cli_3.6.5           sass_0.4.10
## [13] jquerylib_0.1.4     compiler_4.5.0      tools_4.5.0
## [16] evaluate_1.0.3      bslib_0.9.0         yaml_2.3.10
## [19] BiocManager_1.30.26 jsonlite_2.0.0      rlang_1.1.6
```