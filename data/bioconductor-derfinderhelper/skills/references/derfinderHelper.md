Code

* Show All Code
* Hide All Code

# Introduction to derfinderHelper

Leonardo Collado-Torres1,2\*

1Lieber Institute for Brain Development, Johns Hopkins Medical Campus
2Center for Computational Biology, Johns Hopkins University

\*lcolladotor@gmail.com

#### 29 October 2025

#### Package

derfinderHelper 1.44.0

# 1 Basics

## 1.1 Install *[derfinderHelper](https://bioconductor.org/packages/3.22/derfinderHelper)*

`R` is an open-source statistical environment which can be easily modified to enhance its functionality via packages. *[derfinderHelper](https://bioconductor.org/packages/3.22/derfinderHelper)* is a `R` package available via the [Bioconductor](http://bioconductor/packages/derfinderHelper) repository for packages. `R` can be installed on any operating system from [CRAN](https://cran.r-project.org/) after which you can install *[derfinderHelper](https://bioconductor.org/packages/3.22/derfinderHelper)* by using the following commands in your `R` session:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("derfinderHelper")

## Check that you have a valid Bioconductor installation
BiocManager::valid()
```

## 1.2 Required knowledge

*[derfinderHelper](https://bioconductor.org/packages/3.22/derfinderHelper)* is based on many other packages and in particular in those that have implemented the infrastructure needed for dealing with RNA-seq data. A *[derfinderHelper](https://bioconductor.org/packages/3.22/derfinderHelper)* user is not expected to deal with those packages directly but will need to be familiar with *[derfinder](https://bioconductor.org/packages/3.22/derfinder)*.

If you are asking yourself the question “Where do I start using Bioconductor?” you might be interested in [this blog post](http://lcolladotor.github.io/2014/10/16/startbioc/#.VkOKbq6rRuU).

## 1.3 Asking for help

As package developers, we try to explain clearly how to use our packages and in which order to use the functions. But `R` and `Bioconductor` have a steep learning curve so it is critical to learn where to ask for help. The blog post quoted above mentions some but we would like to highlight the [Bioconductor support site](https://support.bioconductor.org/) as the main resource for getting help: remember to use the `derfinder` or `derfinderHelper` tags and check [the older posts](https://support.bioconductor.org/t/derfinder/). Other alternatives are available such as creating GitHub issues and tweeting. However, please note that if you want to receive help you should adhere to the [posting guidelines](http://www.bioconductor.org/help/support/posting-guide/). It is particularly critical that you provide a small reproducible example and your session information so package developers can track down the source of the error.

## 1.4 Citing *[derfinderHelper](https://bioconductor.org/packages/3.22/derfinderHelper)*

We hope that *[derfinderHelper](https://bioconductor.org/packages/3.22/derfinderHelper)* will be useful for your research. Please use the following information to cite the package and the overall approach. Thank you!

```
## Citation info
citation("derfinderHelper")
```

```
## To cite package 'derfinderHelper' in publications use:
##
##   Collado-Torres L, Jaffe AE, Leek JT (2017). _derfinderHelper:
##   derfinder helper package_. doi:10.18129/B9.bioc.derfinderHelper
##   <https://doi.org/10.18129/B9.bioc.derfinderHelper>,
##   https://github.com/leekgroup/derfinderHelper - R package version
##   1.44.0, <http://www.bioconductor.org/packages/derfinderHelper>.
##
##   Collado-Torres L, Nellore A, Frazee AC, Wilks C, Love MI, Langmead B,
##   Irizarry RA, Leek JT, Jaffe AE (2017). "Flexible expressed region
##   analysis for RNA-seq with derfinder." _Nucl. Acids Res._.
##   doi:10.1093/nar/gkw852 <https://doi.org/10.1093/nar/gkw852>,
##   <http://nar.oxfordjournals.org/content/early/2016/09/29/nar.gkw852>.
##
## To see these entries in BibTeX format, use 'print(<citation>,
## bibtex=TRUE)', 'toBibtex(.)', or set
## 'options(citation.bibtex.max=999)'.
```

# 2 Introduction to *[derfinderHelper](https://bioconductor.org/packages/3.22/derfinderHelper)*

*[derfinderHelper](https://bioconductor.org/packages/3.22/derfinderHelper)* (Collado-Torres, Jaffe, and Leek, 2017) is a small package that was created to speed up the F-statistics approach implemented in the parent package *[derfinder](https://bioconductor.org/packages/3.22/derfinder)*. It contains a single function, `fstats.apply()`, which is used to calculate the F-statistics for a given data matrix, null and an alternative models.

The data is generally arranged in an matrix where the rows (\(n\)) are the genomic features of interest (gene-level summaries, exon-level summaries, or base-level data) and the columns (\(m\)) represent the samples. The other two main arguments for `fstats.apply()` are the null and alternative model matrices which are \(m \times p\_0\) and \(m \times p\) where \(p\_0\) is the number of covariates in the null model and \(p\) is the number of covariates in the alternative model. The models have to be nested and thus by definition \(p > p\_0\). The end result is a vector of F-statistics with length \(n\), which is run length encoded for memory saving purposes.

Other arguments of `fstats.apply()` are related to flow in *[derfinder](https://bioconductor.org/packages/3.22/derfinder)* such as the scaling factor (`scalefac`) used, whether to subset the data (`index`), and if the data was separated into chunks and saved to disk to lower the memory load (`lowMemDir`).

Implementation-wise, `adjustF` is useful when the denominator of the F-statistic calculation is too small. Finally, `method` controls how will the F-statistics be calculated.

* `Matrix` is the recommended option because it uses around half the memory load of `regular` and can be faster. Specially if the data was saved in this format previously by *[derfinder](https://bioconductor.org/packages/3.22/derfinder)*.
* `Rle` uses the least amount of memory but gets very slow as the number of samples increases. Thus making it less than ideal in several cases.
* `regular` uses base `R` to calculate the F-statistics and can require a large amount of memory. This is noticeable when using several cores to run `fstats.apply()` on different portions of the data.

The F-statistics for each feature \(i\) are calculated using the following formula:

\[ F\_i = \frac{ (\text{RSS0}\_i - \text{RSS1}\_i)/(\text{df}\_1 - \text{df}\_0) }{ \text{adjustF} + (\text{RSS1}\_i / (p - p\_0 - \text{df\_1}))} \]

# 3 Example

The following section walks through an example. However, in practice, you will probably not use this package directly and it will be used via *[derfinder](https://bioconductor.org/packages/3.22/derfinder)*.

## 3.1 Data

First lets create an example data set where we have information for 1000 features and 16 samples where samples 1 to 4 are from group A, 5 to 8 from group B, 9 to 12 from group C, and 13 to 16 from group D.

```
## Create some toy data
suppressPackageStartupMessages(library("IRanges"))
set.seed(20140923)
toyData <- DataFrame(
    "sample1" = Rle(sample(0:10, 1000, TRUE)),
    "sample2" = Rle(sample(0:10, 1000, TRUE)),
    "sample3" = Rle(sample(0:10, 1000, TRUE)),
    "sample4" = Rle(sample(0:10, 1000, TRUE)),
    "sample5" = Rle(sample(0:15, 1000, TRUE)),
    "sample6" = Rle(sample(0:15, 1000, TRUE)),
    "sample7" = Rle(sample(0:15, 1000, TRUE)),
    "sample8" = Rle(sample(0:15, 1000, TRUE)),
    "sample9" = Rle(sample(0:20, 1000, TRUE)),
    "sample10" = Rle(sample(0:20, 1000, TRUE)),
    "sample11" = Rle(sample(0:20, 1000, TRUE)),
    "sample12" = Rle(sample(0:20, 1000, TRUE)),
    "sample13" = Rle(sample(0:100, 1000, TRUE)),
    "sample14" = Rle(sample(0:100, 1000, TRUE)),
    "sample15" = Rle(sample(0:100, 1000, TRUE)),
    "sample16" = Rle(sample(0:100, 1000, TRUE))
)

## Lets say that we have 4 groups
group <- factor(rep(toupper(letters[1:4]), each = 4))

## Note that some groups have higher coverage, we can adjust for this in the model
sampleDepth <- sapply(toyData, sum)
sampleDepth
```

```
##  sample1  sample2  sample3  sample4  sample5  sample6  sample7  sample8
##     4948     5044     5054     5027     7464     7407     7504     7607
##  sample9 sample10 sample11 sample12 sample13 sample14 sample15 sample16
##     9797     9982    10028     9797    50682    49921    49332    50421
```

## 3.2 Models

Next we create the model matrices for our example data set. Lets say that we want to calculate F-statistics comparing the alternative hypothesis that the group coefficients are not 0 versus the null hypothesis that they are equal to 0, when adjusting for the sample depth.

To do so, we create the nested models.

```
## Build the model matrices
mod <- model.matrix(~ sampleDepth + group)
mod0 <- model.matrix(~sampleDepth)

## Explore them
mod
```

```
##    (Intercept) sampleDepth groupB groupC groupD
## 1            1        4948      0      0      0
## 2            1        5044      0      0      0
## 3            1        5054      0      0      0
## 4            1        5027      0      0      0
## 5            1        7464      1      0      0
## 6            1        7407      1      0      0
## 7            1        7504      1      0      0
## 8            1        7607      1      0      0
## 9            1        9797      0      1      0
## 10           1        9982      0      1      0
## 11           1       10028      0      1      0
## 12           1        9797      0      1      0
## 13           1       50682      0      0      1
## 14           1       49921      0      0      1
## 15           1       49332      0      0      1
## 16           1       50421      0      0      1
## attr(,"assign")
## [1] 0 1 2 2 2
## attr(,"contrasts")
## attr(,"contrasts")$group
## [1] "contr.treatment"
```

```
mod0
```

```
##    (Intercept) sampleDepth
## 1            1        4948
## 2            1        5044
## 3            1        5054
## 4            1        5027
## 5            1        7464
## 6            1        7407
## 7            1        7504
## 8            1        7607
## 9            1        9797
## 10           1        9982
## 11           1       10028
## 12           1        9797
## 13           1       50682
## 14           1       49921
## 15           1       49332
## 16           1       50421
## attr(,"assign")
## [1] 0 1
```

## 3.3 Get F-statistics

Finally, we can calculate the F-statistics using `fstats.apply()`.

```
library("derfinderHelper")
fstats <- fstats.apply(data = toyData, mod = mod, mod0 = mod0, scalefac = 1)
fstats
```

```
## numeric-Rle of length 1000 with 1000 runs
##   Lengths:          1          1          1 ...          1          1
##   Values :  1.8484614  0.5732806  0.2493710 ...  0.1197002  1.3113647
```

We can then proceed to use this information in *[derfinder](https://bioconductor.org/packages/3.22/derfinder)* or in any way you like.

# 4 Details

We created *[derfinderHelper](https://bioconductor.org/packages/3.22/derfinderHelper)* for calculating F-statistics using `SnowParam()` from *[BiocParallel](https://bioconductor.org/packages/3.22/BiocParallel)*. Using this form of parallelization requires loading the necessary packages in the child processes. Because *[derfinder](https://bioconductor.org/packages/3.22/derfinder)* takes a long time to load, we shipped off `fstats.apply()` to its own package to improve the speed of the calculations while retaining the memory advantages of `SnowParam()` over `MulticoreParam()`.

Note that transforming the data from a `DataFrame` to a `dgCMatrix` takes some time, so the most efficient performance is achieved when the data is converted at the beginning instead of at every permutation calculation. This is done in `derfinder::preprocessCoverage()` when `lowMemDir` is specified.

# 5 Reproducibility

This package was made possible thanks to:

* R (R Core Team, 2025)
* *[IRanges](https://bioconductor.org/packages/3.22/IRanges)* (Lawrence, Huber, Pagès, Aboyoun, Carlson, Gentleman, Morgan, and Carey, 2013)
* *[Matrix](https://CRAN.R-project.org/package%3DMatrix)* (Bates, Maechler, and Jagan, 2025)
* *[S4Vectors](https://bioconductor.org/packages/3.22/S4Vectors)* (Pagès, Lawrence, and Aboyoun, 2017)
* *[sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo)* (Wickham, Chang, Flight, Müller, and Hester, 2025)
* *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2014)
* *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025)
* *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017)
* *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux, McPherson, Luraschi, Ushey, Atkins, Wickham, Cheng, Chang, and Iannone, 2025)
* *[testthat](https://CRAN.R-project.org/package%3Dtestthat)* (Wickham, 2011)

Code for creating the vignette

```
## Create the vignette
library("rmarkdown")
system.time(render("derfinderHelper.Rmd", "BiocStyle::html_document"))

## Extract the R code
library("knitr")
knit("derfinderHelper.Rmd", tangle = TRUE)
```

Date the vignette was generated.

```
## [1] "2025-10-29 23:34:45 EDT"
```

Wallclock time spent generating the vignette.

```
## Time difference of 3.317 secs
```

`R` session information.

```
## ─ Session info ───────────────────────────────────────────────────────────────────────────────────────────────────────
##  setting  value
##  version  R version 4.5.1 Patched (2025-08-23 r88802)
##  os       Ubuntu 24.04.3 LTS
##  system   x86_64, linux-gnu
##  ui       X11
##  language (EN)
##  collate  C
##  ctype    en_US.UTF-8
##  tz       America/New_York
##  date     2025-10-29
##  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
##  quarto   1.7.32 @ /usr/local/bin/quarto
##
## ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
##  package         * version date (UTC) lib source
##  backports         1.5.0   2024-05-23 [2] CRAN (R 4.5.1)
##  bibtex            0.5.1   2023-01-26 [2] CRAN (R 4.5.1)
##  BiocGenerics    * 0.56.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  BiocManager       1.30.26 2025-06-05 [2] CRAN (R 4.5.1)
##  BiocStyle       * 2.38.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  bookdown          0.45    2025-10-03 [2] CRAN (R 4.5.1)
##  bslib             0.9.0   2025-01-30 [2] CRAN (R 4.5.1)
##  cachem            1.1.0   2024-05-16 [2] CRAN (R 4.5.1)
##  cli               3.6.5   2025-04-23 [2] CRAN (R 4.5.1)
##  derfinderHelper * 1.44.0  2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
##  digest            0.6.37  2024-08-19 [2] CRAN (R 4.5.1)
##  evaluate          1.0.5   2025-08-27 [2] CRAN (R 4.5.1)
##  fastmap           1.2.0   2024-05-15 [2] CRAN (R 4.5.1)
##  generics        * 0.1.4   2025-05-09 [2] CRAN (R 4.5.1)
##  glue              1.8.0   2024-09-30 [2] CRAN (R 4.5.1)
##  htmltools         0.5.8.1 2024-04-04 [2] CRAN (R 4.5.1)
##  httr              1.4.7   2023-08-15 [2] CRAN (R 4.5.1)
##  IRanges         * 2.44.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  jquerylib         0.1.4   2021-04-26 [2] CRAN (R 4.5.1)
##  jsonlite          2.0.0   2025-03-27 [2] CRAN (R 4.5.1)
##  knitr             1.50    2025-03-16 [2] CRAN (R 4.5.1)
##  lattice           0.22-7  2025-04-02 [3] CRAN (R 4.5.1)
##  lifecycle         1.0.4   2023-11-07 [2] CRAN (R 4.5.1)
##  lubridate         1.9.4   2024-12-08 [2] CRAN (R 4.5.1)
##  magrittr          2.0.4   2025-09-12 [2] CRAN (R 4.5.1)
##  Matrix            1.7-4   2025-08-28 [3] CRAN (R 4.5.1)
##  plyr              1.8.9   2023-10-02 [2] CRAN (R 4.5.1)
##  R6                2.6.1   2025-02-15 [2] CRAN (R 4.5.1)
##  Rcpp              1.1.0   2025-07-02 [2] CRAN (R 4.5.1)
##  RefManageR      * 1.4.0   2022-09-30 [2] CRAN (R 4.5.1)
##  rlang             1.1.6   2025-04-11 [2] CRAN (R 4.5.1)
##  rmarkdown         2.30    2025-09-28 [2] CRAN (R 4.5.1)
##  S4Vectors       * 0.48.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  sass              0.4.10  2025-04-11 [2] CRAN (R 4.5.1)
##  sessioninfo     * 1.2.3   2025-02-05 [2] CRAN (R 4.5.1)
##  stringi           1.8.7   2025-03-27 [2] CRAN (R 4.5.1)
##  stringr           1.5.2   2025-09-08 [2] CRAN (R 4.5.1)
##  timechange        0.3.0   2024-01-18 [2] CRAN (R 4.5.1)
##  xfun              0.53    2025-08-19 [2] CRAN (R 4.5.1)
##  xml2              1.4.1   2025-10-27 [2] CRAN (R 4.5.1)
##  yaml              2.3.10  2024-07-26 [2] CRAN (R 4.5.1)
##
##  [1] /tmp/Rtmpk6I1jo/Rinst118dc2cbf057d
##  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
##  [3] /home/biocbuild/bbs-3.22-bioc/R/library
##  * ── Packages attached to the search path.
##
## ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

# 6 Bibliography

This vignette was generated using *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025)
with *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2014) and *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux et al., 2025) running behind the scenes.

Citations made with *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017).

[[1]](#cite-allaire2025rmarkdown)
J. Allaire, Y. Xie, C. Dervieux, et al.
*rmarkdown: Dynamic Documents for R*.
R package version 2.30.
2025.
URL: <https://github.com/rstudio/rmarkdown>.

[[2]](#cite-bates2025matrix)
D. Bates, M. Maechler, and M. Jagan.
*Matrix: Sparse and Dense Matrix Classes and Methods*.
R package version 1.7-4.
2025.
DOI: [10.32614/CRAN.package.Matrix](https://doi.org/10.32614/CRAN.package.Matrix).
URL: [https://CRAN.R-project.org/package=Matrix](https://CRAN.R-project.org/package%3DMatrix).

[[3]](#cite-colladotorres2017derfinderhelper)
L. Collado-Torres, A. E. Jaffe, and J. T. Leek.
*derfinderHelper: derfinder helper package*.
<https://github.com/leekgroup/derfinderHelper> - R package version 1.44.0.
2017.
DOI: [10.18129/B9.bioc.derfinderHelper](https://doi.org/10.18129/B9.bioc.derfinderHelper).
URL: <http://www.bioconductor.org/packages/derfinderHelper>.

[[4]](#cite-lawrence2013software)
M. Lawrence, W. Huber, H. Pagès, et al.
“Software for Computing and Annotating Genomic Ranges”.
In: *PLoS Computational Biology* 9 (8 2013).
DOI: [10.1371/journal.pcbi.1003118](https://doi.org/10.1371/journal.pcbi.1003118).
URL: [[http://www.ploscompbiol.org/article/info%3Adoi%2F10.1371%2Fjournal.pcbi.1003118](http://www.ploscompbiol.org/article/info%3Adoi/10.1371/journal.pcbi.1003118)}.](http://www.ploscompbiol.org/article/info%3Adoi/10.1371/journal.pcbi.1003118%7D.)

[[5]](#cite-mclean2017refmanager)
M. W. McLean.
“RefManageR: Import and Manage BibTeX and BibLaTeX References in R”.
In: *The Journal of Open Source Software* (2017).
DOI: [10.21105/joss.00338](https://doi.org/10.21105/joss.00338).

[[6]](#cite-ole2025biocstyle)
A. Oleś.
*BiocStyle: Standard styles for vignettes and other Bioconductor documents*.
R package version 2.38.0.
2025.
DOI: [10.18129/B9.bioc.BiocStyle](https://doi.org/10.18129/B9.bioc.BiocStyle).
URL: <https://bioconductor.org/packages/BiocStyle>.

[[7]](#cite-S4Vectors)
H. Pagès, M. Lawrence, and P. Aboyoun.
*S4Vectors: S4 implementation of vector-like and list-like objects*.
2017.
DOI: [10.18129/B9.bioc.S4Vectors](https://doi.org/10.18129/B9.bioc.S4Vectors).

[[8]](#cite-2025language)
R Core Team.
*R: A Language and Environment for Statistical Computing*.
R Foundation for Statistical Computing.
Vienna, Austria, 2025.
URL: <https://www.R-project.org/>.

[[9]](#cite-wickham2011testthat)
H. Wickham.
“testthat: Get Started with Testing”.
In: *The R Journal* 3 (2011), pp. 5–10.
URL: <https://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf>.

[[10]](#cite-wickham2025sessioninfo)
H. Wickham, W. Chang, R. Flight, et al.
*sessioninfo: R Session Information*.
R package version 1.2.3.
2025.
DOI: [10.32614/CRAN.package.sessioninfo](https://doi.org/10.32614/CRAN.package.sessioninfo).
URL: [https://CRAN.R-project.org/package=sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo).

[[11]](#cite-xie2014knitr)
Y. Xie.
“knitr: A Comprehensive Tool for Reproducible Research in R”.
In:
*Implementing Reproducible Computational Research*.
Ed. by V. Stodden, F. Leisch and R. D. Peng.
ISBN 978-1466561595.
Chapman and Hall/CRC, 2014.