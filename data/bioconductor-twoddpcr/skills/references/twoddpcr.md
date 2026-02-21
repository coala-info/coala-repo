# twoddpcr: A package for Droplet Digital PCR analysis

Anthony Chiu

#### 30 October 2025

#### Package

twoddpcr 1.34.0

# Contents

* [1 Introduction](#introduction)
* [2 Installing the `twoddpcr` package](#installing-the-twoddpcr-package)
* [3 Loading the `twoddpcr` package](#loading-the-twoddpcr-package)
* [4 Using the in-built dataset](#using-the-in-built-dataset)
* [5 Basic plots](#basic-plots)
* [6 Plotting the droplets and existing classifications](#plotting-the-droplets-and-existing-classifications)
* [7 Independent linear gating on the channels (`thresholdClassify`)](#independent-linear-gating-on-the-channels-thresholdclassify)
* [8 Classifying using the k-means algorithm (`kmeansClassify`)](#classifying-using-the-k-means-algorithm-kmeansclassify)
* [9 Adding “rain”](#adding-rain)
* [10 Creating a summary](#creating-a-summary)
* [11 Analysis of the data](#analysis-of-the-data)
  + [11.1 Comparison of classification methods](#comparison-of-classification-methods)
  + [11.2 Discussion](#discussion)
* [12 Other classification tools](#other-classification-tools)
  + [12.1 Classifying using the k-NN algorithm (`knnClassify`)](#classifying-using-the-k-nn-algorithm-knnclassify)
  + [12.2 Classifying the four ‘corners’ of a plot (`gridClassify`)](#classifying-the-four-corners-of-a-plot-gridclassify)
  + [12.3 Adding rain with `sdRain`](#adding-rain-with-sdrain)
  + [12.4 Custom classifications](#custom-classifications)
* [13 Appendix](#appendix)
  + [13.1 Shiny-based GUI for non-R users](#shiny-based-gui-for-non-r-users)
  + [13.2 Exporting droplet amplitudes from *QuantaSoft* to CSV files](#exporting-droplet-amplitudes-from-quantasoft-to-csv-files)
  + [13.3 Using other datasets](#using-other-datasets)
  + [13.4 Problems reading files](#problems-reading-files)
* [14 Citing `twoddpcr`](#citing-twoddpcr)
* [15 Further reading](#further-reading)
* [16 Session information](#session-information)
* [17 References](#references)
* **Appendix**

# 1 Introduction

Droplet Digital PCR (ddPCR) is a system from Bio-Rad for estimating the number
of genomic fragments in samples. ddPCR attaches fluorochromes to targets of
interest, for example, mutant and wild type KRAS. Each sample is then divided
into 20,000 droplets and qPCR is run on each droplet. The brightness of these
droplets is measured in two channels, each corresponding to our targets.
The amplitudes of the droplets can be plotted and the results analysed to see
whether droplets can be called as:

* Positive in both channels (PP),
* Positive in Channel 1 only (PN),
* Positive in Channel 2 only (NP), or
* Negative in both channels (NN).

There are variations in the brightnesses of the droplets; this can be
particularly evident in and around the PP cluster, where there may be some
crosstalk due the presence of both fluorochromes. The classification of
droplets is therefore not necessarily as simple as deciding on brightness
thresholds for each channel, above which a positive reading is called in that
channel.

This vignette demonstrates how the `twoddpcr` package may be used to load data,
classified and how to quickly create summaries.

# 2 Installing the `twoddpcr` package

The package can be installed from Bioconductor using:

```
install.packages("BiocManager")
BiocManager::install("twoddpcr")
```

Alternatively, it can be installed from GitHub using:

```
library(devtools)
install_github("CRUKMI-ComputationalBiology/twoddpcr")
```

Another alternative is to install the package from source:

```
install.packages("</path/to/twoddpcr/>", repos=NULL, type="source")
```

# 3 Loading the `twoddpcr` package

Once the package has been installed, it can be loaded in the usual way:

```
library(twoddpcr)
```

# 4 Using the in-built dataset

Our example uses the `KRASdata` dataset, which comes as part of the package.
This dataset was created as a triplicate four-fold serial dilution with 5% A549
mutant KRAS cell lines and 95% H1048 wild type KRAS cells as starting material.

To follow along with this dataset, create a `ddpcrPlate` object using:

```
plate <- ddpcrPlate(wells=KRASdata)
```

To follow along with your own dataset, see the
[Appendix](#using-other-datasets).

# 5 Basic plots

All of the droplets can be plotted to see how they tend cluster:

```
dropletPlot(plate)
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the twoddpcr package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: The `size` argument of `element_line()` is deprecated as of ggplot2 3.4.0.
## ℹ Please use the `linewidth` argument instead.
## ℹ The deprecated feature was likely used in the twoddpcr package.
##   Please report the issue to the authors.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

This might not be particularly informative; for example, a density plot may be
more appropriate:

```
heatPlot(plate)
```

![](data:image/png;base64...)

It can be seen here that most of the droplets are concentrated in the
bottom-left and bottom-right clusters.

To take a different view, all of the wells could be plotted side-by-side:

```
facetPlot(plate)
```

![](data:image/png;base64...)

# 6 Plotting the droplets and existing classifications

Since the droplet amplitudes were extracted from Bio-Rad’s *QuantaSoft*, there
may already be some kind of classification. This can be checked with the
`commonClassificationMethod` method, which retrieves the classification methods
that exist for all of the wells in the plate:

```
commonClassificationMethod(plate)
```

```
## [1] "None"    "Cluster"
```

The `Cluster` classification can be plotted:

```
dropletPlot(plate, cMethod="Cluster")
```

![](data:image/png;base64...)

Again, these are all of the wells in the plate superimposed onto the same plot.
This gives a good overall picture, but the detection of rare alleles in
*individual* wells is where ddPCR is particularly useful. The wells that used
in the plate are:

```
names(plate)
```

```
##  [1] "E03" "F03" "G03" "H03" "A04" "B04" "C04" "D04" "E04" "F04" "G04" "H04"
```

Individual wells can be selected using the `[[...]]` syntax (as with lists in
*R*). These can be plotted in the same way using `dropletPlot`. For example:

```
dropletPlot(plate[["F03"]], cMethod="Cluster")
```

![](data:image/png;base64...)

```
dropletPlot(plate[["E04"]], cMethod="Cluster")
```

![](data:image/png;base64...)

# 7 Independent linear gating on the channels (`thresholdClassify`)

This section illustrates how the `Cluster` classification was obtained,
although the original classification was found using *QuantaSoft*.
The classification here involves setting linear gates (thresholds) for the two
channels `Ch1.Amplitude` and `Ch2.Amplitude`, above each of which we will call
a positive reading for that channel.

```
plate <- thresholdClassify(plate, ch1Threshold=6789, ch2Threshold=3000)
```

The `commonClassificationMethod` method shows that there is now a new
classification method:

```
commonClassificationMethod(plate)
```

```
## [1] "None"       "Cluster"    "thresholds"
```

The `thresholds` classification can be plotted using `dropletPlot` but changing
the `cMethod` parameter:

```
dropletPlot(plate, cMethod="thresholds")
```

![](data:image/png;base64...)

# 8 Classifying using the k-means algorithm (`kmeansClassify`)

Visually, it appears that the classification in the previous section does not
accurately classify a region between the main `NP` and `PP` clusters. There are
a number of algorithms that could be used to better classify the clusters; one
such example is the k-means clustering algorithm. The k-means algorithm is
relatively fast but requires that we know how many clusters there are. With
this in mind, it helps to classify all of the wells together so that human
intervention is not required to judge whether some clusters in individual wells
are empty. To run the algorithm on `ddpcrPlate` objects, the `kmeansClassify`
method is used:

```
plate <- kmeansClassify(plate)
commonClassificationMethod(plate)
```

```
## [1] "None"       "Cluster"    "thresholds" "kmeans"
```

```
dropletPlot(plate, cMethod="kmeans")
```

![](data:image/png;base64...)

Notice how the `PP` cluster incorporates more of the droplets when compared to
the `thresholds` case. Visually, it appears that k-means captures the
clustering behaviour of the droplets more accurately.

Using the same wells chosen before, it is interesting to see how the individual
wells classify:

```
dropletPlot(plate[["F03"]], cMethod="kmeans")
```

![](data:image/png;base64...)

```
dropletPlot(plate[["E04"]], cMethod="kmeans")
```

![](data:image/png;base64...)

# 9 Adding “rain”

There are regions between clusters where the classification is ambiguous, e.g.
above and to the left of the NP cluster. These regions can be labelled as
“Rain” and removed from the droplet counts in each of the clusters.
To achieve this, the `mahalanobisRain` method can be used.

```
plate <- mahalanobisRain(plate, cMethod="kmeans", maxDistances=3)
```

The classification methods are now:

```
commonClassificationMethod(plate)
```

```
## [1] "None"          "Cluster"       "thresholds"    "kmeans"
## [5] "kmeansMahRain"
```

Whenever droplets are relabelled as `Rain` using the `mahalanobisRain` method,
the character string “MahRain” is appended to the classification name to
distinguish it from the original. This classification is plotted as:

```
dropletPlot(plate, cMethod="kmeansMahRain")
```

![](data:image/png;base64...)

This does not look particularly good; a lot of droplets that should be
classified have been labelled as “Rain” instead. To remedy this, the
`maxDistances` parameter can be adjusted to control the maximum (Mahalanobis)
distance that droplets can be from the cluster centres.
Some fine-tuning of this parameter gives:

```
plate <- mahalanobisRain(plate, cMethod="kmeans",
                         maxDistances=list(NN=35, NP=35, PN=35, PP=35))
commonClassificationMethod(plate)
```

```
## [1] "None"          "Cluster"       "thresholds"    "kmeans"
## [5] "kmeansMahRain"
```

The plot now looks slightly different:

```
dropletPlot(plate, cMethod="kmeansMahRain")
```

![](data:image/png;base64...)

# 10 Creating a summary

Using the number of droplets in each classification, the Poisson distribution
can be used to estimate the number of fragments/molecules in the starting
sample. For the k-means classification with rain, this gives the summary:

```
kmeansMahRainSummary <- plateSummary(plate, cMethod="kmeansMahRain")
head(kmeansMahRainSummary)
```

```
##      PP  PN   NP    NN AcceptedDroplets MtPositives MtNegatives WtPositives
## E03 292 273 5775  6229            12569         565       12004        6067
## F03 305 256 5840  5946            12347         561       11786        6145
## G03 236 222 4877  4860            10195         458        9737        5113
## H03  24  95 1630  9931            11680         119       11561        1654
## A04  22 101 1844 10840            12807         123       12684        1866
## B04  19 112 1924 10998            13053         131       12922        1943
##     WtNegatives MtConcentration WtConcentration MtCopiesPer20uLWell
## E03        6502          54.110         775.440            1082.201
## F03        6202          54.707         810.049            1094.135
## G03        5082          54.076         819.050            1081.514
## H03       10026          12.048         179.643             240.956
## A04       10941          11.354         185.264             227.072
## B04       11110          11.867         189.615             237.334
##     WtCopiesPer20uLWell TotalCopiesPer20uLWell  Ratio FracAbun
## E03           15508.792              16590.992 0.0698    6.523
## F03           16200.972              17295.107 0.0675    6.326
## G03           16381.000              17462.514 0.0660    6.193
## H03            3592.853               3833.809 0.0671    6.285
## A04            3705.287               3932.358 0.0613    5.774
## B04            3792.292               4029.626 0.0626    5.890
```

The first few columns `PP`, `PN`, `NP` and `NN` are the numbers of droplets in
each class, whereas `AcceptedDroplets` is the sum of these. `MtPositives` is
the number of droplets where a mutant has been called and conversely
`MtNegatives` is the number of droplets with no mutants called. The
`MtConcentration` is the Poisson estimate of how many mutant fragments there
are per 1uL, while the `MtCopiesPer20uLWell` is the same figure multiplied
by 20. There are `Wt` (wild type) analogues of all of these `Mt` figures.
Finally, `Ratio` is the figure `MtConcentration/WtConcentration` and `FracAbun`
is the fractional abundance of mutants in the sample, i.e. `100 * MtConcentration/(MtConcentration + WtConcentration)`.

The summaries for other classifications can still be produced by changing the
`cMethod` parameter to one of those that exist in
`commonClassificationMethod(plate)`.

This concludes the main walkthrough of this vignette.

# 11 Analysis of the data

## 11.1 Comparison of classification methods

As mentioned above, the `KRASdata` dataset was created as a triplicate
four-fold serial dilution with 5% mutant and 95% wild type starting material.
A data frame can be created to reflect this along with the mutant concentration
values of each well.

```
inputNg <- c(rep(64, 3), rep(16, 3), rep(4, 3), rep(1, 3))
mtConcentrations <-
  data.frame(
    x=inputNg,
    Cluster=plateSummary(plate, cMethod="Cluster")$MtConcentration,
    kmeans=plateSummary(plate, cMethod="kmeans")$MtConcentration,
    kmeansMahRain=kmeansMahRainSummary$MtConcentration)
knitr::kable(mtConcentrations)
```

| x | Cluster | kmeans | kmeansMahRain |
| --- | --- | --- | --- |
| 64 | 51.028 | 54.152 | 54.110 |
| 64 | 48.540 | 54.689 | 54.707 |
| 64 | 49.161 | 54.204 | 54.076 |
| 16 | 12.036 | 12.036 | 12.048 |
| 16 | 11.244 | 11.337 | 11.354 |
| 16 | 11.848 | 11.848 | 11.867 |
| 4 | 3.340 | 3.435 | 3.436 |
| 4 | 3.358 | 3.271 | 3.272 |
| 4 | 3.042 | 3.042 | 3.043 |
| 1 | 0.547 | 0.547 | 0.547 |
| 1 | 0.637 | 0.637 | 0.637 |
| 1 | 0.470 | 0.470 | 0.470 |

The mutant concentration values can be plotted and the various classification
methods compared against each other:

```
library(ggplot2)
library(reshape2)
mtConcentrationsLong <- melt(mtConcentrations, id.vars=c("x"))
ggplot(mtConcentrationsLong, aes_string("x", "value")) +
  geom_point() + geom_smooth(method="lm") + facet_wrap(~variable)
```

```
## `geom_smooth()` using formula = 'y ~ x'
```

![](data:image/png;base64...)

Numerically, the regression lines have coefficients of determination (R2
values):

```
bioradLmSummary <- summary(lm(x ~ Cluster, data=mtConcentrations))
kmLmSummary <- summary(lm(x ~ kmeans, data=mtConcentrations))
kmMahRainLmSummary <- summary(lm(x ~ kmeansMahRain, data=mtConcentrations))
knitr::kable(c("Cluster"=bioradLmSummary$r.squared,
               "kmeans"=kmLmSummary$r.squared,
               "kmeansMahRain"=kmMahRainLmSummary$r.squared))
```

|  | x |
| --- | --- |
| Cluster | 0.9989393 |
| kmeans | 0.9988022 |
| kmeansMahRain | 0.9988212 |

## 11.2 Discussion

As shown above, the regression lines fit the data from all of the
classification methods very well. Moreover, the R2 values are all similar and
very close to 1. Therefore all of the approaches are very good and nothing can
be said about which of the methods is better or worse. The density plot created
by `heatPlot` above shows that the number of droplets in the `PP` cluster is
relatively small compared to the other clusters, particularly at the bottom of
the `PP` cluster. This explains why the regression lines are very similar.

An advantage of the `twoddpcr` package’s k-means based approach is that setting
thresholds manually can be subjective. In addition, the k-means clustering
algorithm is more appropriate for finding clusters when the `PN` cluster
‘leans’ and the `NP` cluster ‘lifts’.

Setting rain using standard deviation is a commonly used approach in ddPCR
analysis to remove false positives. It involves setting Ch1 and Ch2 thresholds
for each cluster and removes droplets that are too far from the cluster
centres. This method was introduced in (**???**). However, it is not possible
to set such thresholds for the `NP` cluster above because, for example, setting
a low Ch1 threshold would exclude too much from the top-right of the cluster,
whereas setting a high Ch1 threshold would exclude nothing at all. The
`twoddpcr` package’s Mahalanobis rain method allows this kind of approach to be
used, while still respecting the shapes of the clusters.

# 12 Other classification tools

This section explains how other classification methods can be used. The methods
already described above should suffice, but there are some droplet patterns
that prevent them from working as well as we would like. The following methods
are alternative techniques that can be used.

## 12.1 Classifying using the k-NN algorithm (`knnClassify`)

Another classification algorithm is the k-nearest neighbour (k-NN) algorithm.
The algorithm is very simple: For each droplet in the plate, look at the
classifications of its nearest \(k\)-neighbours in a training set.
Assign the majority classification to the droplet.

The challenge now is to find a good dataset that is not too large, since this
would slow the algorithm considerably for marginal gains. A training set should
also have minimal noise.

To start, two wells `E03` and `A04` are chosen that reflect the clustering
pattern of the plate without too much noise. We create a new (virtual) plate
with the amplitudes from these wells.

```
trainWells <- plate[c("E03", "A04")]
trainPlate <- ddpcrPlate(wells=trainWells)
```

To create the training classification, the k-means algorithm is useful:

```
trainPlate <- kmeansClassify(trainPlate)
dropletPlot(trainPlate, cMethod="kmeans")
```

![](data:image/png;base64...)

We see that k-means has worked quite well here, since the training set is
relatively noise-free. However, it is clear that there is a `PN` droplet that
is much closer to other `PP` droplets than the rest of the `PN` cluster. Noise
can be removed by adding rain:

```
trainPlate <- mahalanobisRain(trainPlate, cMethod="kmeans", maxDistances=3)
dropletPlot(trainPlate, cMethod="kmeansMahRain")
```

![](data:image/png;base64...)

This is a much less noisy classification to use. The training data needs to be
a data frame and should also ignore the droplets classified as `Rain`; the
`removeDropletClasses` method removes these droplets:

```
trainSet <- removeDropletClasses(trainPlate, cMethod="kmeansMahRain")
trainSet <- do.call(rbind, trainSet)
colnames(trainSet)
```

```
## [1] "Ch1.Amplitude" "Ch2.Amplitude" "kmeansMahRain"
```

We can check that the `Rain` droplets have been removed:

```
table(trainSet$kmeansMahRain)
```

```
##
##    NN    NP    PN    PP  Rain   N/A
## 14866  6418   329   246     0     0
```

Next, we use this classification as the training set for the k-NN algorithm:

```
trainAmplitudes <- trainSet[, c("Ch1.Amplitude", "Ch2.Amplitude")]
trainCl <- trainSet$kmeansMahRain
plate <- knnClassify(plate, trainData=trainAmplitudes, cl=trainCl, k=3)
```

Again, it can be checked that there is a new classification method:

```
commonClassificationMethod(plate)
```

```
## [1] "None"          "Cluster"       "thresholds"    "kmeans"
## [5] "kmeansMahRain" "knn"
```

This classification can be plotted in the same way as before:

```
dropletPlot(plate, cMethod="knn")
```

![](data:image/png;base64...)

## 12.2 Classifying the four ‘corners’ of a plot (`gridClassify`)

There may be some datasets where the above classification techniques do not
work satisfactorily. As long as the main clusters have good separation from
each other, the `gridClassify` method may be used. This method defines four
‘corner’ regions with linear cut-offs in each channel; the remaining droplets
are labelled as “Rain”. To see how this works, consider the following (crude)
example:

```
plate <- gridClassify(plate,
                      ch1NNThreshold=6500, ch2NNThreshold=2110,
                      ch1NPThreshold=5765, ch2NPThreshold=5150,
                      ch1PNThreshold=8550, ch2PNThreshold=2450,
                      ch1PPThreshold=6700, ch2PPThreshold=3870)
dropletPlot(plate, cMethod="grid")
```

![](data:image/png;base64...)

This is not a particularly great classification, but this option exists should
it be required. It is tedious to set the parameters above, so it may be helpful
to use the [Shiny app](#shiny-app-for-non-r-users) to aid in this process.

## 12.3 Adding rain with `sdRain`

Since droplets tend to cluster into ellipse-like structures, the
`mahalanobisRain` method should usually suffice for labelling ambiguous
droplets as “Rain”. An alternative way is to use the mean and standard
deviation of each of the clusters (in both channels). To do this, use the
`sdRain` method:

```
plate <- sdRain(plate, cMethod="kmeans")
dropletPlot(plate, cMethod="kmeansSdRain")
```

![](data:image/png;base64...)

As is the case with Mahalanobis rain, the rain levels could be tweaked a little:

```
plate <- sdRain(plate, cMethod="kmeans",
                errorLevel=list(NN=5, NP=5, PN=3, PP=3))
dropletPlot(plate, cMethod="kmeansSdRain")
```

![](data:image/png;base64...)

## 12.4 Custom classifications

If you wish to use your own classification methods, the droplet information
would need to be extracted and can also be added to the `ddpcrPlate` object.
The basic workflow would be:

1. Retrieve the droplet amplitudes using `amplitudes` and combine them in a
   single data frame:

   ```
   allDrops <- amplitudes(plate)
   allDrops <- do.call(rbind, amplitudes)
   ```
2. Classify the droplets using your own method:

   ```
   allDrops$class <- someClassificationMethod(allDrops)
   ```
3. Add the classification to `plate`:

   ```
   plateClassification(plate, cMethod="nameOfCMethod") <- allDrops$class
   ```

The `ddpcrPlate` class only understands classifications if it is a factor with
levels `c("NN", "NP", "PN", "PP", "Rain", "N/A")`. If the result of your custom
classification method returns a vector/factor with four classes (with maybe
some “Rain” or “N/A”), then the vector/factor may be relabelled by:

```
relabelClasses(allDrops, classCol="class")
```

If there are fewer than four classes, `relabelClasses` will try to guess which
of the classes are present. To help the method correctly label the clusters,
set the `presentClasses` parameter:

```
relabelClasses(allDrops, classCol="class", presentClasses=c("NN", "NP", "PN"))
```

# 13 Appendix

## 13.1 Shiny-based GUI for non-R users

A Shiny app is included in the package, which provides a GUI that allows
interactive use of the package for ddPCR analysis. This can be run from an
interactive R session using:

```
shinyVisApp()
```

This can also be accessed at
<http://shiny.cruk.manchester.ac.uk/twoddpcr/>.

To run on your own Shiny server, a file called `app.R` should be created with
the following code:

```
library(shiny)
library(twoddpcr)

# Disable warnings.
options(warn=-1)

shiny::shinyApp(
  ui=shinyVisUI(),
  server=function(input, output, session)
  {
    shinyVisServer(input, output, session)
  }
)
```

## 13.2 Exporting droplet amplitudes from *QuantaSoft* to CSV files

If you have run your own two channel ddPCR experiments that have produced a
*QuantaSoft* Plate (`.qlp`) file, then the raw droplet amplitudes can be
extracted for use with the `twoddpcr` package. To do this:

1. Run *QuantaSoft*.
2. Load a plate (from a *QuantaSoft* Plate `.qlp` file).
3. Select the samples to use by using the `Ctrl` and/or `Shift` key with the
   mouse.
4. Click `Options` in the top-right.
5. Click `Export Amplitude and Cluster Data`.
6. Select a location to export the amplitude files to.
   This can take a while to complete.

The amplitudes will be exported to a number of CSV files in the chosen
location, with one file for each well. Each file is named
`<PlateName>_<WellNumber>_Amplitude.csv`, where `<PlateName>` is the name of
the `.qlp` file without the extension and `<WellNumber>` is the position in the
plate, e.g. `B03`. These amplitude files are now ready to be loaded using the
`twoddpcr` package.

## 13.3 Using other datasets

The example in this vignette can be followed using a different dataset, such as
those from your own ddPCR experiments. To load a dataset:

1. Follow the instructions in the [exporting droplet amplitudes
   section](#exporting-droplet-amplitudes-from-quantasoft-to-csv-files).
2. The droplets can be imported using:

   ```
   plate <- ddpcrPlate(well="data/amplitudes")
   ```

   Here, `data/amplitudes` should be changed to the directory containing the
   droplet amplitude files.

## 13.4 Problems reading files

While loading data, the following error message may appear:

```
Error in read.table(file = file, header = header, sep = sep, quote = quote,  :
  duplicate 'row.names' are not allowed
```

Possible solution: The number of columns in the header row might differ from
the number of columns in the other rows. For example, there may be extra
commas/tabs at the end of some lines. In such cases, the removal of ‘empty’
columns should fix the problem.

# 14 Citing `twoddpcr`

If you use the `twoddpcr` package in your work, please cite the [Bioinformatics
paper](http://dx.doi.org/10.1093/bioinformatics/btx308):

```
citation("twoddpcr")
```

```
## To cite twoddpcr in publications, please use:
##
##   Anthony Chiu, Mahmood Ayub, Caroline Dive, Ged Brady, Crispin J
##   Miller; twoddpcr: An R/Bioconductor package and Shiny app for Droplet
##   Digital PCR analysis. Bioinformatics 2017 btx308. doi:
##   10.1093/bioinformatics/btx308
##
## A BibTeX entry for LaTeX users is
##
##   @Article{,
##     author = {Anthony Chiu and Mahmood Ayub and Caroline Dive and Ged Brady and Crispin Miller},
##     title = {twoddpcr: An R/Bioconductor package and Shiny app for Droplet Digital PCR analysis},
##     journal = {Bioinformatics},
##     publisher = {Oxford University Press},
##     year = {2017},
##   }
```

# 15 Further reading

(**???**) describes how to use R in order to analyse ddPCR data using the
`dpcR` package.

# 16 Session information

Here is the output of `sessionInfo()` on the system on which this document
was compiled:

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
## [1] reshape2_1.4.4   ggplot2_4.0.0    twoddpcr_1.34.0  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10         generics_0.1.4      class_7.3-23
##  [4] stringi_1.8.7       lattice_0.22-7      digest_0.6.37
##  [7] magrittr_2.0.4      evaluate_1.0.5      grid_4.5.1
## [10] RColorBrewer_1.1-3  bookdown_0.45       fastmap_1.2.0
## [13] Matrix_1.7-4        plyr_1.8.9          jsonlite_2.0.0
## [16] tinytex_0.57        promises_1.4.0      BiocManager_1.30.26
## [19] mgcv_1.9-3          scales_1.4.0        jquerylib_0.1.4
## [22] cli_3.6.5           shiny_1.11.1        rlang_1.1.6
## [25] crayon_1.5.3        splines_4.5.1       withr_3.0.2
## [28] cachem_1.1.0        yaml_2.3.10         otel_0.2.0
## [31] tools_4.5.1         dplyr_1.1.4         httpuv_1.6.16
## [34] BiocGenerics_0.56.0 vctrs_0.6.5         R6_2.6.1
## [37] mime_0.13           magick_2.9.0        stats4_4.5.1
## [40] lifecycle_1.0.4     stringr_1.5.2       S4Vectors_0.48.0
## [43] pkgconfig_2.0.3     pillar_1.11.1       bslib_0.9.0
## [46] hexbin_1.28.5       later_1.4.4         gtable_0.3.6
## [49] glue_1.8.0          Rcpp_1.1.0          xfun_0.53
## [52] tibble_3.3.0        tidyselect_1.2.1    knitr_1.50
## [55] dichromat_2.0-0.1   farver_2.1.2        xtable_1.8-4
## [58] nlme_3.1-168        htmltools_0.5.8.1   rmarkdown_2.30
## [61] labeling_0.4.3      compiler_4.5.1      S7_0.2.0
```

# 17 References

# Appendix