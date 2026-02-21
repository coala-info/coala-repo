# Using synapsis

Lucy McNeill

#### 30 October, 2025

# Contents

* [1 About `synapsis`](#about-synapsis)
* [2 Getting started](#getting-started)
  + [2.1 installing `synapsis` through bioconductor](#installing-synapsis-through-bioconductor)
  + [2.2 installing `synapsis` from GitHub](#installing-synapsis-from-github)
  + [2.3 loading synapsis](#loading-synapsis)
  + [2.4 checking documentation](#checking-documentation)
  + [2.5 Data preparation](#data-preparation)
    - [2.5.1 Foci channel](#foci-channel)
    - [2.5.2 Synaptonemal complex channel](#synaptonemal-complex-channel)
    - [2.5.3 Comment on resolution and size](#comment-on-resolution-and-size)
* [3 calling `synapsis` functions on sample image](#calling-synapsis-functions-on-sample-image)
  + [3.1 Cropping routine](#cropping-routine)
    - [3.1.1 without cell separation using watershed](#without-cell-separation-using-watershed)
    - [3.1.2 with cell separation using watershed](#with-cell-separation-using-watershed)
  + [3.2 Getting pachytene](#getting-pachytene)
  + [3.3 Counting foci](#counting-foci)
    - [3.3.1 reading the data frame](#reading-the-data-frame)
* [4 Summary](#summary)
* [5 Next steps](#next-steps)
* [References](#references)

# 1 About `synapsis`

`synapsis` is an R package which is designed for the objective and reproducible analysis of meiotic immunofluorescence data.

Meiosis is a special type of cell division where the chromosome number is halved prior to fertilisation in sexually reproducing species. The accurate halving of chromosomes is facilitated through large scale chromosome exchanges that are referred to as meiotic crossovers. The necessary precursors to crossovers are meiotic DNA double-strand breaks. There is very tight control of DNA double-strand break numbers, timing and positioning. Similarly the repair of these breaks and the intermediate steps to crossover formation are under strict control. All of these events take place on a meiosis-specific chromosomal structure, which is referred to as the synaptonemal complex. These different meiosis-specific molecular events and structures can be visualised with antibody labelling and these signals are what `synapsis` analyses.

There are three common types of labelling patterns that are considered in meiotic immunofluorescence data sets:

1. **The synaptonemal complex** - These linear and thread-like structures are specific to cells which are in meiotic prophase I. A good description of the mouse synaptonemal complex can be found here (Bisig et al. [2012](#ref-Bisig2012)).
2. **Foci** - A number of common proteins that are involved in meiotic double-strand break repair form foci when visualised with immunofluoresence. Some common examples of include the visualisation of the dynamic loading and unloading of RAD51, DMC1, MSH4, MLH1 (Cole et al. [2012](#ref-Cole2012)). Foci can also be seen when visualising relatively fixed chromosomal structures such as centromeres and telomeres.
3. **DNA** - DNA is commonly visualised with a stain referred to as DAPI (4′,6-diamidino-2-phenylindole). As nearly all cells contain DNA, DAPI-stained cells are not necessarily in meiosis, but DAPI is still an informative cytological marker.

One of the more common uses of meiotic immunofluorescence data will be a quantitative analysis of some aspect of double-strand break repair. The challenge for manual quantification of foci relates to subjective and undocumented choices:
What criteria are required to consider the data from one cell? E.g. how is meiotic sub-stage determined? How is a good or bad quality image determined?
How is a foci defined? E.g. size, intensity, signal to background ratio.

Synapsis also lays the foundation for more complex analyses. For example `synapsis` generates output that is compatible with machine learning approaches. In future versions of `synapsis` it will be possible to measure the relative positioning of multiple foci on the same synaptonemal complex, which is another common task that is performed manually by researchers.

A number of good open-source packages exist for the analysis of immunofluoresence data from somatic cells such as the R packages [`EBImage`](https://github.com/aoles/EBImage), [`colocr`](https://cran.r-project.org/web/packages/colocr/vignettes/using_colocr.html), [`ColocalizR`](https://github.com/kroemerlab/ColocalizR), and the code-free tool [`CellProfiler`](https://cellprofiler.org/). We recognise the value of these software and `synapsis` makes significant use of EBImage in particular. Objective and reproducible analyses are essential in research.

# 2 Getting started

To run this tutorial, you will need the following packages:

* knitr
* rmarkdown

```
library(knitr)
library(rmarkdown)
```

```
##
## Attaching package: 'rmarkdown'
```

```
## The following objects are masked from 'package:BiocStyle':
##
##     html_document, md_document, pdf_document
```

## 2.1 installing `synapsis` through bioconductor

Make sure you have the BiocManager package installed.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
```

Then type the following into the Rstudio console:

```
BiocManager::install("synapsis")
```

## 2.2 installing `synapsis` from GitHub

To install `synapsis` from GitHub, you will need:

* devtools

```
library(devtools)
```

You can install the development version of `synapsis` directly from the github repository by pasting the following into the Rstudio console:

```
devtools::install_git('https://github.com/mcneilllucy/synapsis', dependencies  = TRUE)
```

## 2.3 loading synapsis

```
library(synapsis)
```

## 2.4 checking documentation

You can type

```
??auto_crop_fast
```

to explore the first function we will use in the “help” window in Rstudio.

## 2.5 Data preparation

For the moment, we will use the example images which come with synapsis.

```
path = paste0(system.file("extdata",package = "synapsis"))
```

### 2.5.1 Foci channel

```
library(EBImage)
```

Look at the MLH3 channel

```
file_MLH3 <- paste0(path,"/MLH3rabbit488_SYCP3mouse594_fancm_fvb_x_fancm_bl6_724++_slide01_006-MLH3.tif")
image_MLH3 <- readImage(file_MLH3)
```

```
display(2*image_MLH3)
```

### 2.5.2 Synaptonemal complex channel

```
file_SYCP3 <- paste0(path,"/MLH3rabbit488_SYCP3mouse594_fancm_fvb_x_fancm_bl6_724++_slide01_006-SYCP3.tif")
image_SYCP3 <- readImage(file_SYCP3)
```

```
display(2*image_SYCP3)
```

### 2.5.3 Comment on resolution and size

Many of the input parameters in synapsis are in pixel units. It’s good to get a feel of this before you start analysing them. Let’s

```
cat("dimension of image:", dim(image_MLH3)[1], " x ", dim(image_MLH3)[2], sep = " ")
```

```
## dimension of image: 750  x  750
```

or size

```
mb = 1e06
cat("file size in mb:", file.size(file_MLH3)/mb, sep = " ")
```

```
## file size in mb: 2.250206
```

The image is 750 x 750 pixels and 2.25mb. If we recall the SYCP3 channel image, keeping in mind that it is 750 pixels wide, a single cell looks like it takes up roughly 1/8th of the width, i.e. 125 pixels. Keeping this approximate **width of a cell** in **pixels** will come in handy when determining input parameters for your own images.

# 3 calling `synapsis` functions on sample image

Here we will demonstrate the functionality of synapsis. Given an image whose *foci* channel (MLH3) is shown in `MLH3rabbit488_SYCP3mouse594_fancm_fvb_x_fancm_bl6_724++_slide01_006-MLH3.tif`, and *synaptonemal complex* channel (SYCP3) shown in `MLH3rabbit488_SYCP3mouse594_fancm_fvb_x_fancm_bl6_724++_slide01_006-SYCP3.tif`, we can:

* Crop the image around individual cells
* Determine whether these cells are in the pachytene phase (optional)
* Count the number of foci per cell

which are currently the three main features of `synapsis`.

Some notable features mentioned in the tutorial are:

* Separate cells which are close / overlapping
* Make a note of whether the image is likely have a good count compared with a manual count

## 3.1 Cropping routine

### 3.1.1 without cell separation using watershed

```
auto_crop_fast(path, annotation = "on", max_cell_area = 30000, min_cell_area = 7000, file_ext = "tif")
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

```
## [1] "couldn't crop it since cell is on the edge. Neglected the following mask of a cell candidate:"
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

```
## [1] "I cropped this cell:"
```

![](data:image/png;base64...)

```
## [1] "using this mask"
```

![](data:image/png;base64...)

```
## [1] "whose cell number is"
## [1] 2
## out of 1 images, we got 1 viable cells
```

Here we call path, plus other optional parameters (that would otherwise take on default values). But only path is essential. This is because auto\_crop\_fast has built-in default values which are assumed when the user doesn’t specify.

A crops folder with three channels per “viable cell” should have been generated inside the folder where these images are kept i.e. in path.

### 3.1.2 with cell separation using watershed

We will redo this with different settings, so let’s delete the crops folder.

```
unlink(paste0(path,"/crops-RGB/"), recursive = TRUE)
unlink(paste0(path,"/crops/"), recursive = TRUE)
```

Now we will see one of the useful features of synapsis. It can separate cells by making use of EBImage’s watershed and distmap functions. If we set crowded\_cells = TRUE, then

```
auto_crop_fast(path, annotation = "on", max_cell_area = 30000, min_cell_area = 7000, file_ext = "tif",crowded_cells = TRUE)
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

```
## [1] "from the file:"
## [1] "MLH3rabbit488_SYCP3mouse594_fancm_fvb_x_fancm_bl6_724++_slide01_006"
```

![](data:image/png;base64...)

```
## [1] "I cropped this cell:"
```

![](data:image/png;base64...)

```
## [1] "using this mask"
```

![](data:image/png;base64...)

```
## [1] "whose cell number is"
## [1] 1
```

![](data:image/png;base64...)

```
## [1] "I cropped this cell:"
```

![](data:image/png;base64...)

```
## [1] "using this mask"
```

![](data:image/png;base64...)

```
## [1] "whose cell number is"
## [1] 2
```

![](data:image/png;base64...)

```
## [1] "I cropped this cell:"
```

![](data:image/png;base64...)

```
## [1] "using this mask"
```

![](data:image/png;base64...)

```
## [1] "whose cell number is"
## [1] 3
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

```
## out of 1 images, we got 3 viable cells
```

Instead of 1 cell (before we said that crowded\_cells = TRUE), 3 cells were identified.

## 3.2 Getting pachytene

```
SYCP3_stats <- get_pachytene(path,ecc_thresh = 0.8, area_thresh = 0.04, annotation = "on",file_ext = "tif")
```

```
## [1] "decided the following is pachytene"
```

![](data:image/png;base64...)

```
## [1] "decided the following is pachytene"
```

![](data:image/png;base64...)

```
## number of cells kept 2
```

SYCP3\_stats is a data frame summarizing some features of the cells classified as pachytene.

The data frame is populated with information such as the image file name where the data comes from. This will be more useful when you have many images in a folder. Then there are columns of output from the cells that were identified. You will notice a column for genotype. The default settings assume that “++” or “–” are present in the file name. However these can be modified with the parameters “WT\_str” and “KO\_str”.

## 3.3 Counting foci

Now that we have the cropped images, and those which have been selected as our stage of interest (pachytene), we can count foci per cell.

Note the option crowded\_foci = FALSE, because for our antibodies we only typically expect a couple dozen foci per cell. If you are dealing with an antibody that typically has in excess of ~100 foci per cell, e.g. DMC1, it’s recommended to use crowded\_foci = TRUE.
.

```
foci_counts <- count_foci(path,offset_factor = 8, brush_size = 3, offset_px = 0.6, brush_sigma = 3, annotation = "on", stage = "pachytene",file_ext = "tif", watershed_stop= "on",  crowded_foci = FALSE, C1 = 0.03, disc_size_foci = 9)
```

```
##
##  at file /tmp/RtmpAzAlOB/Rinst3745ba3da46c83/synapsis/extdata/crops/pachytene/MLH3rabbit488_SYCP3mouse594_fancm_fvb_x_fancm_bl6_724++_slide01_006-crop-2-SYCP3.tif
##  cell counter is 1
##  original images
```

![](data:image/png;base64...)![](data:image/png;base64...)

```
##
##  displaying resulting foci count plots. Overlay two channels:
```

![](data:image/png;base64...)

```
##
##  displaying resulting masks. Overlay two masks:
```

![](data:image/png;base64...)

```
##
##  coincident foci:
```

![](data:image/png;base64...)

```
##
##  two channels, only coincident foci
```

![](data:image/png;base64...)

```
##
##  which counts this many foci: 23
##  number of alone foci 7
##  at file /tmp/RtmpAzAlOB/Rinst3745ba3da46c83/synapsis/extdata/crops/pachytene/MLH3rabbit488_SYCP3mouse594_fancm_fvb_x_fancm_bl6_724++_slide01_006-crop-3-SYCP3.tif
##  cell counter is 2
##  original images
```

![](data:image/png;base64...)![](data:image/png;base64...)

```
##
##  displaying resulting foci count plots. Overlay two channels:
```

![](data:image/png;base64...)

```
##
##  displaying resulting masks. Overlay two masks:
```

![](data:image/png;base64...)

```
##
##  coincident foci:
```

![](data:image/png;base64...)

```
##
##  two channels, only coincident foci
```

![](data:image/png;base64...)

```
##
##  which counts this many foci: 28
##  number of alone foci 9
```

### 3.3.1 reading the data frame

Let’s look at the results:

```
print(foci_counts)
```

```
##                                                                                                                                                    filename
## 1 /tmp/RtmpAzAlOB/Rinst3745ba3da46c83/synapsis/extdata/crops/pachytene/MLH3rabbit488_SYCP3mouse594_fancm_fvb_x_fancm_bl6_724++_slide01_006-crop-2-SYCP3.tif
## 2 /tmp/RtmpAzAlOB/Rinst3745ba3da46c83/synapsis/extdata/crops/pachytene/MLH3rabbit488_SYCP3mouse594_fancm_fvb_x_fancm_bl6_724++_slide01_006-crop-3-SYCP3.tif
##   cell_no genotype     stage foci_count          sd_foci        mean_foci
## 1       1      +/+ pachytene         23 3.58621242263058 6.96666666666667
## 2       2      +/+ pachytene         28 4.53763044882349 10.5135135135135
##   median_foci            mean_px          median_px        percent_on
## 1           8 0.0192701445994088 0.0117647058823529 0.880382775119617
## 2          11 0.0289901843781464 0.0196078431372549 0.794344473007712
##                sd_px lone_foci                  comments verdict
## 1 0.0241255328238543         7 meets crisp-ness criteria    keep
## 2  0.048167318981632         9 meets crisp-ness criteria    keep
##                   C1
## 1 0.0214486388913312
## 2 0.0148827521147477
```

foci\_counts is a data frame summarizing some features (including foci counts) of the cells classified as pachytene.

The “verdict” column recommends to keep or discard an image based on how it compares to the “crispness criteria” C1 (a measurement of how uniformly sized the foci identified are… empirically indicative of a “clear” image with concident foci and low background).

This is currently how we can identify (to ignore) cells with low signal / high background etc in the foci channel which passed through the automated pipeline.

Let’s clean up the crops folders we just generated..

```
unlink(paste0(path,"/crops-RGB/"), recursive = TRUE)
unlink(paste0(path,"/crops/"), recursive = TRUE)
```

# 4 Summary

In this tutorial, we have demonstrated the main functions of the synapsis package. These were:

1. cropping images around cell candidates, where the package is able to identify individual cells even when they are close / touching, after inputting the location of your raw images (which have already been separated into foci and synaptonemal complex channels).

The output is stored in a folder called “crops” with square images (from all channels) of the cell candidates. Note that a crops-RGB folder is also generated for you to look at the overlapping channels in colour, for your own troubleshooting purposes.

2. Identifying cells in the pachytene phase. This is optional and was made for niche biological problems that are relevant to this meiotic substage.

If you use this, a folder called “pachytene” inside the folder “crops” is generated with the pachytene cell candidates. Make sure you specify this for the counting function (3) with stage = pachytene, so that `synapsis` knows to look in this folder.

3. counting coincident foci on synaptonemal complexes.

The output is a data frame, which includes a measure of the “crispness” of the foci channel image. Related to this is a recommendation to keep or discard the cell candidate.

The process outlined in (1)-(3) may be second nature to biologists who work with microscopy, and images that pass through this automated pipeline would be discarded by a real person much earlier. However, with an automated package, these decisions are recorded along with a quantification of real signal vs background / noise. The user can also change this criteria to be e.g. less strict and allow more noisy images (in the foci channel) to be kept.

# 5 Next steps

Before trying to repeat the same process on your own images, let’s note some things. It is recommended to use high-resolution images (e.g. more than 4MB and 1000x1000 pixels) so that underlying smoothing operations do not erase small foci that you may aim to detect. This may require some testing on a small number of images to determine the appropriate balance between computational efficiency (if images are excessively large) and throughput. To run a function with a small number of images you can set the parameter test\_amount within the function auto\_crop\_fast.

Next, make sure you are aware of your file extensions, and when you call functions on images that are not .jpeg, to specify e.g. file\_ext = tif

Finally, there are many optional inputs to the functions. If the default settings do not generate the desired results, progressively try and alter different parameters by 10’s of percent at a time. The annotation = “on” option is designed for you to knit a notebook which steps you through all of the decisions being made, so that you can troubleshoot parameter values.

# References

Bisig, C. Gaston, Michel F. Guiraldelli, Anna Kouznetsova, Harry Scherthan, Christer Höög, Dean S. Dawson, and Roberto J. Pezza. 2012. “Synaptonemal complex components persist at centromeres and are required for homologous centromere pairing in mouse spermatocytes.” *PLoS Genetics* 8 (6). <https://doi.org/10.1371/journal.pgen.1002701>.

Cole, Francesca, Liisa Kauppi, Julian Lange, Ignasi Roig, Raymond Wang, Scott Keeney, and Maria Jasin. 2012. “Homeostatic control of recombination is implemented progressively in mouse meiosis.” *Nature Cell Biology* 14 (4): 424–30. <https://doi.org/10.1038/ncb2451>.