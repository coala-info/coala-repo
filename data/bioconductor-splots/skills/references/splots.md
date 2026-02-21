# splots: visualization of data from assays in microtitre plate or slide format

Wolfgang Huber

#### 2021-01-04

#### Package

splots 1.76.0

# Contents

* [1 Example data](#example-data)
* [2 Using `ggplot2`](#using-ggplot2)
* [3 Using `splots::plotScreen`](#using-splotsplotscreen)

The `splots` package was written in 2006, and it is still here to support legacy code and to not disrupt other packages that depend on it. It should not be used for new code development. The package provides a single function, `plotScreen`, for visualising data in microtitre plate or slide format. Please consider using the *[platetools](https://CRAN.R-project.org/package%3Dplatetools)* package (see also <https://github.com/Swarchal/platetools>), or simply *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)*, as exemplified below.

# 1 Example data

```
data("featuresPerWell", package = "HD2013SGI")
```

This dataset contains measurements of a combinatorial RNAi screen on a human cell line (HCT116) with fluorescent microscopy as a phenotypic readout, as described in the documentation of the `HD2013SGI` package.
There are 168 plates, each with 384 wells. Within each well, the microscope took images at 4 locations, called `field`. Plate, row, column and field ID are given in the following dataframe.

```
str(featuresPerWell[[1]])
```

```
## 'data.frame':    231840 obs. of  4 variables:
##  $ plate: chr  "001CIQ01IRI" "001CIQ01IRI" "001CIQ01IRI" "001CIQ01IRI" ...
##  $ row  : chr  "B" "B" "B" "B" ...
##  $ col  : chr  "1" "1" "1" "1" ...
##  $ field: chr  "1" "2" "3" "4" ...
```

The actual measurements are in the following matrix, whose rows are aligned with the above dataframe. Its 353 columns are different morphometric measurements, averaged across the cells in that image.

```
str(featuresPerWell[[2]])
```

```
##  num [1:231840, 1:353] 2780 3120 2242 2603 2170 ...
##  - attr(*, "dimnames")=List of 2
##   ..$ : NULL
##   ..$ : chr [1:353] "count" "nuc.0.m.cx" "nuc.0.m.cy" "nuc.0.m.majoraxis" ...
```

For the purpose of this demo, we only use the first 40 plates and the `count` measurement in field 1, i.e., the number of cells in that field—a proxy for the cells’ viability. We also convert the `row` and `col` variables into integers.

```
library("dplyr")
sgi = tibble(featuresPerWell[[1]], count = featuresPerWell[[2]][, "count"]) |>
  filter(plate %in% unique(plate)[1:40],
         field == "1") |>
  mutate (col = as.integer(col),
          row = match(row, LETTERS))
sgi
```

```
## # A tibble: 13,800 × 5
##    plate         row   col field count
##    <chr>       <int> <int> <chr> <dbl>
##  1 001CIQ01IRI     2     1 1      2780
##  2 001CIQ01IRI     2     2 1      2170
##  3 001CIQ01IRI     2     3 1      2548
##  4 001CIQ01IRI     2     4 1      2673
##  5 001CIQ01IRI     2     5 1      2486
##  6 001CIQ01IRI     2     6 1      2611
##  7 001CIQ01IRI     2     7 1      2305
##  8 001CIQ01IRI     2     8 1      2261
##  9 001CIQ01IRI     2     9 1      2724
## 10 001CIQ01IRI     2    10 1      4026
## # ℹ 13,790 more rows
```

# 2 Using `ggplot2`

```
library("ggplot2")
ggplot(sgi, aes(x = col, y = row, fill = count)) + geom_raster() +
  facet_wrap(vars(plate), ncol = 4) +
  scale_fill_gradient(low = "white", high = "#00008B")
```

![Visualization using `ggplot`](data:image/png;base64...)

Figure 1: Visualization using `ggplot`

# 3 Using `splots::plotScreen`

The `plotScreen` takes as input the list `xl`, constructed below. As you can see, this is a lot more clumsy.

```
np = 40
nx = 24
ny = 16
plateNames = unique(featuresPerWell[[1]]$plate)
assertthat::assert_that(length(plateNames) >= np)
plateNames = plateNames[seq_len(np)]
xl = lapply(plateNames, function(pl) {
  sel = with(featuresPerWell[[1]], plate == pl & field == "1")
  rv = rep(NA_real_, nx * ny)
  r = match(featuresPerWell[[1]]$row[sel], LETTERS)
  c = match(featuresPerWell[[1]]$col[sel], paste(seq_len(nx)))
  i = (r-1) * nx + c
  assertthat::assert_that(!any(is.na(r)), !any(is.na(c)), !any(duplicated(i)),
                          all(r>=1), all(r<=ny), all(c>=1), all(c<=nx))
  rv[i] = featuresPerWell[[2]][sel, "count"]
  rv
})
names(xl) = plateNames
```

So this the list `xl`:

```
length(xl)
```

```
## [1] 40
```

```
names(xl)[1:4]
```

```
## [1] "001CIQ01IRI"   "002CIQ01IIRI"  "003CIIQ01IRI"  "004CIIQ01IIRI"
```

```
unique(vapply(xl, function(x) paste(class(x), length(x)), character(1)))
```

```
## [1] "numeric 384"
```

```
xl[[1]][1:30]
```

```
##  [1]   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA
## [16]   NA   NA   NA   NA   NA   NA   NA   NA   NA 2780 2170 2548 2673 2486 2611
```

```
splots::plotScreen(xl, nx = nx, ny = ny, ncol = 4,
           fill = c("white", "#00008B"),
           main = "HD2013SGI", legend.label = "count",
           zrange = c(0, max(unlist(xl), na.rm = TRUE)))
```

```
## Warning in splots::plotScreen(xl, nx = nx, ny = ny, ncol = 4, fill = c("white",
## : The function splots::plotScreen is obsolete, please use ggplot with
## geom_raster and facet_wrap instead, as described in the vignette of the splots
## package
```

![Visualization using `splots::plotScreen`](data:image/png;base64...)

Figure 2: Visualization using `splots::plotScreen`

```
sessionInfo()
```

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
## [1] ggplot2_4.0.0    dplyr_1.1.4      BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6        jsonlite_2.0.0      compiler_4.5.1
##  [4] BiocManager_1.30.26 splots_1.76.0       Rcpp_1.1.0
##  [7] tinytex_0.57        tidyselect_1.2.1    magick_2.9.0
## [10] assertthat_0.2.1    dichromat_2.0-0.1   jquerylib_0.1.4
## [13] scales_1.4.0        yaml_2.3.10         fastmap_1.2.0
## [16] R6_2.6.1            labeling_0.4.3      generics_0.1.4
## [19] knitr_1.50          tibble_3.3.0        bookdown_0.45
## [22] bslib_0.9.0         pillar_1.11.1       RColorBrewer_1.1-3
## [25] rlang_1.1.6         utf8_1.2.6          cachem_1.1.0
## [28] xfun_0.53           sass_0.4.10         S7_0.2.0
## [31] cli_3.6.5           withr_3.0.2         magrittr_2.0.4
## [34] digest_0.6.37       grid_4.5.1          lifecycle_1.0.4
## [37] vctrs_0.6.5         evaluate_1.0.5      glue_1.8.0
## [40] farver_2.1.2        rmarkdown_2.30      tools_4.5.1
## [43] pkgconfig_2.0.3     htmltools_0.5.8.1
```