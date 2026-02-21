# GA4GHshiny

Welliton Souza

University of Campinas, Campinas, Brazil

#### 30 October 2025

#### Package

GA4GHshiny 1.32.0

# 1 Introduction

The [Global Alliance for Genomics and Health](http://genomicsandhealth.org/) (GA4GH) was formed to help accelerate the potential of genomic medicine to advance human health.
It brings together over 400 leading institutions working in healthcare, research, disease advocacy, life science, and information technology.
The [Data Working Group](http://ga4gh.org/#/) of the GA4GH developed [data model schemas](https://github.com/ga4gh/schemas) and application program interfaces (APIs) for genomic data.
These APIs are specifically designed to allow sharing of genomics data in a standardized manner and without having to exchange complete experiments.
They developed a [reference implementation for these APIs](https://github.com/ga4gh/server) providing a web server for hosting genomic data.

We developed the *[GA4GHclient](https://bioconductor.org/packages/3.22/GA4GHclient)* package for retrieving and integrating genomic data from GA4GH-based databases. **GA4GHshiny** is a companion package providing graphical user interface based on web technologies for easly interacting with GA4GH-based databases such as [Thousand Genomes](http://1kgenomes.ga4gh.org/) and [BRCA Exchange](http://brcaexchange.org/).
The web interface integrates with [Beacon Network](https://beacon-network.org/#/) providing a list of databases which have the user selected genomic variant (The Global Alliance for Genomics and Health [2016](#ref-ga4gh)).
It was developed using [Shiny](https://shiny.rstudio.com/) and related packages.

The package has only one function called `app`, which runs the web application.
It can be done within RStudio however the Beacon Network integration may not work.
To solve this problem click in “Open in Browser” button at the top of the window.
For example, the code below runs application connected at <http://1kgenomes.ga4gh.org/>.

```
library(org.Hs.eg.db)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(GA4GHshiny)
app(host = "http://1kgenomes.ga4gh.org/",
    serverName = "Hosting Thousand Genomes Project",
    orgDb = "org.Hs.eg.db",
    txDb = "TxDb.Hsapiens.UCSC.hg19.knownGene")
```

The `host` argument defines which GA4GH-based data server to connect.
This is the only required argument.
There are some database endpoints available.

* [Hosting Thousand Genomes Project](http://1kgenomes.ga4gh.org/)
* [Ensembl REST API](https://rest.ensembl.org/)
* [BRCA Exchange GA4GH API](http://brcaexchange.org/backend/data/ga4gh/v0.6.0a7/)

The value of `serverName` argument will show at the top bar of the interface.
If not defined it will show the value of `host`.

The `orgDb` and the `txDb` package names are necessary for searching by gene symbol and by genomic feature such as exons and transcripts.
The TxDb package version should be the same of the reference genome used by database.

# 2 Deploying web application

**GA4GHshiny** application can be executed as web site through [Shiny Server](https://www.rstudio.com/products/shiny/shiny-server/).
Create an `app.R` file inside ShinyServer application directory adding the text below.
For example `/srv/shiny-server/1kgenomes/app.R`.

```
library(org.Hs.eg.db)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(GA4GHshiny)
app(host = "http://1kgenomes.ga4gh.org/",
    serverName = "Hosting Thousand Genomes Project",
    orgDb = "org.Hs.eg.db",
    txDb = "TxDb.Hsapiens.UCSC.hg19.knownGene")
```

The web application will be available at <http://localhost:3838/1kgenomes/>.

# 3 Session Information

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

# References

The Global Alliance for Genomics and Health. 2016. “A Federated Ecosystem for Sharing Genomic, Clinical Data.” *Science* 352 (6291): 1278–80. <https://doi.org/10.1126/science.aaf6162>.