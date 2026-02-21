# Vignette for pfamAnalyzeR

Kristoffer Vitting-Seerup

#### 30 October, 2025

# Contents

* [1 Background and Rational](#background-and-rational)
* [2 Installation](#installation)
* [3 Workflow](#workflow)
* [4 SessionInfo](#sessioninfo)

# 1 Background and Rational

Protein domains is one of the most import types of annotation we have for proteins. For such annotation the Pfam database/tool is (by far) the most used tool and the *de-facto* way protein domains are currently defined. We have recently shown most human protein domains exist as multiple distinct variants termed domain isotypes - a until now overlooked aspect of protein domains. Domain isotypes are used in a cell, tissue, and disease-specific manner. Accordingly, we find that domain isotypes, compared to each other, modulate, or abolish the functionality of a protein domain. For more information check our [preprint](https://doi.org/10.1101/2022.08.12.503740)

This R package enables the user to read the Pfam prediction from both webserver and stand-alone runs into R and afterwards identify and classification domain isotypes from Pfam results.

These 5 isotypes are the reference isotype and four isotypes that, compared to the reference isotype, are best described as a truncation, an insertion, a deletion, or combinations thereof (“complex”) and are visualized in the figure below:

![](data:image/jpeg;base64...)

# 2 Installation

pfamAnalyzeR is part of the Bioconductor repository and community which means it is distributed with, and dependent on, Bioconductor. Installation of pfamAnalyzeR is easy and can be done from within the R terminal. If it is the first time you use Bioconductor (or don’t know if you have used it), simply copy-paste the following into an R session to install the basic Bioconductor packages (will only done if you don’t already have them):

```
if (!requireNamespace("BiocManager", quietly = TRUE)){
    install.packages("BiocManager")
    BiocManager::install()
}
```

If you already have installed Bioconductor, running these two commands will check whether updates for installed packages are available.

After you have installed the basic Bioconductor packages you can install pfamAnalyzeR by copy-pasting the following into an R session:

```
BiocManager::install("pfamAnalyzeR")
```

This will install the pfamAnalyzeR package as well as other R packages that are needed for pfamAnalyzeR to work.

# 3 Workflow

Lets take a look at how an analysis with pfamAnalyzeR looks

We start by loading the pfamAnalyzeR library.

```
library(pfamAnalyzeR)
#> Loading required package: readr
#> Loading required package: stringr
#> Loading required package: dplyr
#>
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#>
#>     filter, lag
#> The following objects are masked from 'package:base':
#>
#>     intersect, setdiff, setequal, union
```

To showcase pfamAnalyzeR we have included the output of running a small toy dataset througth the pfam webserver in the R pacakge. This can be accessed as follows:

```
### Create sting pointing to result file
# note that you do not need to use the "system.file".
# That is only needed when accessing files in an R package
pfamResultFile <- system.file(
    "extdata/pfam_results.txt",
    package = "pfamAnalyzeR"
)

file.exists(pfamResultFile)
#> [1] TRUE
```

Now we can read in the Pfam result file and classify each domain into one of the 5 domain isotypes.

```
### Run entire pfam analysis
pfamRes <- pfamAnalyzeR(pfamResultFile)
```

With this done we can explore the results a little:

```
### Look at a few entries
pfamRes %>%
    select(seq_id, hmm_name, type, domain_isotype, domain_isotype_simple) %>%
    head()
#> # A tibble: 6 × 5
#>   seq_id         hmm_name type   domain_isotype domain_isotype_simple
#>   <chr>          <chr>    <chr>  <chr>          <chr>
#> 1 TCONS_00000045 ASC      Family Insertion      Non-reference
#> 2 TCONS_00000046 ASC      Family Insertion      Non-reference
#> 3 TCONS_00000047 ASC      Family Insertion      Non-reference
#> 4 TCONS_00000048 ASC      Family Insertion      Non-reference
#> 5 TCONS_00000049 ASC      Family Truncation     Non-reference
#> 6 TCONS_00000066 DUF3523  Family Complex        Non-reference

### Summarize domain isotype
table(pfamRes$domain_isotype)
#>
#>    Complex   Deletion  Insertion  Reference Truncation
#>         80          3         30        196         31

### Summarize domain isotype
table(pfamRes$domain_isotype_simple)
#>
#> Non-reference     Reference
#>           144           196
```

From which it can be seen that a large fraction (!) of protein domains found in regular data are non-reference isotypes.

Please note that pfamAnalyzeR performs the isotype analysis regardless of Pfam result type:

```
table(
    pfamRes$type,
    pfamRes$domain_isotype_simple
)
#>
#>          Non-reference Reference
#>   Domain            78       126
#>   Family            40        62
#>   Repeat            26         8
```

Meaning if you are only interested in a specific annotation type you will have to subset it yourself.

# 4 SessionInfo

```
sessionInfo()
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
#> other attached packages:
#> [1] pfamAnalyzeR_1.10.0 dplyr_1.1.4         stringr_1.5.2
#> [4] readr_2.1.5         BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] vctrs_0.6.5         cli_3.6.5           knitr_1.50
#>  [4] rlang_1.1.6         xfun_0.53           stringi_1.8.7
#>  [7] generics_0.1.4      jsonlite_2.0.0      glue_1.8.0
#> [10] htmltools_0.5.8.1   sass_0.4.10         hms_1.1.4
#> [13] rmarkdown_2.30      evaluate_1.0.5      jquerylib_0.1.4
#> [16] tibble_3.3.0        tzdb_0.5.0          fastmap_1.2.0
#> [19] yaml_2.3.10         lifecycle_1.0.4     bookdown_0.45
#> [22] BiocManager_1.30.26 compiler_4.5.1      pkgconfig_2.0.3
#> [25] digest_0.6.37       R6_2.6.1            utf8_1.2.6
#> [28] tidyselect_1.2.1    pillar_1.11.1       magrittr_2.0.4
#> [31] bslib_0.9.0         withr_3.0.2         tools_4.5.1
#> [34] cachem_1.1.0
```