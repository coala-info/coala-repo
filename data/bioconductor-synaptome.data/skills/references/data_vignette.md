Code

* Show All Code
* Hide All Code

# synaptome.data database for synaptome.db

Oksana Sorokina1\*, Anatoly Sorokin2\*\* and J. Douglas Armstrong1

1The School of Informatics, University of Edinburgh, Edinburgh, UK
2Department of Biochemistry and Systems Biology, Institute of Systems, Molecular and Integrative Biology, University of Liverpool, UK

\*oksana.sorokina@ed.ac.uk
\*\*a.sorokin@liverpool.ac.uk

#### 19 October 2022

#### Package

synaptome.data 0.99.6

# 1 Basics

Genes encoding synaptic proteins are highly associated with neuronal disorders, many of which show clinical co-morbidity. Authors of (Sorokina, Mclean, Croning, Heil, Wysocka, He, Sterratt, Grant, Simpson, and Armstrong, 2021) integrated 58 published synaptic proteomic datasets that describe over 8000 proteins. They combined protein datasets with direct protein-protein interactions and functional metadata to build a database. Analysis of that database reveals the shared and unique protein components that underpin multiple disorders. The `synaptome.data` provides Bioconductor with access to the public version of that database .

## 1.1 Install `synaptome.data`

`R` is an open-source statistical environment which can be easily modified to enhance its functionality via packages. *[synaptome.data](https://bioconductor.org/packages/3.16/synaptome.data)* is a `R` package available via the [Bioconductor](http://bioconductor.org) repository for packages. `R` can be installed on any operating system from [CRAN](https://cran.r-project.org/) after which you can install *[synaptome.data](https://bioconductor.org/packages/3.16/synaptome.data)* by using the following commands in your `R` session:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
      install.packages("BiocManager")
  }

BiocManager::install("synaptome.data")

## Check that you have a valid Bioconductor installation
BiocManager::valid()
```

## 1.2 Required knowledge

*[synaptome.data](https://bioconductor.org/packages/3.16/synaptome.data)* is based on many other packages and in particular in those that have implemented the infrastructure needed for dealing with RNA-seq data (EDIT!). That is, packages like *[SummarizedExperiment](https://bioconductor.org/packages/3.16/SummarizedExperiment)* (EDIT!).

If you are asking yourself the question “Where do I start using Bioconductor?” you might be interested in [this blog post](http://lcolladotor.github.io/2014/10/16/startbioc/#.VkOKbq6rRuU).

## 1.3 Asking for help

As package developers, we try to explain clearly how to use our packages and in which order to use the functions. But `R` and `Bioconductor` have a steep learning curve so it is critical to learn where to ask for help. The blog post quoted above mentions some but we would like to highlight the [Bioconductor support site](https://support.bioconductor.org/) as the main resource for getting help: remember to use the `synaptome.data` tag and check [the older posts](https://support.bioconductor.org/t/synaptome.data/). Other alternatives are available such as creating GitHub issues and tweeting. However, please note that if you want to receive help you should adhere to the [posting guidelines](http://www.bioconductor.org/help/support/posting-guide/). It is particularly critical that you provide a small reproducible example and your session information so package developers can track down the source of the error.

## 1.4 Citing `synaptome.data`

We hope that *[synaptome.data](https://bioconductor.org/packages/3.16/synaptome.data)* will be useful for your research. Please use the following information to cite the package and the overall approach. Thank you!

```
## Citation info
citation("synaptome.data")
#>
#> To cite synaptome.db in publications use:
#>
#>   Sorokina, O., Mclean, C., Croning, M.D.R. et al.  A unified resource
#>   and configurable model of the synapse proteome and its role in
#>   disease.  Sci Rep 11, 9967 (2021).
#>   https://doi.org/10.1038/s41598-021-88945-7
#>
#> A BibTeX entry for LaTeX users is
#>
#>   @Article{,
#>     title = {A unified resource and configurable model of the synapse proteome and its role in disease},
#>     author = {Oksana Sorokina and Colin Mclean and Mike D. R. Croning and Katharina F. Heil and Emilia Wysocka and Xin He and David Sterratt and Seth G. N. Grant and T. Ian Simpson and J. Douglas Armstrong},
#>     journal = {Scientific Reports},
#>     year = {2021},
#>     volume = {11},
#>     number = {1},
#>     pages = {9967},
#>     doi = {10.1038/s41598-021-88945-7},
#>     url = {https://doi.org/10.1038/s41598-021-88945-7},
#>   }
```

# 2 Quick start to using to `synaptome.data`

```
library("synaptome.data")
ahub <- AnnotationHub::AnnotationHub(hub='http://127.0.0.1:9393/')
sdb<-AnnotationHub::query(ahub,'SynaptomeDB')
```

Here is an example of you can cite your package inside the vignette:

* *[synaptome.data](https://bioconductor.org/packages/3.16/synaptome.data)* (Sorokina, Mclean, Croning et al., 2021)

# 3 Reproducibility

The *[synaptome.data](https://bioconductor.org/packages/3.16/synaptome.data)* package (Sorokina, Mclean, Croning et al., 2021) was made possible thanks to:

* R (R Core Team, 2022)
* *[BiocStyle](https://bioconductor.org/packages/3.16/BiocStyle)* (Oleś, 2022)
* *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2022)
* *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017)
* *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, McPherson, Luraschi, Ushey, Atkins, Wickham, Cheng, Chang, and Iannone, 2022)
* *[sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo)* (Wickham, Chang, Flight, Müller, and Hester, 2021)

This package was developed using *[biocthis](https://bioconductor.org/packages/3.16/biocthis)*.

Code for creating the vignette

```
## Create the vignette
library("rmarkdown")
system.time(render("data_vignette.Rmd", "BiocStyle::html_document"))

## Extract the R code
library("knitr")
knit("data_vignette.Rmd", tangle = TRUE)
```

Date the vignette was generated.

```
#> [1] "2022-10-19 03:02:23 EDT"
```

Wallclock time spent generating the vignette.

```
#> Time difference of 0.509 secs
```

`R` session information.

```
#> ─ Session info ───────────────────────────────────────────────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.2.1 (2022-06-23)
#>  os       Ubuntu 20.04.5 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2022-10-19
#>  pandoc   2.5 @ /usr/bin/ (via rmarkdown)
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
#>  package     * version date (UTC) lib source
#>  backports     1.4.1   2021-12-13 [2] CRAN (R 4.2.1)
#>  bibtex        0.5.0   2022-09-25 [2] CRAN (R 4.2.1)
#>  BiocManager   1.30.18 2022-05-18 [2] CRAN (R 4.2.1)
#>  BiocStyle   * 2.25.0  2022-10-18 [2] Bioconductor
#>  bookdown      0.29    2022-09-12 [2] CRAN (R 4.2.1)
#>  bslib         0.4.0   2022-07-16 [2] CRAN (R 4.2.1)
#>  cachem        1.0.6   2021-08-19 [2] CRAN (R 4.2.1)
#>  cli           3.4.1   2022-09-23 [2] CRAN (R 4.2.1)
#>  digest        0.6.30  2022-10-18 [2] CRAN (R 4.2.1)
#>  evaluate      0.17    2022-10-07 [2] CRAN (R 4.2.1)
#>  fastmap       1.1.0   2021-01-25 [2] CRAN (R 4.2.1)
#>  generics      0.1.3   2022-07-05 [2] CRAN (R 4.2.1)
#>  htmltools     0.5.3   2022-07-18 [2] CRAN (R 4.2.1)
#>  httr          1.4.4   2022-08-17 [2] CRAN (R 4.2.1)
#>  jquerylib     0.1.4   2021-04-26 [2] CRAN (R 4.2.1)
#>  jsonlite      1.8.2   2022-10-02 [2] CRAN (R 4.2.1)
#>  knitr         1.40    2022-08-24 [2] CRAN (R 4.2.1)
#>  lubridate     1.8.0   2021-10-07 [2] CRAN (R 4.2.1)
#>  magrittr      2.0.3   2022-03-30 [2] CRAN (R 4.2.1)
#>  plyr          1.8.7   2022-03-24 [2] CRAN (R 4.2.1)
#>  R6            2.5.1   2021-08-19 [2] CRAN (R 4.2.1)
#>  Rcpp          1.0.9   2022-07-08 [2] CRAN (R 4.2.1)
#>  RefManageR  * 1.4.0   2022-09-30 [2] CRAN (R 4.2.1)
#>  rlang         1.0.6   2022-09-24 [2] CRAN (R 4.2.1)
#>  rmarkdown     2.17    2022-10-07 [2] CRAN (R 4.2.1)
#>  sass          0.4.2   2022-07-16 [2] CRAN (R 4.2.1)
#>  sessioninfo * 1.2.2   2021-12-06 [2] CRAN (R 4.2.1)
#>  stringi       1.7.8   2022-07-11 [2] CRAN (R 4.2.1)
#>  stringr       1.4.1   2022-08-20 [2] CRAN (R 4.2.1)
#>  xfun          0.33    2022-09-12 [2] CRAN (R 4.2.1)
#>  xml2          1.3.3   2021-11-30 [2] CRAN (R 4.2.1)
#>  yaml          2.3.6   2022-10-18 [2] CRAN (R 4.2.1)
#>
#>  [1] /tmp/RtmpWRZ2Jl/Rinst1e59c129973f0d
#>  [2] /home/biocbuild/bbs-3.16-bioc/R/library
#>
#> ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

# 4 Bibliography

This vignette was generated using *[BiocStyle](https://bioconductor.org/packages/3.16/BiocStyle)* (Oleś, 2022)
with *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2022) and *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, McPherson et al., 2022) running behind the scenes.

Citations made with *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017).

[[1]](#cite-allaire2022rmarkdown)
J. Allaire, Y. Xie, J. McPherson, et al.
*rmarkdown: Dynamic Documents for R*.
R package version 2.17.
2022.
URL: <https://github.com/rstudio/rmarkdown>.

[[2]](#cite-mclean2017refmanager)
M. W. McLean.
“RefManageR: Import and Manage BibTeX and BibLaTeX References in R”.
In: *The Journal of Open Source Software* (2017).
DOI: [10.21105/joss.00338](https://doi.org/10.21105/joss.00338).

[[3]](#cite-ole2022biocstyle)
A. Oleś.
*BiocStyle: Standard styles for vignettes and other Bioconductor documents*.
R package version 2.25.0.
2022.
URL: <https://github.com/Bioconductor/BiocStyle>.

[[4]](#cite-2022language)
R Core Team.
*R: A Language and Environment for Statistical Computing*.
R Foundation for Statistical Computing.
Vienna, Austria, 2022.
URL: <https://www.R-project.org/>.

[[5]](#cite-sorokina2021unified)
O. Sorokina, C. Mclean, M. D. R. Croning, et al.
“A unified resource and configurable model of the synapse proteome and its role in disease”.
In: *Scientific Reports* 11.1 (2021), p. 9967.
DOI: [10.1038/s41598-021-88945-7](https://doi.org/10.1038/s41598-021-88945-7).
URL: <https://doi.org/10.1038/s41598-021-88945-7>.

[[6]](#cite-wickham2021sessioninfo)
H. Wickham, W. Chang, R. Flight, et al.
*sessioninfo: R Session Information*.
R package version 1.2.2.
2021.
URL: [https://CRAN.R-project.org/package=sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo).

[[7]](#cite-xie2022knitr)
Y. Xie.
*knitr: A General-Purpose Package for Dynamic Report Generation in R*.
R package version 1.40.
2022.
URL: <https://yihui.org/knitr/>.