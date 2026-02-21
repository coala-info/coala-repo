# An introduction to biodbMirbase

Pierrick Roger

#### 9 January 2023

#### Abstract

How to use the biodbMirbase connector and its methods.

#### Package

biodbMirbase 1.2.2

# 1 Purpose

biodbMirbase is a *biodb* extension package that implements a connector to
miRBase mature database (Griffiths-Jones et al. 2006, @griffithsjones2007\_miRBase, @kozomara2010\_miRBase, @kozomara2013\_miRBase).

# 2 Installation

Install using Bioconductor:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install('biodbMirbase')
```

# 3 Initialization

The first step in using *biodbMirbase*, is to create an instance of the biodb
class `Biodb` from the main *biodb* package. This is done by calling the
constructor of the class:

```
mybiodb <- biodb::newInst()
```

During this step the configuration is set up, the cache system is initialized
and extension packages are loaded.

We will see at the end of this vignette that the *biodb* instance needs to be
terminated with a call to the `terminate()` method.

# 4 Creating a connector to miRBase mature database

In *biodb* the connection to a database is handled by a connector instance that
you can get from the factory.
biodbMirbase implements a connector to a remote database.
Here is the code to instantiate a connector:

```
conn <- mybiodb$getFactory()$createConn('mirbase.mature')
```

```
## Loading required package: biodbMirbase
```

# 5 Accessing entries

To get some of the first entry IDs (accession numbers) from the database, run:

```
ids <- conn$getEntryIds(2)
ids
```

```
## [1] "MIMAT0000001" "MIMAT0000002"
```

To retrieve entries, use:

```
entries <- conn$getEntry(ids)
entries
```

```
## [[1]]
## Biodb miRBase mature database entry instance MIMAT0000001.
##
## [[2]]
## Biodb miRBase mature database entry instance MIMAT0000002.
```

To convert a list of entries into a dataframe, run:

```
x <- mybiodb$entriesToDataframe(entries)
x
```

```
##      accession                     description         name
## 1 MIMAT0000001 Caenorhabditis elegans let-7-5p cel-let-7-5p
## 2 MIMAT0000002 Caenorhabditis elegans lin-4-5p cel-lin-4-5p
##                   aa.seq mirbase.mature.id
## 1 UGAGGUAGUAGGUUGUAUAGUU      MIMAT0000001
## 2  UCCCUGAGACCUCAAGUGUGA      MIMAT0000002
```

# 6 Closing biodb instance

When done with your *biodb* instance you have to terminate it, in order to
ensure release of resources (file handles, database connection, etc):

```
mybiodb$terminate()
```

```
## INFO  [15:57:10.005] Closing BiodbMain instance...
## INFO  [15:57:10.007] Connector "mirbase.mature" deleted.
```

# 7 Session information

```
sessionInfo()
```

```
## R version 4.2.2 (2022-10-31)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 20.04.5 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.16-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.16-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] biodbMirbase_1.2.2 BiocStyle_2.26.0
##
## loaded via a namespace (and not attached):
##  [1] progress_1.2.2      tidyselect_1.2.0    xfun_0.36
##  [4] bslib_0.4.2         vctrs_0.5.1         generics_0.1.3
##  [7] htmltools_0.5.4     BiocFileCache_2.6.0 yaml_2.3.6
## [10] utf8_1.2.2          blob_1.2.3          XML_3.99-0.13
## [13] rlang_1.0.6         jquerylib_0.1.4     pillar_1.8.1
## [16] withr_2.5.0         glue_1.6.2          DBI_1.1.3
## [19] rappdirs_0.3.3      bit64_4.0.5         dbplyr_2.2.1
## [22] lifecycle_1.0.3     plyr_1.8.8          stringr_1.5.0
## [25] memoise_2.0.1       evaluate_0.19       knitr_1.41
## [28] fastmap_1.1.0       curl_4.3.3          fansi_1.0.3
## [31] biodb_1.6.1         Rcpp_1.0.9          openssl_2.0.5
## [34] filelock_1.0.2      BiocManager_1.30.19 cachem_1.0.6
## [37] jsonlite_1.8.4      bit_4.0.5           chk_0.8.1
## [40] askpass_1.1         hms_1.1.2           digest_0.6.31
## [43] stringi_1.7.8       bookdown_0.31       dplyr_1.0.10
## [46] cli_3.6.0           tools_4.2.2         magrittr_2.0.3
## [49] sass_0.4.4          RSQLite_2.2.20      tibble_3.1.8
## [52] crayon_1.5.2        pkgconfig_2.0.3     ellipsis_0.3.2
## [55] prettyunits_1.1.1   assertthat_0.2.1    rmarkdown_2.19
## [58] httr_1.4.4          lgr_0.4.4           R6_2.5.1
## [61] compiler_4.2.2
```

# References

Griffiths-Jones, Sam, Russell J. Grocock, Stijn van Dongen, Alex Bateman, and Anton J. Enright. 2006. “MiRBase: MicroRNA Sequences, Targets and Gene Nomenclature.” *Nucleic Acids Research* 34 (suppl\_1): D140–D144. <https://doi.org/10.1093/nar/gkj112>.

Griffiths-Jones, Sam, Harpreet Kaur Saini, Stijn van Dongen, and Anton J. Enright. 2007. “miRBase: tools for microRNA genomics.” *Nucleic Acids Research* 36 (November): D154–D158. <https://doi.org/10.1093/nar/gkm952>.

Kozomara, Ana, and Sam Griffiths-Jones. 2010. “MiRBase: Integrating microRNA Annotation and Deep-Sequencing Data.” *Nucleic Acids Research* 39 (suppl\_1): D152–D157. <https://doi.org/10.1093/nar/gkq1027>.

———. 2013. “MiRBase: Annotating High Confidence microRNAs Using Deep Sequencing Data.” *Nucleic Acids Research* 42 (D1): D68–D73. <https://doi.org/10.1093/nar/gkt1181>.