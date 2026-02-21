# clevRvis Vignette

#### 29 October 2025

# Contents

* [1 Introduction](#introduction)
  + [1.1 Requirements](#requirements)
  + [1.2 Installation](#installation)
  + [1.3 Running clevRvis](#running-clevrvis)
* [2 Examplary use of clevRvis](#examplary-use-of-clevrvis)
  + [2.1 createSeaObject()](#createseaobject)
    - [2.1.1 Usage](#usage)
    - [2.1.2 Details](#details)
    - [2.1.3 Examples](#examples)
  + [2.2 sharkPlot()](#sharkplot)
    - [2.2.1 Usage](#usage-1)
    - [2.2.2 Details](#details-1)
    - [2.2.3 Examples](#examples-1)
  + [2.3 extSharkPlot()](#extsharkplot)
    - [2.3.1 Usage](#usage-2)
    - [2.3.2 Details](#details-2)
    - [2.3.3 Examples](#examples-2)
  + [2.4 dolphinPlot()](#dolphinplot)
    - [2.4.1 Usage](#usage-3)
    - [2.4.2 Details](#details-3)
    - [2.4.3 Examples](#examples-3)
  + [2.5 combinedPlot()](#combinedplot)
    - [2.5.1 Usage](#usage-4)
    - [2.5.2 Details](#details-4)
    - [2.5.3 Examples](#examples-4)
  + [2.6 plaicePlot()](#plaiceplot)
    - [2.6.1 Usage](#usage-5)
    - [2.6.2 Details](#details-5)
    - [2.6.3 Examples](#examples-5)
  + [2.7 exploreTrees()](#exploretrees)
    - [2.7.1 Usage](#usage-6)
    - [2.7.2 Details](#details-6)
    - [2.7.3 Examples](#examples-6)
  + [2.8 clevRvisShiny()](#clevrvisshiny)
    - [2.8.1 Usage](#usage-7)
    - [2.8.2 Examples](#examples-7)
  + [2.9 Data](#data)
* [3 Session information](#session-information)

# 1 Introduction

Clonal evolution describes the development of a tumor over time, considering the principle of ‘survival of the fittest’ on a cellular level. The development of cellular heterogeneity is of special interest with respect to cancer as it can be associated with therapy response, prognosis and survival of a patient. For example, relapse may be caused by an aggressive subclone.

The study of clonal evolution is based on mutations detected in a tumor sample. Ideally, data on mutations being present or absent is available for more than one time point in the cause of a patient’s disease. In a first analysis step, mutations have to be clustered to define clones. Every clone is commonly characterized by the cancer cell fraction (CCF) for every time point. The clones can, subsequently, be arranged as phylogenetic trees to represent the tumor’s evolution. A final, but essential step in the analysis of clonal evolution, significantly contributing to interpretation of the results, is its visualization.

clevRvis provides an extensive set of visualization techniques for clonal evolution. Three types of plots are available: 1) shark plots (basic trees, showing the phylogeny and optionally the cancer cell fraction CCF); 2) dolphin plots (advanced visualization, showing the phylogeny and the development of CCFs over time); 3) plaice plots (novel visualization, showing the phylogeny, the development of CCFs and the development of remaining healthy alleles, influenced by bi-allelic events, over time). Moreover, the tool provides algorithms for fully automatic interpolation of time points and estimation of therapy effect to approximate a tumor’s development in the presence of few measured time points, as well as exploring alternative trees.

clevRvis provides all common features for visualization also available in established R-packages like ‘timescape’. These features have been revised from scratch and optimized (e.g. supporting branched independent evolution, supporting visualization of a single clone, extensive validity check of the input, switch between bottom- and centered-layout). Furthermore, a wide set of additional features is available (e.g. automatic phylogeny-aware color-coding, algorithms for time point interpolation and therapy effect estimation, graphical user interface).

## 1.1 Requirements

To run clevRvis, you need R (Version 4.1.0 or higher).

## 1.2 Installation

To install clevRvis, type the following commands in R:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("clevRvis")
```

## 1.3 Running clevRvis

After installation, the package can be loaded into R by typing

```
library(clevRvis)
```

```
##
## Attaching package: 'clevRvis'
```

```
## The following object is masked from 'package:base':
##
##     col
```

clevRvis is available as a shiny GUI. You can run the shiny version either by RStudio executing the function `clevRvisShiny()`. Additionally, all functions for classical use in R are available:

1. `createSeaObject()`: Create a seaObject
2. `sharkPlot()`: Generate a basic graph visualization of clonal evolution
3. `extSharkplot()`: Generate an extended graph visualization of clonal evolution
4. `dolphinPlot()`: Generate a detailed visualization of clonal evolution
5. `combinedPlot()`: Generate a combined basic graph and detailed visualization of clonal evolution
6. `plaicePlot()`: Generate an allele-aware visualization of clonal evolution
7. `exploreTrees()`: Generate alternative parental relations to explore alternative trees

# 2 Examplary use of clevRvis

## 2.1 createSeaObject()

clevRvis needs a seaObject for the visualization of clonal evolution by means of any available plot. When generating the seaObject extra time points may be interpolated and/or therapy effect estimated.

### 2.1.1 Usage

```
createSeaObject(fracTable,parents,timepoints,col=NULL,cloneLabels=NULL,
                originTimepoint=NULL,timepointInterpolation=TRUE,
                therapyEffect=NULL)
```

* `fracTable` A numeric matrix containing tumor fraction estimates for all clones at all time points.
* `parents` An integer vector specifying parental relationships between clones.
* `timepoints` A numeric vector specifying the time points for each column of the matrix.
* `col` (optional) A vector of colors to use when plotting each clone.
* `cloneLabels` (optional) A character vector of names to assign to each clone when plotting a legend.
* `originTimepoint` (optional) Time point when the first clone emerges (must be before the first measured time point).
* `timepointInterpolation` When set to true extra time points will be interpolated between measured time points and before the first measure timepoint to improve the visualization (default: TRUE).
* `therapyEffect` (optional) A single numeric value indicating the time point when to estimate the effect of therapy or a numeric vector containing two consecutive measured time points, therapy effect timepoint will be in the middle.

### 2.1.2 Details

The basis for all plotting functions included in clevRvis is a seaObject. It contains information on the CCFs for all clones, at all measured time points. Additionally, parental information on the clones is included.

Additional time points may be interpolated, therapy effect estimated when generating seaObjects.

Time point interpolation is generally recommended to improve visualization of clonal evolution. When having less time points than clones, or many new clones emerging in one single measured time point, the extra time point interpolation is strongly recommended to visualize the clonal evolution properly. If there is only one measured time point, time point interpolation is needed and the time point of origin must be manually specified, as there is no way of calculating it.

To visualize the effect of therapy on the clones’ CCFs in case of missing measured data, a fully automatic approach for therapy effect estimation is available. When creating the seaObject, a specific time point can be defined (between two measured time points) or two measured time points can be selected (new therapy effect time point will be in the middle) for the estimation of the therapy effect.

A seaObject with all relevant slots filled is returned.

#### 2.1.2.1 Time point interpolation

For an improved visualization of clonal evolution, enabling time point interpolation is recommended.

#### 2.1.2.2 Therapy effect estimation

When generating the seaObject, the effect of therapy can also be estimated. There’s two options to define the therapy effect time point:

* The therapyEffect is defined as a single numeric value in between measured time points -> the therapy effect will be estimated at the given time point
* The therapyEffect is defined as a vector containing two measured time points -> the therapy effect will be estimated at the midpoint between them

### 2.1.3 Examples

```
##Example data
timepoints <- c(0,50,100)
parents <- c(0,1,1,3,0,5,6)
fracTable <- matrix(c(20,10,0,0,0,0,0,
                    40,20,15,0,30,10,0,
                    50,25,15,10,40,20,15),
                    ncol = length(timepoints))
seaObject <- createSeaObject(fracTable, parents, timepoints,
                            timepointInterpolation = FALSE)
```

```
##seaObject with enabled time point estimation
seaObject_tp <- createSeaObject(fracTable, parents, timepoints,
                                timepointInterpolation = TRUE)
```

```
##seaObject with enabled time point estimation and therapy effect
##estimation between time point 50 and 100
seaObject_te <- createSeaObject(fracTable, parents, timepoints,
                            timepointInterpolation = TRUE,
                            therapyEffect = c(50,100))
```

```
##seaObject with manually defined colors
seaObject_col <- createSeaObject(fracTable, parents, timepoints,
                                timepointInterpolation = TRUE,
                                col = rainbow(7))
```

## 2.2 sharkPlot()

A shark plot shows the basic graph visualization of clonal evolution with nodes representing clones and edges indicating their evolutionary relations.

### 2.2.1 Usage

```
sharkPlot(seaObject, showLegend, main)
```

* `seaObject` A seaObject.
* `showLegend` A boolean indicating whether to show the legend or not (default: FALSE).
* `main` A string corresponding to the plot’’s main title.

### 2.2.2 Details

A shark plot is the basic approach for visualization: common trees, with nodes representing clones and edges indicating their evolutionary relation. Phylogeny can be directly deduced from these plots.

Shark plots also offer an extension to visualize the changes in CCF along time for each clone. CCFs of each clone (rows) at each time point (columns) are shown as points next to the basic shark plot (see `extSharkPlot`).

### 2.2.3 Examples

```
#Basic shark plot showing legend and title
sharkPlot(seaObject_tp, showLegend = TRUE, main = 'Example Shark plot')
```

![](data:image/png;base64...)

```
#Basic shark plot showing legend and title with manually defined color coding
sharkPlot(seaObject_col, showLegend = TRUE, main = 'Example Shark plot')
```

![](data:image/png;base64...)

## 2.3 extSharkPlot()

An extended shark plot shows the basic graph visualization of clonal evolution with nodes representing clones and edges indicating their evolutionary relations and additional visualization of CCFs.

### 2.3.1 Usage

```
extSharkPlot(seaObject, showLegend, main, timepoints, width, interactivePlot)
```

* `seaObject` A seaObject.
* `showLegend` A boolean indicating whether to show the legend or not (default: FALSE).
* `main` A string corresponding to the plot’s main title (default: NULL).
* `timepoints` By default, all time points available in the seaObject are visualized. Optionally, a selected set of available time points can be chosen.
* `width` An integer value indicating the width of the widget plot (default: 10).
* `interactivePlot` A boolean defining whether the plot should be interactive (default: TRUE; if using this function to export the extended shark plot, e.g. by png(), define interactivePlot = FALSE).

### 2.3.2 Details

An extended shark plots consists of two elements:

1. A basic shark plot: common trees, with nodes representing clones and edges indicating their evolutionary relation. Phylogeny can be directly deduced from these plots.
2. Additionally, CCFs of each clone (rows) at each time point (columns) are shown as points next to the basic shark plot. The size of each point correlates with the CCF at the corresponding clone and time point.

Both plots are linked in an interactive widget.

### 2.3.3 Examples

```
##extended shark plot, showing CCF as point size only for measured
###time points, legend and title
extSharkPlot(seaObject_tp, timepoints = timepoints, showLegend = TRUE,
            main = 'Example Extended Shark plot')
```

## 2.4 dolphinPlot()

Dolphin plots provide a detailed visualization of clonal evolution. Plots show the development of all clones over time (x axis) and their clonal prevalences (y axis).

### 2.4.1 Usage

```
dolphinPlot(seaObject, shape, borderCol, pos, vlines, vlineCol, vlab,
            vlabSize, separateIndependentClones, showLegend,
            markMeasuredTimepoints, main, mainPos, mainSize, xlab,
            ylab, pad.left, annotations, annotSize)
```

* `seaObject` A seaObject.
* `shape` The type of shape to construct the plot out of. The options are “spline” and “polygon” (default: “spline”").
* `borderCol` A color for the border line. If “NULL” then no border will be drawn (default: NULL).
* `pos` Plotting position of the clones. Options are “center” or “bottom” (default: “center”).
* `vlines` A vector of positions at which to draw vertical lines (default: NULL).
* `vlineCol` A color value for the vertical lines (default: “#6E6E66”).
* `vlab` A character vector containing labels for each of the vertical lines (default: NULL).
* `vlabSize` An integer value for the vertical labels size (default: 3).
* `separateIndependentClones` Boolean defining whether independently-arising clones (with parent 0) should be separated by blank space in the plot (default: FALSE).
* `showLegend` A boolean indicating whether to show a legend at the left side of the plot (default: FALSE).
* `markMeasuredTimepoints` A vector of x positions at which to draw triangles on the bottom of the plot (default: NULL).
* `main` A string corresponding to the plot’s main title (default: NULL).
* `mainPos` A string defining the title’s position. Options are ‘left’, ‘middle’ or ‘right’, always above the plot (default: “middle”).
* `mainSize` An integer value defining the size of the title (default: 5).
* `xlab` A string defining the label of the x axis (default: NULL).
* `ylab` A string defining the label of the y axis. Automatically, a vertical line showing 100% will be plotted (default: NULL).
* `pad.left` The amount of “ramp-up” to the left of the first time point. Given as a fraction of the total plot width (default: 0.005).
* `annotations` A data.frame with: columns “x” (x position), “y” (y position), “lab” (annotation text) and “col” (color of the text either black or white) (default: NULL).
* `annotSize` An integer value defining the size of the annotations (default: 3).

### 2.4.2 Details

Dolphin plots displays detailed information on clonal evolution, showing the development of all clones over time (x-axis) and their clonal prevalence (y-axis). Information on phylogeny, CCFs and time course characterizing a clonal evolution are jointly visualized in this single plot.

Several basic options for customizing dolphin plots are available, e.g. switching between spline and polygon shape, bottom or central visualization, annotations, separating independent clones, adding vertical lines and labels, changing border and vertical lines colors, etc.

Dolphin plots may be chosen to be plotted along with basic shark plots (see `combinedPlot()`).

### 2.4.3 Examples

```
##Dolphin plot, with vertical lines showing all time points, custom y axis
##label and triangles indicating the measured time points
dolphinPlot(seaObject_tp, showLegend = TRUE,
            vlines = timepoints(seaObject),
            vlab = timepoints(seaObject), vlabSize = 2,
            ylab = 'Cancer cell fractions (CCFs)',
            markMeasuredTimepoints = timepoints)
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the clevRvis package.
##   Please report the issue at <https://github.com/sandmanns/clevRvis/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

```
##Dolphin plot polygon shape
dolphinPlot(seaObject_tp, showLegend = TRUE, vlines = timepoints,
            vlab = timepoints, vlabSize = 2,
            ylab = 'Cancer cell fractions (CCFs)', shape = 'polygon')
```

![](data:image/png;base64...)

```
##Dolphin plot bottom layout and separated independent clones
dolphinPlot(seaObject_tp, showLegend = FALSE,  vlines = timepoints,
            vlab = timepoints, vlabSize = 2,
            ylab = 'Cancer cell fractions (CCFs)',
            separateIndependentClones = TRUE, pos = 'bottom')
```

![](data:image/png;base64...)

To add annotations to clones in the plot, a table must be created containing the following columns: \* `x` x position of the annotation text \* `y` y position of the annotation text \* `col` color of the text (options are ‘black’ or ‘white’) \* `lab` text of the annotation

```
##Dolphin plot with annotations
annotsTable <- data.frame(x = c(50,75), y = c(15,50),
                            col = c('black', 'white'),
                            lab = c('Annotation clone 5', 'Annotation clone 2'))
dolphinPlot(seaObject_tp, showLegend = TRUE, main = 'Example Dolphin Plot',
            vlines = timepoints, vlab = timepoints, vlabSize = 2,
            ylab = 'Cancer cell fraction', annotations = annotsTable,
            pos = 'bottom', separateIndependentClones = TRUE)
```

![](data:image/png;base64...)

```
##Dolphin plot with enabled therapy effect estimation
##vertical lines show all time points, customized y axis label,
##triangles indicate the measured time points
dolphinPlot(seaObject_te, showLegend = TRUE,
            vlines = slot(seaObject,"timepoints"),
            vlab = slot(seaObject,"timepoints"), vlabSize = 2,
            ylab = 'Cancer cell fractions (CCFs)',
            markMeasuredTimepoints = timepoints)
```

![](data:image/png;base64...)

## 2.5 combinedPlot()

Given a sea object containing layout information, a shark and dolphin plot can be plotted together - linked and interactive.

### 2.5.1 Usage

```
combinedPlot(seaObject_tp, shark, dolphin, shape, borderCol, vlines,
            vlineCol, vlab, vlabSize, pos, separateIndependentClones,
            showLegend, markMeasuredTimepoints, downloadWidget,
            mainDph, mainPosDph, mainSizeDph, mainShk, xlab, ylab,
            pad.left, annotations, width, height)
```

* `seaObject` A seaObject.
* `shark` A boolean defining whether or not to draw a shark plot (default: TRUE).
* `dolphin` A boolean defining whether or not to draw a dolphin plot (default: TRUE).
* `shape` The type of shape to construct the plot out of. The options are “spline” and “polygon” (default: “spline”").
* `borderCol` A color for the border line. If “NULL” then no border will be drawn (default: NULL).
* `pos` Plotting position of the clones. Options are “center”, “bottom” or “top” (default: “center”).
* `vlines` A vector of positions at which to draw vertical lines (default: NULL).
* `vlineCol` A color value for the vertical lines (default: “#6E6E66”).
* `vlab` A character vector containing labels for each of the vertical lines (default: NULL).
* `vlabSize` An integer value for the vertical labels size (default: 3).
* `separateIndependentClones` Boolean defining whether independently-arising clones (with parent 0) should be separated by blank space in the plot (default: FALSE).
* `showLegend` A boolean indicating whether to show a legend at the left side of the plot (default: FALSE).
* `markMeasuredTimepoints` A vector of x positions at which to draw triangles on the bottom of the plot (default: NULL).
* `downloadWidget` File to safe HTML to (default: NULL).
* `mainDph` A string corresponding to the dolphin plot’s main title (default: NULL).
* `mainPosDph` A string defining the dolphin plot’s title position. Options are ‘left’, ‘middle’ or ‘right’, always above the plot (default: “middle”).
* `mainSizeDph` An integer value defining the size of the dolphin plot’s title (default: 5).
* `mainShk` A string corresponding to the shark plot’s main title (default: NULL).
* `xlab` A string defining the label of the x axis (default: NULL).
* `ylab` A string defining the label of the y axis. Automatically, a vertical line showing 100% will be plotted (default: NULL).
* `pad.left` The amount of “ramp-up” to the left of the first time point. Given as a fraction of the total plot width (default: 0.005).
* `annotations` A data.frame with: columns “x” (x position), “y” (y position), “lab” (annotation text) and “col” (color of the text either black or white) (default: NULL).
* `width` An integer value indicating the with of the output widget (default: 12).
* `height` An integer value indicating the height of the output widget (default: 9).

### 2.5.2 Details

Dolphin plots may be chosen to be plotted along with basic shark plots (for details see `dolphinPlot()` and `sharkPlot()`. Both plots are internally connected. By hovering on one of the clones, it is automatically highlighted in both, shark and dolphin plot.

Important note: extended shark plots and dolphin plots can NOT be visualized together.

### 2.5.3 Examples

```
##Basic shark plot linked to dolphin plot
combinedPlot(seaObject_tp, showLegend = TRUE, vlines = timepoints,
            vlab = timepoints, vlabSize = 2, ylab = 'Cancer cell fraction',
            separateIndependentClones = TRUE)
```

## 2.6 plaicePlot()

Plaice plots provide an allele-aware visualization of clonal evolution. Plots show the development of all clones over time (x axis) and their clonal prevalences (y axis), and the ratio of remaining healthy alleles (lower plaice).

### 2.6.1 Usage

```
plaicePlot(seaObject, shape, borderCol, vlines, vlineCol, vlab, vlabSize,
            separateIndependentClones, clonesToFill, showLegend,
            markMeasuredTimepoints, main, mainPos, mainSize, xlab, ylab,
            pad.left, annotations, annotationsSize, interactivePlot)
```

* `seaObject` A seaObject.
* `shape` The type of shape to construct the plot out of. The options are “spline” and “polygon” (default: “spline”").
* `borderCol` A color for the border line. If “NULL” then no border will be drawn (default: “black”).
* `vlines` A vector of positions at which to draw vertical lines (default: NULL).
* `vlineCol` A color value for the vertical lines (default: “#6E6E66”).
* `vlab` A character vector containing labels for each of the vertical lines (default: NULL).
* `vlabSize` An integer value for the vertical labels size (default: 3).
* `separateIndependentClones` Boolean defining whether independently-arising clones (with parent 0) should be separated by blank space in the plot (default: FALSE).
* `clonesToFill` An integer vector with the index of the clone’s color to fill each clone. For example: clonesToFill <- c(0,0,0,2,0,0) clone 4 (and its children) will be filled with clone 2 color (default: NULL).
* `showLegend` A boolean indicating whether to show a legend at the left side of the plot (default: FALSE).
* `markMeasuredTimepoints` A vector of x positions at which to draw triangles on the bottom of the plot (default: NULL).
* `main` A string corresponding to the plot’s main title (default: NULL).
* `mainPos` A string defining the title’s position. Options are ‘left’, ‘middle’ or ‘right’, always above the plot (default: “middle”).
* `mainSize` An integer value defining the size of the title (default: 5).
* `xlab` A string defining the label of the x axis (default: NULL).
* `ylab` A boolean defining whether or not to show the default y axis labels (default: FALSE).
* `pad.left` The amount of “ramp-up” to the left of the first time point. Given as a fraction of the total plot width (default: 0.005).
* `annotations` A data.frame with: columns “x” (x position), “y” (y position), “lab” (annotation text) and “col” (color of the text either black or white) (default: NULL).
* `annotationsSize` An integer value defining the size of the annotations (default: 3).
* `interactivePlot` A boolean defining whether the plot should be interactive (default: TRUE; if using this function to export the plaice plot, e.g. by png(), define interactivePlot = FALSE).

### 2.6.2 Details

Plaice plots represent an option for visualizing clonal evolution on allelic- level. The upper half of the plot (=plaice) shows a common dolphin plot in bottom visualization. The lower plaice shows the percentage of healthy alleles. Clones that are characterized by bi-allelic events affecting one or more genes may be colored accordingly. Coloring of clones in the lower plaice is interpreted as follows:

* An uncolored clone indicates that at least one copy of a healthy allele is present for all genes.
* A colored clone indicates that a bi-allelic event took place. As a consequence, no healthy allele of the gene(s) affected by the bi-allelic event remains.
  + If clone 1 carries a point mutation in TP53 and clone 2 carries an additional del17p (affecting the remaining healthy allele), clone 2 in the lower plaice should be colored in the same hue as clone 1 in the upper plaice, which is originally characterized by mutation in TP53, indicating that the double-hit event affected TP53.
  + If clone 1 carries a deletion of 17p and clone 2 carries an additional point mutation in TP53 (affecting the remaining healthy allele), clone 2 in the lower plaice should be colored in the same hue as clone 2 in the upper plaice, which is originally charatcerized by mutation in TP53, indicating that the double-hit event affected TP53.
  + If clone 2 carries two point mutations in TP53 affecting different alleles, clone 2 in the lower plaice should be colored in the same hue as clone 2 in the upper plaice, indicating that the double-hit event affected TP53.
  + If clone 2 carries a variant affecting the X chromosome of a male subject, leading to a loss of the only available healthy allele, clone 2 in the lower plaice should be colored in the same hue as clone 2 in the upper plaice, indicating the hemizygous variant affecting a gene on the X chromosome.

### 2.6.3 Examples

```
#Plaice plot when all genes have at least one healthy copy
plaicePlot(seaObject_tp, showLegend = TRUE,  vlines = timepoints,
            vlab = timepoints, vlabSize = 4, ylab = TRUE,
            separateIndependentClones = TRUE)
```

```
#Plaice plot showing biallelic events + annotations
annotsTable <- data.frame(x = c(24,55), y = c(-40,-5),
                            col = c('black', 'white'),
                            lab = c('TP53', 'UBA1'))
plaicePlot(seaObject_tp, showLegend = TRUE,  vlines = timepoints,
            vlab = timepoints, vlabSize = 4, ylab = TRUE,
            separateIndependentClones = TRUE, clonesToFill = c(0,0,1,0,0,6,0),
            annotations = annotsTable)
```

```
##Plaice plot with enabled therapy effect estimation,
##all genes are assumed to have at least one healthy copy
plaicePlot(seaObject_te, showLegend = TRUE,  vlines = timepoints,
            vlab = timepoints, vlabSize = 4, ylab = TRUE,
            separateIndependentClones = TRUE)
```

## 2.7 exploreTrees()

Plaice plots provide an allele-aware visualization of clonal evolution. Plots show the development of all clones over time (x axis) and their clonal prevalences (y axis), and the ratio of remaining healthy alleles (lower plaice).

### 2.7.1 Usage

```
exploreTrees(fracTable,timepoints)
```

* `fracTable` A numeric matrix containing tumor fraction estimates for all clones at all time points.
* `timepoints` A numeric vector specifying the time points for each column of the matrix.

### 2.7.2 Details

To create a seaObject, the basis for all plotting functions in clevRvis, a fracTable, a timepoints vector and a parents vector are required. clevRvis provides an approach to determine all valid parental relations on the basis of the information provided in fracTable and the timepoints vector. Thereby, alternative trees can be explored.

To optimize run-time, the analysis is devided into 3 step procedure:

1. Possible parents are determined. If clone 1 has at any measured time point a lower CCF compared to clone 2, then clone 1 cannot be clone 2’s parent.
2. Possible branched dependent evolution is investigated. If clone 2 can only develope from clone 1, the difference in CCFs for clone 1 and clone 2 is calculated. Every remaining clone with a CCF larger than the difference cannot develop from clone 1.
3. All remaining, possible parental relations are determined. An extensive validity check is performed using clevRvis (validity check when creating a seaObject). A maximum of 20,000 parental relations is investigated.

A list of numeric vectors containing valid parental relations, apt to explore alternative trees.

### 2.7.3 Examples

```
##Alternative, valid parental relations are determined
timepoints <- c(0,30,75,150)
fracTable <- matrix(
            c( 100, 45, 00, 00,
                20, 00, 00, 00,
                30, 00, 20, 05,
                98, 00, 55, 40),
            ncol=length(timepoints))

trees <- exploreTrees(fracTable, timepoints)
trees
```

```
## $`0,1,1,1`
## [1] 0 1 1 1
##
## $`0,1,1,3`
## [1] 0 1 1 3
```

## 2.8 clevRvisShiny()

clevRvis provides an additional shiny GUI to perform all analyses interactively.

### 2.8.1 Usage

```
clevRvisShiny()
```

### 2.8.2 Examples

clevRvis supports two input file types - with and without information on parental relations.

#### 2.8.2.1 Input - without parental relations

A file containing clones in the first column and information on the clones’ cancer cell fractions (CCFs) for each time point in the subsequent columns may be uploaded. Subsequently, the parental relations are defined interactively in the shiny-app. Two exemplary input files, containing the CCFs for simulated clonal evolution, are available with the package.

Exemplary file Example1.xlsx is provided along with the package in ‘inst/extdata’. The file contains an easy, manually generated example of clonal evolution (4 clones, 2 time points). The suggested parental relations, that have to be defined manually for the analysis with clevRvis, are:

| Clone | Parent |
| --- | --- |
| clone A | normal cell |
| clone B | clone A |
| clone C | clone B |
| clone D | clone C |

A second exemplary file Example2.xlsx is also provided along with the package in ‘inst/extdata’. The file contains a more complex, manually generated example of clonal evolution (5 clones, 5 time points). For Example2.xlsx the suggested parental relations are:

| Clone | Parent |
| --- | --- |
| clone A | normal cell |
| clone B | clone A |
| clone C | clone B |
| clone D | clone C |
| clone E | clone B |

Alternatively, previously defined vector `timepoints` and matrix `fracTable` can be easily used to generate adequate input data for use of the clevRvis shiny-app.

```
##Data used in a previous example
timepoints <- c(0,50,100)
fracTable <- matrix(c(20,10,0,0,0,0,0,
                    40,20,15,0,30,10,0,
                    50,25,15,10,40,20,15),
                    ncol = length(timepoints))

##Define input for shiny-app
input<-data.frame(Clones=paste0("Clone ",LETTERS[1:nrow(fracTable)]),
                    as.data.frame(fracTable))
names(input)[2:ncol(input)]<-timepoints

##Export data.frame 'input', e.g. as csv-file
##write.table(input, "Example3.csv", sep = ",", row.names = FALSE,quote = FALSE)
```

Subsequently, Example3.csv can be used as input for the clevRvis shiny-app. Parental relations have to be defined interactively:

| Clone | Parent |
| --- | --- |
| clone A | normal cell |
| clone B | clone A |
| clone C | clone A |
| clone D | clone C |
| clone E | Normal cell |
| Clone F | Clone E |
| Clone G | Clone F |

#### 2.8.2.2 Input - with parental relations

A file containing clones in the first column, information on the clones’ CCFs for each time point in the subsequent columns and information on the parental relations in a column ‘parent’ may be uploaded. The position of the ‘parent’-column in the input file is not restricted. Two exemplary input files - Example1\_withParents.xlsx and Example2\_withParents.xlsx -, containing the CCFs for simulated clonal evolution and parental relations in an additional column, are available with the package in ‘inst/extdata’. The files correspond to files Example1.xlsx and Example2.xlsx, just containing the additional column ‘parent’.

Alternatively, previously defined vectors `timepoints` and `parents` and matrix `fracTable` can be easily used to generate adequate input data for use of the clevRvis shiny-app.

```
##Data used in a previous example
timepoints <- c(0,50,100)
parents <- c(0,1,1,3,0,5,6)
fracTable <- matrix(c(20,10,0,0,0,0,0,
                    40,20,15,0,30,10,0,
                    50,25,15,10,40,20,15),
                    ncol = length(timepoints))

##Define input for shiny-app
input<-data.frame(Clones=paste0("Clone ",LETTERS[1:nrow(fracTable)]),
                    as.data.frame(fracTable),parents=parents)
names(input)[2:(ncol(input)-1)]<-timepoints

##Export data.frame 'input', e.g. as csv-file
##write.table(input, "Example3_withParents.csv", sep = ",", row.names = FALSE,
##quote = FALSE)
```

Subsequently, Example3\_withParents.csv can be used as input for the clevRvis shiny-app.

#### 2.8.2.3 (opt.) Explore parental relations

Independent of whether a user uploads parental relations within an input file or not, clevRvis provides an option to explore parental relations. For a defined CCF table, all valid parental relations can be determined. The results are provided as a drop-down menu in the ‘Inputs’ panel (normal cells coded as 0). A user may choose any valid parental relations instead of the original one to perform all subsequent analyses.

#### 2.8.2.4 Subsequent analyses

Once an input file has been read in, further analysis options are available:

As second step, a seaObject has to be created, using the second panel on the left side of the clevRvis shiny-app - ‘seaObject options’. `Extra time points interpolation` and `Therapy Effect estimation` can be enabled. By executing `Submit`, a seaObject is created. The seaObject table is provided in the second output-tab ‘seaObject table’ on the right.

As a third step, customized plots can be generated, using the third panel on the left side of the clevRvis shiny-app - ‘Plots’. All plots are provided in the third output-tab ‘Plots’ on the right.

Optionally, as a final step, annotations can be added to the previously generated plots using the fourth panel on the left side of the clevRvis shiny-app - ‘Annotations’.

A detailed walk-through is provided in the ‘Tutorial’ panel within the clevRvis shiny-app.

## 2.9 Data

To generate appropriate input for the analysis with clevRvis, called variants have to be clustered (ideally also considering copy-number variants) and phylogenetic trees reconstructed to determine parental information. According to our experience, algorithms for automatic clustering and tree reconstruction, considering bulk DNA-seq data, do not always generate valid results (see Sandmann et al. 2022 <https://cgp.iiarjournals.org/content/19/2/194.long>). Currently, we suggest manual analysis for both analysis steps (compare e.g. Reutter, Sandmann et al. 2021 <https://www.nature.com/articles/s41375-020-0862-5> or Sandmann, Behrens et al. 2022 <https://www.frontiersin.org/articles/10.3389/fonc.2022.888114/full>).

# 3 Session information

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
## [1] knitr_1.50       clevRvis_1.10.0  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6            xfun_0.53               bslib_0.9.0
##  [4] ggplot2_4.0.0           htmlwidgets_1.6.4       ggrepel_0.9.6
##  [7] tzdb_0.5.0              vctrs_0.6.5             tools_4.5.1
## [10] generics_0.1.4          tibble_3.3.0            R.oo_1.27.1
## [13] pkgconfig_2.0.3         ggnewscale_0.5.2        RColorBrewer_1.1-3
## [16] S7_0.2.0                readxl_1.4.5            lifecycle_1.0.4
## [19] compiler_4.5.1          farver_2.1.2            tinytex_0.57
## [22] ggforce_0.5.0           graphlayouts_1.2.2      httpuv_1.6.16
## [25] fontquiver_0.2.1        fontLiberation_0.1.0    shinyWidgets_0.9.0
## [28] htmltools_0.5.8.1       sass_0.4.10             yaml_2.3.10
## [31] crayon_1.5.3            later_1.4.4             pillar_1.11.1
## [34] jquerylib_0.1.4         tidyr_1.3.1             R.utils_2.13.0
## [37] MASS_7.3-65             DT_0.34.0               cachem_1.1.0
## [40] magick_2.9.0            viridis_0.6.5           mime_0.13
## [43] fontBitstreamVera_0.1.1 tidyselect_1.2.1        digest_0.6.37
## [46] colourpicker_1.3.0      dplyr_1.1.4             purrr_1.1.0
## [49] bookdown_0.45           labeling_0.4.3          cowplot_1.2.0
## [52] polyclip_1.10-7         fastmap_1.2.0           grid_4.5.1
## [55] colorspace_2.1-2        cli_3.6.5               magrittr_2.0.4
## [58] patchwork_1.3.2         dichromat_2.0-0.1       ggraph_2.2.2
## [61] tidygraph_1.3.1         readr_2.1.5             withr_3.0.2
## [64] gdtools_0.4.4           scales_1.4.0            promises_1.4.0
## [67] rmarkdown_2.30          igraph_2.2.1            otel_0.2.0
## [70] gridExtra_2.3           cellranger_1.1.0        R.methodsS3_1.8.2
## [73] hms_1.1.4               memoise_2.0.1           shiny_1.11.1
## [76] evaluate_1.0.5          shinycssloaders_1.1.0   miniUI_0.1.2
## [79] viridisLite_0.4.2       rlang_1.1.6             ggiraph_0.9.2
## [82] Rcpp_1.1.0              xtable_1.8-4            glue_1.8.0
## [85] shinyhelper_0.3.2       tweenr_2.0.3            BiocManager_1.30.26
## [88] shinydashboard_0.7.3    jsonlite_2.0.0          R6_2.6.1
## [91] systemfonts_1.3.1
```