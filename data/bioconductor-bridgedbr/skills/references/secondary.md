# Secondary identifiers

Egon Willighagen

#### 29 October 2025

#### Package

BridgeDbR 2.20.0

# 1 Introduction

Databases use identifiers to point to records. One of the goals of BridgeDb is
is to map identifier for a record from one database to the identifier of a
matching record in another database. This is explained in the Tutorial vigenette.

However, within one databases, linking from one identifier to another can also
be useful. Many databases have older and newer identifiers, where the newer
identfier replaces the older identifier. For example, [HGNC](https://www.genenames.org/)
replaces symbols to make naming more consistent or to solve ambiguity.

The recent [sec2pri](https://github.com/sec2pri) and BridgeDb [Tiwid](https://github.com/bridgedb/tiwid)
projects track outdated identifiers. These projects define secondary identifiers
as identifiers that should not be used anymore. Some of them have been replaced
by new identifiers, called primary identifiers.

This vignette explains how to use `sec2pri` BridgeDb identifier mapping files
to detect secondary identifiers, and, where possible, suggest the replacing
primary identifier.

The [Bioconductor BridgeDbR package](https://doi.org/10.18129/B9.bioc.BridgeDbR)
page describes how to install the package. After installation, the library can be loaded with the following command:

```
install.packages("BiocManager")
BiocManager::install("BridgeDbR")
install.packages(pkgs=c("rJava", "curl"))

library(curl)
library(rJava)
library(BridgeDbR)
```

\*Note: if you have trouble with rJava (required package), please read the [general information](https://www.rforge.net/rJava/docs/index.html) or
follow the instructions [here](https://github.com/hannarud/r-best-practices/wiki/Installing-RJava-%28Ubuntu%29) for Ubuntu.

## 1.1 Downloading sec2pri databases

The first thing to do is download a BridgeDb identifier mapping database. This
database is a `.bridge` file just as those from the BridgeDb website. The difference
is that these `sec2pri` databases focus on primary and secondary identifiers of
a single data source.

Here we will use ChEBI (Hastings et al. [2016](#ref-Hastings2016)) as an example. These files can be downloaded
as artifacts produced during one of the GitHub Actions in the `mapping_preprocessing`
repository, specifically, [here](https://github.com/sec2pri/mapping_preprocessing/actions/workflows/chebi.yml).

Click the most recently run `Check and test ChEBI updates` run, and notice the
artifacts:

![](data:image/png;base64...)

Click the `chebi_procesed` artifact and save this locally as a `chebi_processed.zip`
file. Unzip the file to get the `ChEBI_secID2priID.bridge` file in the current working directory.

## 1.2 Loading the sec2pri database

This downloaded file is then loaded with (see also the Tutorial vignette):

```
sec2pri = BridgeDbR::loadDatabase("ChEBI_secID2priID.bridge")
```

## 1.3 Analyzing ChEBI identifiers

Let’s say we have the ChEBI identifier `CHEBI:1234` in our dataset and we want to
know if this is a primary or a secondary identifier. We can check with the `sec2pri`
databases which other identifiers it is mapped to:

```
BridgeDbR::map(sec2pri, source="Ce", identifier="CHEBI:1234")
```

The output looks like this:

```
  source identifier target     mapping isPrimary
1     Ce CHEBI:1234     Ce  CHEBI:1234         F
2     Ce CHEBI:1234     Ce CHEBI:19730         F
3     Ce CHEBI:1234     Ce CHEBI:28423         T
```

Two first two columns are your input identifier, and column three and four are
mapped identifiers. The fifth column indicates if the column is primary (`T`) or
secondary (`F`). We see here that `CHEBI:1234` is a secondary identifier.

We also see that there is a matching primary identifier, `CHEBI:28243`.

We can extract the primary identifier with regular R code, e.g. like:

```
mappedIDs = BridgeDbR::map(sec2pri, source="Ce", identifier="CHEBI:1234")
mappedIDs[intersect(which(mappedIDs[,"target"] == "Ce"),which(mappedIDs[,"isPrimary"] == "T")),]
```

## 1.4 Conclusion

With the appropriate `sec2pri` you can use this approach to identify secondary
identifiers, and where possible, replace them with the matching primary identifier.

Please keep in mind, most databases have their own reasons for when to replace
an identifier, and rules how to do that. Some databases do not, however, have
1-to-1 relationships, and manual inspection is recommended.

# References

Hastings, Janna, Gareth Owen, Adriano Dekker, Marcus Ennis, Namrata Kale, Venkatesh Muthukrishnan, Steve Turner, Neil Swainston, Pedro Mendes, and Christoph Steinbeck. 2016. “ChEBI in 2016: Improved Services and an Expanding Collection of Metabolites.” *Nucleic Acids Research* 44 (D1): D1214–9. <https://doi.org/10.1093/NAR/GKV1031>.

# Appendix

# A Session info

Here is the output of `sessionInfo()` on the system on which this document was
compiled running pandoc 2.7.3:

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37       R6_2.6.1            bookdown_0.45
##  [4] fastmap_1.2.0       xfun_0.53           cachem_1.1.0
##  [7] knitr_1.50          htmltools_0.5.8.1   rmarkdown_2.30
## [10] lifecycle_1.0.4     cli_3.6.5           sass_0.4.10
## [13] jquerylib_0.1.4     compiler_4.5.1      tools_4.5.1
## [16] evaluate_1.0.5      bslib_0.9.0         yaml_2.3.10
## [19] BiocManager_1.30.26 jsonlite_2.0.0      rlang_1.1.6
```