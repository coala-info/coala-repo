# Overview

William Hutchison1\* and Stefano Mangiola1

1WEHI - Walter and Eliza Hall Institute of Medical Research

\*hutchison.w@wehi.edu.au

#### 1 December 2025

#### Abstract

A brief overview of the tidySpatialExperiment package - demonstrating the SpatialExperiment-tibble abstraction, compatibility with the *tidyverse* ecosystem, compatibility with the *tidyomics* ecosystem and a few helpful utility functions.

#### Package

tidySpatialExperiment 1.6.2

# Contents

* [1 Introduction](#introduction)
  + [1.1 Resources](#resources)
  + [1.2 Functions and utilities](#functions-and-utilities)
  + [1.3 Installation](#installation)
  + [1.4 Load data](#load-data)
  + [1.5 SpatialExperiment-tibble abstraction](#spatialexperiment-tibble-abstraction)
* [2 Integration with the *tidyverse* ecosystem](#integration-with-the-tidyverse-ecosystem)
  + [2.1 Manipulate with dplyr](#manipulate-with-dplyr)
  + [2.2 Tidy with tidyr](#tidy-with-tidyr)
  + [2.3 Plot with ggplot2](#plot-with-ggplot2)
  + [2.4 Plot with plotly](#plot-with-plotly)
* [3 Utilities](#utilities)
  + [3.1 Append feature data to cell data](#append-feature-data-to-cell-data)
  + [3.2 Aggregate cells](#aggregate-cells)
  + [3.3 Elliptical and rectangular region selection](#elliptical-and-rectangular-region-selection)
  + [3.4 Interactive gating](#interactive-gating)
* [4 Special column behaviour](#special-column-behaviour)
* [5 Citation](#citation)
* [6 Session information](#session-information)

# 1 Introduction

tidySpatialExperiment provides a bridge between the
[SpatialExperiment](https://github.com/drighelli/SpatialExperiment)
package and the [*tidyverse*](https://www.tidyverse.org) ecosystem. It
creates an invisible layer that allows you to interact with a
`SpatialExperiment` object as if it were a tibble; enabling the use of
functions from [dplyr](https://github.com/tidyverse/dplyr),
[tidyr](https://github.com/tidyverse/tidyr),
[ggplot2](https://github.com/tidyverse/ggplot2) and
[plotly](https://github.com/plotly/plotly.R). But, underneath, your data
remains a `SpatialExperiment` object.

tidySpatialExperiment also provides six additional utility functions.

## 1.1 Resources

If you would like to learn more about tidySpatialExperiment and *tidyomics*, the following links are a good place to start:

* [The tidySpatialExperiment
  website](http://william-hutchison.github.io/tidySpatialExperiment/)
* [The tidyomics website](https://github.com/tidyomics)

The *tidyomics* ecosystem also includes packages for:

* Working with genomic features:

  + [plyranges](https://github.com/sa-lee/plyranges), for tidy
    manipulation of genomic range data.
  + [nullranges](https://github.com/nullranges/nullranges), for tidy
    generation of genomic ranges representing the null hypothesis.
  + [plyinteractions](https://github.com/tidyomics/plyinteractions),
    for tidy manipulation of genomic interaction data.
* Working with transcriptomic features:

  + [tidySummarizedExperiment](https://github.com/stemangiola/tidySummarizedExperiment),
    for tidy manipulation of `SummarizedExperiment` objects.
  + [tidySingleCellExperiment](https://github.com/stemangiola/tidySingleCellExperiment),
    for tidy manipulation of `SingleCellExperiment` objects.
  + [tidyseurat](https://github.com/stemangiola/tidyseurat), for
    tidy manipulation of `Seurat` objects.
  + [tidybulk](https://github.com/stemangiola/tidybulk), for bulk
    RNA-seq analysis.
* Working with cytometry features:

  + [tidytof](https://github.com/keyes-timothy/tidytof), for tidy
    manipulation of high-dimensional cytometry data.
* And a few associated packages:

  + [tidygate](https://github.com/stemangiola/tidygate), for manual
    gating of points in space.
  + [tidyheatmap](https://github.com/stemangiola/tidyHeatmap/), for
    modular heatmap contruction.

## 1.2 Functions and utilities

| Package | Functions available |
| --- | --- |
| `SpatialExperiment` | All |
| `dplyr` | `arrange`,`bind_rows`, `bind_cols`, `distinct`, `filter`, `group_by`, `summarise`, `select`, `mutate`, `rename`, `left_join`, `right_join`, `inner_join`, `slice`, `sample_n`, `sample_frac`, `count`, `add_count` |
| `tidyr` | `nest`, `unnest`, `unite`, `separate`, `extract`, `pivot_longer` |
| `ggplot2` | `ggplot` |
| `plotly` | `plot_ly` |

| Utility | Description |
| --- | --- |
| `as_tibble` | Convert cell data to a `tbl_df` |
| `join_features` | Append feature data to cell data |
| `aggregate_cells` | Aggregate cell-feature abundance into a pseudobulk `SummarizedExperiment` object |
| `rectangle` | Select cells in a rectangular region of space |
| `ellipse` | Select cells in an elliptical region of space |
| `gate` | Interactively or programmatically select cells in an arbitrary region of space |

## 1.3 Installation

You can install the stable version of tidySpatialExperiment from
Bioconductor.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("tidySpatialExperiment")
```

Or, you can install the development version of tidySpatialExperiment
from GitHub.

```
if (!requireNamespace("pak", quietly = TRUE))
    install.packages("pak")

pak::pak("william-hutchison/tidySpatialExperiment")
```

## 1.4 Load data

Here, we attach tidySpatialExperiment and an example `SpatialExperiment`
object.

```
# Load example SpatialExperiment object
library(tidySpatialExperiment)
example(read10xVisium)
```

```
## Warning in read10xVisium(samples, sample_ids, type = "sparse", data = "raw", : 'read10xVisium' is deprecated.
## Use 'VisiumIO::TENxVisium(List)' instead.
## See help("Deprecated")
```

```
## Warning: `when()` was deprecated in purrr 1.0.0.
## ℹ Please use `if` instead.
## ℹ The deprecated feature was likely used in the tidySpatialExperiment package.
##   Please report the issue at
##   <https://github.com/william-hutchison/tidySpatialExperiment/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning in read10xVisium(samples2, sample_ids, type = "sparse", data = "raw", : 'read10xVisium' is deprecated.
## Use 'VisiumIO::TENxVisium(List)' instead.
## See help("Deprecated")
```

## 1.5 SpatialExperiment-tibble abstraction

A `SpatialExperiment` object represents assay-feature values as rows and
cells as columns. Additional information about the cells is stored in the
`reducedDims`, `colData` and `spatialCoords` slots.

tidySpatialExperiment provides a SpatialExperiment-tibble abstraction,
representing cells as rows and cell data as columns, in accordance with the
tidy observation-variable convention. The cell data is made up of information stored in the `colData` and `spatialCoords` slots.

The default view is now of the SpatialExperiment-tibble abstraction.

```
spe
```

```
## # A SpatialExperiment-tibble abstraction: 50 × 7
## # Features = 50 | Cells = 50 | Assays = counts
##    .cell              in_tissue array_row array_col sample_id pxl_col_in_fullres
##    <chr>              <lgl>         <int>     <int> <chr>                  <int>
##  1 AAACAACGAATAGTTC-1 FALSE             0        16 section1                2312
##  2 AAACAAGTATCTCCCA-1 TRUE             50       102 section1                8230
##  3 AAACAATCTACTAGCA-1 TRUE              3        43 section1                4170
##  4 AAACACCAATAACTGC-1 TRUE             59        19 section1                2519
##  5 AAACAGAGCGACTCCT-1 TRUE             14        94 section1                7679
##  6 AAACAGCTTTCAGAAG-1 FALSE            43         9 section1                1831
##  7 AAACAGGGTCTATATT-1 FALSE            47        13 section1                2106
##  8 AAACAGTGTTCCTGGG-1 FALSE            73        43 section1                4170
##  9 AAACATGGTGAGAGGA-1 FALSE            62         0 section1                1212
## 10 AAACATTTCCCGGATT-1 FALSE            61        97 section1                7886
## # ℹ 40 more rows
## # ℹ 1 more variable: pxl_row_in_fullres <int>
```

But, our data maintains its status as a `SpatialExperiment` object.
Therefore, we have access to all `SpatialExperiment` functions.

```
spe |>
    colData() |>
    head()
```

```
## DataFrame with 6 rows and 4 columns
##                    in_tissue array_row array_col   sample_id
##                    <logical> <integer> <integer> <character>
## AAACAACGAATAGTTC-1     FALSE         0        16    section1
## AAACAAGTATCTCCCA-1      TRUE        50       102    section1
## AAACAATCTACTAGCA-1      TRUE         3        43    section1
## AAACACCAATAACTGC-1      TRUE        59        19    section1
## AAACAGAGCGACTCCT-1      TRUE        14        94    section1
## AAACAGCTTTCAGAAG-1     FALSE        43         9    section1
```

```
spe |>
    spatialCoords() |>
    head()
```

```
##                    pxl_col_in_fullres pxl_row_in_fullres
## AAACAACGAATAGTTC-1               2312               1252
## AAACAAGTATCTCCCA-1               8230               7237
## AAACAATCTACTAGCA-1               4170               1611
## AAACACCAATAACTGC-1               2519               8315
## AAACAGAGCGACTCCT-1               7679               2927
## AAACAGCTTTCAGAAG-1               1831               6400
```

```
spe |>
    imgData()
```

```
## DataFrame with 1 row and 4 columns
##     sample_id    image_id   data scaleFactor
##   <character> <character> <list>   <numeric>
## 1    section1      lowres   ####   0.0510334
```

# 2 Integration with the *tidyverse* ecosystem

## 2.1 Manipulate with dplyr

Most functions from dplyr are available for use with the
SpatialExperiment-tibble abstraction. For example, `filter()` can be used
to filter cells by a variable of interest.

```
spe |>
   filter(array_col < 5)
```

```
## # A SpatialExperiment-tibble abstraction: 3 × 7
## # Features = 50 | Cells = 3 | Assays = counts
##   .cell              in_tissue array_row array_col sample_id pxl_col_in_fullres
##   <chr>              <lgl>         <int>     <int> <chr>                  <int>
## 1 AAACATGGTGAGAGGA-1 FALSE            62         0 section1                1212
## 2 AAACGAAGATGGAGTA-1 FALSE            58         4 section1                1487
## 3 AAAGAATGACCTTAGA-1 FALSE            64         2 section1                1349
## # ℹ 1 more variable: pxl_row_in_fullres <int>
```

And `mutate` can be used to add new variables, or modify the value of an
existing variable.

```
spe |>
    mutate(in_region = c(in_tissue & array_row < 10))
```

```
## # A SpatialExperiment-tibble abstraction: 50 × 8
## # Features = 50 | Cells = 50 | Assays = counts
##    .cell    in_tissue array_row array_col sample_id in_region pxl_col_in_fullres
##    <chr>    <lgl>         <int>     <int> <chr>     <lgl>                  <int>
##  1 AAACAAC… FALSE             0        16 section1  FALSE                   2312
##  2 AAACAAG… TRUE             50       102 section1  FALSE                   8230
##  3 AAACAAT… TRUE              3        43 section1  TRUE                    4170
##  4 AAACACC… TRUE             59        19 section1  FALSE                   2519
##  5 AAACAGA… TRUE             14        94 section1  FALSE                   7679
##  6 AAACAGC… FALSE            43         9 section1  FALSE                   1831
##  7 AAACAGG… FALSE            47        13 section1  FALSE                   2106
##  8 AAACAGT… FALSE            73        43 section1  FALSE                   4170
##  9 AAACATG… FALSE            62         0 section1  FALSE                   1212
## 10 AAACATT… FALSE            61        97 section1  FALSE                   7886
## # ℹ 40 more rows
## # ℹ 1 more variable: pxl_row_in_fullres <int>
```

## 2.2 Tidy with tidyr

Most functions from tidyr are also available. Here, `nest()` is used to
group the data by `sample_id`, and `unnest()` is used to ungroup the data.

```
# Nest the SpatialExperiment object by sample_id
spe_nested <-
    spe |>
    nest(data = -sample_id)

# View the nested SpatialExperiment object
spe_nested
```

```
## # A tibble: 1 × 2
##   sample_id data
##   <chr>     <list>
## 1 section1  <SptlExpr[,50]>
```

```
# Unnest the nested SpatialExperiment objects
spe_nested |>
    unnest(data)
```

```
## # A SpatialExperiment-tibble abstraction: 50 × 7
## # Features = 50 | Cells = 50 | Assays = counts
##    .cell              in_tissue array_row array_col sample_id pxl_col_in_fullres
##    <chr>              <lgl>         <int>     <int> <chr>                  <int>
##  1 AAACAACGAATAGTTC-1 FALSE             0        16 section1                2312
##  2 AAACAAGTATCTCCCA-1 TRUE             50       102 section1                8230
##  3 AAACAATCTACTAGCA-1 TRUE              3        43 section1                4170
##  4 AAACACCAATAACTGC-1 TRUE             59        19 section1                2519
##  5 AAACAGAGCGACTCCT-1 TRUE             14        94 section1                7679
##  6 AAACAGCTTTCAGAAG-1 FALSE            43         9 section1                1831
##  7 AAACAGGGTCTATATT-1 FALSE            47        13 section1                2106
##  8 AAACAGTGTTCCTGGG-1 FALSE            73        43 section1                4170
##  9 AAACATGGTGAGAGGA-1 FALSE            62         0 section1                1212
## 10 AAACATTTCCCGGATT-1 FALSE            61        97 section1                7886
## # ℹ 40 more rows
## # ℹ 1 more variable: pxl_row_in_fullres <int>
```

## 2.3 Plot with ggplot2

The `ggplot()` function can be used to create a plot directly from a
`SpatialExperiment` object. This example also demonstrates how tidy
operations can be combined to build up more complex analysis.

```
spe |>
    filter(sample_id == "section1" & in_tissue) |>

    # Add a column with the sum of feature counts per cell
    mutate(count_sum = purrr::map_int(.cell, ~
        spe[, .x] |>
            counts() |>
            sum()
      )) |>

    # Plot with tidySpatialExperiment and ggplot2
    ggplot(aes(x = reorder(.cell, count_sum), y = count_sum)) +
    geom_point() +
    coord_flip()
```

![](data:image/png;base64...)

## 2.4 Plot with plotly

The `plot_ly()` function can also be used to create a plot from a
`SpatialExperiment` object.

```
spe |>
    filter(sample_id == "section1") |>
    plot_ly(
        x = ~ array_col,
        y = ~ array_row,
        color = ~ in_tissue,
        type = "scatter"
    )
```

![](data:image/png;base64...)

# 3 Utilities

## 3.1 Append feature data to cell data

The *tidyomics* ecosystem places an emphasis on interacting with cell
data. To interact with feature data, the `join_features()` function can be
used to append assay-feature values to cell data.

```
# Join feature data in wide format, preserving the SpatialExperiment object
spe |>
    join_features(features = c("ENSMUSG00000025915", "ENSMUSG00000042501"), shape = "wide") |>
    head()
```

```
## # A SpatialExperiment-tibble abstraction: 50 × 9
## # Features = 6 | Cells = 50 | Assays = counts
##    .cell              in_tissue array_row array_col sample_id ENSMUSG00000025915
##    <chr>              <lgl>         <int>     <int> <chr>                  <dbl>
##  1 AAACAACGAATAGTTC-1 FALSE             0        16 section1                   0
##  2 AAACAAGTATCTCCCA-1 TRUE             50       102 section1                   0
##  3 AAACAATCTACTAGCA-1 TRUE              3        43 section1                   0
##  4 AAACACCAATAACTGC-1 TRUE             59        19 section1                   0
##  5 AAACAGAGCGACTCCT-1 TRUE             14        94 section1                   0
##  6 AAACAGCTTTCAGAAG-1 FALSE            43         9 section1                   0
##  7 AAACAGGGTCTATATT-1 FALSE            47        13 section1                   0
##  8 AAACAGTGTTCCTGGG-1 FALSE            73        43 section1                   0
##  9 AAACATGGTGAGAGGA-1 FALSE            62         0 section1                   0
## 10 AAACATTTCCCGGATT-1 FALSE            61        97 section1                   0
## # ℹ 40 more rows
## # ℹ 3 more variables: ENSMUSG00000042501 <dbl>, pxl_col_in_fullres <int>,
## #   pxl_row_in_fullres <int>
```

```
# Join feature data in long format, discarding the SpatialExperiment object
spe |>
    join_features(features = c("ENSMUSG00000025915", "ENSMUSG00000042501"), shape = "long") |>
    head()
```

```
## tidySpatialExperiment says: A data frame is returned for independent data
##               analysis.
```

```
## # A tibble: 6 × 7
##   .cell       in_tissue array_row array_col sample_id .feature .abundance_counts
##   <chr>       <lgl>         <int>     <int> <chr>     <chr>                <dbl>
## 1 AAACAACGAA… FALSE             0        16 section1  ENSMUSG…                 0
## 2 AAACAACGAA… FALSE             0        16 section1  ENSMUSG…                 0
## 3 AAACAAGTAT… TRUE             50       102 section1  ENSMUSG…                 0
## 4 AAACAAGTAT… TRUE             50       102 section1  ENSMUSG…                 1
## 5 AAACAATCTA… TRUE              3        43 section1  ENSMUSG…                 0
## 6 AAACAATCTA… TRUE              3        43 section1  ENSMUSG…                 0
```

## 3.2 Aggregate cells

Sometimes, it is necessary to aggregate the gene-transcript abundance
from a group of cells into a single value. For example, when comparing
groups of cells across different samples with fixed-effect models.

The `aggregate_cells()` function can be used to aggregate cells by a
specified variable and assay, returning a `SummarizedExperiment` object.

```
spe |>
    aggregate_cells(in_tissue, assays = "counts")
```

```
## class: SummarizedExperiment
## dim: 50 2
## metadata(0):
## assays(1): counts
## rownames(50): ENSMUSG00000002459 ENSMUSG00000005886 ...
##   ENSMUSG00000104217 ENSMUSG00000104328
## rowData names(1): symbol
## colnames(2): FALSE TRUE
## colData names(3): .aggregated_cells in_tissue sample_id
```

## 3.3 Elliptical and rectangular region selection

The `ellipse()` and `rectangle()` functions can be used to select cells by
their position in space.

```
spe |>
    filter(sample_id == "section1") |>
    mutate(in_ellipse = ellipse(array_col, array_row, c(20, 40), c(20, 20))) |>
    ggplot(aes(x = array_col, y = array_row, colour = in_ellipse)) +
    geom_point()
```

![](data:image/png;base64...)

## 3.4 Interactive gating

For the interactive selection of cells in space, tidySpatialExperiment experiment provides `gate()`. This function uses [tidygate](https://github.com/stemangiola/tidygate), shiny and plotly to launch an interactive plot overlaying cells in position with image data. Additional parameters can be used to specify point colour, shape, size and alpha, either with a column in the SpatialExperiment object or a constant value.

```
spe_gated <-
  spe |>
  gate(colour = "in_tissue", alpha = 0.8)
```

![](data:image/gif;base64...)

A record of which points appear in which gates is appended to the SpatialExperiment object in the `.gated` column. To select cells which appear within any gates, filter for non-NA values. To select cells which appear within a specific gate, string pattern matching can be used.

```
# Select cells within any gate
spe_gated |>
  filter(!is.na(.gated))
```

```
## # A SpatialExperiment-tibble abstraction: 4 × 8
## # Features = 50 | Cells = 4 | Assays = counts
##   .cell        in_tissue array_row array_col sample_id .gated pxl_col_in_fullres
##   <chr>        <lgl>         <int>     <int> <chr>     <chr>               <int>
## 1 AAACGAGACGG… TRUE             35        79 section1  2                    6647
## 2 AAACTGCTGGC… TRUE             45        67 section1  2                    5821
## 3 AAAGGGATGTA… TRUE             24        62 section1  1,2                  5477
## 4 AAAGGGCAGCT… TRUE             24        26 section1  1                    3000
## # ℹ 1 more variable: pxl_row_in_fullres <int>
```

```
# Select cells within gate 2
spe_gated |>
  filter(stringr::str_detect(.gated, "2"))
```

```
## # A SpatialExperiment-tibble abstraction: 3 × 8
## # Features = 50 | Cells = 3 | Assays = counts
##   .cell        in_tissue array_row array_col sample_id .gated pxl_col_in_fullres
##   <chr>        <lgl>         <int>     <int> <chr>     <chr>               <int>
## 1 AAACGAGACGG… TRUE             35        79 section1  2                    6647
## 2 AAACTGCTGGC… TRUE             45        67 section1  2                    5821
## 3 AAAGGGATGTA… TRUE             24        62 section1  1,2                  5477
## # ℹ 1 more variable: pxl_row_in_fullres <int>
```

Details of the interactively drawn gates are saved to `tidygate_env$gates`. This variable is overwritten each time interactive gates are drawn, so save it right away if you would like to access it later.

```
# Inspect previously drawn gates
tidygate_env$gates |>
  head()
```

```
## # A tibble: 6 × 3
##       x     y .gate
##   <dbl> <dbl> <dbl>
## 1 4310. 3125.     1
## 2 3734. 3161.     1
## 3 2942. 3521.     1
## 4 2834. 3665.     1
## 5 2834. 4385.     1
## 6 2978. 4493.     1
```

```
# Save if needed
tidygate_env$gates |>
  write_rds("important_gates.rds")
```

If previously drawn gates are supplied to the `programmatic_gates` argument, cells will be gated programmatically. This feature allows the reproduction of previously drawn interactive gates.

```
important_gates <-
  read_rds("important_gates.rds")

spe |>
  gate(programmatic_gates = important_gates)) |>
  filter(!is.na(.gated))
```

```
## # A SpatialExperiment-tibble abstraction: 4 × 8
## # Features = 50 | Cells = 4 | Assays = counts
##   .cell        in_tissue array_row array_col sample_id .gated pxl_col_in_fullres
##   <chr>        <lgl>         <int>     <int> <chr>     <chr>               <int>
## 1 AAACGAGACGG… TRUE             35        79 section1  2                    6647
## 2 AAACTGCTGGC… TRUE             45        67 section1  2                    5821
## 3 AAAGGGATGTA… TRUE             24        62 section1  1,2                  5477
## 4 AAAGGGCAGCT… TRUE             24        26 section1  1                    3000
## # ℹ 1 more variable: pxl_row_in_fullres <int>
```

# 4 Special column behaviour

Removing the `.cell` column will return a tibble. This is consistent
with the behaviour in other *tidyomics* packages.

```
spe |>
    select(-.cell) |>
    head()
```

```
## tidySpatialExperiment says: Key columns are missing. A data frame is
##                         returned for independent data analysis.
```

```
## # A tibble: 6 × 4
##   in_tissue array_row array_col sample_id
##   <lgl>         <int>     <int> <chr>
## 1 FALSE             0        16 section1
## 2 TRUE             50       102 section1
## 3 TRUE              3        43 section1
## 4 TRUE             59        19 section1
## 5 TRUE             14        94 section1
## 6 FALSE            43         9 section1
```

The `sample_id` column cannot be removed with *tidyverse* functions, and
can only be modified if the changes are accepted by SpatialExperiment’s
`colData()` function.

```
# sample_id is not removed, despite the user's request
spe |>
    select(-sample_id)
```

```
## # A SpatialExperiment-tibble abstraction: 50 × 7
## # Features = 50 | Cells = 50 | Assays = counts
##    .cell              in_tissue array_row array_col sample_id pxl_col_in_fullres
##    <chr>              <lgl>         <int>     <int> <chr>                  <int>
##  1 AAACAACGAATAGTTC-1 FALSE             0        16 section1                2312
##  2 AAACAAGTATCTCCCA-1 TRUE             50       102 section1                8230
##  3 AAACAATCTACTAGCA-1 TRUE              3        43 section1                4170
##  4 AAACACCAATAACTGC-1 TRUE             59        19 section1                2519
##  5 AAACAGAGCGACTCCT-1 TRUE             14        94 section1                7679
##  6 AAACAGCTTTCAGAAG-1 FALSE            43         9 section1                1831
##  7 AAACAGGGTCTATATT-1 FALSE            47        13 section1                2106
##  8 AAACAGTGTTCCTGGG-1 FALSE            73        43 section1                4170
##  9 AAACATGGTGAGAGGA-1 FALSE            62         0 section1                1212
## 10 AAACATTTCCCGGATT-1 FALSE            61        97 section1                7886
## # ℹ 40 more rows
## # ℹ 1 more variable: pxl_row_in_fullres <int>
```

```
# This change maintains separation of sample_ids and is permitted
spe |>
    mutate(sample_id = stringr::str_c(sample_id, "_modified")) |>
    head()
```

```
## # A SpatialExperiment-tibble abstraction: 50 × 7
## # Features = 6 | Cells = 50 | Assays = counts
##    .cell              in_tissue array_row array_col sample_id pxl_col_in_fullres
##    <chr>              <lgl>         <int>     <int> <chr>                  <int>
##  1 AAACAACGAATAGTTC-1 FALSE             0        16 section1…               2312
##  2 AAACAAGTATCTCCCA-1 TRUE             50       102 section1…               8230
##  3 AAACAATCTACTAGCA-1 TRUE              3        43 section1…               4170
##  4 AAACACCAATAACTGC-1 TRUE             59        19 section1…               2519
##  5 AAACAGAGCGACTCCT-1 TRUE             14        94 section1…               7679
##  6 AAACAGCTTTCAGAAG-1 FALSE            43         9 section1…               1831
##  7 AAACAGGGTCTATATT-1 FALSE            47        13 section1…               2106
##  8 AAACAGTGTTCCTGGG-1 FALSE            73        43 section1…               4170
##  9 AAACATGGTGAGAGGA-1 FALSE            62         0 section1…               1212
## 10 AAACATTTCCCGGATT-1 FALSE            61        97 section1…               7886
## # ℹ 40 more rows
## # ℹ 1 more variable: pxl_row_in_fullres <int>
```

```
# This change does not maintain separation of sample_ids and produces an error
spe |>
    mutate(sample_id = "new_sample")
```

```
## # A SpatialExperiment-tibble abstraction: 50 × 7
## # Features = 50 | Cells = 50 | Assays = counts
##    .cell              in_tissue array_row array_col sample_id pxl_col_in_fullres
##    <chr>              <lgl>         <int>     <int> <chr>                  <int>
##  1 AAACAACGAATAGTTC-1 FALSE             0        16 new_samp…               2312
##  2 AAACAAGTATCTCCCA-1 TRUE             50       102 new_samp…               8230
##  3 AAACAATCTACTAGCA-1 TRUE              3        43 new_samp…               4170
##  4 AAACACCAATAACTGC-1 TRUE             59        19 new_samp…               2519
##  5 AAACAGAGCGACTCCT-1 TRUE             14        94 new_samp…               7679
##  6 AAACAGCTTTCAGAAG-1 FALSE            43         9 new_samp…               1831
##  7 AAACAGGGTCTATATT-1 FALSE            47        13 new_samp…               2106
##  8 AAACAGTGTTCCTGGG-1 FALSE            73        43 new_samp…               4170
##  9 AAACATGGTGAGAGGA-1 FALSE            62         0 new_samp…               1212
## 10 AAACATTTCCCGGATT-1 FALSE            61        97 new_samp…               7886
## # ℹ 40 more rows
## # ℹ 1 more variable: pxl_row_in_fullres <int>
```

The `pxl_col_in_fullres` and `px_row_in_fullres` columns cannot be
removed or modified with *tidyverse* functions. This is consistent with
the behaviour of dimension reduction data in other *tidyomics* packages.

```
# Attempting to remove pxl_col_in_fullres produces an error
spe |>
    select(-pxl_col_in_fullres)
```

```
## Error in `select_helper()`:
## ! Can't select columns that don't exist.
## ✖ Column `pxl_col_in_fullres` doesn't exist.
```

```
# Attempting to modify pxl_col_in_fullres produces an error
spe |>
    mutate(pxl_col_in_fullres)
```

```
## Error in `dplyr::mutate()`:
## ℹ In argument: `pxl_col_in_fullres`.
## Caused by error:
## ! object 'pxl_col_in_fullres' not found
```

# 5 Citation

If you use tidySpatialExperiment in published research, please cite [The tidyomics ecosystem: enhancing omic data analyses](https://doi.org/10.1038/s41592-024-02299-2).

# 6 Session information

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] tidySpatialExperiment_1.6.2     ggplot2_4.0.1
##  [3] tidyr_1.3.1                     dplyr_1.1.4
##  [5] tidySingleCellExperiment_1.20.1 ttservice_0.5.3
##  [7] SpatialExperiment_1.20.0        SingleCellExperiment_1.32.0
##  [9] SummarizedExperiment_1.40.0     Biobase_2.70.0
## [11] GenomicRanges_1.62.0            Seqinfo_1.0.0
## [13] IRanges_2.44.0                  S4Vectors_0.48.0
## [15] BiocGenerics_0.56.0             generics_0.1.4
## [17] MatrixGenerics_1.22.0           matrixStats_1.5.0
## [19] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gridExtra_2.3             rlang_1.1.6
##  [3] magrittr_2.0.4            otel_0.2.0
##  [5] compiler_4.5.2            DelayedMatrixStats_1.32.0
##  [7] vctrs_0.6.5               stringr_1.6.0
##  [9] crayon_1.5.3              pkgconfig_2.0.3
## [11] fastmap_1.2.0             magick_2.9.0
## [13] XVector_0.50.0            ellipsis_0.3.2
## [15] labeling_0.4.3            scuttle_1.20.0
## [17] utf8_1.2.6                promises_1.5.0
## [19] rmarkdown_2.30            tinytex_0.58
## [21] purrr_1.2.0               xfun_0.54
## [23] cachem_1.1.0              beachmat_2.26.0
## [25] jsonlite_2.0.0            later_1.4.4
## [27] rhdf5filters_1.22.0       DelayedArray_0.36.0
## [29] Rhdf5lib_1.32.0           BiocParallel_1.44.0
## [31] parallel_4.5.2            R6_2.6.1
## [33] bslib_0.9.0               stringi_1.8.7
## [35] RColorBrewer_1.1-3        limma_3.66.0
## [37] jquerylib_0.1.4           Rcpp_1.1.0
## [39] bookdown_0.45             knitr_1.50
## [41] R.utils_2.13.0            httpuv_1.6.16
## [43] Matrix_1.7-4              tidyselect_1.2.1
## [45] dichromat_2.0-0.1         abind_1.4-8
## [47] yaml_2.3.11               viridis_0.6.5
## [49] codetools_0.2-20          lattice_0.22-7
## [51] tibble_3.3.0              shiny_1.11.1
## [53] withr_3.0.2               S7_0.2.1
## [55] evaluate_1.0.5            pillar_1.11.1
## [57] BiocManager_1.30.27       plotly_4.11.0
## [59] sparseMatrixStats_1.22.0  scales_1.4.0
## [61] xtable_1.8-4              glue_1.8.0
## [63] lazyeval_0.2.2            tools_4.5.2
## [65] data.table_1.17.8         locfit_1.5-9.12
## [67] rhdf5_2.54.0              grid_4.5.2
## [69] edgeR_4.8.0               DropletUtils_1.30.0
## [71] HDF5Array_1.38.0          cli_3.6.5
## [73] tidygate_1.0.14           fansi_1.0.7
## [75] S4Arrays_1.10.1           viridisLite_0.4.2
## [77] gtable_0.3.6              R.methodsS3_1.8.2
## [79] sass_0.4.10               digest_0.6.39
## [81] dqrng_0.4.1               SparseArray_1.10.4
## [83] rjson_0.2.23              htmlwidgets_1.6.4
## [85] farver_2.1.2              htmltools_0.5.8.1
## [87] R.oo_1.27.1               lifecycle_1.0.4
## [89] h5mread_1.2.1             httr_1.4.7
## [91] statmod_1.5.1             mime_0.13
```