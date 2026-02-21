# plotGrouper

### 2025-10-30

![logo](data:image/png;base64...)

# Description

A tool for generating figure-ready graphs from file. It borrows heavily from packages developed
by others, including ggplot2 and dplyr from the tidyverse and batch statistical
calculations from ggpubr.

Plots can be made using combinations of geoms including bar, violin, box,
crossbar, density, point, line, and errorbar.

![](data:image/png;base64...)

![](data:image/png;base64...)

# Prerequisites

1. If you do not already have R installed, or your version is out of date,
   download the latest version [Here](https://cran.r-project.org).

* Optionally, install the latest version of
  [RStudio Desktop](https://www.rstudio.com/products/rstudio/#Desktop).

2. Download the package from Bioconductor.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
  BiocManager::install("plotGrouper")
```

* Alternatively, install the development version of the package from Github
  using `BbiocManager`:

```
BiocManager::install("jdgagnon/plotGrouper")
```

* Or using `devtools`:

```
devtools::install_github("jdgagnon/plotGrouper")
```

# Usage

Load the package into the R session.

`library(plotGrouper)`

To initialize the shiny app, paste the following code in your R console
and run it.

`plotGrouper()`

Once the web app opens, you can access the `iris` dataset by clicking the iris
button to learn how to use the app. After the `iris` data loads, the selection
windows will be automatically populated and a graph should be displayed.

| Unique identifier | Comparisons | Variables |
| --- | --- | --- |
| ***Sample*** | ***Species*** | ***Sepal.Length*** |
| setosa\_1 | setosa | 5.1 |
| setosa\_2 | setosa | 4.9 |
| versicolor\_1 | versicolor | 7 |
| versicolor\_2 | versicolor | 6.4 |
| virginica\_1 | virginica | 6.3 |
| virginica\_2 | virginica | 5.8 |
| etc… | etc… | etc… |

These columns can be titled anything you want but values in the columns are
important.

* The `Unique identifier` column should contain only unique values that
  identify each individual sample (e.g., `Sample` within `iris` `Raw Data`).
* The `Comparisons` column should contain replicated values that identify each
  individual as belonging to a group (e.g., `Species` within `iris` `Raw Data`).
* The `Variables` column(s) should created for each variable you wish
  to plot. The values in these columns must be numeric (e.g., `Sepal.Length`,
  `Sepal.Width`, `Petal.Length`, `Petal.Width` within `iris` `Raw Data`)

After importing a data file, a `Sheet` column will be created and populated
with the sheet name(s) from the file if it came from an excel spreadsheet
or the file name if it came from a csv or tsv file.

* The `Variables to plot` selection window is used to choose which variable(s)
  to plot (e.g., `Sepal.Width` from the `iris` data). If multiple are selected,
  they will be grouped according to the `Independent variable` selected.
* The `Comparisons` selection window is used to choose which column contains
  theinformation that identifies which condition each sample belongs to (e.g.,
  the `Species` column within the `iris` data).
* The `Independent variable` selection window is used to select how the plots
  should be grouped. If `variable` is selected (the default), the plots will be
  grouped by the values in `Variables to plot`.
* Use the `Shapes` selector to change the shape of the points for each
  comparison variable.
* Use the `Colors` selector to change the point colors for each
  comparison variable.
* Use the `Fills` selector to change the fill color for the other geoms being
  plotted for each comparison variable.

To prevent the `Shapes`, `Colors`, or `Fills` from reverting to their defaults,
click the `Lock` checkboxes.

Individual plots can be saved by clicking `Save` on the `Plot` tab or multiple
plots may be arranged on a single page by clicking `Add plot to report`.
Clicking this button will send the current plot to the `Report` tab and assign
it a number in the `Report plot #` dropdown menu. To revisit a plot stored in
the `Report` tab, select the plot you wish to restore and click
`Load plot from report`. Changes can be made to this plot and then updated in
the `Report` by clicking `Update plot in report`.

* The statistics calculated for the current plot being displayed in the `Plot`
  tab are stored in the `Statistics` tab. These can be saved by clicking the
  `Download` button on the `Statistics` tab.
* The `Plot Data` tab contains the reorganized subset of data being plotted.
* The `Raw Data` tab displays the dataframe that was created upon import of the
  file along with the automatically created `Sheet` column.

# Session info

Here is the output of `sessionInfo()` on the system on which this package was
developed:

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
## loaded via a namespace (and not attached):
##  [1] compiler_4.5.1    fastmap_1.2.0     cli_3.6.5         htmltools_0.5.8.1
##  [5] tools_4.5.1       knitr_1.50        digest_0.6.37     xfun_0.53
##  [9] mime_0.13         rlang_1.1.6       evaluate_1.0.5
```

# License

[GNU GPL-3.0-or-later](https://www.gnu.org/licenses/gpl.txt)