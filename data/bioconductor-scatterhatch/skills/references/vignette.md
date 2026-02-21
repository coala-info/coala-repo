# Creating a Scatterplot with Texture

#### Tejas Guha

#### January 21, 2021

## Importing Local Libraries

```
library(scatterHatch)
```

## Preparing the Data

The data that will be used to showcase the function is [a tissue-CyCIF PDAC dataset from Lin et al](http://spatial.rc.fas.harvard.edu/spatialgiotto/giotto.cycif.html). The preprocessing begins by adding manual annotations for each cell’s location in the tissue sample.

```
data("pdacData")
pdacData$cellID <- paste0('cell_', 1:nrow(pdacData))
pdacData$Yt <- -pdacData$Yt
pancreas_frames = c(1:6, 27:31, 15:19, 40:44)
PDAC_frames = c(23:26, 35:37, 51:52, 64:65, 77)
small_intestines_frames = c(49:50, 63, 75:76, 88:89, 100:103, 112:116, 125:129, 137:140)
annotateLocation <- function(frame){
    if (frame %in% pancreas_frames){return("Pancreas")}
    if (frame %in% PDAC_frames){return("PDAC")}
    if (frame %in% small_intestines_frames){return("Small Intestine")}
    return("Other")
}
pdacData$location <- sapply(pdacData$frame, annotateLocation)

head(pdacData[, c('Xt', 'Yt', 'location', 'frame')])
#>         Xt        Yt location frame
#> 1 1342.878  -801.154 Pancreas     1
#> 2 5688.494 -1391.393 Pancreas     4
#> 3 6295.826 -1393.807 Pancreas     4
#> 4 5344.257 -1391.650 Pancreas     4
#> 5 5640.034 -1391.416 Pancreas     4
#> 6 5923.357 -1390.776 Pancreas     4
```

## Creating a Basic ScatterHatch Plot

`scatterHatch()` must have a data frame passed to it, along with three strings denoting the columns with the x/y coordinates and a factor variable of each point being plotted. The factor variable identifies the group each point is a part of. `scatterHatch()` returns a ggplot2 object with three layers; the points, the line segments (the hatching), and an invisible custom geom to render the legend icons.

```
plt <- scatterHatch(data = pdacData, x = "Xt", y = "Yt", color_by = "location", legendTitle = "Tissue Type")
plot(plt)
```

![](data:image/png;base64...)

## Customizing ScatterHatch Plot

### Changing the Order of Pattern Assignment

Controlling the aesthetics of each pattern is done by passing a list to the `patternList` argument. Each element of the list should contain a list that denotes the desired aesthetics for each pattern. Every element of `patternList` must have a named element called “pattern” that contains the unique pattern type for which the aesthetics are being changed. If patternList is passed, then the length of patternList must be equal to the number of groups being plotted.

### Changing the Angles of each Pattern

Angle denotes the angle(s) for which the lines of a particular hatching pattern should be drawn. For example, the default horizontal pattern (“+”) is an angle of 0 while the default vertical pattern (“-”) is an angle of 90. Angle can be a vector with multiple angles. For example, the cross (“x”) is a vector of angles: `c(135, 45)`.

```
patternList = list(list(pattern = "/", angle = 70), list(pattern = "-"), list(pattern = "x",
    angle = c(135, 90, 45), lineWidth = 0.2), list(pattern = "+"))
plt <- scatterHatch(data = pdacData, x = "Xt", y = "Yt", color_by = "location", legendTitle = "Tissue Type",
    patternList = patternList)
plot(plt)
```

![](data:image/png;base64...)

## scatterHatch() Arguments Explained

| Argument | Description |
| --- | --- |
| data | A dataframe of the dataset being plotted |
| x | A string describing the column name with the x-coordinates of the points being plotted |
| y | A string describing the column name with the y-coordinates of the points being plotted |
| factor | A string describing the column name of the factor variable |
| legendTitle | The legend title |
| pointSize | ggplot2 point size |
| pointAlpha | Transparency of each point |
| gridSize | Integer describing the precision of the hatched patterns. Larger the value, greater the precision at the expense of efficiency. Default segregates plots into 10000 bins |
| sparsePoints | A logical vector that denotes the outlying points. Default utilizies an in-built sparsity detector |
| patternList | List containing the aesthethics of each pattern |
| colorPalette | Character vector describing the point color of each group; default is color-blind friendly and uses colors from the dittoSeq package |

## Pattern Aesthetics Arguments

These pattern aesthetics are passed into a list in the patternList argument of `scatterHatch()`.

| Aesthetics | Description |
| --- | --- |
| pattern | A string representing one of the possible 7 patterns to be used: (horizontal or “-”), (vertical or “|”), (positiveDiagonal or “/”), (negativeDiagonal or “"), (checkers or”+“), (cross or”x“), and (blank or”"). |
| angle | Vector or number denoting at what angle(s) the lines in a hatching pattern should be drawn - e.g. `c(45, 90, 135)` |
| lineWidth | Number representing the width of the lines in the pattern |
| lineColor | String representing the colors of the lines in the pattern (black, white, etc.) |
| lineType | String representing the type of lines in the pattern (solid, dashed, etc.) |

## Session Info

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
#> [1] scatterHatch_1.16.0
#>
#> loaded via a namespace (and not attached):
#>  [1] Matrix_1.7-4          gtable_0.3.6          jsonlite_2.0.0
#>  [4] dplyr_1.1.4           compiler_4.5.1        spatstat.utils_3.2-0
#>  [7] Rcpp_1.1.0            tidyselect_1.2.1      dichromat_2.0-0.1
#> [10] jquerylib_0.1.4       scales_1.4.0          yaml_2.3.10
#> [13] fastmap_1.2.0         lattice_0.22-7        plyr_1.8.9
#> [16] ggplot2_4.0.0         deldir_2.0-4          R6_2.6.1
#> [19] spatstat.univar_3.1-4 labeling_0.4.3        generics_0.1.4
#> [22] spatstat.geom_3.6-0   knitr_1.50            polyclip_1.10-7
#> [25] tibble_3.3.0          bslib_0.9.0           pillar_1.11.1
#> [28] RColorBrewer_1.1-3    rlang_1.1.6           cachem_1.1.0
#> [31] xfun_0.53             sass_0.4.10           S7_0.2.0
#> [34] cli_3.6.5             withr_3.0.2           magrittr_2.0.4
#> [37] formatR_1.14          digest_0.6.37         grid_4.5.1
#> [40] lifecycle_1.0.4       vctrs_0.6.5           evaluate_1.0.5
#> [43] glue_1.8.0            farver_2.1.2          spatstat.data_3.1-9
#> [46] rmarkdown_2.30        tools_4.5.1           pkgconfig_2.0.3
#> [49] htmltools_0.5.8.1
```