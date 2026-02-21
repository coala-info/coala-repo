# karyoploteR: plot customizable linear genomes displaying arbitrary data

Bernat Gel (bgel@igtp.cat)

#### 30 October 2025

#### Package

karyoploteR 1.36.0

# Contents

* [1 Introduction](#introduction)
* [2 Tutorial and Examples](#tutorial-and-examples)
* [3 Quick Start](#quick-start)
* [4 Creating a karyotype plot](#creating-a-karyotype-plot)
  + [4.1 Genomes and Chromosomes](#genomes-and-chromosomes)
  + [4.2 Types of Plots](#types-of-plots)
  + [4.3 Adding Axis](#adding-axis)
  + [4.4 Changing the plotting parameters](#changing-the-plotting-parameters)
  + [4.5 Zooming: plotting small parts of the genome](#zooming-plotting-small-parts-of-the-genome)
  + [4.6 Clipping and cutting the object representation](#clipping-and-cutting-the-object-representation)
* [5 Adding Data](#adding-data)
  + [5.1 Common Parameters](#common-parameters)
  + [5.2 Basic Plotting Functions](#basic-plotting-functions)
  + [5.3 Higher Level Plotting Functions](#higher-level-plotting-functions)
* [6 Compatibility with *magrittr*](#compatibility-with-magrittr)
* [7 Session Info](#session-info)

# 1 Introduction

Data visualisation is a powerful tool used for data analysis and exploration in many fields. Genomics data
analysis is one of these fields where good visualisation tools can be of great help. The aim of karyoploteR is to offer the user an easy way to plot data along the genome to get broad wide view where it is possible to identify genome wide relations and distributions.

*[karyoploteR](https://bioconductor.org/packages/3.22/karyoploteR)* is based on base R graphics and mimicks its interface. You first create a plot with `plotKaryotype` and then sequentially call a number of functions (`kpLines`, `kpPoints`, `kpBars`…) to add data to the plot.

*[karyoploteR](https://bioconductor.org/packages/3.22/karyoploteR)* is a plotting tool and only a plotting tool. That means that it is not able to download or retrieve any data. The downside of this is that the user is responsible of getting the data into R. The upside is that it is not tied to any data provider and thus can be used to plot genomic data coming from anywhere. The only exception to this are the ideograms cytobands, that by default are plotted using pre-downloaded data from UCSC.

# 2 Tutorial and Examples

In addition to this vignette, an detailed step-by-step tutorial and a set of
complex examples with complete code are available at
[<https://bernatgel.github.io/karyoploter_tutorial/>]

# 3 Quick Start

The basic idea behind *[karyoploteR](https://bioconductor.org/packages/3.22/karyoploteR)* has been to create a plotting system inspired by the R base graphics. Therefore, the basic workflow to create a karyoplot is to start with an empty plot with no data apart from the ideograms themselves using `plotKaryotype` and then add the data plots as required. To add the data there are functions based on the R base graphics low-level primitives -e.g `kpPoints`, `kpLines`, `kpSegments`, `kpRect`… - that can be used to plot virtually anything along the genome and other functions at a higher level useful to plot more specific genomic data types -e.g. `kpPlotRegions`, `kpPlotCoverage`…-.

This is a first simple example plotting a set of regions representing copy-number gains and losses using the `kpPlotRegions` function:

```
  gains <- toGRanges(data.frame(chr=c("chr1", "chr5", "chr17", "chr22"), start=c(1, 1000000, 4000000, 1),
                      end=c(5000000, 3200000, 80000000, 1200000)))
  losses <- toGRanges(data.frame(chr=c("chr3", "chr9", "chr17"), start=c(80000000, 20000000, 1),
                       end=c(170000000, 30000000, 25000000)))
  kp <- plotKaryotype(genome="hg19")
  kpPlotRegions(kp, gains, col="#FFAACC")
  kpPlotRegions(kp, losses, col="#CCFFAA")
```

![](data:image/png;base64...)

As you can see, the `plotKaryotype` returns a `KaryoPlot` object that has to be passed to any subsequent plot call.

`plotKaryotype` accepts a number of parameters but the most commonly used are `genome`, `chromosomes` and `plot.type`. The `genome` and `chromosomes` are used to specify the genome to be plotted (defaults to `hg19` and which chromosomes to plot (defaults to `canonical`). The `plot.type` parameter is used to select between different modes of adding data to the genome (above, below or on the ideograms).

For example, to create a plot of the mouse genome with data above the ideograms we would use this:

```
  kp <- plotKaryotype(genome="mm10", plot.type=1, main="The mm10 genome")
```

![](data:image/png;base64...)

And to plot the first thee chromosomes of the hg19 human genome assembly with data above and below them:

```
  kp <- plotKaryotype(genome="hg19", plot.type=2, chromosomes=c("chr1", "chr2", "chr3"))
```

![](data:image/png;base64...)

All low-level plotting functions share a similar interface, and in general, they accept the standard R plotting parameters (`lwd`, `cex`, `pch`, etc…). The simplest way (althought not always the most convenient) is to treat them as the equivalent R base plotting functions with an additional `chr` parameter. As an example, we can create a set of random 1 base regions (using *[regioneR](https://bioconductor.org/packages/3.22/regioneR)* `createRandomRegions`) and add a random `y` value to them:

```
  rand.data <- createRandomRegions(genome="hg19", nregions=1000, length.mean=1, length.sd=0,
                      mask=NA, non.overlapping=TRUE)
```

```
##
## Attaching package: 'Biostrings'
```

```
## The following object is masked from 'package:base':
##
##     strsplit
```

```
  rand.data <- toDataframe(sort(rand.data))
  rand.data <- cbind(rand.data, y=runif(n=1000, min=-1, max=1))

  #Select some data points as "special ones"
  sel.data <- rand.data[c(7, 30, 38, 52),]
  head(rand.data)
```

```
##    chr    start      end           y
## 1 chr1  3644551  3644551  0.37182379
## 2 chr1 10069646 10069646 -0.75039143
## 3 chr1 10992432 10992432 -0.62290400
## 4 chr1 11258844 11258844  0.50535078
## 5 chr1 14149997 14149997 -0.05097132
## 6 chr1 17784109 17784109  0.84357538
```

And then plot them in different ways.

```
  kp <- plotKaryotype(genome="hg19", plot.type=2, chromosomes=c("chr1", "chr2", "chr3"))

  kpDataBackground(kp, data.panel = 1, r0=0, r1=0.45)
  kpAxis(kp, ymin=-1, ymax=1, r0=0.05, r1=0.4, col="gray50", cex=0.5)
  kpPoints(kp, chr=rand.data$chr, x=rand.data$start, y=rand.data$y,
           ymin=-1, ymax=1, r0=0.05, r1=0.4, col="black", pch=".", cex=2)
  kpPoints(kp, chr=sel.data$chr, x=sel.data$start, y=sel.data$y,
           ymin=-1, ymax=1, r0=0.05, r1=0.4, col="red")
  kpText(kp, chr=sel.data$chr, x=sel.data$start, y=sel.data$y,
         ymin=-1, ymax=1, r0=0.05, r1=0.4, labels=c("A", "B", "C", "D"), col="red",
         pos=4, cex=0.8)

  #Upper part: data.panel=1
  kpDataBackground(kp, data.panel = 1, r0=0.5, r1=1)
  kpAxis(kp, ymin=-1, ymax=1, r0=0.5, r1=1, col="gray50", cex=0.5, numticks = 5)
  kpAbline(kp, h=c(-0.5, 0, 0.5), col="gray50", ymin=-1, ymax=1, r0=0.5, r1=1)
  kpLines(kp, chr=rand.data$chr, x=rand.data$start, y=rand.data$y,
          col="#AA88FF", ymin=-1, ymax=1, r0=0.5, r1=1)
  #Use kpSegments to add small tic to the line
  kpSegments(kp, chr=rand.data$chr, x0=rand.data$start, x1=rand.data$start,
             y0=rand.data$y-0.1, y1=rand.data$y+0.1,
             col="#8866DD", ymin=-1, ymax=1, r0=0.5, r1=1)
  #Plot the same line but inverting the data by pssing a r0>r1
  kpLines(kp, chr=rand.data$chr, x=rand.data$start, y=rand.data$y,
          col="#FF88AA", ymin=-1, ymax=1, r0=1, r1=0.5)

  #Lower part: data.panel=2
  kpDataBackground(kp, r0=0, r1=0.29, color = "#EEFFEE", data.panel = 2)
  kpAxis(kp, col="#AADDAA", ymin=-1, ymax=1, r0=0, r1=0.29, data.panel = 2,
         numticks = 2, cex=0.5, tick.len = 0)
  kpAbline(kp, h=0, col="#AADDAA", ymin=-1, ymax=1, r0=0, r1=0.29, data.panel = 2)
  kpBars(kp, chr=rand.data$chr, x0=rand.data$start, x1=rand.data$end, y1 = rand.data$y,
          col="#AADDAA", ymin=-1, ymax=1, r0=0, r1=0.29, data.panel = 2, border="#AADDAA" )

  kpDataBackground(kp, r0=0.34, r1=0.63, color = "#EEEEFF", data.panel = 2)
  kpAxis(kp, col="#AAAADD", ymin=-1, ymax=1, r0=0.34, r1=0.63, data.panel = 2,
         numticks = 2, cex=0.5, tick.len = 0)
  kpAbline(kp, h=0, col="#AAAADD", ymin=-1, ymax=1, r0=0.34, r1=0.63, data.panel = 2)
  kpSegments(kp, chr=rand.data$chr, x0=rand.data$start, x1=rand.data$end,
             y0=rand.data$y-0.2, y1=rand.data$y,
             col="#AAAADD", ymin=-1, ymax=1, r0=0.34, r1=0.63, data.panel = 2, lwd=2)

  kpDataBackground(kp, r0=0.68, r1=0.97, color = "#FFEEEE", data.panel = 2)
  kpAxis(kp, col="#DDAAAA", ymin=-1, ymax=1, r0=0.68, r1=0.97, data.panel = 2,
         numticks = 2, cex=0.5, tick.len = 0)
  kpPoints(kp, chr=rand.data$chr, x=rand.data$start, y=rand.data$y,
          col="#DDAAAA", ymin=-1, ymax=1, r0=0.68, r1=0.97, data.panel = 2, pch=".", cex=3)
```

![](data:image/png;base64...)

# 4 Creating a karyotype plot

All plots in *[karyoploteR](https://bioconductor.org/packages/3.22/karyoploteR)* start with a call to `plotKaryotype`. This function is used to define the desired type of plot and the basic plotting parameters, creates an empty plot with the ideograms representing the chromosomes and finally returns a `KaryoPlot` object that will be needed by all functions adding data into the plot.

There are two main parts in the karyoplots: the ideograms and the data panels. The ideograms represent the chromosomes and are usually represented by the chromosomic cytobands. The data panels are the parts of the plot where data will be plotted. They are not marked by default (no border or background) and depending on the plot type there may be more than one per chromosome.

`plotKaryotype` accepts a number of parameters to modify its behaviour, but by default it will create an empty karyoplot of the human genome version hg19 with a single data panel above the ideograms:

```
  kp <- plotKaryotype()
```

![](data:image/png;base64...)

In this section we will see how the different parameters of `plotKarytype` can be used to modify this basic plot and create plots with more data panels, for other organisms, with a different style or showing just some of the chromosomes.

## 4.1 Genomes and Chromosomes

A karyoplot is a representation of a genome, and thus, one of the main parameters of `plotKaryotype` is `genome`. With it we can specify what genome we want to plot. The package includes a small cache with information on some genomes and to use it we have to specify the genome using the standard UCSC genome name (hg19, hg38, mm10, dm6, …). However, internally it can use *[regioneR](https://bioconductor.org/packages/3.22/regioneR)*’s `getGenomeAndMask` function and so we can specify the genome in any fornmat accepted by this function, including the name of any `BSGenome` object available in the system. If we want `plotKaryotype` to ignore the included cache and try to automatically get the genome information from other sources we can set `use.cache` to `FALSE`.

In addition, with the `chromosomes` parameter, it is possible to plot only a subset of the chromosomes of the genome. The chromosomes can be specified either as a list of chromosome names or as one of the predefined sets for the available organisms: autosomal, canonical and all. By default, only canonical chromosomes are drawn. The `chromosomes` parameter can also be used to change the order of the chromosomes.

```
  kp <- plotKaryotype(chromosomes=c("autosomal"))
```

![](data:image/png;base64...)

```
  kp <- plotKaryotype(genome="mm10", chromosomes=c("chr10", "chr13", "chr2"))
```

![](data:image/png;base64...)

## 4.2 Types of Plots

There are currently 5 plot types available:

* **plot.type=1** A plot with stacked horizontal ideograms and a single data panel on top of them
* **plot.type=2** A plot with stacked horizontal ideograms and two data panels, one above and one below them
* **plot.type=3** A plot with horizontal ideograms all in one level, and two data panels, one above and one below them
* **plot.type=4** A plot with horizontal ideograms all in one level, and one data panel above them
* **plot.type=5** A plot with horizontal ideograms all in one level, and one data panel below them

To clearly see where the data panels are and in some cases, to help the readers interpret the data it is possible to add a background to the data panels with `kpDataBackground`. Please take into account that the function draws a solid rectangle and so if any data was already plotted it would be no longer visible.

This is plot type 1:

```
  kp <- plotKaryotype(chromosomes = c("chr1", "chr2"), plot.type = 1)
  kpDataBackground(kp, data.panel = 1)
```

![](data:image/png;base64...)

This is plot type 2:

```
 kp <- plotKaryotype(chromosomes = c("chr1", "chr2"), plot.type = 2)
 kpDataBackground(kp, data.panel = 1)
 kpDataBackground(kp, data.panel = 2)
```

![](data:image/png;base64...)

This is plot type 3:

```
 kp <- plotKaryotype(chromosomes = c("chr1", "chr2"), plot.type = 3)
 kpDataBackground(kp, data.panel = 1)
 kpDataBackground(kp, data.panel = 2)
```

![](data:image/png;base64...)

This is plot type 4:

```
 kp <- plotKaryotype(chromosomes = c("chr1", "chr2"), plot.type = 4)
 kpDataBackground(kp, data.panel = 1)
```

![](data:image/png;base64...)

And this is plot type 5:

```
 kp <- plotKaryotype(chromosomes = c("chr1", "chr2"), plot.type = 5)
 kpDataBackground(kp, data.panel = 1)
```

![](data:image/png;base64...)

## 4.3 Adding Axis

In some cases, adding axis to the plots can help stablishing a context for the data. `kpAxis` draws an axis on the letf or right side of the data panel and it’s possible to change it’s appearance, position, labels and ticks. If combined with a `kpDataBackground`, its important to draw the axis after the background, so it’s not overdrawn by it.

```
  kp <- plotKaryotype(chromosomes=c("chr1", "chr2"), plot.type=2)

  #data.panel=1
  kpDataBackground(kp)
  #Default axis
    kpAxis(kp)
  #Axis on the right side of the data.panel
    kpAxis(kp, side = 2)

  #data.panel=2
  kpDataBackground(kp, r1=0.47, data.panel=2)
  #Changing the limits and having more ticks, with a smaller font size
  kpAxis(kp, r1=0.47, ymin=-5000, ymax = 5000, numticks = 5, cex=0.5, data.panel=2)
  #and a different scale on the right
  kpAxis(kp, r1=0.47, ymin=-2, ymax = 2, numticks = 3, cex=0.5, data.panel=2, side=2)

  kpDataBackground(kp, r0=0.53, data.panel=2)
  #Changing the colors and labels and tick positions
  kpAxis(kp, r0=0.53, tick.pos = c(0.3, 0.6, 1), labels = c("A", "B", "C"), col="#66AADD",
         cex=0.5, data.panel=2)
```

![](data:image/png;base64...)

## 4.4 Changing the plotting parameters

In addition to changing the genomes, chromosomes, and plot types, it’s also possible to change and customize the different sizes and margins defining the look of the karyoplot. To do this we need to to provide an object with all the plotting parameters as the `plot.params` parameter of `plotKaryotype`. The easiest way to get a valid `plot.params` object is calling `getDefaultPlotParams` and modifying the response. To see the available plot params and their default values we can call `plotDefaultPlotParams`, which will create a plot with the representation of the plot parameters. Note that the plotting parameters plot are only implemented for plot types 1, 2 and 3.

This is for `plot.type=2`

```
plotDefaultPlotParams(plot.type=2)
```

![](data:image/png;base64...)

And this is for `plot.type=3`

```
plotDefaultPlotParams(plot.type=3)
```

![](data:image/png;base64...)

Or we can change the plot parameters to create different configurations. For example, we can create a plot with a data panel larger than the other and smaller margins:

```
plot.params <- getDefaultPlotParams(plot.type=2)
plot.params$ideogramheight <- 5
plot.params$data2height <- 50
plot.params$leftmargin <- 0.05
plot.params$bottommargin <- 20
plot.params$topmargin <- 20

plotDefaultPlotParams(plot.type=2, plot.params=plot.params)
```

![](data:image/png;base64...)

Or a plot with a very small data panel above the ideogram almost touching it (for example, to mark the regions of interest) and a bigger data panel below it (for example, to plot the detailed data):

```
plot.params <- getDefaultPlotParams(plot.type=3)
plot.params$ideogramheight <- 50
plot.params$data1height <- 50
plot.params$data1inmargin <- 1
plot.params$data2height <- 400

plotDefaultPlotParams(plot.type = 3, plot.params=plot.params)
```

![](data:image/png;base64...)

## 4.5 Zooming: plotting small parts of the genome

In addition to plotting the whole genome, it is possible to use karyoploteR
to plot a single small region, zooming in into it and not plotting the rest of
the genome.

**IMPORTANT:** It is not possible to zoom into multiple regions in a single plot.
Each zoomed plot can only represent a single region.

To activate this feature, we only need to specify the region to zoom in
passing a GRanges object in the `zoom` parameter of the `plotKaryotype`
function. This will create a new plot showing only the region in `zoom` and
with the number of data panels derived from `plot.type`.

For example, this is a standard plot of chromosome 1 with some random data:

```
  data.points <- data.frame(chr="chr1", pos=(1:240)*1e6, value=rnorm(240, 0.5, 0.1))
  kp <- plotKaryotype(plot.type = 4, chromosomes = "chr1")
  kpDataBackground(kp, data.panel = 1)
  kpAddBaseNumbers(kp)
  kpPoints(kp, chr = data.points$chr, x=data.points$pos, y=data.points$value, col=rainbow(240))
```

![](data:image/png;base64...)

And we can zoom into the region between 180-240Mb to see it with more detail.

```
  detail.region <- toGRanges(data.frame("chr1", 180e6, 240e6))
  data.points <- data.frame(chr="chr1", pos=(1:240)*1e6, value=rnorm(240, 0.5, 0.1))
  kp <- plotKaryotype(plot.type = 4, zoom=detail.region)
  kpDataBackground(kp, data.panel = 1)
  kpAddBaseNumbers(kp)
  kpPoints(kp, chr = data.points$chr, x=data.points$pos, y=data.points$value, col=rainbow(240))
```

![](data:image/png;base64...)

## 4.6 Clipping and cutting the object representation

When zooming, by default any data representation is clipped to the visible part
of the data panel. That is, only the part of the data representations inside
the data panel is drawn and anything falling out of it is cutted out.

It is possible to change this behaviour by setting the `clipping` parameter to
`FALSE`.

As an example, we can create a plot with a big point and a couple of arrows: one
ending above the limit of the data panel and the other one totally contained in
the data panal.

```
  kp <- plotKaryotype(plot.type = 4, chromosomes = "chr1")
  kpDataBackground(kp, data.panel = 1)
  kpAddBaseNumbers(kp)
  kpPoints(kp, chr = "chr1", x=180e6, y=0.5, pch=16, cex=8, col="#FAC67A", clipping=TRUE)
  kpArrows(kp, chr = "chr1", x0 = 50e6, x1=170e6, y0=0.2, y1=1.1)
  kpArrows(kp, chr = "chr1", x0 = 160e6, x1=240e6, y0=0.9, y1=0.5)
```

![](data:image/png;base64...)

We can see the two complete arrows and the point.

However, when we zoom in closer to the point, we end up with only parts of the
arrows and the point.

```
  detail.region <- toGRanges(data.frame("chr1", 135e6, 180e6))
  kp <- plotKaryotype(plot.type = 4, zoom = detail.region)
  kpDataBackground(kp, data.panel = 1)
  kpAddBaseNumbers(kp)
  kpPoints(kp, chr = "chr1", x=180e6, y=0.5, pch=16, cex=8, col="#FAC67A")
  kpArrows(kp, chr = "chr1", x0 = 50e6, x1=170e6, y0=0.2, y1=1.1)
  kpArrows(kp, chr = "chr1", x0 = 160e6, x1=240e6, y0=0.9, y1=0.5)
```

![](data:image/png;base64...)

Note that while the point of the arrow is within the detail region it gets clipped
because zooming activates the clipping.

We can disable clipping of individual elements using the `clipping` parameter.
For example, we can disable it for the arrows and leave it active for the point.

```
  detail.region <- toGRanges(data.frame("chr1", 135e6, 180e6))
  kp <- plotKaryotype(plot.type = 4, zoom = detail.region)
  kpDataBackground(kp, data.panel = 1)
  kpAddBaseNumbers(kp)
  kpPoints(kp, chr = "chr1", x=180e6, y=0.5, pch=16, cex=8, col="#FAC67A")
  kpArrows(kp, chr = "chr1", x0 = 50e6, x1=170e6, y0=0.2, y1=1.1, clipping=FALSE)
  kpArrows(kp, chr = "chr1", x0 = 160e6, x1=240e6, y0=0.9, y1=0.5, clipping=FALSE)
```

![](data:image/png;base64...)

Notice the the downward pointing arrow is still clipped, but this is only because
it end out of the actual image.

# 5 Adding Data

After creating a plot we can add data to it using successive calls to the various data plotting functions. There are two types of data plotting functions: the low levels ones, based on the basic plotting functions from base graphics (`kpPoints`, `kpLines`, etc…) and the higher level ones, that are functions specialized in drawing certain object types such as `GRanges` (`kpPlotRegions`, `kpPlotCoverage`). It is perfectly possible to draw new data on top of the already plotted one in order to create combined plots.

In addition, it is be possible to create custom plotting functions based on the coordinates change function included in the `karyoplot` object.

## 5.1 Common Parameters

All plotting functions share a set of common parameters that define where and how data will be plotted.

`r0` and `r1` define the region of the data panel where the data will be plotted. They are inspired by the r0 and r1 parameters in Circos, where they define the min and max radius where the data will be confined. A value of 0 is the most proximal to the ideogram and 1 is the farthest one. In addition, if `r0>r1`, the data will be “flipped”, drawing larger values of y closer to the ideogram.

`ymin` and `ymax` define the minimum and maximum expected y value to be plotted. By default they are 0 and 1 but any finite number is possible. They work together with `r0` and `r1` to define where a data point will be drawn. In general, a data point with `y=ymin` will be plotted at `r0` and a data point with `y=ymax` will be plotted at `r1`.

`data.panel` states in which data panel (if there’s more than one available) the data will be plotted. The data panel identifier depends on the `plot.type`.

`clipping` states whether data representation could span out of the data panel
or if it should be cut at the data panel boundary (`clipping=TRUE`, default).

In addition, all plotting functions accept the applicable standard R graphic parameters (`lwd`, `col`, `cex`, …)

## 5.2 Basic Plotting Functions

The basic or low-level plotting functions mimmick the base R plotting functions and are use to draw basic types: points, lines, segments, arrows, etc…

All basic plotting functions share a number of parameters to specify the data points. `chr` accepts a vector of chromosome names stating the chromosome to which data point belongs. `x` (or `x0` and `x1`) are used to specify the horizontal position of the data points (or its start and end) and the units are base pairs. `y` (or `y0` and `y1`) specify the value (or start and end value) of the data point and should be in the range `[ymin-ymax]`. All parameters are recycled if needed using the standard vector recycling rules, but in some situations this might result in strange results.

For example, to plot a point with value 0.2 in position 30Mb of chromosome 1 and a rectangle with values 0.2 to 0.4 in positions from 100Mb to 120Mb we would use:

```
  kp <- plotKaryotype(chromosomes=c("chr1"))
  kpDataBackground(kp)
  kpAxis(kp)
  kpPoints(kp, chr="chr1", x=30000000, y=0.2)
  kpRect(kp, chr="chr1", x0=100000000, x1=120000000, y0=0.2, y1=0.4)
```

![](data:image/png;base64...)

Another possibility is to create a `GRanges` object with the data, with `chr`, `x0` and `x1` as the sequence, start and end, and one (`y`) or two (`y0` and `y1`) metadata columns with the values. This `GRanges` object can then be passed in in the `data` parameter. In addition, it is possible to overrule the content of data if any of the explicit parameters is used.

```
  dd <- toGRanges(data.frame(chr="chr1", start=30000000, end=30000000, y=0.2))
  dd2 <- toGRanges(data.frame(chr="chr1", start=100000000, end=120000000, y0=0.2, y1=0.4))

  kp <- plotKaryotype(chromosomes=c("chr1"))
  kpDataBackground(kp)
  kpAxis(kp)
  kpPoints(kp, data=dd)
  kpPoints(kp, data=dd, y=0.8)
  kpRect(kp, data=dd2)
```

![](data:image/png;base64...)

These are the available basic plotting functions (more detailed information and
extended examples can be found at [karyoploteR’s tutorial and examples page](https://bernatgel.github.io/karyoploter_tutorial/#Examples)):

* **kpAbline** Draws horizontal and vertical lines spanning the whole avaliable space
* **kpArrows** Draws arrows. Using the `code` parameter, it’s possible to specify where the arrowhead should be placed.
* **kpBars** Draws vertical bars. If `y0` is present, bars span from `y0` to `y1`, if it’s ommited, bars span from 0 to `y1`
* **kpHeatmap** Draws a heatmap-like representation of the data. Specifically, for each data point a rectangle is drawn with the color determined by the `y` value
* **kpLines** Draws straight lines joining the data points.
* **kpPoints** Draws points (or other shaes using `pch`) in the data points.
* **kpPolygon** Draws a closed polygon joining all data points
* **kpRect** Draws a rectangle at the specified points.
* **kpSegments** Draws segments joining the specified points
* **kpText** Draws text labels at the specified positions. Text labels are provided via the `labels` argument.

```
  pp <- getDefaultPlotParams(plot.type = 1)
  pp$data1height=600

  tr.i <- 1/11
  tr.o <- 1/10

  kp <- plotKaryotype(chromosomes=c("chr1"), plot.params = pp)

  dd <- toGRanges(data.frame(chr="chr1", start=end(kp$genome[1])/50*(0:49), end=end(kp$genome[1])/50*(1:50)))
  mcols(dd) <- data.frame(y=((sin(start(dd)) + rnorm(n=50, mean=0, sd=0.1))/5)+0.5)

  tn <- 0
  kpDataBackground(kp, r0=tr.o*tn, r1=tr.o*tn+tr.i)
  kpPoints(kp, dd, r0=tr.o*tn, r1=tr.o*tn+tr.i, pch=".", cex=2)
  kpRect(kp, chr="chr1", x0=5000000, x1=45000000, y0=0.2, y1=0.8, r0=tr.o*tn, r1=tr.o*tn+tr.i, col="#EEEEEE", border="#666666")
  kpText(kp, chr="chr1", x=25000000, y=0.5, col="red", r0=tr.o*tn, r1=tr.o*tn+tr.i, labels="kpPoints", cex=0.7)

  tn <- 1
  kpDataBackground(kp, r0=tr.o*tn, r1=tr.o*tn+tr.i)
  kpLines(kp, dd, r0=tr.o*tn, r1=tr.o*tn+tr.i, pch=".", cex=2)
  kpRect(kp, chr="chr1", x0=5000000, x1=45000000, y0=0.2, y1=0.8, r0=tr.o*tn, r1=tr.o*tn+tr.i, col="#EEEEEE", border="#666666")
  kpText(kp, chr="chr1", x=25000000, y=0.5, col="red", r0=tr.o*tn, r1=tr.o*tn+tr.i, labels="kpLines", cex=0.7)

  tn <- 2
  kpDataBackground(kp, r0=tr.o*tn, r1=tr.o*tn+tr.i)
  kpBars(kp, dd, y1=dd$y, r0=tr.o*tn, r1=tr.o*tn+tr.i, col="#AAFFAA", border="#66DD66")
  kpRect(kp, chr="chr1", x0=5000000, x1=45000000, y0=0.2, y1=0.8, r0=tr.o*tn, r1=tr.o*tn+tr.i, col="#EEEEEE", border="#666666")
  kpText(kp, chr="chr1", x=25000000, y=0.5, col="red", r0=tr.o*tn, r1=tr.o*tn+tr.i, labels="kpBars", cex=0.7)

  tn <- 3
  kpDataBackground(kp, r0=tr.o*tn, r1=tr.o*tn+tr.i)
  kpRect(kp, dd, y0=dd$y-0.3, y1=dd$y, r0=tr.o*tn, r1=tr.o*tn+tr.i, col="#AAAAFF", border="#6666DD")
  kpRect(kp, chr="chr1", x0=5000000, x1=45000000, y0=0.2, y1=0.8, r0=tr.o*tn, r1=tr.o*tn+tr.i, col="#EEEEEE", border="#666666")
  kpText(kp, chr="chr1", x=25000000, y=0.5, col="red", r0=tr.o*tn, r1=tr.o*tn+tr.i, labels="kpRect", cex=0.7)

  tn <- 4
  kpDataBackground(kp, r0=tr.o*tn, r1=tr.o*tn+tr.i)
  kpText(kp, dd, labels=as.character(1:50), cex=0.5, r0=tr.o*tn, r1=tr.o*tn+tr.i, col="#DDAADD")
  kpRect(kp, chr="chr1", x0=5000000, x1=45000000, y0=0.2, y1=0.8, r0=tr.o*tn, r1=tr.o*tn+tr.i, col="#EEEEEE", border="#666666")
  kpText(kp, chr="chr1", x=25000000, y=0.5, col="red", r0=tr.o*tn, r1=tr.o*tn+tr.i, labels="kpText", cex=0.7)

  tn <- 5
  kpDataBackground(kp, r0=tr.o*tn, r1=tr.o*tn+tr.i)
  kpSegments(kp, dd, y0=dd$y-0.3, y1=dd$y, r0=tr.o*tn, r1=tr.o*tn+tr.i)
  kpRect(kp, chr="chr1", x0=5000000, x1=45000000, y0=0.2, y1=0.8, r0=tr.o*tn, r1=tr.o*tn+tr.i, col="#EEEEEE", border="#666666")
  kpText(kp, chr="chr1", x=25000000, y=0.5, col="red", r0=tr.o*tn, r1=tr.o*tn+tr.i, labels="kpSegments", cex=0.7)

  tn <- 6
  kpDataBackground(kp, r0=tr.o*tn, r1=tr.o*tn+tr.i)
  kpArrows(kp, dd, y0=dd$y-0.3, y1=dd$y, r0=tr.o*tn, r1=tr.o*tn+tr.i, length=0.04)
  kpRect(kp, chr="chr1", x0=5000000, x1=45000000, y0=0.2, y1=0.8, r0=tr.o*tn, r1=tr.o*tn+tr.i, col="#EEEEEE", border="#666666")
  kpText(kp, chr="chr1", x=25000000, y=0.5, col="red", r0=tr.o*tn, r1=tr.o*tn+tr.i, labels="kpArrows", cex=0.7)

  tn <- 7
  kpDataBackground(kp, r0=tr.o*tn, r1=tr.o*tn+tr.i)
  kpHeatmap(kp, dd, r0=tr.o*tn+tr.i/4, r1=tr.o*tn+tr.i-tr.i/4, colors = c("green", "black", "red"))
  kpRect(kp, chr="chr1", x0=5000000, x1=45000000, y0=0.2, y1=0.8, r0=tr.o*tn, r1=tr.o*tn+tr.i, col="#EEEEEE", border="#666666")
  kpText(kp, chr="chr1", x=25000000, y=0.5, col="red", r0=tr.o*tn, r1=tr.o*tn+tr.i, labels="kpHeatmap", cex=0.7)

  tn <- 8
  kpDataBackground(kp, r0=tr.o*tn, r1=tr.o*tn+tr.i)
  kpPolygon(kp, dd, r0=tr.o*tn, r1=tr.o*tn+tr.i)
  kpRect(kp, chr="chr1", x0=5000000, x1=45000000, y0=0.2, y1=0.8, r0=tr.o*tn, r1=tr.o*tn+tr.i, col="#EEEEEE", border="#666666")
  kpText(kp, chr="chr1", x=25000000, y=0.5, col="red", r0=tr.o*tn, r1=tr.o*tn+tr.i, labels="kpPolygon", cex=0.7)

  tn <- 9
  kpDataBackground(kp, r0=tr.o*tn, r1=tr.o*tn+tr.i)
  kpAbline(kp, h=c(0.25, 0.5, 0.75), v=start(dd), r0=tr.o*tn, r1=tr.o*tn+tr.i)
  kpRect(kp, chr="chr1", x0=5000000, x1=45000000, y0=0.2, y1=0.8, r0=tr.o*tn, r1=tr.o*tn+tr.i, col="#EEEEEE", border="#666666")
  kpText(kp, chr="chr1", x=25000000, y=0.5, col="red", r0=tr.o*tn, r1=tr.o*tn+tr.i, labels="kpAbline", cex=0.7)
```

![](data:image/png;base64...)

## 5.3 Higher Level Plotting Functions

Higher level functions are designed to plot specific data types and objects and they expect data to be given using a specific object.

These are the currently available high-level plotting functions:

* **kpPlotRegions** Accepts a `GRanges` object and plots the regions as solid rectangles. If there are overlapping regions, it automatically detect them and plot them in a stacked way.
* **kpPlotCoverage** Accepts a `Granges` object and plots the coverage level over the genome as a histogram-like bar plot.
* **kpPlotDensity** Accepts a `GRanges` object and computes its density over set size windows. It is possible to change the window size to change the smoothing effect.
* **kpPlotBAMDensity** Accepts a BAM file and computes the read density along the genome. The density is computed directly from the BAM file
* **kpPlotMarkers** Given a set of genomic positions and labels, creates sticks and texts markers naming the positions. Useful for genes and other named genomic elements. Includes a simple positioning algorithm that will attempt to avoid the overlapping of text labels.
* **kpPlotRainfall** Given a set of variants, creates a raifall plot depicting the distance between each variant and the next one. Useful to identify *kataegis*, regions with an accumulation of variants.
* **kpPlotRibbon** Plots a variable width line. Useful to show confidence intervals and similar objects.
* **kpPlotLinks** Plots links between different regions of the genome, either in the same of different chromosomes.

Extended information regarding these functions and additional real-life examples can be found at the [karyoploteR’s tutorial and examples page](https://bernatgel.github.io/karyoploter_tutorial/#Examples)

# 6 Compatibility with *[magrittr](https://bioconductor.org/packages/3.22/magrittr)*

*[karyoploteR](https://bioconductor.org/packages/3.22/karyoploteR)* is compatible with *[magrittr](https://bioconductor.org/packages/3.22/magrittr)* and so it is also possible to use `%>%` pipes to chain the calls to the plotting functions. This allows somewhat simpler code.

For example this code

```
  kp <- plotKaryotype(genome="hg19")
  kpDataBackground(kp)
  kpAxis(kp)
  kpPlotRegions(kp, gains, col="#FFAACC")
  kpPlotRegions(kp, losses, col="#CCFFAA")
```

is equivalent to this one using pipes

```
  library(magrittr)
  kp <- plotKaryotype(genome="hg19") %>% kpDataBackground() %>%  kpAxis() %>%
    kpPlotRegions(gains, col="#FFAACC") %>%
    kpPlotRegions(losses, col="#CCFFAA")
```

# 7 Session Info

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
##  [1] BSgenome.Hsapiens.UCSC.hg19.masked_1.3.993
##  [2] BSgenome.Hsapiens.UCSC.hg19_1.4.3
##  [3] BSgenome_1.78.0
##  [4] rtracklayer_1.70.0
##  [5] BiocIO_1.20.0
##  [6] Biostrings_2.78.0
##  [7] XVector_0.50.0
##  [8] magrittr_2.0.4
##  [9] karyoploteR_1.36.0
## [10] regioneR_1.42.0
## [11] GenomicRanges_1.62.0
## [12] Seqinfo_1.0.0
## [13] IRanges_2.44.0
## [14] S4Vectors_0.48.0
## [15] BiocGenerics_0.56.0
## [16] generics_0.1.4
## [17] knitr_1.50
## [18] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3                   bitops_1.0-9
##  [3] gridExtra_2.3               rlang_1.1.6
##  [5] biovizBase_1.58.0           matrixStats_1.5.0
##  [7] compiler_4.5.1              RSQLite_2.4.3
##  [9] GenomicFeatures_1.62.0      png_0.1-8
## [11] vctrs_0.6.5                 ProtGenerics_1.42.0
## [13] stringr_1.5.2               pkgconfig_2.0.3
## [15] crayon_1.5.3                fastmap_1.2.0
## [17] magick_2.9.0                backports_1.5.0
## [19] Rsamtools_2.26.0            rmarkdown_2.30
## [21] UCSC.utils_1.6.0            tinytex_0.57
## [23] bit_4.6.0                   xfun_0.53
## [25] cachem_1.1.0                cigarillo_1.0.0
## [27] GenomeInfoDb_1.46.0         jsonlite_2.0.0
## [29] blob_1.2.4                  DelayedArray_0.36.0
## [31] BiocParallel_1.44.0         parallel_4.5.1
## [33] cluster_2.1.8.1             R6_2.6.1
## [35] VariantAnnotation_1.56.0    bslib_0.9.0
## [37] stringi_1.8.7               RColorBrewer_1.1-3
## [39] bezier_1.1.2                rpart_4.1.24
## [41] jquerylib_0.1.4             Rcpp_1.1.0
## [43] bookdown_0.45               SummarizedExperiment_1.40.0
## [45] base64enc_0.1-3             Matrix_1.7-4
## [47] nnet_7.3-20                 tidyselect_1.2.1
## [49] rstudioapi_0.17.1           dichromat_2.0-0.1
## [51] abind_1.4-8                 yaml_2.3.10
## [53] codetools_0.2-20            curl_7.0.0
## [55] lattice_0.22-7              tibble_3.3.0
## [57] Biobase_2.70.0              KEGGREST_1.50.0
## [59] S7_0.2.0                    evaluate_1.0.5
## [61] foreign_0.8-90              pillar_1.11.1
## [63] BiocManager_1.30.26         MatrixGenerics_1.22.0
## [65] checkmate_2.3.3             RCurl_1.98-1.17
## [67] ensembldb_2.34.0            ggplot2_4.0.0
## [69] scales_1.4.0                glue_1.8.0
## [71] lazyeval_0.2.2              Hmisc_5.2-4
## [73] tools_4.5.1                 data.table_1.17.8
## [75] GenomicAlignments_1.46.0    XML_3.99-0.19
## [77] grid_4.5.1                  AnnotationDbi_1.72.0
## [79] colorspace_2.1-2            htmlTable_2.4.3
## [81] restfulr_0.0.16             Formula_1.2-5
## [83] cli_3.6.5                   S4Arrays_1.10.0
## [85] dplyr_1.1.4                 AnnotationFilter_1.34.0
## [87] gtable_0.3.6                sass_0.4.10
## [89] digest_0.6.37               SparseArray_1.10.0
## [91] rjson_0.2.23                htmlwidgets_1.6.4
## [93] farver_2.1.2                memoise_2.0.1
## [95] htmltools_0.5.8.1           lifecycle_1.0.4
## [97] httr_1.4.7                  bit64_4.6.0-1
## [99] bamsignals_1.42.0
```