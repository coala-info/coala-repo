# Introduction to MicrobiomeProfiler

#### Meijun Chen and GuangChuang Yu

#### 2025-10-30

* [Install package](#install-package)
* [Introduction](#introduction)
* [Getting Started Quickly](#getting-started-quickly)
* [Supported Analysis](#supported-analysis)
* [Case Study](#case-study)
  + [Data input](#data-input)
  + [Run example](#run-example)
* [Annotation database](#annotation-database)
* [Session Information](#session-information)

# Install package

```
if (!require("BiocManager"))
    install.packages("BiocManager")
BiocManager::install("MicrobiomeProfiler")
```

# Introduction

`MicrobiomeProfiler` is a functional enrichment tool for microbiome data based `clusterProfiler`. It is an R/shiny package with user-friendly interface.

As showed in the following figure, the sidebar panel was the input options and the main panel was designed to show output results (Also can be seen in other analysis).

![**KEGG enrichment analysis**](data:image/png;base64...)

**KEGG enrichment analysis**

# Getting Started Quickly

Run the application:

```
library(MicrobiomeProfiler)
run_MicrobiomeProfiler()
```

# Supported Analysis

Also, `MicrobiomeProfiler` provides several enrich functions for optional analysis.

* KEGG enrichment analysis
* COG enrichment analysis
* Microbe-Disease enrichment analysis
* Metabo-Pathway analysis

There are four reference gene catalogs collected from publications that can be used as universe for KEGG analysis in specific scenarios.

| Reference Gene Catalog | Description |
| --- | --- |
| human\_gut2014 | Integrated non-redundant gene catalog of human gut microbiome published on Natrue Biotechnology in 2014 |
| human\_gut2016 | Integrated non-redundant gene catalog of human gut microbiome published on Cell Systems in 2016 |
| human\_skin | Integrated human skin microbial non-redundant gene catalog |
| human\_vagina | a comprehensive human vaginal non-redundant gene catalog (VIRGO) that includes 6751 KEGG orthology |

# Case Study

## Data input

To click the `Example` button, the example gene list would be showed in the input area. Also, more parameters can be set below the input area, for instance, p value cutoff. There is a customer\_defined\_universe choice for users to define the specific universe for enrichment analysis (Also for other enrichment analysis). After that, clicking the `Submit` button to process analysis. The `Clean` button was designed for cleaning the current results.

![**Customize the universe**](data:image/png;base64...)

**Customize the universe**

![**Customize the universe**](data:image/png;base64...)

**Customize the universe**

And then, the universe input box would be showed below.

## Run example

Here we showed the case study of example: **Comparative functional KEGG enrichment analysis between Lung Microbioe in IPF and Healthy Individuals**. 295 significantly differential KEGG orthologs between Lung Microbioe in idiopathnic pulmonary fibrosis Patients (IPF) and healthy individuals were reported for KEGG enrichment analysis.

![**Case study**](data:image/png;base64...)

**Case study**

The default visualization results showed top 10 significant terms. In addition, users can click the interested terms on the table, and click the `Update` to get the results. Furthermore, there are some output settings to adjust the output figure.

![**To show interested tetms**](data:image/png;base64...)

**To show interested tetms**

# Annotation database

`MicrobiomeProfiler` has utilized four database.

* KEGG database: Kyoto Encyclopedia of Genes and Genomes
* COG database: Clusters of Orthologous Groups of proteins
* Disbiome: Linking microbiome to disease
* SMPDB: The Small Molecule Pathway Database

# Session Information

```
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> loaded via a namespace (and not attached):
#>  [1] digest_0.6.37     R6_2.6.1          fastmap_1.2.0     xfun_0.53
#>  [5] cachem_1.1.0      knitr_1.50        htmltools_0.5.8.1 png_0.1-8
#>  [9] rmarkdown_2.30    lifecycle_1.0.4   prettydoc_0.4.1   cli_3.6.5
#> [13] sass_0.4.10       jquerylib_0.1.4   compiler_4.5.1    tools_4.5.1
#> [17] evaluate_1.0.5    bslib_0.9.0       yaml_2.3.10       rlang_1.1.6
#> [21] jsonlite_2.0.0
```