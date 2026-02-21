# easyreporting standard usage

Dario Righelli

#### 2025-10-29

# Contents

* [1 Description](#description)
* [2 Requirements](#requirements)
* [3 easyreporting instance creation](#easyreporting-instance-creation)
* [4 Code Chunks](#code-chunks)
  + [4.1 Manually creating a code chunk](#manually-creating-a-code-chunk)
  + [4.2 Code Chunks Options](#code-chunks-options)
  + [4.3 Adding personal files to source](#adding-personal-files-to-source)
  + [4.4 Complete chunk creation](#complete-chunk-creation)
* [5 Compiling the report](#compiling-the-report)
* [6 Session Info](#session-info)

# 1 Description

This vignettes will guide the user in the exploration of the functionalities of
easyreporting.

# 2 Requirements

For the usage you just need to load the **easyreporting** package, which will
load the **R6** and **rmarkdown** packages.

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
**author(s)** paramenter is optional.

Once created the **easyreporting** class instance, we can use it in our further
code to make other operations.
It stores some variables for us, in order to not be called again during next
opreations.
For example the name and the path of the report, the type of report
and the general rmarkdown options of the document.

```
proj.path <- file.path(tempdir(), "general_report")

er <- easyreporting(filenamePath=proj.path, title="example_report",
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
er <- easyreporting(filenamePath=proj.path, title="example_report",
                        author=c("Dario Righelli"))
```

# 4 Code Chunks

*Easyreporting* enables to include rmarkdown titles from first (default) to
sixth **level**.
The good norm, when writing reports, is always to add a title to a new code
chunk (CC) followed by a natural language text, which describes the CC.

```
mkdTitle(er, title="Code Chunks", level=1)

mkdGeneralMsg(er, "A simple paragraph useful to describe my code chunk...")
```

## 4.1 Manually creating a code chunk

The most mechanical way to create and populate a CC is to manually open the CC,
to insert the code, and then to close it.
Here we show how to insert a variable assignenent inside a CC.

```
mkdTitle(er, title="Manual code chunk", level=2)

mkdCodeChunkSt(er)
```

```
#> Please remember to close the Code Chunk!
#> Just invoke mkdCodeChunkEnd() once you complete your function calling :)
```

```
variable <- 1
mkdVariableAssignment(er, "variable", `variable`, show=TRUE)
mkdCodeChunkEnd(er)
```

## 4.2 Code Chunks Options

By using the standard function *makeOptionsList*, it is possible to create a
custom list of options (an *optionsList*), as described from **rmarkdown**.
In this way we are able to personalize even single code chunks, depending on
specific cases.

Here we create an optionsList where the includeFlag is set to *TRUE*
(our default is *FALSE*).

When opening the code chunk, it is possible to pass the new optionsList to the
easyreporting class *mkdCodeChunkSt* method.

```
optList <- makeOptionsList(echoFlag=TRUE, includeFlag=TRUE)
mkdCodeChunkSt(er, optionList=optList)
```

```
#> Please remember to close the Code Chunk!
#> Just invoke mkdCodeChunkEnd() once you complete your function calling :)
```

```
mkdCodeChunkEnd(er)
```

## 4.3 Adding personal files to source

If you have one or more files with some functions that you want to use inside
your code, it is possible to add them by using the *sourceFilesList*
parameter.

```
## moreover I can add a list of files to source in che code chunk
RFilesList <- list.files(system.file("script", package="easyreporting"),
                        full.names=TRUE)
mkdCodeChunkSt(er, optionList=optList, sourceFilesList=RFilesList)
```

```
#> Copying /tmp/RtmpeQ3FGx/Rinst1db144e0a85c8/easyreporting/script/fakeFunctions.R to /tmp/RtmpMHNzeW//fakeFunctions.R
```

```
#> Copying /tmp/RtmpeQ3FGx/Rinst1db144e0a85c8/easyreporting/script/geneFunctions.R to /tmp/RtmpMHNzeW//geneFunctions.R
```

```
#> Copying /tmp/RtmpeQ3FGx/Rinst1db144e0a85c8/easyreporting/script/importFunctions.R to /tmp/RtmpMHNzeW//importFunctions.R
```

```
#> Copying /tmp/RtmpeQ3FGx/Rinst1db144e0a85c8/easyreporting/script/plotFunctions.R to /tmp/RtmpMHNzeW//plotFunctions.R
```

```
#> Please remember to close the Code Chunk!
#> Just invoke mkdCodeChunkEnd() once you complete your function calling :)
```

```
mkdGeneralMsg(er, message="(v <- fakeFunction(10))")
mkdCodeChunkEnd(er)
```

## 4.4 Complete chunk creation

It is also possible to create a complete chunk by using the
*mkdCodeChunkComplete* function.

```
mkdCodeChunkComplete(er, code="v <- fakeFunction(11)")
```

Finally, it is possible to create a unique code chunk within all the
functionalities desribed before.

```
optList <- makeOptionsList(includeFlag=TRUE, cacheFlag=TRUE)

mkdCodeChunkCommented(er,
                comment="This is the comment of the following code chunk",
                code="v <- fakeFunction(12)",
                optionList=optList,
                sourceFilesList=NULL)
```

# 5 Compiling the report

Once finished our analysis it is possible to compile the produced rmarkdown report simply by using the *compile* method.
The compile method appends a sessionInfo() to the report to trace all the packages and versions used for the analysis.

```
compile(er)
```

# 6 Session Info

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