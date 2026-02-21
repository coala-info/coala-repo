# Bio Pipeline Usage

Dario Righelli

#### 2025-10-29

# Contents

* [1 Description](#description)
* [2 Requirements](#requirements)
* [3 easyreporting instance creation](#easyreporting-instance-creation)
* [4 Loading Data](#loading-data)
* [5 Counts exploration](#counts-exploration)
* [6 Differential expression](#differential-expression)
  + [6.1 Inspecting DEGs](#inspecting-degs)
* [7 Compiling the report](#compiling-the-report)
* [8 Session Info](#session-info)

# 1 Description

This vignettes will guide you throught a tipycal usage of the **easyreporting**
package, while performing a simplified bioinformatics analysis workflow.

# 2 Requirements

For the usage you just need to load the **easyreporting** package, which will
load the **rmarkdown** and **tools** packages.

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("easyreporting")
```

```
library("easyreporting")
```

# 3 easyreporting instance creation

For simplicity we setup a project directory path starting from the working
directory for our report, but you can just enter any path.
The **filenamepath** and the **title** parameters are mandatory, while the
**author** paramenter is optional.

Once created the **easyreporting** class instance, we can use it into our
further code to make other operations.
It stores some variables for us, in order to not be called again during next
opreations.
For example the name and the path of the report, the type of report
and the general rmarkdown options of the document.

```
proj.path <- file.path(tempdir(), "bioinfo_report")
bioEr <- easyreporting(filenamePath=proj.path, title="bioinfo_report",
                        author=c(
                      person(given="Dario", family="Righelli",
                          email="fake_email@gmail.com",
                          comment=c(ORCID="ORCIDNUMBER",
                                    url="www.fakepersonalurl.com",
                                    affiliation="Institute of Applied Mathematics, CNR, Naples, IT",
                                    affiliation_url="www.fakeurl.com")),
                    person(given="Claudia", family="Angelini",
                    comment=c(ORCID="ORCIDNUMBER",
                              url="www.fakepersonalurl.com",
                              affiliation="Institute of Applied Mathematics, CNR, Naples, IT",
                              affiliation_url="www.fakeurl.com"))
                    )
                  )
```

```
#> Warning in person1(given = given[[i]], family = family[[i]], middle =
#> middle[[i]], : Invalid ORCID iD: 'ORCIDNUMBER'.
#> Warning in person1(given = given[[i]], family = family[[i]], middle =
#> middle[[i]], : Invalid ORCID iD: 'ORCIDNUMBER'.
```

```
#> Loading required package: distill
```

# 4 Loading Data

For this vignette we previously downloaded an xlsx table from GEO with accession
number [*GSE134118*](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE134118).

For importing the xls file, we prepared an ad-hoc function called *importData*
stored in the *importFunctions.R* file.

```
mkdTitle(bioEr, title="Loading Counts Data")
mkdCodeChunkComplete(object=bioEr, code=quote(geneCounts <- importData(
      system.file("extdata/GSE134118_Table_S3.xlsx", package="easyreporting"))),
      sourceFilesList=system.file("script/importFunctions.R", package="easyreporting"))
```

```
#> Copying /tmp/RtmpeQ3FGx/Rinst1db144e0a85c8/easyreporting/script/importFunctions.R to /tmp/RtmpMHNzeW//importFunctions.R
```

# 5 Counts exploration

In order to explore the counts we can perform a PCA with *plotPCA* function
within the *EDASeq* package.
To trace this step we again use a *mkdCodeChunkComplete* function, inserting the
function call as the message to track.

```
mkdTitle(bioEr, title="Plot PCA on count data", level=2)
mkdCodeChunkComplete(bioEr,
                        code=quote(EDASeq::plotPCA(as.matrix(geneCounts))))
```

# 6 Differential expression

Let’s suppose we stored a function for applying edgeR on our counts in an R file.
We called the file *geneFunctions.R* and the function *applyEdgeRExample*.

It will be easy for us to source the file and to call the function with a single
call of easyreporting package.
By aid of the *mkdCodeChunkCommented* function we can add a comment preceeding
the code chunk.

```
mkdTitle(bioEr, "Differential Expression Analysis")
mkdCodeChunkCommented(bioEr,
    code="degList <- applyEdgeRExample(counts=geneCounts,
                    samples=colnames(geneCounts), contrast='Pleura - Broth')",
    comment=paste0("As we saw from the PCA, the groups are well separated",
        ", so we can perform a Differential Expression analysis with edgeR."),
    sourceFilesList=system.file("script/geneFunctions.R",
                                package="easyreporting"))
```

```
#> Copying /tmp/RtmpeQ3FGx/Rinst1db144e0a85c8/easyreporting/script/geneFunctions.R to /tmp/RtmpMHNzeW//geneFunctions.R
```

## 6.1 Inspecting DEGs

Usually to have a graphical representation of the obtained results we can plot an
MD plot by using the *plotMD* function of the *limma* package.

Also in this case, we create a new title and a new chunk within the function to call.

```
mkdTitle(bioEr, "MD Plot of DEGs", level=2)
mkdCodeChunkComplete(bioEr, code="limma::plotMD(degList$test)")
```

# 7 Compiling the report

Once finished our analysis it is possible to compile the produced rmarkdown report simply by using the *compile* method.
The compile method appends a sessionInfo() to the report to trace all the packages and versions used for the analysis.

```
compile(bioEr)
```

# 8 Session Info

```
sessionInfo()
```

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
#> other attached packages:
#> [1] distill_1.6          easyreporting_1.22.0 BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] digest_0.6.37       R6_2.6.1            bookdown_0.45
#>  [4] fastmap_1.2.0       xfun_0.53           cachem_1.1.0
#>  [7] knitr_1.50          memoise_2.0.1       htmltools_0.5.8.1
#> [10] rmarkdown_2.30      lifecycle_1.0.4     cli_3.6.5
#> [13] downlit_0.4.4       sass_0.4.10         withr_3.0.2
#> [16] jquerylib_0.1.4     compiler_4.5.1      tools_4.5.1
#> [19] evaluate_1.0.5      bslib_0.9.0         yaml_2.3.10
#> [22] formatR_1.14        BiocManager_1.30.26 jsonlite_2.0.0
#> [25] rlang_1.1.6
```