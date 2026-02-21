Code

* Show All Code
* Hide All Code

# Introduction to derfinderData

Leonardo Collado-Torres1,2\*

1Lieber Institute for Brain Development, Johns Hopkins Medical Campus
2Center for Computational Biology, Johns Hopkins University

\*lcolladotor@gmail.com

#### 4 November 2025

#### Package

derfinderData 2.28.0

# 1 Overview

`derfinderData` is a small data package with information extracted from *BrainSpan* (see [here](http://download.alleninstitute.org/brainspan/MRF_BigWig_Gencode_v10/bigwig/)) (BrainSpan, 2011) for 24 samples restricted to chromosome 21. The BigWig files in this package can then be used by other packages for examples, such as in `derfinder` and `derfinderPlot`.

While you could download the data from *BrainSpan* (BrainSpan, 2011), this package is helpful for scenarios where you might encounter some difficulties such as the one described in this [thread](https://stat.ethz.ch/pipermail/bioc-devel/2014-September/006329.html).

# 2 Data

The following code builds the phenotype table included in `derfinderData`. For two randomly selected structures, 12 samples were chosen with 6 of them being fetal samples and the other 6 coming from adult individuals. For the fetal samples, the age in PCW is transformed into age in years by

```
age_in_years = (age_in_PCW - 40) / 52
```

In other data sets you might want to subtract 42 instead of 40 if some observations have PCW up to 42.

```
## Construct brainspanPheno table
brainspanPheno <- data.frame(
    gender = c("F", "M", "M", "M", "F", "F", "F", "M", "F", "M", "M", "F", "M", "M", "M", "M", "F", "F", "F", "M", "F", "M", "M", "F"),
    lab = c("HSB97.AMY", "HSB92.AMY", "HSB178.AMY", "HSB159.AMY", "HSB153.AMY", "HSB113.AMY", "HSB130.AMY", "HSB136.AMY", "HSB126.AMY", "HSB145.AMY", "HSB123.AMY", "HSB135.AMY", "HSB114.A1C", "HSB103.A1C", "HSB178.A1C", "HSB154.A1C", "HSB150.A1C", "HSB149.A1C", "HSB130.A1C", "HSB136.A1C", "HSB126.A1C", "HSB145.A1C", "HSB123.A1C", "HSB135.A1C"),
    Age = c(-0.442307692307693, -0.365384615384615, -0.461538461538461, -0.307692307692308, -0.538461538461539, -0.538461538461539, 21, 23, 30, 36, 37, 40, -0.519230769230769, -0.519230769230769, -0.461538461538461, -0.461538461538461, -0.538461538461539, -0.519230769230769, 21, 23, 30, 36, 37, 40)
)
brainspanPheno$structure_acronym <- rep(c("AMY", "A1C"), each = 12)
brainspanPheno$structure_name <- rep(c("amygdaloid complex", "primary auditory cortex (core)"), each = 12)
brainspanPheno$file <- paste0("http://download.alleninstitute.org/brainspan/MRF_BigWig_Gencode_v10/bigwig/", brainspanPheno$lab, ".bw")
brainspanPheno$group <- factor(ifelse(brainspanPheno$Age < 0, "fetal", "adult"), levels = c("fetal", "adult"))
```

We can then save the phenotype information, which is included in `derfinderData`.

```
## Save pheno table
save(brainspanPheno, file = "brainspanPheno.RData")
```

Here is how the data looks like:

```
library("knitr")

## Explore pheno
p <- brainspanPheno[, -which(colnames(brainspanPheno) %in% c("structure_acronym", "structure_name", "file"))]
kable(p, format = "html", row.names = TRUE)
```

|  | gender | lab | Age | group |
| --- | --- | --- | --- | --- |
| 1 | F | HSB97.AMY | -0.4423077 | fetal |
| 2 | M | HSB92.AMY | -0.3653846 | fetal |
| 3 | M | HSB178.AMY | -0.4615385 | fetal |
| 4 | M | HSB159.AMY | -0.3076923 | fetal |
| 5 | F | HSB153.AMY | -0.5384615 | fetal |
| 6 | F | HSB113.AMY | -0.5384615 | fetal |
| 7 | F | HSB130.AMY | 21.0000000 | adult |
| 8 | M | HSB136.AMY | 23.0000000 | adult |
| 9 | F | HSB126.AMY | 30.0000000 | adult |
| 10 | M | HSB145.AMY | 36.0000000 | adult |
| 11 | M | HSB123.AMY | 37.0000000 | adult |
| 12 | F | HSB135.AMY | 40.0000000 | adult |
| 13 | M | HSB114.A1C | -0.5192308 | fetal |
| 14 | M | HSB103.A1C | -0.5192308 | fetal |
| 15 | M | HSB178.A1C | -0.4615385 | fetal |
| 16 | M | HSB154.A1C | -0.4615385 | fetal |
| 17 | F | HSB150.A1C | -0.5384615 | fetal |
| 18 | F | HSB149.A1C | -0.5192308 | fetal |
| 19 | F | HSB130.A1C | 21.0000000 | adult |
| 20 | M | HSB136.A1C | 23.0000000 | adult |
| 21 | F | HSB126.A1C | 30.0000000 | adult |
| 22 | M | HSB145.A1C | 36.0000000 | adult |
| 23 | M | HSB123.A1C | 37.0000000 | adult |
| 24 | F | HSB135.A1C | 40.0000000 | adult |

We can verify that this is indeed the information included in `derfinderData`.

```
## Rename our newly created pheno data
newPheno <- brainspanPheno

## Load the included data
library("derfinderData")
```

```
##
## Attaching package: 'derfinderData'
```

```
## The following object is masked _by_ '.GlobalEnv':
##
##     brainspanPheno
```

```
## Verify
identical(newPheno, brainspanPheno)
```

```
## [1] TRUE
```

Using the phenotype information, you can use `derfinder` to extract the base-level coverage information for chromosome 21 from these samples. Then, you can export the data to BigWig files.

```
library("derfinder")

## Determine the files to use and fix the names
files <- brainspanPheno$file
names(files) <- gsub(".AMY|.A1C", "", brainspanPheno$lab)

## Load the data
system.time(fullCovAMY <- fullCoverage(
    files = files[brainspanPheno$structure_acronym == "AMY"], chrs = "chr21"
))
# user  system elapsed
# 4.505   0.178  37.676
system.time(fullCovA1C <- fullCoverage(
    files = files[brainspanPheno$structure_acronym == "A1C"], chrs = "chr21"
))
# user  system elapsed
# 2.968   0.139  27.704

## Write BigWig files
dir.create("AMY")
system.time(createBw(fullCovAMY, path = "AMY", keepGR = FALSE))
# user  system elapsed
# 5.749   0.332   6.045
dir.create("A1C")
system.time(createBw(fullCovA1C, path = "A1C", keepGR = FALSE))
# user  system elapsed
# 5.025   0.299   5.323

## Check that 12 files were created in each directory
all(c(length(dir("AMY")), length(dir("A1C"))) == 12)
# TRUE

## Save data for examples running on Windows
save(fullCovAMY, file = "fullCovAMY.RData")
save(fullCovA1C, file = "fullCovA1C.RData")
```

These BigWig files are available under *extdata* as shown below:

```
## Find AMY BigWigs
dir(system.file("extdata", "AMY", package = "derfinderData"))
```

```
##  [1] "HSB113.bw" "HSB123.bw" "HSB126.bw" "HSB130.bw" "HSB135.bw" "HSB136.bw"
##  [7] "HSB145.bw" "HSB153.bw" "HSB159.bw" "HSB178.bw" "HSB92.bw"  "HSB97.bw"
```

```
## Find A1C BigWigs
dir(system.file("extdata", "A1C", package = "derfinderData"))
```

```
##  [1] "HSB103.bw" "HSB114.bw" "HSB123.bw" "HSB126.bw" "HSB130.bw" "HSB135.bw"
##  [7] "HSB136.bw" "HSB145.bw" "HSB149.bw" "HSB150.bw" "HSB154.bw" "HSB178.bw"
```

# 3 Reproducibility

Code for creating the vignette

```
## Create the vignette
library("rmarkdown")
system.time(render("derfinderData.Rmd", "BiocStyle::html_document"))

## Extract the R code
library("knitr")
knit("derfinderData.Rmd", tangle = TRUE)
```

Date the vignette was generated.

```
## [1] "2025-11-04 11:16:25 EST"
```

Wallclock time spent generating the vignette.

```
## Time difference of 0.779 secs
```

`R` session information.

```
## ─ Session info ───────────────────────────────────────────────────────────────
##  setting  value
##  version  R version 4.5.1 Patched (2025-08-23 r88802)
##  os       Ubuntu 24.04.3 LTS
##  system   x86_64, linux-gnu
##  ui       X11
##  language (EN)
##  collate  C
##  ctype    en_US.UTF-8
##  tz       America/New_York
##  date     2025-11-04
##  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
##  quarto   1.7.32 @ /usr/local/bin/quarto
##
## ─ Packages ───────────────────────────────────────────────────────────────────
##  package       * version date (UTC) lib source
##  backports       1.5.0   2024-05-23 [2] CRAN (R 4.5.1)
##  bibtex          0.5.1   2023-01-26 [2] CRAN (R 4.5.1)
##  BiocManager     1.30.26 2025-06-05 [2] CRAN (R 4.5.1)
##  BiocStyle     * 2.38.0  2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
##  bookdown        0.45    2025-10-03 [2] CRAN (R 4.5.1)
##  bslib           0.9.0   2025-01-30 [2] CRAN (R 4.5.1)
##  cachem          1.1.0   2024-05-16 [2] CRAN (R 4.5.1)
##  cli             3.6.5   2025-04-23 [2] CRAN (R 4.5.1)
##  derfinderData * 2.28.0  2025-11-04 [1] Bioconductor 3.22 (R 4.5.1)
##  digest          0.6.37  2024-08-19 [2] CRAN (R 4.5.1)
##  evaluate        1.0.5   2025-08-27 [2] CRAN (R 4.5.1)
##  fastmap         1.2.0   2024-05-15 [2] CRAN (R 4.5.1)
##  generics        0.1.4   2025-05-09 [2] CRAN (R 4.5.1)
##  glue            1.8.0   2024-09-30 [2] CRAN (R 4.5.1)
##  htmltools       0.5.8.1 2024-04-04 [2] CRAN (R 4.5.1)
##  httr            1.4.7   2023-08-15 [2] CRAN (R 4.5.1)
##  jquerylib       0.1.4   2021-04-26 [2] CRAN (R 4.5.1)
##  jsonlite        2.0.0   2025-03-27 [2] CRAN (R 4.5.1)
##  knitr         * 1.50    2025-03-16 [2] CRAN (R 4.5.1)
##  lifecycle       1.0.4   2023-11-07 [2] CRAN (R 4.5.1)
##  lubridate       1.9.4   2024-12-08 [2] CRAN (R 4.5.1)
##  magrittr        2.0.4   2025-09-12 [2] CRAN (R 4.5.1)
##  plyr            1.8.9   2023-10-02 [2] CRAN (R 4.5.1)
##  R6              2.6.1   2025-02-15 [2] CRAN (R 4.5.1)
##  Rcpp            1.1.0   2025-07-02 [2] CRAN (R 4.5.1)
##  RefManageR    * 1.4.0   2022-09-30 [2] CRAN (R 4.5.1)
##  rlang           1.1.6   2025-04-11 [2] CRAN (R 4.5.1)
##  rmarkdown       2.30    2025-09-28 [2] CRAN (R 4.5.1)
##  sass            0.4.10  2025-04-11 [2] CRAN (R 4.5.1)
##  sessioninfo   * 1.2.3   2025-02-05 [2] CRAN (R 4.5.1)
##  stringi         1.8.7   2025-03-27 [2] CRAN (R 4.5.1)
##  stringr         1.5.2   2025-09-08 [2] CRAN (R 4.5.1)
##  timechange      0.3.0   2024-01-18 [2] CRAN (R 4.5.1)
##  xfun            0.54    2025-10-30 [2] CRAN (R 4.5.1)
##  xml2            1.4.1   2025-10-27 [2] CRAN (R 4.5.1)
##  yaml            2.3.10  2024-07-26 [2] CRAN (R 4.5.1)
##
##  [1] /tmp/RtmpZItnjj/Rinst2725a61c0070c
##  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
##  [3] /home/biocbuild/bbs-3.22-bioc/R/library
##  * ── Packages attached to the search path.
##
## ──────────────────────────────────────────────────────────────────────────────
```

# 4 Bibliography

This vignette was generated using `BiocStyle` (Oleś, 2025)
with `knitr` (Xie, 2014) and `rmarkdown` (Allaire, Xie, Dervieux, McPherson, Luraschi, Ushey, Atkins, Wickham, Cheng, Chang, and Iannone, 2025) running behind the scenes.

Citations made with *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017).

[[1]](#cite-allaire2025rmarkdown)
J. Allaire, Y. Xie, C. Dervieux, et al.
*rmarkdown: Dynamic Documents for R*.
R package version 2.30.
2025.
URL: <https://github.com/rstudio/rmarkdown>.

[[2]](#cite-brainspan)
BrainSpan.
“Atlas of the Developing Human Brain [Internet]. Funded by ARRA Awards 1RC2MH089921-01, 1RC2MH090047-01, and 1RC2MH089929-01.”
2011.
URL: <http://developinghumanbrain.org>.

[[3]](#cite-mclean2017refmanager)
M. W. McLean.
“RefManageR: Import and Manage BibTeX and BibLaTeX References in R”.
In: *The Journal of Open Source Software* (2017).
DOI: [10.21105/joss.00338](https://doi.org/10.21105/joss.00338).

[[4]](#cite-ole2025biocstyle)
A. Oleś.
*BiocStyle: Standard styles for vignettes and other Bioconductor documents*.
R package version 2.38.0.
2025.
DOI: [10.18129/B9.bioc.BiocStyle](https://doi.org/10.18129/B9.bioc.BiocStyle).
URL: <https://bioconductor.org/packages/BiocStyle>.

[[5]](#cite-xie2014knitr)
Y. Xie.
“knitr: A Comprehensive Tool for Reproducible Research in R”.
In:
*Implementing Reproducible Computational Research*.
Ed. by V. Stodden, F. Leisch and R. D. Peng.
ISBN 978-1466561595.
Chapman and Hall/CRC, 2014.