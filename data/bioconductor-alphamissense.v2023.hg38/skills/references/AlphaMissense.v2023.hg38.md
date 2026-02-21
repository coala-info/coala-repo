# AlphaMissense.v2023.hg38 AnnotationHub Resource Metadata

Robert Castelo1\*

1Dept. of Medicine and Life Sciences, Universitat Pompeu Fabra, Barcelona, Spain

\*robert.castelo@upf.edu

#### 25 October 2023

#### Abstract

Store AlphaMissense.v2023.hg38 AnnotationHub Resource Metadata.

#### Package

AlphaMissense.v2023.hg38 3.18.2

# 1 Retrieval of AlphaMissense.v2023.hg38 pathogenicity scores through AnnotationHub resources

The `AlphaMissense.v2023.hg38` package provides metadata for the
*[AnnotationHub](https://bioconductor.org/packages/3.18/AnnotationHub)* resources associated with human AlphaMissense
pathogenicity scores [@cheng2023accurate]. The original data can be found at
the Google DeepMind download
[site](https://console.cloud.google.com/storage/browser/dm_alphamissense).
Details about how those original data were processed into
*[AnnotationHub](https://bioconductor.org/packages/3.18/AnnotationHub)* resources can be found in the source
file:

```
AlphaMissense.v2023.hg38/scripts/make-metadata_AlphaMissense.v2023.hg38.R
```

The pathogenicity scores for `AlphaMissense.v2023.hg38` can be retrieved using
the *[AnnotationHub](https://bioconductor.org/packages/3.18/AnnotationHub)*,
which is a web resource that provides a central location where genomic files
(e.g., VCF, bed, wig) and other resources from standard (e.g., UCSC, Ensembl) and
distributed sites, can be found. A Bioconductor *[AnnotationHub](https://bioconductor.org/packages/3.18/AnnotationHub)* web
resource creates and manages a local cache of files retrieved by the user,
helping with quick and reproducible access.

While the *[AnnotationHub](https://bioconductor.org/packages/3.18/AnnotationHub)* API can be used to query those resources,
we encourage to use the *[GenomicScores](https://bioconductor.org/packages/3.18/GenomicScores)* API
[@puigdevall2018genomicscores], as follows. The first step to retrieve genomic
scores is to check the ones available to download.

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
enable a quicker retrieval later. In this case, because AlphaMissense
scores are distributed under a
[CC BY-NC-SA 4.0](https://github.com/google-deepmind/alphamissense#alphamissense-predictions-license) license, we should add the argument
`accept.license=TRUE` to non-interactively obtain the data. If we
do call `getGScores()` interactively without that argument, the function
will ask us to accept the license.

```
am23 <- getGScores("AlphaMissense.v2023.hg38", accept.license=TRUE)
am23
```

```
## GScores object
## # organism: Homo sapiens (UCSC, hg38)
## # provider: Google DeepMind
## # provider version: v2023
## # download date: Oct 10, 2023
## # loaded sequences: chr1
## # maximum abs. error: 0.005
## # license: CC BY-NC-SA 4.0, see https://creativecommons.org/licenses/by-nc-sa/4.0
## # use 'citation()' to cite these data in publications
```

```
citation(am23)
```

```
## Jun Cheng, Guido Novati, Joshua Pan, Clare Bycroft, Akvilė Žemgulytė,
## Taylor Applebaum, Alexander Pritzel, Lai Hong Wong, Michal Zielinski,
## Tobias Sargeant, Rosalia G. Schneider, Andrew W. Senior, John Jumper,
## Demis Hassabis, Pushmeet Kohli, Žiga Avsec (2023). "Accurate
## proteome-wide missense variant effect prediction with AlphaMissense."
## _Science_, *381*, eadg7492. doi:10.1126/science.adg7492
## <https://doi.org/10.1126/science.adg7492>.
```

Finally, the AlphaMissense pathogenicity score of a particular genomic position
is retrieved using the function ‘gscores()’. Please consult the documentation
of the *[GenomicScores](https://bioconductor.org/packages/3.18/GenomicScores)* package for details on how to use it. For
instance, @cheng2023accurate report likely pathogenic scores for variants in
the human glucose sensor GCK. If we would like to retrieve the AlphaMissense
score of the variant
[NM\_000162.5(GCK):c.1174C>T (p.Arg392Cys)](https://www.ncbi.nlm.nih.gov/clinvar/variation/585909),
classified as pathogenic in the ClinVar database, we should call `gscores()`
as follows.

```
gscores(am23, GRanges("chr7:44145576"), ref="C", alt="T")
```

```
## GRanges object with 1 range and 1 metadata column:
##       seqnames    ranges strand |   default
##          <Rle> <IRanges>  <Rle> | <numeric>
##   [1]     chr7  44145576      * |      0.87
##   -------
##   seqinfo: 25 sequences (1 circular) from hg38 genome
```

## 1.1 Building an annotation package from a GScores object

Retrieving genomic scores through `AnnotationHub` resources requires an internet
connection and we may want to work with such resources offline. For that purpose,
we can create ourselves an annotation package, such as
[phastCons100way.UCSC.hg38](https://bioconductor.org/packages/phastCons100way.UCSC.hg38),
from a `GScores` object corresponding to a downloaded `AnnotationHub` resource.
To do that we use the function `makeGScoresPackage()` as follows:

```
makeGScoresPackage(am23, maintainer="Me <me@example.com>", author="Me", version="1.0.0")
```

```
## Creating package in ./AlphaMissense.v2023.hg38
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
## R version 4.3.1 (2023-06-16)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 22.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.18-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.10.0
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
##  [1] GenomicScores_2.14.0 GenomicRanges_1.54.0 GenomeInfoDb_1.38.0
##  [4] IRanges_2.36.0       S4Vectors_0.40.0     AnnotationHub_3.10.0
##  [7] BiocFileCache_2.10.0 dbplyr_2.3.4         BiocGenerics_0.48.0
## [10] BiocStyle_2.30.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.0              dplyr_1.1.3
##  [3] blob_1.2.4                    filelock_1.0.2
##  [5] Biostrings_2.70.0             bitops_1.0-7
##  [7] fastmap_1.1.1                 RCurl_1.98-1.12
##  [9] promises_1.2.1                XML_3.99-0.14
## [11] digest_0.6.33                 mime_0.12
## [13] lifecycle_1.0.3               ellipsis_0.3.2
## [15] KEGGREST_1.42.0               interactiveDisplayBase_1.40.0
## [17] RSQLite_2.3.1                 magrittr_2.0.3
## [19] compiler_4.3.1                rlang_1.1.1
## [21] sass_0.4.7                    tools_4.3.1
## [23] utf8_1.2.4                    yaml_2.3.7
## [25] knitr_1.44                    S4Arrays_1.2.0
## [27] bit_4.0.5                     curl_5.1.0
## [29] DelayedArray_0.28.0           abind_1.4-5
## [31] HDF5Array_1.30.0              withr_2.5.1
## [33] purrr_1.0.2                   grid_4.3.1
## [35] fansi_1.0.5                   xtable_1.8-4
## [37] Rhdf5lib_1.24.0               cli_3.6.1
## [39] rmarkdown_2.25                crayon_1.5.2
## [41] generics_0.1.3                httr_1.4.7
## [43] DBI_1.1.3                     cachem_1.0.8
## [45] rhdf5_2.46.0                  zlibbioc_1.48.0
## [47] AnnotationDbi_1.64.0          BiocManager_1.30.22
## [49] XVector_0.42.0                matrixStats_1.0.0
## [51] vctrs_0.6.4                   Matrix_1.6-1.1
## [53] jsonlite_1.8.7                bookdown_0.36
## [55] bit64_4.0.5                   jquerylib_0.1.4
## [57] glue_1.6.2                    BiocVersion_3.18.0
## [59] later_1.3.1                   tibble_3.2.1
## [61] pillar_1.9.0                  rappdirs_0.3.3
## [63] htmltools_0.5.6.1             rhdf5filters_1.14.0
## [65] GenomeInfoDbData_1.2.11       R6_2.5.1
## [67] evaluate_0.22                 shiny_1.7.5.1
## [69] Biobase_2.62.0                lattice_0.22-5
## [71] png_0.1-8                     memoise_2.0.1
## [73] httpuv_1.6.12                 bslib_0.5.1
## [75] Rcpp_1.0.11                   SparseArray_1.2.0
## [77] xfun_0.40                     MatrixGenerics_1.14.0
## [79] pkgconfig_2.0.3
```

# 3 References