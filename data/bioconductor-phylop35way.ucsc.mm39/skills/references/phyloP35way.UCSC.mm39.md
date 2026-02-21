# phyloP35way.UCSC.mm39 AnnotationHub Resource Metadata

Robert Castelo1\*

1Dept. of Experimental and Health Sciences, Universitat Pompeu Fabra, Barcelona, Spain

\*robert.castelo@upf.edu

#### 12 July 2022

#### Abstract

Store phyloP35way.UCSC.mm39 AnnotationHub Resource Metadata.

#### Package

phyloP35way.UCSC.mm39 3.16.0

# 1 Retrieval of phyloP35way.UCSC.mm39 genomic scores through AnnotationHub resources

The `phyloP35way.UCSC.mm39` package provides metadata for the
*[AnnotationHub](https://bioconductor.org/packages/3.16/AnnotationHub)* resources associated with mouse phyloP
conservation scores calculated from multiple genome alignments of the
human genome with 34 other vertebrate genomes. The original data can be
found at the UCSC download [site](https://hgdownload.soe.ucsc.edu/goldenPath/mm39/phyloP35way).
Details about how those original data were processed into
*[AnnotationHub](https://bioconductor.org/packages/3.16/AnnotationHub)* resources can be found in the source
file:

```
phyloP35way.UCSC.mm39/scripts/make-metadata_phyloP35way.UCSC.mm39.R
```

The genomic scores for `phyloP35way.UCSC.mm39` can be retrieved using the
*[AnnotationHub](https://bioconductor.org/packages/3.16/AnnotationHub)*,
which is a web resource that provides a central location where genomic files
(e.g., VCF, bed, wig) and other resources from standard (e.g., UCSC, Ensembl) and
distributed sites, can be found. A Bioconductor *[AnnotationHub](https://bioconductor.org/packages/3.16/AnnotationHub)* web
resource creates and manages a local cache of files retrieved by the user,
helping with quick and reproducible access.

While the *[AnnotationHub](https://bioconductor.org/packages/3.16/AnnotationHub)* API can be used to query those resources,
we encourage to use the *[GenomicScores](https://bioconductor.org/packages/3.16/GenomicScores)* API, as follows.
The first step to retrieve genomic scores is to check the ones available to download.

```
availableGScores()
```

```
##  [1] "cadd.v1.3.hg19"                    "fitCons.UCSC.hg19"
##  [3] "linsight.UCSC.hg19"                "mcap.v1.0.hg19"
##  [5] "phastCons7way.UCSC.hg38"           "phastCons27way.UCSC.dm6"
##  [7] "phastCons30way.UCSC.hg38"          "phastCons46wayPlacental.UCSC.hg19"
##  [9] "phastCons46wayPrimates.UCSC.hg19"  "phastCons60way.UCSC.mm10"
## [11] "phastCons100way.UCSC.hg19"         "phastCons100way.UCSC.hg38"
## [13] "phyloP60way.UCSC.mm10"             "phyloP100way.UCSC.hg19"
## [15] "phyloP100way.UCSC.hg38"            "phastCons35way.UCSC.mm39"
## [17] "phyloP35way.UCSC.mm39"
```

The selected resource can be downloaded with the function getGScores().
After the resource is downloaded the first time, the cached copy will
enable a quicker retrieval later.

```
phylop <- getGScores("phyloP35way.UCSC.mm39")
```

Finally, the phyloP score of a particular genomic position
is retrieved using the function ‘gscores()’. Please consult the
the documentation of the *[GenomicScores](https://bioconductor.org/packages/3.16/GenomicScores)* package
for details on how to use it.

```
gscores(phylop, GRanges(seqnames="chr22", IRanges(start=50967020:50967025, width=1)))
```

## 1.1 Building an annotation package from a GScores object

Retrieving genomic scores through `AnnotationHub` resources requires an internet
connection and we may want to work with such resources offline. For that purpose,
we can create ourselves an annotation package, such as
[phastCons100way.UCSC.hg19](https://bioconductor.org/packages/phastCons100way.UCSC.hg19),
from a `GScores` object corresponding to a downloaded `AnnotationHub` resource.
To do that we use the function `makeGScoresPackage()` as follows:

```
makeGScoresPackage(phylop, maintainer="Me <me@example.com>", author="Me", version="1.0.0")
```

```
## Creating package in ./phyloP35way.UCSC.mm39
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
## R version 4.2.0 Patched (2022-05-05 r82321)
## Platform: x86_64-apple-darwin19.6.0 (64-bit)
## Running under: macOS Catalina 10.15.7
##
## Matrix products: default
## BLAS:   /Users/ka36530_ca/R-stuff/bin/R-4-2/lib/libRblas.dylib
## LAPACK: /Users/ka36530_ca/R-stuff/bin/R-4-2/lib/libRlapack.dylib
##
## locale:
## [1] C/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] BiocStyle_2.25.0
##
## loaded via a namespace (and not attached):
##  [1] bookdown_0.27       digest_0.6.29       R6_2.5.1
##  [4] jsonlite_1.8.0      magrittr_2.0.3      evaluate_0.15
##  [7] stringi_1.7.6       rlang_1.0.3         cli_3.3.0
## [10] jquerylib_0.1.4     bslib_0.3.1         rmarkdown_2.14
## [13] tools_4.2.0         stringr_1.4.0       xfun_0.31
## [16] yaml_2.3.5          fastmap_1.1.0       compiler_4.2.0
## [19] BiocManager_1.30.18 htmltools_0.5.2     knitr_1.39
## [22] sass_0.4.1
```