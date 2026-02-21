# The *UCSC.utils* package

Hervé Pagès1

1Fred Hutch Cancer Center, Seattle, WA

#### Compiled 11 December 2025; Modified 14 January 2025

#### Package

UCSC.utils 1.6.1

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Functions defined in the package](#functions-defined-in-the-package)
  + [3.1 list\_UCSC\_genomes()](#list_ucsc_genomes)
  + [3.2 get\_UCSC\_chrom\_sizes()](#get_ucsc_chrom_sizes)
  + [3.3 list\_UCSC\_tracks()](#list_ucsc_tracks)
  + [3.4 fetch\_UCSC\_track\_data()](#fetch_ucsc_track_data)
  + [3.5 UCSC\_dbselect()](#ucsc_dbselect)
* [4 Session information](#session-information)

# 1 Introduction

*[UCSC.utils](https://bioconductor.org/packages/3.22/UCSC.utils)* is an infrastructure package that provides a
small set of low-level utilities to retrieve data from the UCSC Genome
Browser. Most functions in the package access the data via the UCSC REST
API but some of them query the UCSC MySQL server directly.

Note that the primary purpose of the package is to support higher-level
functionalities implemented in downstream packages like
*[GenomeInfoDb](https://bioconductor.org/packages/3.22/GenomeInfoDb)* or *[txdbmaker](https://bioconductor.org/packages/3.22/txdbmaker)*.

# 2 Installation

Like any other Bioconductor package, *[UCSC.utils](https://bioconductor.org/packages/3.22/UCSC.utils)* should always
be installed with `BiocManager::install()`:

```
if (!require("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("UCSC.utils")
```

However, note that *[UCSC.utils](https://bioconductor.org/packages/3.22/UCSC.utils)* will typically get automatically
installed as a dependency of other Bioconductor packages, so explicit
installation of the package is usually not needed.

# 3 Functions defined in the package

## 3.1 list\_UCSC\_genomes()

```
suppressPackageStartupMessages(library(UCSC.utils))

list_UCSC_genomes("cat")
```

```
##             organism  genome common_name tax_id
## 1        Felis catus felCat3         Cat   9685
## 2        Felis catus felCat4         Cat   9685
## 3        Felis catus felCat5         Cat   9685
## 4        Felis catus felCat8         Cat   9685
## 5        Felis catus felCat9         Cat   9685
## 6 Tursiops truncatus turTru2     Dolphin   9739
##                                 description
## 1                 Mar. 2006 (Broad/felCat3)
## 2        Dec. 2008 (NHGRI/GTB V17e/felCat4)
## 3 Sep. 2011 (ICGSC Felis_catus 6.2/felCat5)
## 4 Nov. 2014 (ICGSC Felis_catus_8.0/felCat8)
## 5       Nov. 2017 (Felis_catus_9.0/felCat9)
## 6       Oct. 2011 (Baylor Ttru_1.4/turTru2)
```

See `?list_UCSC_genomes` for more information and additional examples.

## 3.2 get\_UCSC\_chrom\_sizes()

```
felCat9_chrom_sizes <- get_UCSC_chrom_sizes("felCat9")
head(felCat9_chrom_sizes)
```

```
##                chrA1 chrUn_NW_019369707v1 chrUn_NW_019369340v1
##            242100913                 1969                 2790
## chrUn_NW_019367154v1 chrUn_NW_019366602v1 chrUn_NW_019367170v1
##                 2807                 2835                 2909
```

See `?get_UCSC_chrom_sizes` for more information and additional examples.

## 3.3 list\_UCSC\_tracks()

```
list_UCSC_tracks("felCat9", group="varRep")
```

```
##                track     primary_table       type  group composite_track
## 1  EVA SNP Release 7           evaSnp7 bigBed 9 + varRep         EVA SNP
## 2  EVA SNP Release 6           evaSnp6 bigBed 9 + varRep         EVA SNP
## 3  EVA SNP Release 5           evaSnp5 bigBed 9 + varRep         EVA SNP
## 4  EVA SNP Release 4           evaSnp4 bigBed 9 + varRep         EVA SNP
## 5  EVA SNP Release 3            evaSnp bigBed 9 + varRep         EVA SNP
## 6     Microsatellite          microsat      bed 4 varRep            <NA>
## 7   Interrupted Rpts     nestedRepeats   bed 12 + varRep            <NA>
## 8       RepeatMasker              rmsk       rmsk varRep            <NA>
## 9     Simple Repeats      simpleRepeat    bed 4 + varRep            <NA>
## 10        WM + SDust windowmaskerSdust      bed 3 varRep            <NA>
```

See `?list_UCSC_tracks` for more information and
additional examples.

## 3.4 fetch\_UCSC\_track\_data()

```
mm9_cytoBandIdeo <- fetch_UCSC_track_data("mm9", "cytoBandIdeo")
head(mm9_cytoBandIdeo)
```

```
##   chrom chromStart chromEnd name gieStain
## 1  chr1          0  8918386  qA1  gpos100
## 2  chr1    8918386 12386647  qA2     gneg
## 3  chr1   12386647 20314102  qA3   gpos33
## 4  chr1   20314102 22295965  qA4     gneg
## 5  chr1   22295965 31214352  qA5  gpos100
## 6  chr1   31214352 43601000   qB     gneg
```

See `?fetch_UCSC_track_data` for more information and
additional examples.

## 3.5 UCSC\_dbselect()

Retrieve a full SQL table:

```
felCat9_refGene <- UCSC_dbselect("felCat9", "refGene")
head(felCat9_refGene)
```

```
##    bin         name chrom strand   txStart     txEnd  cdsStart    cdsEnd
## 1  863 NM_001009849 chrE2      +  36523718  36526085  36523718  36526085
## 2 1227 NM_001009828 chrD1      -  84257818  84258562  84257818  84258562
## 3  762 NM_001009827 chrE1      -  23276059  23282999  23276460  23282943
## 4 1577 NM_001009826 chrC1      - 130088795 130092596 130089335 130092527
## 5  759 NM_001309049 chrA1      +  22918805  22920344  22919057  22920092
## 6  875 NM_001042567 chrB1      -  38074338  38098460  38074369  38098430
##   exonCount
## 1         3
## 2         1
## 3         4
## 4         2
## 5         1
## 6        10
##                                                                                   exonStarts
## 1                                                                36523718,36525219,36525973,
## 2                                                                                  84257818,
## 3                                                       23276059,23276487,23281555,23282867,
## 4                                                                       130088795,130092512,
## 5                                                                                  22918805,
## 6 38074338,38076636,38078534,38079916,38082234,38083702,38084693,38086308,38090951,38098342,
##                                                                                     exonEnds
## 1                                                                36523788,36525337,36526085,
## 2                                                                                  84258562,
## 3                                                       23276485,23276548,23281667,23282999,
## 4                                                                       130090382,130092596,
## 5                                                                                  22920344,
## 6 38074370,38076741,38078717,38080037,38082477,38083936,38084805,38086488,38091121,38098460,
##   score name2 cdsStartStat cdsEndStat           exonFrames
## 1     0 CCL17         cmpl       cmpl               0,1,2,
## 2     0  BDNF         cmpl       cmpl                   0,
## 3     0  CCL5         cmpl       cmpl             2,2,1,0,
## 4     0 CXCR4         cmpl       cmpl                 0,0,
## 5     0 LPAR6         cmpl       cmpl                   0,
## 6     0   LPL         cmpl       cmpl 2,2,2,1,1,1,0,0,1,0,
```

Or retrieve a subset of it:

```
columns <- c("chrom", "strand", "txStart", "txEnd", "exonCount", "name2")
UCSC_dbselect("felCat9", "refGene", columns=columns, where="chrom='chrA1'")
```

```
##    chrom strand   txStart     txEnd exonCount      name2
## 1  chrA1      + 141539866 141571963        14       HEXB
## 2  chrA1      - 138510635 138551376        10        SMN
## 3  chrA1      - 145138360 145306338         8       ARSB
## 4  chrA1      + 175374295 175382370        14        F12
## 5  chrA1      + 191099915 191109377         6      IL12B
## 6  chrA1      + 199096975 199126348        22      CSF1R
## 7  chrA1      +  11563271  11622511        32      BRCA2
## 8  chrA1      +  22918805  22920344         1      LPAR6
## 9  chrA1      -  24436704  24481859         9      LRCH1
## 10 chrA1      -  77088366  77130144         5      EFNB2
## 11 chrA1      +  82349957  82367091         9      LAMP1
## 12 chrA1      +  91725271  91726174         1 FELCATV1R2
## 13 chrA1      + 111190386 111192290         4       CSF2
## 14 chrA1      + 111190386 111192290         4       CSF2
## 15 chrA1      - 111639220 111641240         4        IL5
## 16 chrA1      + 111778711 111787544         4        IL4
## 17 chrA1      - 111946494 111949509         2       GDF9
## 18 chrA1      - 121247112 121356809         8      NR3C1
## 19 chrA1      - 161161087 161213837         6       LIX1
## 20 chrA1      + 193037229 193057081         8     HAVCR1
## 21 chrA1      - 200182785 200184042         1      ADRB2
## 22 chrA1      + 214528332 214560411         7    SLC45A2
```

Note that `UCSC_dbselect` is an alternative to `fetch_UCSC_track_data`
that is more efficient and gives the user more control on what data to
retrieve exactly from the server. However, the downside of it is that
it does not work with all tracks!

See `?UCSC_dbselect` for more information and additional examples.

# 4 Session information

```
sessionInfo()
```

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] UCSC.utils_1.6.1 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] vctrs_0.6.5         httr_1.4.7          cli_3.6.5
##  [4] knitr_1.50          rlang_1.1.6         xfun_0.54
##  [7] DBI_1.2.3           generics_0.1.4      jsonlite_2.0.0
## [10] bit_4.6.0           S4Vectors_0.48.0    htmltools_0.5.9
## [13] sass_0.4.10         stats4_4.5.2        hms_1.1.4
## [16] rmarkdown_2.30      evaluate_1.0.5      jquerylib_0.1.4
## [19] fastmap_1.2.0       yaml_2.3.12         lifecycle_1.0.4
## [22] bookdown_0.46       RMariaDB_1.3.4      BiocManager_1.30.27
## [25] compiler_4.5.2      blob_1.2.4          timechange_0.3.0
## [28] pkgconfig_2.0.3     digest_0.6.39       R6_2.6.1
## [31] curl_7.0.0          bslib_0.9.0         bit64_4.6.0-1
## [34] tools_4.5.2         lubridate_1.9.4     BiocGenerics_0.56.0
## [37] cachem_1.1.0
```