Code

* Show All Code
* Hide All Code

# Introduction to `awst`

Davide Risso1\*

1Department of Statistical Sciences, University of Padova

\*risso.davide@gmail.com

#### 29 October 2025

#### Package

awst 1.18.0

# 1 Basics

## 1.1 Install `awst`

`R` is an open-source statistical environment which can be easily modified to
enhance its functionality via packages. *[awst](https://bioconductor.org/packages/3.22/awst)* is a `R` package
available via the [Bioconductor](http://bioconductor.org) repository for
packages. `R` can be installed on any operating system from
[CRAN](https://cran.r-project.org/) after which you can install
*[awst](https://bioconductor.org/packages/3.22/awst)* by using the following commands in your `R` session:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("awst")

## Check that you have a valid Bioconductor installation
BiocManager::valid()
```

## 1.2 Required knowledge

*[awst](https://bioconductor.org/packages/3.22/awst)* is based on many other packages and in particular in those
that have implemented the infrastructure needed for dealing with RNA-seq data.
That is, packages like *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)*.

If you are asking yourself the question “Where do I start using Bioconductor?”
you might be interested in [this blog
post](http://lcolladotor.github.io/2014/10/16/startbioc/#.VkOKbq6rRuU).

## 1.3 Asking for help

As package developers, we try to explain clearly how to use our packages and in
which order to use the functions. But `R` and `Bioconductor` have a steep
learning curve so it is critical to learn where to ask for help. The blog post
quoted above mentions some but we would like to highlight the
[Bioconductor support site](https://support.bioconductor.org/) as the main
resource for getting help: remember to use the `awst` tag and check
[the older posts](https://support.bioconductor.org/t/awst/).
Other alternatives are available such as creating GitHub issues and tweeting.
However, please note that if you want to receive help you should adhere to the
[posting guidelines](http://www.bioconductor.org/help/support/posting-guide/).
It is particularly critical that you provide a small reproducible example and
your session information so package developers can track down the source of the
error.

## 1.4 Citing `awst`

We hope that *[awst](https://bioconductor.org/packages/3.22/awst)* will be useful for your research. Please use
the following information to cite the package and the overall approach.
Thank you!

```
## Citation info
citation("awst")
#> Warning in person1(given = given[[i]], family = family[[i]], middle =
#> middle[[i]], : It is recommended to use 'given' instead of 'middle'.
#> To cite package 'awst' in publications use:
#>
#>   Risso D, Pagnotta SM (2021). "Per-sample standardization and
#>   asymmetric winsorization lead to accurate clustering of RNA-seq
#>   expression profiles." _Bioinformatics_.
#>   doi:10.1093/bioinformatics/btab091
#>   <https://doi.org/10.1093/bioinformatics/btab091>.
#>
#> A BibTeX entry for LaTeX users is
#>
#>   @Article{,
#>     title = {Per-sample standardization and asymmetric winsorization lead to accurate clustering of RNA-seq expression profiles},
#>     author = {Davide Risso and Stefano Maria Pagnotta},
#>     year = {2021},
#>     journal = {Bioinformatics},
#>     doi = {10.1093/bioinformatics/btab091},
#>   }
```

# 2 What does `awst` does?

AWST aims to regularize the original read counts to reduce the effect of noise
on the clustering of samples. In fact, gene expression data are characterized by
high levels of noise in both lowly expressed features, which suffer from
background effects and low signal-to-noise ratio, and highly expressed features,
which may be the result of amplification bias and other experimental artifacts.
These effects are of utmost importance in highly degraded or low input material
samples, such as tumor samples and single cells.

AWST comprises two main steps. In the first one, namely the standardization
step, we standardize the counts by centering and scaling them, exploiting the
log-normal probability distribution. We refer to the standardized counts as
z-counts. The second step, namely the smoothing step, leverages a highly skewed
transformation that decreases the noise while preserving the influence of genes
to separate molecular subtypes. These two steps are implemented in the `awst`
function.

A further filtering method, implemented in the `gene_filter` function, is
suggested to remove those features that only contribute noise to the clustering.

# 3 Quick start

```
library(awst)
library(airway)
library(SummarizedExperiment)
library(EDASeq)
library(ggplot2)
```

Here, we will use the data in the *[airway](https://bioconductor.org/packages/3.22/airway)* package to illustrate
the `awst` approach.

Please, see our paper (Risso and Pagnotta, 2021) and
[this repository](https://github.com/drisso/awst_analysis) for more extensive
and biologically relevant examples.

```
data(airway)
airway
#> class: RangedSummarizedExperiment
#> dim: 63677 8
#> metadata(1): ''
#> assays(1): counts
#> rownames(63677): ENSG00000000003 ENSG00000000005 ... ENSG00000273492
#>   ENSG00000273493
#> rowData names(10): gene_id gene_name ... seq_coord_system symbol
#> colnames(8): SRR1039508 SRR1039509 ... SRR1039520 SRR1039521
#> colData names(9): SampleName cell ... Sample BioSample
```

The data are stored in a `RangedSummarizedExperiment`, a special case of the
`SummarizedExperiment` class, one of the central classes in Bioconductor. If you
are not familiar with it, I recomment to look at its vignette available at
*[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)*.

First, we filter out non-expressed genes. For simplicity, we remove those genes
with fewer than 10 reads on average across samples.

```
filter <- rowMeans(assay(airway)) >= 10
table(filter)
#> filter
#> FALSE  TRUE
#> 47587 16090

se <- airway[filter,]
```

We are left with 16090 genes. We are now ready to apply `awst` to the
data.

```
se <- awst(se)
se
#> class: RangedSummarizedExperiment
#> dim: 16090 8
#> metadata(1): ''
#> assays(2): counts awst
#> rownames(16090): ENSG00000000003 ENSG00000000419 ... ENSG00000273472
#>   ENSG00000273486
#> rowData names(10): gene_id gene_name ... seq_coord_system symbol
#> colnames(8): SRR1039508 SRR1039509 ... SRR1039520 SRR1039521
#> colData names(9): SampleName cell ... Sample BioSample
plot(density(assay(se, "awst")[,1]), main = "Sample 1")
```

![](data:image/png;base64...)

We can see that the majority of the values have been shrunk around −2, while the
others values gradually increase up to around 4. The effect of reducing the
contribution of lowly expressed genes, and of the winsorization for the highly
expressed ones, results in a better separation of the samples, reflecting
biological differences (Risso and Pagnotta, 2021).

The other main function of the *[awst](https://bioconductor.org/packages/3.22/awst)* package is `gene_filter`.
It can be used to remove those genes that contribute little to nothing to the
distance between samples. The function uses an entropy measure to remove the
uninformative genes.

```
filtered <- gene_filter(se)
dim(filtered)
#> [1] 10842     8
```

Our final dataset is made of 8 genes.

We can see how the `awst` transformation leads to separation between treatment
(along PC1) and cell line (along PC2).

```
res_pca <- prcomp(t(assay(filtered, "awst")))
df <- as.data.frame(cbind(res_pca$x, colData(airway)))
ggplot(df, aes(x = PC1, y = PC2, color = dex, shape = cell)) +
    geom_point() + theme_classic()
```

![](data:image/png;base64...)

# 4 Role of normalization

Although in this example `awst` applied to raw data works well, a prior
normalization step can help. We have found that full-quantile normalization
works well and has the computational advantage of allowing `awst` to estimate
the parameters only once for all samples (Risso and Pagnotta, 2021).

Here we show the results of `awst` after full-quantile normalization
(implemented in *[EDASeq](https://bioconductor.org/packages/3.22/EDASeq)*).

```
assay(se, "fq") <- betweenLaneNormalization(assay(se), which="full")
se <- awst(se, expr_values = "fq")

res_pca <- prcomp(t(assay(se, "awst")))
df <- as.data.frame(cbind(res_pca$x, colData(airway)))
ggplot(df, aes(x = PC1, y = PC2, color = dex, shape = cell)) +
    geom_point() + theme_classic()
```

![](data:image/png;base64...)

# 5 Reproducibility

The *[awst](https://bioconductor.org/packages/3.22/awst)* package (Risso and Pagnotta, 2021) was made possible
thanks to:

* R (R Core Team, 2025)
* *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025)
* *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2025)
* *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017)
* *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux, McPherson, Luraschi, Ushey, Atkins, Wickham, Cheng, Chang, and Iannone, 2025)
* *[sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo)* (Wickham, Chang, Flight, Müller, and Hester, 2025)
* *[testthat](https://CRAN.R-project.org/package%3Dtestthat)* (Wickham, 2011)

This package was developed using *[biocthis](https://bioconductor.org/packages/3.22/biocthis)*.

Code for creating the vignette

```
## Create the vignette
library("rmarkdown")
system.time(render("awst_intro.Rmd", "BiocStyle::html_document"))

## Extract the R code
library("knitr")
knit("awst_intro.Rmd", tangle = TRUE)
```

Date the vignette was generated.

```
#> [1] "2025-10-29 22:35:43 EDT"
```

Wallclock time spent generating the vignette.

```
#> Time difference of 22.405 secs
```

`R` session information.

```
#> ─ Session info ───────────────────────────────────────────────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 Patched (2025-08-23 r88802)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-10-29
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
#>  package              * version   date (UTC) lib source
#>  abind                  1.4-8     2024-09-12 [2] CRAN (R 4.5.1)
#>  airway               * 1.29.0    2025-10-28 [2] Bioconductor 3.22 (R 4.5.1)
#>  AnnotationDbi          1.72.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  aroma.light            3.40.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  awst                 * 1.18.0    2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
#>  backports              1.5.0     2024-05-23 [2] CRAN (R 4.5.1)
#>  bibtex                 0.5.1     2023-01-26 [2] CRAN (R 4.5.1)
#>  Biobase              * 2.70.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocFileCache          3.0.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocGenerics         * 0.56.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocIO                 1.20.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocManager            1.30.26   2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocParallel         * 1.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocStyle            * 2.38.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  biomaRt                2.66.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Biostrings           * 2.78.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  bit                    4.6.0     2025-03-06 [2] CRAN (R 4.5.1)
#>  bit64                  4.6.0-1   2025-01-16 [2] CRAN (R 4.5.1)
#>  bitops                 1.0-9     2024-10-03 [2] CRAN (R 4.5.1)
#>  blob                   1.2.4     2023-03-17 [2] CRAN (R 4.5.1)
#>  bookdown               0.45      2025-10-03 [2] CRAN (R 4.5.1)
#>  bslib                  0.9.0     2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem                 1.1.0     2024-05-16 [2] CRAN (R 4.5.1)
#>  cigarillo              1.0.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  cli                    3.6.5     2025-04-23 [2] CRAN (R 4.5.1)
#>  codetools              0.2-20    2024-03-31 [3] CRAN (R 4.5.1)
#>  crayon                 1.5.3     2024-06-20 [2] CRAN (R 4.5.1)
#>  curl                   7.0.0     2025-08-19 [2] CRAN (R 4.5.1)
#>  DBI                    1.2.3     2024-06-02 [2] CRAN (R 4.5.1)
#>  dbplyr                 2.5.1     2025-09-10 [2] CRAN (R 4.5.1)
#>  DelayedArray           0.36.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  deldir                 2.0-4     2024-02-28 [2] CRAN (R 4.5.1)
#>  dichromat              2.0-0.1   2022-05-02 [2] CRAN (R 4.5.1)
#>  digest                 0.6.37    2024-08-19 [2] CRAN (R 4.5.1)
#>  dplyr                  1.1.4     2023-11-17 [2] CRAN (R 4.5.1)
#>  EDASeq               * 2.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  evaluate               1.0.5     2025-08-27 [2] CRAN (R 4.5.1)
#>  farver                 2.1.2     2024-05-13 [2] CRAN (R 4.5.1)
#>  fastmap                1.2.0     2024-05-15 [2] CRAN (R 4.5.1)
#>  filelock               1.0.3     2023-12-11 [2] CRAN (R 4.5.1)
#>  generics             * 0.1.4     2025-05-09 [2] CRAN (R 4.5.1)
#>  GenomicAlignments    * 1.46.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  GenomicFeatures        1.62.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  GenomicRanges        * 1.62.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  ggplot2              * 4.0.0     2025-09-11 [2] CRAN (R 4.5.1)
#>  glue                   1.8.0     2024-09-30 [2] CRAN (R 4.5.1)
#>  gtable                 0.3.6     2024-10-25 [2] CRAN (R 4.5.1)
#>  hms                    1.1.4     2025-10-17 [2] CRAN (R 4.5.1)
#>  htmltools              0.5.8.1   2024-04-04 [2] CRAN (R 4.5.1)
#>  httr                   1.4.7     2023-08-15 [2] CRAN (R 4.5.1)
#>  httr2                  1.2.1     2025-07-22 [2] CRAN (R 4.5.1)
#>  hwriter                1.3.2.1   2022-04-08 [2] CRAN (R 4.5.1)
#>  interp                 1.1-6     2024-01-26 [2] CRAN (R 4.5.1)
#>  IRanges              * 2.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  jpeg                   0.1-11    2025-03-21 [2] CRAN (R 4.5.1)
#>  jquerylib              0.1.4     2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite               2.0.0     2025-03-27 [2] CRAN (R 4.5.1)
#>  KEGGREST               1.50.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  knitr                  1.50      2025-03-16 [2] CRAN (R 4.5.1)
#>  labeling               0.4.3     2023-08-29 [2] CRAN (R 4.5.1)
#>  lattice                0.22-7    2025-04-02 [3] CRAN (R 4.5.1)
#>  latticeExtra           0.6-31    2025-09-10 [2] CRAN (R 4.5.1)
#>  lifecycle              1.0.4     2023-11-07 [2] CRAN (R 4.5.1)
#>  lubridate              1.9.4     2024-12-08 [2] CRAN (R 4.5.1)
#>  magrittr               2.0.4     2025-09-12 [2] CRAN (R 4.5.1)
#>  Matrix                 1.7-4     2025-08-28 [3] CRAN (R 4.5.1)
#>  MatrixGenerics       * 1.22.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  matrixStats          * 1.5.0     2025-01-07 [2] CRAN (R 4.5.1)
#>  memoise                2.0.1     2021-11-26 [2] CRAN (R 4.5.1)
#>  pillar                 1.11.1    2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgconfig              2.0.3     2019-09-22 [2] CRAN (R 4.5.1)
#>  plyr                   1.8.9     2023-10-02 [2] CRAN (R 4.5.1)
#>  png                    0.1-8     2022-11-29 [2] CRAN (R 4.5.1)
#>  prettyunits            1.2.0     2023-09-24 [2] CRAN (R 4.5.1)
#>  progress               1.2.3     2023-12-06 [2] CRAN (R 4.5.1)
#>  pwalign                1.6.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  R.methodsS3            1.8.2     2022-06-13 [2] CRAN (R 4.5.1)
#>  R.oo                   1.27.1    2025-05-02 [2] CRAN (R 4.5.1)
#>  R.utils                2.13.0    2025-02-24 [2] CRAN (R 4.5.1)
#>  R6                     2.6.1     2025-02-15 [2] CRAN (R 4.5.1)
#>  rappdirs               0.3.3     2021-01-31 [2] CRAN (R 4.5.1)
#>  RColorBrewer           1.1-3     2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp                   1.1.0     2025-07-02 [2] CRAN (R 4.5.1)
#>  RCurl                  1.98-1.17 2025-03-22 [2] CRAN (R 4.5.1)
#>  RefManageR           * 1.4.0     2022-09-30 [2] CRAN (R 4.5.1)
#>  restfulr               0.0.16    2025-06-27 [2] CRAN (R 4.5.1)
#>  rjson                  0.2.23    2024-09-16 [2] CRAN (R 4.5.1)
#>  rlang                  1.1.6     2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown              2.30      2025-09-28 [2] CRAN (R 4.5.1)
#>  Rsamtools            * 2.26.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  RSQLite                2.4.3     2025-08-20 [2] CRAN (R 4.5.1)
#>  rtracklayer            1.70.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Arrays               1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Vectors            * 0.48.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S7                     0.2.0     2024-11-07 [2] CRAN (R 4.5.1)
#>  sass                   0.4.10    2025-04-11 [2] CRAN (R 4.5.1)
#>  scales                 1.4.0     2025-04-24 [2] CRAN (R 4.5.1)
#>  Seqinfo              * 1.0.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  sessioninfo          * 1.2.3     2025-02-05 [2] CRAN (R 4.5.1)
#>  ShortRead            * 1.68.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  SparseArray            1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  stringi                1.8.7     2025-03-27 [2] CRAN (R 4.5.1)
#>  stringr                1.5.2     2025-09-08 [2] CRAN (R 4.5.1)
#>  SummarizedExperiment * 1.40.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  tibble                 3.3.0     2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyselect             1.2.1     2024-03-11 [2] CRAN (R 4.5.1)
#>  timechange             0.3.0     2024-01-18 [2] CRAN (R 4.5.1)
#>  vctrs                  0.6.5     2023-12-01 [2] CRAN (R 4.5.1)
#>  withr                  3.0.2     2024-10-28 [2] CRAN (R 4.5.1)
#>  xfun                   0.53      2025-08-19 [2] CRAN (R 4.5.1)
#>  XML                    3.99-0.19 2025-08-22 [2] CRAN (R 4.5.1)
#>  xml2                   1.4.1     2025-10-27 [2] CRAN (R 4.5.1)
#>  XVector              * 0.50.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  yaml                   2.3.10    2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/RtmpUS50IS/Rinst341c6fd300e0f
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

# 6 Bibliography

This vignette was generated using *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)*
(Oleś, 2025)
with *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2025) and *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)*
(Allaire, Xie, Dervieux et al., 2025) running behind the scenes.

Citations made with *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017).

[[1]](#cite-allaire2025rmarkdown)
J. Allaire, Y. Xie, C. Dervieux, et al.
*rmarkdown: Dynamic Documents for R*.
R package version 2.30.
2025.
URL: <https://github.com/rstudio/rmarkdown>.

[[2]](#cite-mclean2017refmanager)
M. W. McLean.
“RefManageR: Import and Manage BibTeX and BibLaTeX References in R”.
In: *The Journal of Open Source Software* (2017).
DOI: [10.21105/joss.00338](https://doi.org/10.21105/joss.00338).

[[3]](#cite-ole2025biocstyle)
A. Oleś.
*BiocStyle: Standard styles for vignettes and other Bioconductor documents*.
R package version 2.38.0.
2025.
DOI: [10.18129/B9.bioc.BiocStyle](https://doi.org/10.18129/B9.bioc.BiocStyle).
URL: <https://bioconductor.org/packages/BiocStyle>.

[[4]](#cite-2025language)
R Core Team.
*R: A Language and Environment for Statistical Computing*.
R Foundation for Statistical Computing.
Vienna, Austria, 2025.
URL: <https://www.R-project.org/>.

[[5]](#cite-risso2021sample)
D. Risso and S. M. Pagnotta.
“Per-sample standardization and asymmetric winsorization lead to accurate clustering of RNA-seq expression profiles”.
In: *Bioinformatics* (2021).
DOI: [10.1093/bioinformatics/btab091](https://doi.org/10.1093/bioinformatics/btab091).

[[6]](#cite-wickham2011testthat)
H. Wickham.
“testthat: Get Started with Testing”.
In: *The R Journal* 3 (2011), pp. 5–10.
URL: <https://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf>.

[[7]](#cite-wickham2025sessioninfo)
H. Wickham, W. Chang, R. Flight, et al.
*sessioninfo: R Session Information*.
R package version 1.2.3.
2025.
DOI: [10.32614/CRAN.package.sessioninfo](https://doi.org/10.32614/CRAN.package.sessioninfo).
URL: [https://CRAN.R-project.org/package=sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo).

[[8]](#cite-xie2025knitr)
Y. Xie.
*knitr: A General-Purpose Package for Dynamic Report Generation in R*.
R package version 1.50.
2025.
URL: <https://yihui.org/knitr/>.