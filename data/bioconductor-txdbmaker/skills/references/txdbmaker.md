# Making TxDb Objects

Marc Carlson, Patrick Aboyoun, Hervé Pagès, Seth Falcon and Martin Morgan

#### Compiled 11 December 2025; Modified 4 April 2024

#### Package

txdbmaker 1.6.2

# Contents

* [1 Introduction](#introduction)
* [2 Installing the `txdbmaker` package](#installing-the-txdbmaker-package)
* [3 Using `makeTxDbFromUCSC`](#using-maketxdbfromucsc)
* [4 Using `makeTxDbFromBiomart`](#using-maketxdbfrombiomart)
* [5 Using `makeTxDbFromEnsembl`](#using-maketxdbfromensembl)
* [6 Using `makeTxDbFromGFF`](#using-maketxdbfromgff)
* [7 Saving and Loading a `TxDb` Object](#saving-and-loading-a-txdb-object)
* [8 Using `makeTxDbPackageFromUCSC` and `makeTxDbPackageFromBiomart`](#using-maketxdbpackagefromucsc-and-maketxdbpackagefrombiomart)
* [9 Session Information](#session-information)

# 1 Introduction

The *[txdbmaker](https://bioconductor.org/packages/3.22/txdbmaker)* package provides functions to make `TxDb`
objects from genomic annotation provided by the UCSC Genome Browser
(<https://genome.ucsc.edu/>), Ensembl (<https://ensembl.org/>),
BioMart (<http://www.biomart.org/>), or directly from a GFF or GTF file.

In this document we will quickly demonstrate the use of these
functions.

Note that the package also provides a lower-level utility, `makeTxDb()`,
for creating `TxDb` objects from data directly supplied by the user.
Please refer to its man page (`?makeTxDb`) for more information.

See vignette in the *[GenomicFeatures](https://bioconductor.org/packages/3.22/GenomicFeatures)* package for an
introduction to `TxDb` objects.

# 2 Installing the `txdbmaker` package

Install the package with:

```
if (!require("BiocManager", quietly=TRUE))
    install.packages("BiocManager")

BiocManager::install("txdbmaker")
```

Then load it with:

```
suppressPackageStartupMessages(library(txdbmaker))
```

# 3 Using `makeTxDbFromUCSC`

The function `makeTxDbFromUCSC` downloads UCSC
Genome Bioinformatics transcript tables (e.g. `knownGene`,
`refGene`, `ensGene`) for a genome build (e.g.
`mm9`, `hg19`). Use the `supportedUCSCtables`
utility function to get the list of tables known to work with
`makeTxDbFromUCSC`.

```
supportedUCSCtables(genome="mm9")
```

```
##         tablename              track composite_track
## 1         acembly      AceView Genes            <NA>
## 2    augustusGene           AUGUSTUS            <NA>
## 3        ccdsGene               CCDS            <NA>
## 4         ensGene      Ensembl Genes            <NA>
## 5        exoniphy           Exoniphy            <NA>
## 6          geneid       Geneid Genes            <NA>
## 7         genscan      Genscan Genes            <NA>
## 8       knownGene         UCSC Genes            <NA>
## 9   knownGeneOld4     Old UCSC Genes            <NA>
## 10      nscanGene             N-SCAN            <NA>
## 11   pseudoYale60      Yale Pseudo60            <NA>
## 12        refGene       RefSeq Genes            <NA>
## 13        sgpGene          SGP Genes            <NA>
## 14  transcriptome      Transcriptome            <NA>
## 15 vegaPseudoGene   Vega Pseudogenes      Vega Genes
## 16       vegaGene Vega Protein Genes      Vega Genes
## 17    xenoRefGene       Other RefSeq            <NA>
```

```
mm9KG_txdb <- makeTxDbFromUCSC(genome="mm9", tablename="knownGene")
```

```
## Download the knownGene table ... OK
## Download the knownToLocusLink table ... OK
## Extract the 'transcripts' data frame ... OK
## Extract the 'splicings' data frame ... OK
## Download and preprocess the 'chrominfo' data frame ... OK
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
mm9KG_txdb
```

```
## TxDb object:
## # Db type: TxDb
## # Supporting package: GenomicFeatures
## # Data source: UCSC
## # Genome: mm9
## # Organism: Mus musculus
## # Taxonomy ID: 10090
## # UCSC Table: knownGene
## # UCSC Track: UCSC Genes
## # Resource URL: https://genome.ucsc.edu/
## # Type of Gene ID: Entrez Gene ID
## # Full dataset: yes
## # Nb of transcripts: 55419
## # Db created by: txdbmaker package from Bioconductor
## # Creation time: 2025-12-11 21:35:33 -0500 (Thu, 11 Dec 2025)
## # txdbmaker version at creation time: 1.6.2
## # RSQLite version at creation time: 2.4.5
## # DBSCHEMAVERSION: 1.2
```

See `?makeTxDbFromUCSC` for more information.

# 4 Using `makeTxDbFromBiomart`

Retrieve data from BioMart by specifying the mart and the data set to
the `makeTxDbFromBiomart` function (not all BioMart
data sets are currently supported):

```
mmusculusEnsembl <- makeTxDbFromBiomart(dataset="mmusculus_gene_ensembl")
```

As with the `makeTxDbFromUCSC` function, the
`makeTxDbFromBiomart` function also has a
`circ_seqs` argument that will default to using the contents
of the `DEFAULT_CIRC_SEQS` vector. And just like those UCSC
sources, there is also a helper function called
`getChromInfoFromBiomart` that can show what the different
chromosomes are called for a given source.

Using the `makeTxDbFromBiomart`
`makeTxDbFromUCSC` functions can take a while and
may also require some bandwidth as these methods have to download and
then assemble a database from their respective sources. It is not
expected that most users will want to do this step every time.
Instead, we suggest that you save your annotation objects and label
them with an appropriate time stamp so as to facilitate reproducible
research.

See `?makeTxDbFromBiomart` for more information.

# 5 Using `makeTxDbFromEnsembl`

The `makeTxDbFromEnsembl` function creates a `TxDb` object
for a given organism by importing the genomic locations of its transcripts,
exons, CDS, and genes from an Ensembl database.

See `?makeTxDbFromEnsembl` for more information.

# 6 Using `makeTxDbFromGFF`

You can also extract transcript information from either GFF3 or GTF
files by using the `makeTxDbFromGFF` function.
Usage is similar to `makeTxDbFromBiomart` and
`makeTxDbFromUCSC`.

See `?makeTxDbFromGFF` for more information.

# 7 Saving and Loading a `TxDb` Object

Once a `TxDb` object has been created, it can be saved
to avoid the time and bandwidth costs of recreating it and to make it
possible to reproduce results with identical genomic feature data at a
later date. Since `TxDb` objects are backed by a
SQLite database, the save format is a SQLite database file (which
could be accessed from programs other than R if desired). Note that
it is not possible to serialize a `TxDb` object using
R’s `save` function.

```
saveDb(mm9KG_txdb, file="mm9KG_txdb.sqlite")
```

And as was mentioned earlier, a saved `TxDb` object can
be initialized from a .sqlite file by simply using `loadDb`.

```
mm9KG_txdb <- loadDb("mm9KG_txdb.sqlite")
```

# 8 Using `makeTxDbPackageFromUCSC` and `makeTxDbPackageFromBiomart`

It is often much more convenient to just make an annotation package
out of your annotations. If you are finding that this is the case,
then you should consider the convenience functions:
`makeTxDbPackageFromUCSC` and
`makeTxDbPackageFromBiomart`. These functions are similar
to `makeTxDbFromUCSC` and
`makeTxDbFromBiomart` except that they will take the
extra step of actually wrapping the database up into an annotation
package for you. This package can then be installed and used as of
the standard TxDb packages found on in the Bioconductor
repository.

# 9 Session Information

```
## R version 4.5.2 (2025-10-31)
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
##  [1] txdbmaker_1.6.2        GenomicFeatures_1.62.0 AnnotationDbi_1.72.0
##  [4] Biobase_2.70.0         GenomicRanges_1.62.1   IRanges_2.44.0
##  [7] Seqinfo_1.0.0          S4Vectors_0.48.0       BiocGenerics_0.56.0
## [10] generics_0.1.4         BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            dplyr_1.1.4
##  [3] blob_1.2.4                  filelock_1.0.3
##  [5] Biostrings_2.78.0           bitops_1.0-9
##  [7] fastmap_1.2.0               RCurl_1.98-1.17
##  [9] BiocFileCache_3.0.0         GenomicAlignments_1.46.0
## [11] XML_3.99-0.20               digest_0.6.39
## [13] timechange_0.3.0            lifecycle_1.0.4
## [15] KEGGREST_1.50.0             RSQLite_2.4.5
## [17] magrittr_2.0.4              compiler_4.5.2
## [19] rlang_1.1.6                 sass_0.4.10
## [21] progress_1.2.3              tools_4.5.2
## [23] yaml_2.3.12                 rtracklayer_1.70.0
## [25] knitr_1.50                  prettyunits_1.2.0
## [27] S4Arrays_1.10.1             bit_4.6.0
## [29] curl_7.0.0                  DelayedArray_0.36.0
## [31] abind_1.4-8                 BiocParallel_1.44.0
## [33] grid_4.5.2                  biomaRt_2.66.0
## [35] SummarizedExperiment_1.40.0 cli_3.6.5
## [37] rmarkdown_2.30              crayon_1.5.3
## [39] otel_0.2.0                  httr_1.4.7
## [41] rjson_0.2.23                DBI_1.2.3
## [43] cachem_1.1.0                stringr_1.6.0
## [45] parallel_4.5.2              BiocManager_1.30.27
## [47] XVector_0.50.0              restfulr_0.0.16
## [49] matrixStats_1.5.0           vctrs_0.6.5
## [51] Matrix_1.7-4                jsonlite_2.0.0
## [53] bookdown_0.46               hms_1.1.4
## [55] bit64_4.6.0-1               jquerylib_0.1.4
## [57] glue_1.8.0                  codetools_0.2-20
## [59] lubridate_1.9.4             stringi_1.8.7
## [61] GenomeInfoDb_1.46.2         BiocIO_1.20.0
## [63] UCSC.utils_1.6.1            tibble_3.3.0
## [65] pillar_1.11.1               rappdirs_0.3.3
## [67] htmltools_0.5.9             GenomeInfoDbData_1.2.15
## [69] R6_2.6.1                    dbplyr_2.5.1
## [71] httr2_1.2.2                 evaluate_1.0.5
## [73] lattice_0.22-7              RMariaDB_1.3.4
## [75] png_0.1-8                   Rsamtools_2.26.0
## [77] cigarillo_1.0.0             memoise_2.0.1
## [79] bslib_0.9.0                 SparseArray_1.10.7
## [81] xfun_0.54                   MatrixGenerics_1.22.0
## [83] pkgconfig_2.0.3
```