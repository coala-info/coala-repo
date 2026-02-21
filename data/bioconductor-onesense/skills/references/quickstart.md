# Quickstart guide

#### *Tan Yong kee*

#### *2019-01-04*

# Installing and Loading the Package

---

To install oneSENSE package, start R and run the following code:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
install.packages("BiocManager")
BiocManager::install("oneSENSE")
```

Load the package with the following code

```
library(oneSENSE)
```

Read the package description to find out more about oneSENSE GUI

```
? "onesense_GUI()"
```

```
## No documentation for 'onesense_GUI()' in specified packages and libraries:
## you could try '??onesense_GUI()'
```

# Using the oneSENSE package

---

## Rational of One-SENSE

One-SENSE measures cellular parameters assinged to manually predefined
catergories, and a one-dimensional map is constructed for each catergory
using t-SNE. Each dimension is informative and can be annotated through
the use of heatplots aligned in parallel to each axis, allowing for
simultaneous visualization of two catergories across a two-dimensional plot.
The cellular occupancy of the resulting plots alllows for direct assessment
of the relationships between the categories.

Read more about One-SENSE: [here](https://www.ncbi.nlm.nih.gov/pubmed/26667171)

## Run oneSENSE using the GUI

The easiest way to access oneSENSE is via the Graphics User Interface(GUI)
provided in the package. After loading the package, simply set the directory
as instructed in the note above and run the following code:

```
onesense_GUI()
```

The interface will appear like below, you can click the information button
**!** to check the explanation for each entry and customize your own analysis.

**1. Choose the directory where the FCS files are located.**

![Selecting FCS directory](data:image/png;base64...)

Selecting FCS directory

**2. Display the markers you want to select**

![Display Markers](data:image/png;base64...)

Display Markers

**3. Select the first, second and/or third(optional) category of markers
you want to group together** ![Select Markers by Catergory](data:image/png;base64...)

**4. Input the number you want to subsample from each FCS file under ceil.**

![Ceiling and Bins](data:image/png;base64...)

Ceiling and Bins

**5. Input the number of bins you want for the cells to be sorted into**

**6. Press submit and it will run to produce median heatplots**

**7. If you wish to do a frequency heatmap, press select coordinates,
and after selecting coordinates, press generate CSV.**

![Coordinate Selection](data:image/png;base64...)

Coordinate Selection

**8. Press submit frequency heatplot to generate a different set of heatplot** ![Frequency Heatplot Submission](data:image/png;base64...)

Depending on the size of your data, it will take some time to run
the analysis. Once done, the oneSENSE visualisations will be displayed.

### Median Heatplot example

![Median Heatplot](data:image/png;base64...)

Median Heatplot

### Frequency Heatplot example

![Frequency Heatplot](data:image/png;base64...)

Frequency Heatplot

# Session Information

```
sessionInfo()
```

```
## R version 3.5.2 (2018-12-20)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 16.04.5 LTS
##
## Matrix products: default
## BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] oneSENSE_1.4.1       scatterplot3d_0.3-41 shinyFiles_0.7.2
## [4] shiny_1.2.0          webshot_0.5.1
##
## loaded via a namespace (and not attached):
##  [1] Rcpp_1.0.0          mvtnorm_1.0-8       lattice_0.20-38
##  [4] tidyr_0.8.2         corpcor_1.6.9       gtools_3.8.1
##  [7] assertthat_0.2.0    digest_0.6.18       mime_0.6
## [10] R6_2.3.0            plyr_1.8.4          stats4_3.5.2
## [13] pcaPP_1.9-73        evaluate_0.12       httr_1.4.0
## [16] ggplot2_3.1.0       pillar_1.3.1        gplots_3.0.1
## [19] rlang_0.3.0.1       lazyeval_0.2.1      data.table_1.11.8
## [22] gdata_2.18.0        rmarkdown_1.11      Rtsne_0.15
## [25] stringr_1.3.1       htmlwidgets_1.3     munsell_0.5.0
## [28] compiler_3.5.2      httpuv_1.4.5.1      xfun_0.4
## [31] pkgconfig_2.0.2     BiocGenerics_0.28.0 htmltools_0.3.6
## [34] tidyselect_0.2.5    tibble_2.0.0        matrixStats_0.54.0
## [37] viridisLite_0.3.0   rrcov_1.4-7         crayon_1.3.4
## [40] dplyr_0.7.8         later_0.7.5         MASS_7.3-51.1
## [43] bitops_1.0-6        grid_3.5.2          jsonlite_1.6
## [46] xtable_1.8-3        gtable_0.2.0        magrittr_1.5
## [49] scales_1.0.0        graph_1.60.0        KernSmooth_2.23-15
## [52] stringi_1.2.4       fs_1.2.6            promises_1.0.1
## [55] bindrcpp_0.2.2      robustbase_0.93-3   flowCore_1.48.1
## [58] tools_3.5.2         Biobase_2.42.0      glue_1.3.0
## [61] purrr_0.2.5         DEoptimR_1.0-8      parallel_3.5.2
## [64] yaml_2.2.0          colorspace_1.3-2    cluster_2.0.7-1
## [67] caTools_1.17.1.1    plotly_4.8.0        knitr_1.21
## [70] bindr_0.1.1
```