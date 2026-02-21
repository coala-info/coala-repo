# Detecting differentially abundant subpopulations in mass cytometry data

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### 29 October 2025

#### Package

cydar 1.34.0

# Contents

* [1 Introduction](#introduction)
* [2 Setting up the data](#setting-up-the-data)
  + [2.1 Mocking up a data set](#mocking-up-a-data-set)
  + [2.2 Pre-processing of intensities](#pre-processing-of-intensities)
    - [2.2.1 Pooling cells together](#pooling-cells-together)
    - [2.2.2 Estimating transformation parameters](#estimating-transformation-parameters)
    - [2.2.3 Gating out uninteresting cells](#gating-out-uninteresting-cells)
    - [2.2.4 Applying functions to the original data](#applying-functions-to-the-original-data)
  + [2.3 Normalizing intensities across batches](#normalizing-intensities-across-batches)
* [3 Counting cells into hyperspheres](#counting-cells-into-hyperspheres)
* [4 Testing for significant differences in abundance](#testing-for-significant-differences-in-abundance)
* [5 Controlling the spatial FDR](#controlling-the-spatial-fdr)
* [6 Visualizing and interpreting the results](#visualizing-and-interpreting-the-results)
  + [6.1 With static plots](#with-static-plots)
  + [6.2 Using a Shiny app](#using-a-shiny-app)
* [7 Additional notes](#additional-notes)
* [8 Session information](#session-information)

# 1 Introduction

Mass cytometry is a technique that allows simultaneous profiling of many (> 30) protein markers on each of millions of cells.
This is frequently used to characterize cell subpopulations based on unique combinations of markers.
One way to analyze this data is to identify subpopulations that change in abundance between conditions, e.g., with or without drug treatment, before and after stimulation.
This vignette will describe the steps necessary to perform this “differential abundance” (DA) analysis.

# 2 Setting up the data

## 2.1 Mocking up a data set

The analysis starts from a set of Flow Cytometry Standard (FCS) files containing intensities for each cell.
For the purposes of this vignette, we will simulate some data to demonstrate the methods below.
This experiment will assay 30 markers, and contain 3 replicate samples in each of 2 biological conditions.
We add two small differentially abundant subpopulations to ensure that we get something to look at later.

```
ncells <- 20000
nda <- 200
nmarkers <- 31
down.pos <- 1.8
up.pos <- 1.2
conditions <- rep(c("A", "B"), each=3)
combined <- rbind(matrix(rnorm(ncells*nmarkers, 1.5, 0.6), ncol=nmarkers),
                  matrix(rnorm(nda*nmarkers, down.pos, 0.3), ncol=nmarkers),
                  matrix(rnorm(nda*nmarkers, up.pos, 0.3), ncol=nmarkers))
combined[,31] <- rnorm(nrow(combined), 1, 0.5) # last marker is a QC marker.
combined <- 10^combined # raw intensity values
sample.id <- c(sample(length(conditions), ncells, replace=TRUE),
               sample(which(conditions=="A"), nda, replace=TRUE),
               sample(which(conditions=="B"), nda, replace=TRUE))
colnames(combined) <- paste0("Marker", seq_len(nmarkers))
```

We use this to construct a `ncdfFlowSet` for our downstream analysis.

```
library(ncdfFlow)
collected.exprs <- list()
for (i in seq_along(conditions)) {
    stuff <- list(combined[sample.id==i,,drop=FALSE])
    names(stuff) <- paste0("Sample", i)
    collected.exprs[[i]] <- poolCells(stuff)
}
names(collected.exprs) <- paste0("Sample", seq_along(conditions))
collected.exprs <- ncdfFlowSet(as(collected.exprs, "flowSet"))
```

In practice, we can use the `read.ncdfFlowSet` function to load intensities from FCS files into the R session.
The `ncdfFlowSet` object can replace all instances of `collected.exprs` in the downstream steps.

## 2.2 Pre-processing of intensities

### 2.2.1 Pooling cells together

The intensities need to be transformed and gated prior to further analysis.
We first pool all cells together into a single `flowFrame`, which will be used for construction of the transformation and gating functions for all samples.
This avoids spurious differences from using sample-specific functions.

```
pool.ff <- poolCells(collected.exprs)
```

### 2.2.2 Estimating transformation parameters

We use the `estimateLogicle` method from the *[flowCore](https://bioconductor.org/packages/3.22/flowCore)* package to obtain a transformation function, and apply it to `pool.ff`.
This performs a biexponential transformation with parameters estimated for optimal display.

```
library(flowCore)
trans <- estimateLogicle(pool.ff, colnames(pool.ff))
proc.ff <- transform(pool.ff, trans)
```

### 2.2.3 Gating out uninteresting cells

The next step is to construct gates to remove uninteresting cells.
There are several common gates that are used in mass cytometry data analysis, typically used in the following order:

* Gating out calibration beads (high in Ce140) used to correct for intensity shifts in the mass spectrometer.
* Gating on moderate intensities for the DNA markers, to remove debris and doublets.
  This can be done using the `dnaGate` function.
* Gating on a dead/alive marker, to remove dead cells.
  Whether high or low values should be removed depends on the marker (e.g., high values to be removed for cisplatin).
* Gating out low values for selected markers, e.g., CD45 when studying leukocytes, CD3 when studying T cells.

To demonstrate, we will construct a gate to remove low values for the last marker, using the `outlierGate` function.
The constructed gate is then applied to the `flowFrame`, only retaining cells falling within the gated region.

```
gate.31 <- outlierGate(proc.ff, "Marker31", type="upper")
gate.31
```

```
## Rectangular gate 'Marker31_outlierGate' with dimensions:
##   Marker31: (-Inf,4.00691483197923)
```

```
filter.31 <- filter(proc.ff, gate.31)
summary(filter.31@subSet)
```

```
##    Mode   FALSE    TRUE
## logical      35   20011
```

We apply the gate before proceeding to the next marker to be gated.

```
proc.ff <- Subset(proc.ff, gate.31)
```

### 2.2.4 Applying functions to the original data

Applying the transformation functions to the original data is simple.

```
processed.exprs <- transform(collected.exprs, trans)
```

Applying the gates is similarly easy.
Use methods the *[flowViz](https://bioconductor.org/packages/3.22/flowViz)* package to see how gating diagnostics can be visualized.

```
processed.exprs <- Subset(processed.exprs, gate.31)
```

Markers used for gating are generally ignored in the rest of the analysis.
For example, as long as all cells contain DNA, we are generally not interested in differences in the amount of DNA.
This is achieved by discarding those markers (in this case, marker 31).

```
processed.exprs <- processed.exprs[,1:30]
```

## 2.3 Normalizing intensities across batches

By default, we do not perform any normalization of intensities between samples.
This is because we assume that barcoding was used with multiplexed staining and mass cytometry.
Thus, technical biases that might affect intensity should be the same in all samples, which means that they cancel out when comparing between samples.

In data sets containing multiple batches of separately barcoded samples, we provide the `normalizeBatch` function to adjust the intensities.
This uses range-based normalization to equalize the dynamic range between batches for each marker.
Alternatively, it can use warping functions to eliminate non-linear distortions due to batch effects.

The problem of normalization is much harder to solve in data sets with no barcoding at all.
In such cases, the best solution is to expand the sizes of the hyperspheres to “smooth over” any batch effects.
See the `expandRadius` function for more details.

# 3 Counting cells into hyperspheres

We quantify abundance by assigning cells to hyperspheres in the high-dimensional marker space, and counting the number of cells from each sample in each hypersphere.
To do this, we first convert the intensity data into a format that is more amenable for counting.
The `prepareCellData` function works with either a list of matrices or directly with a `ncdfFlowSet` object:

```
cd <- prepareCellData(processed.exprs)
```

We then assign cells to hyperspheres using the `countCells` function.
Each hypersphere is centred at a cell to restrict ourselves to non-empty hyperspheres, and has radius equal to 0.5 times the square root of the number of markers.
The square root function adjusts for increased sparsity of the data at higher dimensions, while the 0.5 scaling factor allows cells with 10-fold differences in marker intensity (due to biological variability or technical noise) to be counted into the same hypersphere.
Also see the `neighborDistances` function for guidance on choosing a value of `tol`.

```
cd <- countCells(cd, tol=0.5)
```

The output is another `CyData` object with extra information added to various fields.
In particular, the reported count matrix contains the set of counts for each hypersphere (row) from each sample (column).

```
head(assay(cd))
```

```
##      Sample1 Sample2 Sample3 Sample4 Sample5 Sample6
## [1,]       3       2       2       3       1       3
## [2,]       5       3       3       1       3       4
## [3,]      18      12      10      20      20      17
## [4,]       8      10      10       8      10      11
## [5,]       4       3       2       2       6       4
## [6,]      15      11      11       9      11      15
```

Also reported are the “positions” of the hyperspheres, defined for each marker as the median intensity for all cells assigned to each hypersphere.
This will be required later for interpretation, as the marker intensities are required for defining the function of each subpopulation.
Shown below is the position of the first hypersphere, represented by its set of median intensities across all markers.

```
head(intensities(cd))
```

```
##       Marker1  Marker2  Marker3  Marker4  Marker5  Marker6  Marker7  Marker8
## [1,] 1.935216 1.621694 2.325808 2.359776 1.860679 2.554833 1.584387 2.177329
## [2,] 2.048235 1.888618 1.801245 2.304992 2.323944 2.983492 1.893258 1.577251
## [3,] 1.880033 1.749370 2.040192 1.913833 1.960235 2.450760 1.815175 2.014227
## [4,] 2.152604 2.091855 2.130278 1.884290 1.734792 2.385762 2.212991 1.557423
## [5,] 1.987925 2.040171 1.689086 1.821558 2.029702 2.230201 1.812877 1.577025
## [6,] 1.681509 1.644520 2.120424 2.067032 2.373343 2.615216 2.020481 1.879629
##       Marker9 Marker10 Marker11 Marker12 Marker13 Marker14 Marker15 Marker16
## [1,] 1.965201 2.504554 1.987023 1.615083 2.277024 1.864424 1.985269 2.622448
## [2,] 1.895828 2.250659 2.278522 2.136907 2.450920 1.775294 2.475739 2.354286
## [3,] 2.186744 2.194509 1.794433 1.925331 1.876094 1.215048 2.175568 2.116105
## [4,] 1.957281 1.982099 1.666649 1.837341 1.913230 1.729033 2.057884 2.502645
## [5,] 1.647798 2.250659 2.164262 1.599050 2.059281 1.445524 2.209033 1.758812
## [6,] 2.221887 2.198820 1.990962 2.235905 2.076642 1.432514 2.310020 2.131121
##      Marker17 Marker18 Marker19 Marker20 Marker21 Marker22 Marker23 Marker24
## [1,] 1.994012 2.126200 2.070139 1.759891 2.383390 2.101001 2.450541 2.402508
## [2,] 2.551345 2.007046 2.238893 1.827287 1.834920 2.797972 2.241896 2.631434
## [3,] 2.053636 2.092680 2.331233 1.543082 2.121804 2.414006 2.088759 2.320296
## [4,] 2.200870 2.114198 2.416651 1.626348 1.834196 2.133127 1.976339 2.652789
## [5,] 2.223537 1.932704 2.001924 1.520426 2.103868 2.449764 1.682056 2.088853
## [6,] 2.136387 2.128450 2.227746 1.418245 2.542672 2.656247 1.748710 2.362842
##      Marker25 Marker26 Marker27 Marker28 Marker29 Marker30
## [1,] 2.224650 2.051278 2.552788 2.304247 1.851389 1.806861
## [2,] 1.935589 2.161518 2.026925 2.195922 2.235846 1.539614
## [3,] 2.304592 1.281929 2.209488 2.418433 2.035156 1.913856
## [4,] 2.322681 1.742538 2.273032 2.212816 2.100904 2.000834
## [5,] 2.191409 1.391174 1.758729 1.834596 1.584468 2.123280
## [6,] 2.005628 2.379539 2.224184 2.394664 1.876070 2.085412
```

There is some light filtering in `countCells` to improve memory efficiency, which can be adjusted with the `filter` argument.

# 4 Testing for significant differences in abundance

We can use a number of methods to test the count data for differential abundance.
Here, we will use the quasi-likelihood (QL) method from the *[edgeR](https://bioconductor.org/packages/3.22/edgeR)* package.
This allows us to model discrete count data with overdispersion due to biological variability.

```
library(edgeR)
y <- DGEList(assay(cd), lib.size=cd$totals)
```

First, we do some filtering to remove low-abundance hyperspheres with average counts below 5.
These are mostly uninteresting as they do not provide enough evidence to reject the null hypothesis.
Removing them also reduces computational work and the severity of the multiple testing correction.
Lower values can also be used, but we do not recommend going below 1.

```
keep <- aveLogCPM(y) >= aveLogCPM(5, mean(cd$totals))
cd <- cd[keep,]
y <- y[keep,]
```

We then apply the QL framework to estimate the dispersions, fit a generalized linear model and test for significant differences between conditions.
We refer interested readers to the *[edgeR](https://bioconductor.org/packages/3.22/edgeR)* user’s guide for more details.

```
design <- model.matrix(~factor(conditions))
y <- estimateDisp(y, design)
fit <- glmQLFit(y, design, robust=TRUE)
res <- glmQLFTest(fit, coef=2)
```

Note that normalization by total cell count per sample is implicitly performed by setting `lib.size=out$totals`.
We do not recommend using `calcNormFactors` in this context, as its assumptions may not be applicable to mass cytometry data.

# 5 Controlling the spatial FDR

To correct for multiple testing, we aim to control the spatial false discovery rate (FDR).
This refers to the FDR across areas of the high-dimensional space.
We do this using the `spatialFDR` function, given the p-values and positions of all tested hyperspheres.

```
qvals <- spatialFDR(intensities(cd), res$table$PValue)
```

Hyperspheres with significant differences in abundance are defined as those detected at a spatial FDR of, say, 5%.

```
is.sig <- qvals <= 0.05
summary(is.sig)
```

```
##    Mode   FALSE    TRUE
## logical     112      84
```

This approach is a bit more sophisticated than simply applying the BH method to the hypersphere p-values.
Such a simple approach would fail to account for the different densities of hyperspheres in different parts of the high-dimensional space.

# 6 Visualizing and interpreting the results

## 6.1 With static plots

To interpret the DA hyperspheres, we use dimensionality reduction to visualize them in a convenient two-dimensional representation.
This is done here with PCA, though for more complex data sets, we suggest using something like *[Rtsne](https://CRAN.R-project.org/package%3DRtsne)*.

```
sig.coords <- intensities(cd)[is.sig,]
sig.res <- res$table[is.sig,]
coords <- prcomp(sig.coords)
```

Each DA hypersphere is represented as a point on the plot below, coloured according to its log-fold change between conditions.
We can see that we’ve recovered the two DA subpopulations that we put in at the start.
One subpopulation increases in abundance (red) while the other decreases (blue) in the second condition relative to the first.

```
plotSphereLogFC(coords$x[,1], coords$x[,2], sig.res$logFC)
```

![](data:image/png;base64...)

This plot should be interpreted by examining the marker intensities, in order to determine what each area of the plot represents.
We suggest using the `plotSphereIntensity` function to make a series of plots for all markers, as shown below.
Colours represent to the median marker intensities of each hypersphere, mapped onto the *[viridis](https://CRAN.R-project.org/package%3Dviridis)* colour scale.

```
par(mfrow=c(6,5), mar=c(2.1, 1.1, 3.1, 1.1))
limits <- intensityRanges(cd, p=0.05)
all.markers <- markernames(cd)
for (i in order(all.markers)) {
    plotSphereIntensity(coords$x[,1], coords$x[,2], sig.coords[,i],
        irange=limits[,i], main=all.markers[i])
}
```

![](data:image/png;base64...)

We use the `intensityRanges` function to define the bounds of the colour scale.
This caps the minimum and maximum intensities at the 5th and 95th percentiles, respectively, to avoid colours being skewed by outliers.

Note that both of these functions return a vector of colours, named with the corresponding numeric value of the log-fold change or intensity.
This can be used to construct a colour bar – see `?plotSphereLogFC` for more details.

## 6.2 Using a Shiny app

An alternative approach to interpretation is to examine each hypersphere separately, and to determine the cell type corresponding to the hypersphere’s intensities.
First, we prune done the number of hyperspheres to be examined in this manner.
This is done by identifying “non-redundant” hyperspheres, i.e., hyperspheres that do not overlap hyperspheres with lower p-values.

```
nonred <- findFirstSphere(intensities(cd), res$table$PValue)
summary(nonred)
```

```
##    Mode   FALSE    TRUE
## logical     194       2
```

We pass these hyperspheres to the `interpretSpheres`, which creates a Shiny app where the intensities are displayed.
The idea is to allow users to inspect each hypersphere, annotate it and then save the labels to R once annotation is complete.
See the documentation for more details.

```
all.coords <- prcomp(intensities(cd))
app <- interpretSpheres(cd, select=nonred, metrics=res$table, run=FALSE,
                        red.coords=all.coords$x[,1:2], red.highlight=is.sig)
# Set run=TRUE if you want the app to run automatically.
```

# 7 Additional notes

Users wanting to identify specific subpopulations may consider using the `selectorPlot` function from *[scran](https://bioconductor.org/packages/3.22/scran)*.
This provides an interactive framework by which hyperspheres can be selected and saved to a R session for further examination.
The best markers that distinguish cells in one subpopulation from all others can also be identified using `pickBestMarkers`.

# 8 Session information

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] edgeR_4.8.0                 limma_3.66.0
##  [3] ncdfFlow_2.56.0             BH_1.87.0-1
##  [5] flowCore_2.22.0             BiocParallel_1.44.0
##  [7] cydar_1.34.0                SingleCellExperiment_1.32.0
##  [9] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [11] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [13] IRanges_2.44.0              S4Vectors_0.48.0
## [15] BiocGenerics_0.56.0         generics_0.1.4
## [17] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [19] knitr_1.50                  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6        xfun_0.53           bslib_0.9.0
##  [4] ggplot2_4.0.0       lattice_0.22-7      vctrs_0.6.5
##  [7] tools_4.5.1         parallel_4.5.1      tibble_3.3.0
## [10] pkgconfig_2.0.3     BiocNeighbors_2.4.0 Matrix_1.7-4
## [13] RColorBrewer_1.1-3  S7_0.2.0            lifecycle_1.0.4
## [16] compiler_4.5.1      farver_2.1.2        tinytex_0.57
## [19] statmod_1.5.1       codetools_0.2-20    httpuv_1.6.16
## [22] htmltools_0.5.8.1   sass_0.4.10         yaml_2.3.10
## [25] later_1.4.4         pillar_1.11.1       jquerylib_0.1.4
## [28] DelayedArray_0.36.0 cachem_1.1.0        magick_2.9.0
## [31] viridis_0.6.5       abind_1.4-8         mime_0.13
## [34] RProtoBufLib_2.22.0 locfit_1.5-9.12     tidyselect_1.2.1
## [37] digest_0.6.37       dplyr_1.1.4         bookdown_0.45
## [40] splines_4.5.1       fastmap_1.2.0       grid_4.5.1
## [43] cli_3.6.5           SparseArray_1.10.0  magrittr_2.0.4
## [46] S4Arrays_1.10.0     dichromat_2.0-0.1   scales_1.4.0
## [49] promises_1.4.0      rmarkdown_2.30      XVector_0.50.0
## [52] otel_0.2.0          gridExtra_2.3       cytolib_2.22.0
## [55] memoise_2.0.1       shiny_1.11.1        evaluate_1.0.5
## [58] viridisLite_0.4.2   rlang_1.1.6         Rcpp_1.1.0
## [61] xtable_1.8-4        glue_1.8.0          BiocManager_1.30.26
## [64] jsonlite_2.0.0      R6_2.6.1
```