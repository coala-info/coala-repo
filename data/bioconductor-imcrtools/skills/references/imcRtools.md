# Tools for IMC data analysis

Nils Eling1,2\*, Lasse Meyer1,2\*\* and Daniel Schulz1,2\*\*\*

1Department for Quantitative Biomedicine, University of Zurich
2Institute for Molecular Health Sciences, ETH Zurich

\*nils.eling@dqbm.uzh.ch
\*\*lasse.meyer@@uzh.ch
\*\*\*daniel.schulz@@uzh.ch

#### 30 October 2025

#### Abstract

This R package supports the handling and analysis of imaging mass cytometry
and other highly multiplexed imaging data. The main functionality includes
reading in single-cell data after image segmentation and measurement, data
formatting to perform channel spillover correction and a number of spatial
analysis approaches. First, cell-cell interactions are detected via spatial
graph construction; these graphs can be visualized with cells representing
nodes and interactions representing edges. Furthermore, per cell, its direct
neighbours are summarized to allow spatial clustering. Per image/grouping
level, interactions between types of cells are counted, averaged and
compared against random permutations. In that way, types of cells that
interact more (attraction) or less (avoidance) frequently than expected by
chance are detected.

#### Package

imcRtools 1.16.0

# 1 Introduction

This vignette gives an introduction to handling and analyzing imaging
mass cytometry (IMC) and other highly-multiplexed imaging data in R. The
`imcRtools` package relies on expression and morphological features
extracted from multi-channel images using corresponding segmentation
masks. A description of data types and segmentation approaches can be
found below ([data types](#dataTypes), [segmentation](#segmentation)).
However, due to shared data structures, the functionalities of the
`imcRtools` package are applicable to most highly multiplexed imaging
modalities.

## 1.1 Overview

The `imcRtools` package exports functions and example data to perform
the following analyses:

1. [Read in pre-processed data](#read-in-data)
2. [Perform spillover correction for IMC data](#spillover)
3. [Build](#build-graph) and [visualize](#viz-cells) spatial graphs
4. [Aggregate across neighbouring cells](#aggregate-neighbors) for
   spatial clustering
5. [Detect spatial patches](#patch-detection) of similar cell-types
6. [Test the attraction or avoidance between
   celltypes](#test-neighborhood)

To highlight the usability of these function, the `imcRtools` package
also exports a number of [test data files](#test-data).

## 1.2 Highly multiplexed imaging

Highly multiplexed imaging techniques (Bodenmiller [2016](#ref-Bodenmiller2016)) such as imaging
mass cytometry (IMC) (Giesen et al. [2014](#ref-Giesen2014)), multiplexed ion beam imaging (MIBI)
(Angelo et al. [2014](#ref-Angelo2014)) and cyclic immunofluorescence techniques (Lin et al. [2018](#ref-Lin2018), @Gut2018) acquire read-outs of the expression of tens of protein in a
spatially resolved manner. After technology-dependent data
pre-processing, the raw data files are comparable: multi-channel images
for the dimensions `x`, `y`, and `c`, where `x` and `y` define the
number of pixels (`x * y`) per image and `c` the number of proteins
(also refered to as “markers”) measured per image. More info on the
[data types](#dataTypes) and [further pre-processing](#segmentation) can
be found below.

Increased multiplexity compared to epitope-based techniques is achieved
using single-cell resolved spatial transcriptomics techniques including
MERFISH (Chen et al. [2015](#ref-Chen2015)) and seqFISH (Lubeck et al. [2014](#ref-Lubeck2014)). However, data produced by
these techniques required different pre-processing steps. Nevertheless,
analysis performed on the single-cell level is equally applicable.

### 1.2.1 Imaging mass cytometry

IMC (Giesen et al. [2014](#ref-Giesen2014)) is a highly multiplexed imaging approach to measure
spatial protein abundance. In IMC, tissue sections on slides are stained
with a mix of around 40 metal-conjugated antibodies prior to laser
ablation with \(1\mu{}m\) resolution. The ablated material is transferred
to a mass cytometer for time-of-flight detection of the metal ions
(Giesen et al. [2014](#ref-Giesen2014)). At an ablation frequency of 200Hz, a 1mm x 1mm region can
be acquired within 1.5 hours.

### 1.2.2 Data types

In the case of IMC, the raw data output are .mcd files containing all
acquired regions per slide. During image pre-prcoessing these files are
converted into individual multi-channel .tiff and
[OME-TIFF](https://docs.openmicroscopy.org/ome-model/5.6.3/ome-tiff/)
files. These file formats are supported by most open-source and
commercial image analysis software, such as
[Fiji](https://imagej.net/software/fiji/),
[QuPath](https://qupath.github.io/) or [napari](https://napari.org/).

In R, these .tiff files can be read into individual
[Image](https://bioconductor.org/packages/release/bioc/vignettes/EBImage/inst/doc/EBImage-introduction.html#3_Image_data_representation)
objects or combined into a
[CytoImageList](https://www.bioconductor.org/packages/release/bioc/vignettes/cytomapper/inst/doc/cytomapper.html#5_The_CytoImageList_object)
object supported by the
[cytomapper](https://www.bioconductor.org/packages/release/bioc/html/cytomapper.html)
package.

### 1.2.3 Segmentation and feature extraction

The pixel resolution of most highly multiplexed imaging technologies
including IMC support the detection of cellular structures. Therefore, a
common processing step using multi-channel images is object
segmentation. In this vignette, objects are defined as cells; however,
also larger scale structures could be segmented.

There are multiple different image segmentation approaches available.
However, `imcRtools` only supports direct reader functions for two
segmentation strategies developed for highly multiplexed imaging
technologies:

1. The
   [ImcSegmentationPipeline](https://github.com/BodenmillerGroup/ImcSegmentationPipeline)
   has been developed to give the user flexibility in how to perform
   channel selection and image segmentation. The underlying principle
   is to train a pixel classifier (using
   [ilastik](https://www.ilastik.org/)) on a number of selected
   channels to perform probabilistic classification of each pixel into:
   background, cytoplasm and nucleus. Based on these classification
   probabilities a [CellProfiler](https://cellprofiler.org/) pipeline
   performs cell segmentation and feature extraction.
2. A containerized version of this pipeline is implemented in
   [steinbock](https://github.com/BodenmillerGroup/steinbock).
   `steinbock` further supports segmentation via the use of `Mesmer`
   from the `DeepCell` library (Greenwald et al. [2021](#ref-Greenwald2021)).

While the output of both approaches is structured differently, the
exported features are comparable:

1. per cell: channel intensity, morphology and location
2. cell-cell interactions exported as graph

By combining these with availabel channel information, the data can be
read into a *[SpatialExperiment](https://bioconductor.org/packages/3.22/SpatialExperiment)* or
*[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* object (see
[below](#read-in-data)).

# 2 Example data

The `imcRtools` package contains a number of example data generated by
the Hyperion imaging system for different purposes. The following
section gives an overview of these files.

## 2.1 For spillover correction

To highlight the use of the `imcRtools` package for spillover
correction, we provide four .txt files containing pixel intensities of
four spotted metals.

Please refer to the [spillover correction](#spillover) section for full
details.

These files are accessible via:

```
path <- system.file("extdata/spillover", package = "imcRtools")

list.files(path, recursive = TRUE)
```

```
## [1] "Dy161.txt" "Dy162.txt" "Dy163.txt" "Dy164.txt"
```

## 2.2 Raw data in form of .txt files

IMC generates .mcd files storing the raw data or all acquired regions of
interest (ROI). In addition, the raw pixel values are also stored in
individual .txt files per ROI.

To highlight reading in raw data in form of .txt files, the `imcRtools`
contains 3 sample acquisitions:

```
txt_files <- list.files(system.file("extdata/mockData/raw",
                                    package = "imcRtools"))
txt_files
```

```
## [1] "20210305_NE_mockData2_ROI_001_1.txt" "20210305_NE_mockData2_ROI_002_2.txt"
## [3] "20210305_NE_mockData2_ROI_003_3.txt"
```

## 2.3 ImcSegmentationPipeline output data

IMC data preprocessing and segmentation can be performed using the
[ImcSegmentationPipeline](https://github.com/BodenmillerGroup/ImcSegmentationPipeline).
It generates a number of `.csv` files containing object/cell-specific
and image-specific metadata.

The `imcRtools` package exports the `read_cpout` function as convenient
reader function for outputs generated by the `ImcSegmentationPipeline`.
For demonstration purposes, `imcRtools` contains the output of running
the pipeline on a small example dataset:

```
path <- system.file("extdata/mockData/cpout", package = "imcRtools")

list.files(path, recursive = TRUE)
```

```
## [1] "Experiment.csv"           "Image.csv"
## [3] "Object_relationships.csv" "cell.csv"
## [5] "panel.csv"                "var_Image.csv"
## [7] "var_cell.csv"
```

## 2.4 steinbock output data

The [steinbock](https://github.com/BodenmillerGroup/steinbock) pipeline
can be used to process, segment and extract features from IMC data. For
more information, please refer to its
[documentation](https://bodenmillergroup.github.io/steinbock/).

To highlight the functionality of `imcRtools` to read in single-cell
data generated by `steinbock`, we provide a small toy dataset available
at:

```
path <- system.file("extdata/mockData/steinbock", package = "imcRtools")

list.files(path, recursive = TRUE)
```

```
##  [1] "images.csv"
##  [2] "intensities/20210305_NE_mockData1_001.csv"
##  [3] "intensities/20210305_NE_mockData1_002.csv"
##  [4] "intensities/20210305_NE_mockData1_003.csv"
##  [5] "intensities/20210305_NE_mockData2_001.csv"
##  [6] "intensities/20210305_NE_mockData2_002.csv"
##  [7] "intensities/20210305_NE_mockData2_003.csv"
##  [8] "intensities/20210305_NE_mockData3_001.csv"
##  [9] "intensities/20210305_NE_mockData3_002.csv"
## [10] "intensities/20210305_NE_mockData3_003.csv"
## [11] "intensities/20210305_NE_mockData4_001.csv"
## [12] "intensities/20210305_NE_mockData4_002.csv"
## [13] "intensities/20210305_NE_mockData4_003.csv"
## [14] "intensities/20210305_NE_mockData5_001.csv"
## [15] "intensities/20210305_NE_mockData5_002.csv"
## [16] "intensities/20210305_NE_mockData5_003.csv"
## [17] "neighbors/20210305_NE_mockData1_001.csv"
## [18] "neighbors/20210305_NE_mockData1_002.csv"
## [19] "neighbors/20210305_NE_mockData1_003.csv"
## [20] "neighbors/20210305_NE_mockData2_001.csv"
## [21] "neighbors/20210305_NE_mockData2_002.csv"
## [22] "neighbors/20210305_NE_mockData2_003.csv"
## [23] "neighbors/20210305_NE_mockData3_001.csv"
## [24] "neighbors/20210305_NE_mockData3_002.csv"
## [25] "neighbors/20210305_NE_mockData3_003.csv"
## [26] "neighbors/20210305_NE_mockData4_001.csv"
## [27] "neighbors/20210305_NE_mockData4_002.csv"
## [28] "neighbors/20210305_NE_mockData4_003.csv"
## [29] "neighbors/20210305_NE_mockData5_001.csv"
## [30] "neighbors/20210305_NE_mockData5_002.csv"
## [31] "neighbors/20210305_NE_mockData5_003.csv"
## [32] "panel.csv"
## [33] "regionprops/20210305_NE_mockData1_001.csv"
## [34] "regionprops/20210305_NE_mockData1_002.csv"
## [35] "regionprops/20210305_NE_mockData1_003.csv"
## [36] "regionprops/20210305_NE_mockData2_001.csv"
## [37] "regionprops/20210305_NE_mockData2_002.csv"
## [38] "regionprops/20210305_NE_mockData2_003.csv"
## [39] "regionprops/20210305_NE_mockData3_001.csv"
## [40] "regionprops/20210305_NE_mockData3_002.csv"
## [41] "regionprops/20210305_NE_mockData3_003.csv"
## [42] "regionprops/20210305_NE_mockData4_001.csv"
## [43] "regionprops/20210305_NE_mockData4_002.csv"
## [44] "regionprops/20210305_NE_mockData4_003.csv"
## [45] "regionprops/20210305_NE_mockData5_001.csv"
## [46] "regionprops/20210305_NE_mockData5_002.csv"
## [47] "regionprops/20210305_NE_mockData5_003.csv"
## [48] "steinbock.sh"
```

The example data related to the `ImcSegmentationPipeline` and
`steinbock` can also be accessed
[online](https://github.com/BodenmillerGroup/TestData/tree/main/datasets/210308_ImcTestData).

# 3 Read in IMC data

The `imcRtools` package supports reading in data generated by the
[ImcSegmentationPipeline](https://github.com/BodenmillerGroup/ImcSegmentationPipeline)
or [steinbock](https://github.com/BodenmillerGroup/steinbock) pipeline.

To read in the outpout data into a
*[SpatialExperiment](https://bioconductor.org/packages/3.22/SpatialExperiment)* or
*[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)*, the `imcRtools` package
exports the `read_cpout` function.

By default, the single-cell data is read into a
*[SpatialExperiment](https://bioconductor.org/packages/3.22/SpatialExperiment)* object. Here, the extracted
channel- and cell-specific intensities are stored in the `counts(spe)`
slot. All morphological features are stored in `colData(spe)` and the
spatial locations of the cells are stored in `spatialCoords(spe)`. The
interaction graph is stored in `colPair(spe, "neighbourhood")`.

Alternatively, the data can be read into a
*[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* object. The only
difference is the lack of `spatialCoords(sce)`. Here, the spatial
coordinates are stored in `colData(spe)$Pos_X` and `colData(spe)$Pos_Y`.

## 3.1 Read in CellProfiler output

The
[ImcSegmentationPipeline](https://github.com/BodenmillerGroup/ImcSegmentationPipeline)
produces a number of output files. By default, all single-cell features
are measured and exported. To browse and select the features of
interest, the `imcRtools` package provides the `show_cpout_features`
function:

```
path <- system.file("extdata/mockData/cpout", package = "imcRtools")

show_cpout_features(path)
```

By default, `read_cpout` will read in the mean intensity per channel and
cell from “hot pixel” filtered image stacks specified via
`intensities = "Intensity_MeanIntensity_FullStackFiltered"`. Please
refer to `?read_cpout` for the full documentation.

```
cur_path <- system.file("extdata/mockData/cpout", package = "imcRtools")

# Read as SpatialExperiment
(spe <- read_cpout(cur_path, graph_file = "Object_relationships.csv"))
```

```
## class: SpatialExperiment
## dim: 5 239
## metadata(0):
## assays(1): counts
## rownames(5): Ag107 Pr141 Sm147 Eu153 Yb172
## rowData names(7): Tube.Number Metal.Tag ... deepcell cellpose
## colnames(239): 1_1 1_2 ... 15_29 15_30
## colData names(12): sample_id ObjectNumber ... Metadata_acid
##   Metadata_description
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## spatialCoords names(2) : Pos_X Pos_Y
## imgData names(1): sample_id
```

```
# Read as SingleCellExperiment
(sce <- read_cpout(cur_path, graph_file = "Object_relationships.csv",
                   return_as = "sce"))
```

```
## class: SingleCellExperiment
## dim: 5 239
## metadata(0):
## assays(1): counts
## rownames(5): Ag107 Pr141 Sm147 Eu153 Yb172
## rowData names(7): Tube.Number Metal.Tag ... deepcell cellpose
## colnames(239): 1_1 1_2 ... 15_29 15_30
## colData names(14): sample_id ObjectNumber ... Metadata_acid
##   Metadata_description
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

## 3.2 Read in steinbock output

Single-cell data and all associated metadata (e.g. spatial location,
morphology and interaction graphs) as produced by the
[steinbock](https://github.com/BodenmillerGroup/steinbock) pipeline can
be read in using the `read_steinbock` function:

```
cur_path <- system.file("extdata/mockData/steinbock", package = "imcRtools")

# Read as SpatialExperiment
(spe <- read_steinbock(cur_path))
```

```
## class: SpatialExperiment
## dim: 5 404
## metadata(0):
## assays(1): counts
## rownames(5): Ag107 Cytokeratin 5 Laminin YBX1 H3K27Ac
## rowData names(7): channel name ... cellpose Tube.Number
## colnames(404): 20210305_NE_mockData1_001_1 20210305_NE_mockData1_001_2
##   ... 20210305_NE_mockData5_003_39 20210305_NE_mockData5_003_40
## colData names(8): sample_id ObjectNumber ... width_px height_px
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## spatialCoords names(2) : Pos_X Pos_Y
## imgData names(1): sample_id
```

```
# Read as SingleCellExperiment
(sce <- read_steinbock(cur_path, return_as = "sce"))
```

```
## class: SingleCellExperiment
## dim: 5 404
## metadata(0):
## assays(1): counts
## rownames(5): Ag107 Cytokeratin 5 Laminin YBX1 H3K27Ac
## rowData names(7): channel name ... cellpose Tube.Number
## colnames(404): 20210305_NE_mockData1_001_1 20210305_NE_mockData1_001_2
##   ... 20210305_NE_mockData5_003_39 20210305_NE_mockData5_003_40
## colData names(10): sample_id ObjectNumber ... width_px height_px
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

For more information, please refer to `?read_steinbock`.

## 3.3 Read raw .txt files into Image objects

For reading in and visualization of multi-channel images and
segmentation masks, please refer to the
*[cytomapper](https://bioconductor.org/packages/3.22/cytomapper)* package. The `imcRtools` package
however supports reading in raw .txt files generated by the Hyperion
imaging system into a `CytoImageList` object; a data container exported
by `cytomapper`.

The user needs to provide a path from which all .txt files will be read
in:

```
path <- system.file("extdata/mockData/raw", package = "imcRtools")

cur_CytoImageList <- readImagefromTXT(path)
cur_CytoImageList
```

```
## CytoImageList containing 3 image(s)
## names(3): 20210305_NE_mockData2_ROI_001_1 20210305_NE_mockData2_ROI_002_2 20210305_NE_mockData2_ROI_003_3
## Each image contains 5 channel(s)
## channelNames(5): Ag107Di Pr141Di Sm147Di Eu153Di Yb172Di
```

By specifying the `pattern` argument, individual or a subset of files
can be read in. For more information, please refer to
`?readImagefromTXT`.

# 4 Spillover correction

When acquiring IMC images, pixel intensities can be influenced by
spillover from neighboring channels. To correct for this, Chevrier *et
al.* have developed a staining protocol to acquire individually spotted
metal isotopes (Chevrier et al. [2017](#ref-Chevrier2017)). Based on these measurements, spillover
into neighboring channels can be quantified to correct pixel
intensities.

The `imcRtools` package provides helper functions that facilitate the
correction of spillover for IMC data. For a full tutorial, please refer
to the [IMC data analysis
book](https://bodenmillergroup.github.io/IMCDataAnalysis/spillover-correction.html).

## 4.1 Read in the single-spot acquisitions

In the first step, the pixel intensities of individually spotted metals
need to be read into a `SingleCellExperiment` container for downstream
use with the *[CATALYST](https://bioconductor.org/packages/3.22/CATALYST)* package. For this, the
`readSCEfromTXT` function can be used when txt files are available.
The latest generation of IMC machines - XTi - does not produce txt files
anymore. The `readSCEfromTIFF` function can be used to generate a
`SingleCellExperiment` container from tiff files produced with the
`steinbock` framework:

# 5 From txt

```
path <- system.file("extdata/spillover", package = "imcRtools")
sce <- readSCEfromTXT(path)
```

```
## Spotted channels:  Dy161, Dy162, Dy163, Dy164
## Acquired channels:  Dy161, Dy162, Dy163, Dy164
## Channels spotted but not acquired:
## Channels acquired but not spotted:
```

```
sce
```

```
## class: SingleCellExperiment
## dim: 4 400
## metadata(0):
## assays(1): counts
## rownames(4): 161Dy(Dy161Di) 162Dy(Dy162Di) 163Dy(Dy163Di)
##   164Dy(Dy164Di)
## rowData names(2): channel_name marker_name
## colnames(400): Dy161.1 Dy161.2 ... Dy164.99 Dy164.100
## colData names(9): Start_push End_push ... sample_metal sample_mass
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

# 6 From tiff

```
path <- system.file("extdata/spillover_tiff/img", package = "imcRtools")
image_df_path <- system.file("extdata/spillover_tiff/images.csv", package = "imcRtools")
panel_df_path <- system.file("extdata/spillover_tiff/panel.csv", package = "imcRtools")
sce <- readSCEfromTIFF(path, image_df_path, panel_df_path)
```

```
## Spotted channels:  Dy161, Dy162, Dy163, Dy164
## Acquired channels:  Dy161, Dy162, Dy163, Dy164
## Channels spotted but not acquired:
## Channels acquired but not spotted:
```

```
sce
```

```
## class: SingleCellExperiment
## dim: 4 80000
## metadata(0):
## assays(1): counts
## rownames(4): Dy161 Dy162 Dy163 Dy164
## rowData names(2): channel_name marker_name
## colnames: NULL
## colData names(4): cell_id sample_id sample_metal sample_mass
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

Here, the example metal spot files are read in. The spot information are
stored in the `colData(sce)` slot and channel information are stored in
`rowData(sce)`. Each column represents a single pixel.

## 6.1 Quality control on single-spot acquisitions

In the next step, it is crucial to identify potentially mislabeled spots
or spots with low pixel intensities. The `imcRtools` package exports the
`plotSpotHeatmap` function, which visualizes the aggregated (default
`median`) pixel intensities per spot and per metal:

```
plotSpotHeatmap(sce)
```

![](data:image/png;base64...)

Here, high median pixel intensities can be observed in each spot and
their corresponding channels (visualized on the `log10` scale by
default). To quickly identify spot/channel combinations with low signal,
the `threshold` parameter can be set:

```
plotSpotHeatmap(sce, log = FALSE, threshold = 200)
```

![](data:image/png;base64...)

## 6.2 Consecutive pixel binning

If pixel intensities are low, spillover estimation might not be robust.
Therefore, the `binAcrossPixels` function can be used to sum consecutive
pixels and enhance the acquired signal. This step is optional for
spillover estimation.

```
sce2 <- binAcrossPixels(sce, bin_size = 5)

plotSpotHeatmap(sce2, log = FALSE, threshold = 200)
```

![](data:image/png;base64...)

## 6.3 Pixel filtering

Prior to spillover estimation, the *[CATALYST](https://bioconductor.org/packages/3.22/CATALYST)*
package provides the `assignPrelim`, `estCutoffs` and `applyCutoffs`
functions to estimate the spotted mass for each pixel based on their
channel intensities. For more information on the spillover estimation
and correction, please refer to the [CATALYST
vignette](https://bioconductor.org/packages/release/bioc/vignettes/CATALYST/inst/doc/preprocessing.html#compensation).

This estimation can be used to identify pixels that cannot be easily
assigned to their spotted mass, potentially indicating pixels with weak
signal. To remove these pixels, the `filterPixels` function can be used.
This function further removes pixels assigned to masses, which only
contain very few pixels.

```
library(CATALYST)

bc_key <- as.numeric(unique(sce$sample_mass))
assay(sce, "exprs") <- asinh(counts(sce)/5)
sce <- assignPrelim(sce, bc_key = bc_key)
sce <- estCutoffs(sce)
sce <- applyCutoffs(sce)

# Filter out mislabeled pixels
sce <- filterPixels(sce)

table(sce$bc_id, sce$sample_mass)
```

```
##
##         161   162   163   164
##   0      11    78   123    10
##   161 19989     0     0     0
##   162     0 19922     0     0
##   163     0     0 19877     0
##   164     0     0     0 19990
```

## 6.4 Estimating the spillover matrix

Finally, the pre-processed `SiingleCellExperiment` object can be used to
generate the spillover matrix using the `CATALYST::computeSpillmat`
function:

```
sce <- computeSpillmat(sce)
metadata(sce)$spillover_matrix
```

```
##             Dy161Di     Dy162Di     Dy163Di     Dy164Di
## Dy161Di 1.000000000 0.027691801 0.009718301 0.005720745
## Dy162Di 0.016014265 1.000000000 0.043053239 0.009650176
## Dy163Di 0.003140381 0.012804170 1.000000000 0.016494897
## Dy164Di 0.000000000 0.002627576 0.011235724 1.000000000
```

This spillover matrix can be directly applied to compensate the
summarized pixel intensities per cell and per channel as described
[here](https://bioconductor.org/packages/release/bioc/vignettes/CATALYST/inst/doc/preprocessing.html#compcytof-compensation-of-mass-cytometry-data).

# 7 Spatial analysis

The following section will highlight functions for spatial analyses of
the data.

## 7.1 Constructing graphs

When following the `ImcSegmentationPipeline` or `steinbock` and reading
in the data using the corresponding functions, the generated graphs are
automatically stored in the `colPair(spe, "neighborhood")` slot.
Alternatively, the `buildSpatialGraph` function in the `imcRtools`
package constructs interaction graphs using either (i) cell-centroid
expansion, (ii) k-nearest neighbor search or (iii) delaunay
triangulation.

```
library(cytomapper)
data("pancreasSCE")

pancreasSCE <- buildSpatialGraph(pancreasSCE, img_id = "ImageNb",
                                 type = "expansion",
                                 threshold = 20)
pancreasSCE <- buildSpatialGraph(pancreasSCE, img_id = "ImageNb",
                                 type = "knn",
                                 k = 5)
pancreasSCE <- buildSpatialGraph(pancreasSCE, img_id = "ImageNb",
                                 type = "delaunay")

colPairNames(pancreasSCE)
```

```
## [1] "expansion_interaction_graph" "knn_interaction_graph"
## [3] "delaunay_interaction_graph"
```

When setting `type = "knn"`, by default a directional graph will be
build. Setting `directed = FALSE` will create bi-directional edges for
each pair of cells that are connected by at least one edge in the
directed setting.

## 7.2 Graph/cell visualization

The cells’ locations and constructed graphs can be visualized using the
`plotSpatial` function. Here, cells are referred to as “nodes” and
cell-cell interactions are referred to as “edges”. All visual attributes
of the nodes and edges can be set. Either by specifying a variable in
`colData(spe)`, a marker name or a single entry using the `*_fix`
parameters. By default the `plotSpatial` function will visualize equal physical
units on the x- and y-axis with an aspect ratio of 1. The example data are
located in different regions of an image and we therefore set `scales = "free"`
for simpler visualization.

```
library(ggplot2)
library(ggraph)

plotSpatial(pancreasSCE,
            img_id = "ImageNb",
            node_color_by = "CellType",
            node_shape_by = "ImageNb",
            node_size_by = "Area",
            draw_edges = TRUE,
            colPairName = "knn_interaction_graph",
            directed = FALSE,
            scales = "free")
```

![](data:image/png;base64...)

```
# Colored by expression and with arrows
plotSpatial(pancreasSCE,
            img_id = "ImageNb",
            node_color_by = "PIN",
            assay_type = "exprs",
            node_size_fix = 3,
            edge_width_fix = 0.2,
            draw_edges = TRUE,
            colPairName = "knn_interaction_graph",
            directed = TRUE,
            arrow = grid::arrow(length = grid::unit(0.1, "inch")),
            end_cap = ggraph::circle(0.05, "cm"),
            scales = "free")
```

![](data:image/png;base64...)

```
# Subsetting the SingleCellExperiment
plotSpatial(pancreasSCE[,pancreasSCE$Pattern],
            img_id = "ImageNb",
            node_color_by = "CellType",
            node_size_fix = 1,
            draw_edges = TRUE,
            colPairName = "knn_interaction_graph",
            directed = TRUE)
```

![](data:image/png;base64...)

The returned object can be further modified using the `ggplot2` logic.
This includes changing the node color, shape and size using
`scale_color_*`, `scale_shape_*` and `scale_size_*`. Edge attributes can
be altered using the `scale_edge_*` function exported by `ggraph`,

## 7.3 Neighborhood aggregation

The `aggregateNeighbors` function can be used to aggregate features of
all neighboring cells for each individual cell. This function operates
in two settings.

1. `metadata`: when aggregating by cell-specific metadata, the function
   computes the relative frequencies of all entries to
   `colData(sce)[[count_by]]` within the direct neighborhood of each
   cell.
2. `expression`: the expression counts of neighboring cells are
   aggregated using the specified `statistic` (defaults to `mean`).

Each cell’s neighborhood is defined as endpoints of edges stored in
`colPair(sce, colPairName)`.

```
pancreasSCE <- aggregateNeighbors(pancreasSCE,
                                  colPairName = "knn_interaction_graph",
                                  aggregate_by = "metadata",
                                  count_by = "CellType")
head(pancreasSCE$aggregatedNeighbors)
```

```
## DataFrame with 6 rows and 3 columns
##   celltype_A celltype_B celltype_C
##    <numeric>  <numeric>  <numeric>
## 1          0        0.0        1.0
## 2          0        0.2        0.8
## 3          0        0.0        1.0
## 4          0        0.0        1.0
## 5          0        0.0        1.0
## 6          0        0.0        1.0
```

```
pancreasSCE <- aggregateNeighbors(pancreasSCE,
                                  colPairName = "knn_interaction_graph",
                                  aggregate_by = "expression",
                                  assay_type =  "exprs")
head(pancreasSCE$mean_aggregatedExpression)
```

```
## DataFrame with 6 rows and 5 columns
##          H3      CD99       PIN      CD8a       CDH
##   <numeric> <numeric> <numeric> <numeric> <numeric>
## 1   2.32500  0.860329  0.092871  0.725000   2.51264
## 2   2.88022  1.629762  0.319527  0.207873   2.46486
## 3   3.10829  0.735389  0.190616  0.255515   1.89484
## 4   2.55842  0.773342  0.124545  0.188629   2.51084
## 5   2.44287  1.126240  0.252129  0.200261   2.61336
## 6   2.65059  0.903869  0.181792  0.196691   2.16434
```

The returned entries can now be used for clustering to group cells based
on their environment (either by aggregated categorical features or
expression).

```
set.seed(22)
cur_cluster <- kmeans(pancreasSCE$aggregatedNeighbors, centers = 3)
pancreasSCE$clustered_neighbors <- factor(cur_cluster$cluster)

# Visualize CellType and clustered_neighbors
plotSpatial(pancreasSCE,
            img_id = "ImageNb",
            node_color_by = "CellType",
            node_size_fix = 4,
            edge_width_fix = 2,
            edge_color_by = "clustered_neighbors",
            draw_edges = TRUE,
            colPairName = "knn_interaction_graph",
            directed = FALSE,
            nodes_first = FALSE,
            scales = "free") +
    scale_color_brewer(palette = "Set2") +
    scale_edge_color_brewer(palette = "Set1")
```

![](data:image/png;base64...)

```
# Visualize clustered_neighbors
plotSpatial(pancreasSCE,
            img_id = "ImageNb",
            node_color_by = "clustered_neighbors",
            node_size_fix = 4,
            edge_width_fix = 1,
            draw_edges = TRUE,
            colPairName = "knn_interaction_graph",
            directed = FALSE,
            nodes_first = FALSE,
            scales = "free")+
    scale_color_brewer(palette = "Set1")
```

![](data:image/png;base64...)

## 7.4 Spatial context analysis

The single cell assignments derived from clustering cells based on their
environment can be interpreted as **cellular neighborhoods (CNs)**, which can
represent sites of unique local processes (Schürch et al. [2020](#ref-Schurch2020)).

Downstream of CNs, imcRtools exports three functions to detect and
analyze the **spatial context (SC)** of each cell.

1. `detectSpatialContext`: for the function to detect SCs
2. `filterSpatialContext`: for the function to filter SCs
3. `plotSpatialContext`: for the function to plot SC graphs

The term SC was coined by Bhate and colleagues (Bhate et al. [2022](#ref-Bhate2022)) and
describes tissue regions in which distinct CNs may be interacting,
which can lead to specialized local biological events.

The `detectSpatialContext` function relies on CN fractions for each cell in
a spatial interaction graph (originally a k-nearest neighbor (KNN) graph).

We can retrieve the CN fractions using the above-described `buildSpatialGraph`
and `aggregateNeighbors` functions. The window size (k for KNN) for
`buildSpatialGraph` should reflect a length scale on which biological signals
can be exchanged and depends, among others, on cell density and tissue area.
In view of their divergent functionality, we recommend to use a larger
window size for SC (interaction between local processes) than for CN
(local processes) detection.

Subsequently, the CN fractions are sorted from high-to-low and the SC of each
cell is assigned the minimal combination of SCs that additively surpass a
user-defined threshold. The default threshold of 0.9 aims to represent the
dominant CNs, hence the most prevalent signals, in a given window.

For more details, please refer to (Bhate et al. [2022](#ref-Bhate2022)).

```
# Generate k-nearest neighbor graph
pancreasSCE <- buildSpatialGraph(pancreasSCE, img_id = "ImageNb",
                                 type = "knn",
                                 name = "knn_spatialcontext_graph",
                                 k = 15)
colPairNames(pancreasSCE)
```

```
## [1] "expansion_interaction_graph" "knn_interaction_graph"
## [3] "delaunay_interaction_graph"  "knn_spatialcontext_graph"
```

```
# Aggregate based on clustered_neighbors
pancreasSCE <- aggregateNeighbors(pancreasSCE,
                                  colPairName = "knn_spatialcontext_graph",
                                  aggregate_by = "metadata",
                                  count_by = "clustered_neighbors",
                                  name = "aggregatedNeighborhood")

# Detect spatial contexts
pancreasSCE <- detectSpatialContext(pancreasSCE,
                                    entry = "aggregatedNeighborhood",
                                    threshold = 0.9,
                                    name = "spatial_context")
# Define SC color scheme
col_SC <- setNames(c("#A6CEE3", "#1F78B4", "#B2DF8A", "#33A02C", "#FB9A99", "#E31A1C", "#FDBF6F"),
                   sort(unique(pancreasSCE$spatial_context)))

# Visualize spatial contexts on images
plotSpatial(pancreasSCE,
            img_id = "ImageNb",
            node_color_by = "spatial_context",
            node_size_fix = 4,
            edge_width_fix = 1,
            draw_edges = TRUE,
            colPairName = "knn_spatialcontext_graph",
            directed = FALSE,
            nodes_first = FALSE,
            scales = "free") +
    scale_color_manual(values = col_SC)
```

![](data:image/png;base64...)

After SC assignment for each individual cell, the `filterSpatialContext`
function allows to filter detected SCs based on user-defined thresholds
for number of group entries (usually image or patient ID) and/or total
number of cells per SC.

In addition to a new column entry to the `colData(object)`, the function
also returns a `data.frame` entry to `metadata(object)` containing filtered group
and cell counts per SC.

```
# Filter spatial contexts
# By number of group entries
pancreasSCE <- filterSpatialContext(pancreasSCE,
                            entry = "spatial_context",
                            group_by = "ImageNb",
                            group_threshold = 2,
                            name = "spatial_context_filtered_group")

metadata(pancreasSCE)$filterSpatialContext
```

```
##   spatial_context n_cells n_group
## 1               1      87       2
## 2             1_2      71       2
## 4             1_3      90       2
## 5               2      55       2
## 7               3      14       2
```

```
plotSpatial(pancreasSCE,
            img_id = "ImageNb",
            node_color_by = "spatial_context_filtered_group",
            node_size_fix = 4,
            edge_width_fix = 1,
            draw_edges = TRUE,
            colPairName = "knn_spatialcontext_graph",
            directed = FALSE,
            nodes_first = FALSE,
            scales = "free") +
    scale_color_manual(values = col_SC)
```

![](data:image/png;base64...)

```
# By total number of cells
pancreasSCE <- filterSpatialContext(pancreasSCE,
                            entry = "spatial_context",
                            group_by = "ImageNb",
                            cells_threshold = 15,
                            name = "spatial_context_filtered_cells")

metadata(pancreasSCE)$filterSpatialContext
```

```
##   spatial_context n_cells n_group
## 1               1      87       2
## 2             1_2      71       2
## 3           1_2_3      16       1
## 4             1_3      90       2
## 5               2      55       2
## 6             2_3      29       1
```

```
plotSpatial(pancreasSCE,
            img_id = "ImageNb",
            node_color_by = "spatial_context_filtered_cells",
            node_size_fix = 4,
            edge_width_fix = 1,
            draw_edges = TRUE,
            colPairName = "knn_spatialcontext_graph",
            directed = FALSE,
            nodes_first = FALSE,
            scales = "free") +
    scale_color_manual(values = col_SC)
```

![](data:image/png;base64...)

Lastly, the `plotSpatialContext` function plots directed *SC graphs*,
akin to *CN combination maps* in (Bhate et al. [2022](#ref-Bhate2022)), based on symbolic
edge-lists and vertex metadata, which operates on cohort-level.

```
## Plot spatial context graph
# Default
plotSpatialContext(pancreasSCE,
                   entry = "spatial_context",
                   group_by = "ImageNb")
```

![](data:image/png;base64...)

```
# Colored by name and size by n_cells
plotSpatialContext(pancreasSCE,
                   entry = "spatial_context",
                   group_by = "ImageNb",
                   node_color_by = "name",
                   node_size_by = "n_cells",
                   node_label_color_by = "name")
```

![](data:image/png;base64...)

```
# Colored by n_cells and size by n_group
plotSpatialContext(pancreasSCE,
                   entry = "spatial_context",
                   group_by = "ImageNb",
                   node_color_by = "n_cells",
                   node_size_by = "n_group",
                   node_label_color_by = "n_cells")+
  scale_color_viridis()
```

![](data:image/png;base64...)

The returned object can be further modified using the `ggplot2` logic.
This includes changing the node color and size using `scale_color_*` and
`scale_size_*`. Edge attributes can be altered using the `scale_edge_*`
function exported by `ggraph`.

Furthermore, setting `return_data = TRUE` returns the symbolic edge-list
and vertex metadata used for graph construction in a `list` of two
`data.frames`.

```
# Return data
plotSpatialContext(pancreasSCE,
                   entry = "spatial_context",
                   group_by = "ImageNb",
                   return_data = TRUE)
```

```
## $edges
##   from    to
## 1    1   1_2
## 2    1   1_3
## 3  1_2 1_2_3
## 4  1_3 1_2_3
## 5    2   1_2
## 6    2   2_3
## 7  2_3 1_2_3
## 8    3   1_3
## 9    3   2_3
##
## $vertices
##   spatial_context n_cells n_group length
## 1               1      87       2      1
## 2             1_2      71       2      2
## 3           1_2_3      16       1      3
## 4             1_3      90       2      2
## 5               2      55       2      1
## 6             2_3      29       1      2
## 7               3      14       2      1
```

## 7.5 Community detection

In addition to cellular neighborhood and spatial context analysis, `imcRtools` exports
the `detectCommunity` function to detect the spatial community of each cell as
proposed by (Jackson et al. [2020](#ref-Jackson2020)). Here, each cell is clustered based on its interactions
as defined by a spatial object graph.

In more detail, the spatial community detection procedure is as follows:

1. Create an igraph object from the edge list stored in
   .
2. Perform community detection using the specified algorithm
   (defaults to “louvain”).
3. Store the community IDs in a vector and replace all communities
   with a size smaller than by NA.

```
## Detect spatial community
set.seed(22)
pancreasSCE <- detectCommunity(pancreasSCE,
                               colPairName = "expansion_interaction_graph")

plotSpatial(pancreasSCE,
            img_id = "ImageNb",
            node_color_by = "spatial_community",
            node_size_fix = 4,
            edge_width_fix = 1,
            draw_edges = TRUE,
            colPairName = "expansion_interaction_graph",
            directed = FALSE,
            nodes_first = FALSE,
            scales = "free")
```

![](data:image/png;base64...)

```
## Detect spatial community - specify size_threshold
set.seed(22)
pancreasSCE <- detectCommunity(pancreasSCE,
                               colPairName = "expansion_interaction_graph",
                               size_threshold = 20)

plotSpatial(pancreasSCE,
            img_id = "ImageNb",
            node_color_by = "spatial_community",
            node_size_fix = 4,
            edge_width_fix = 1,
            draw_edges = TRUE,
            colPairName = "expansion_interaction_graph",
            directed = FALSE,
            nodes_first = FALSE,
            scales = "free")
```

![](data:image/png;base64...)
It is also possible to use different community detection algorithms from the `igraph`package.

```
## Detect spatial community - walktrap community detection
set.seed(22)
pancreasSCE <- detectCommunity(pancreasSCE,
                               colPairName = "expansion_interaction_graph",
                               cluster_fun = "walktrap")

plotSpatial(pancreasSCE,
            img_id = "ImageNb",
            node_color_by = "spatial_community",
            node_size_fix = 4,
            edge_width_fix = 1,
            draw_edges = TRUE,
            colPairName = "expansion_interaction_graph",
            directed = FALSE,
            nodes_first = FALSE,
            scales = "free")
```

![](data:image/png;base64...)

Moreover, the user can specify to perform spatial community
detection separately for all unique entries to
e.g. for tumor and non-tumor cells.

```
## Detect spatial community - specify group_by
pancreasSCE <- detectCommunity(pancreasSCE,
                               colPairName = "expansion_interaction_graph",
                               group_by = "CellType",
                               size_threshold = 10,
                               BPPARAM = BiocParallel::SerialParam(RNGseed = 22))

plotSpatial(pancreasSCE,
            img_id = "ImageNb",
            node_color_by = "spatial_community",
            node_size_fix = 4,
            edge_width_fix = 1,
            draw_edges = TRUE,
            colPairName = "expansion_interaction_graph",
            directed = FALSE,
            nodes_first = FALSE,
            scales = "free")
```

![](data:image/png;base64...)

## 7.6 Border cells

To exclude cells that are close to the image border, the `imcRtools`
package exports the `findBorderCells` function.

```
pancreasSCE <- findBorderCells(pancreasSCE,
                               img_id = "ImageNb",
                               border_dist = 10)

plotSpatial(pancreasSCE[,!pancreasSCE$border_cells],
            img_id = "ImageNb",
            node_color_by = "CellType",
            node_size_fix = 4,
            edge_width_fix = 2,
            edge_color_by = "clustered_neighbors",
            draw_edges = TRUE,
            colPairName = "knn_interaction_graph",
            directed = FALSE,
            nodes_first = FALSE,
            scales = "free") +
    scale_color_brewer(palette = "Set2") +
    scale_edge_color_brewer(palette = "Set1")
```

![](data:image/png;base64...)

Excluding border cells can be useful when incorrectly connected cells
are observed at image borders.

## 7.7 Patch detection

An alternative and supervised way of detecting regions with similar
types of cells is available via the `patchDetection` function. Here, the
user defines which cells should be used for patch detection via the
`patch_cells` parameter. A patch is defined as a set of cells as defined
by `patch_cells` which are weakly connected in the graph in
`colPair(object, colPairname)`.

Below, the `patchDetection` function is demonstrated using the
previously computed `expansion` graph and defining cells of `celltype_B`
as the cells of interest. Here, the function additionally draws a
concave hull around the detected patch, expands the hull by 20\(\mu{}m\)
and defines all cells within this expanded hulls as patch cells.

```
pancreasSCE <- patchDetection(pancreasSCE,
                              patch_cells = pancreasSCE$CellType == "celltype_B",
                              colPairName = "expansion_interaction_graph",
                              expand_by = 20,
                              img_id = "ImageNb")

plotSpatial(pancreasSCE,
            img_id = "ImageNb",
            node_color_by = "patch_id",
            scales = "free")
```

![](data:image/png;base64...)

Patches that only consist of 1 or 2 cells cannot be expanded.

For each patch larger than 2 cells, the spatial area can be computed using the
`patchSize` function:

```
patchSize(pancreasSCE)
```

```
## DataFrame with 8 rows and 3 columns
##      patch_id                polygon      size
##   <character>                 <list> <numeric>
## 1           1                     NA        NA
## 2           2                     NA        NA
## 3           3 c(180.4247, 170.4, 1..   913.849
## 4           4                     NA        NA
## 5           5                     NA        NA
## 6           6 c(138.08, 134.4638, ..  4066.407
## 7           7 c(133.1014, 133.9213..  1283.972
## 8           8 c(244.3196, 247.878,..  6224.065
```

## 7.8 Distance statistics to cells of interest

To calculate the min, max, mean or median distance for each cell to a given cell type or class of
cells of interest, the function `distToCells` is available. Cells of interest
are defined via the `x_cells` parameter as `logical` and distances to for all
cells to those cells will be reported in a new column in the `colData` of the
`SingleCellExperiment`.

If the cells of interest form patches (many cells of the same type next to each
other) or similarly if a patch detection has previously been performed the
positive distances reflect the distances from cells outside of patches (or non cells of interest) to the patch cells (or cells of interest) and the negative distances reflect the distances from cells
inside the patches to the cells outside the patches.
For `statistics` = “min” this corresponds to the distance from the cells outside to the closest point on the patch border and from the cells inside to the closest point on the patch border.
If `return_neg` is set to `FALSE`, distances from the cells of interest (or cells inside the patches) to non cells of interest are computed as positive distances.

```
pancreasSCE <- distToCells(pancreasSCE,
                              x_cells = pancreasSCE$CellType == "celltype_B",
                              coords = c("Pos_X","Pos_Y"),
                              statistics = "min",
                              name = "minDist",
                              img_id = "ImageNb")

pancreasSCE <- distToCells(pancreasSCE,
                              x_cells = pancreasSCE$CellType == "celltype_B",
                              coords = c("Pos_X","Pos_Y"),
                              statistics = "mean",
                              name = "meanDist",
                              img_id = "ImageNb")

plotSpatial(pancreasSCE,
            img_id = "ImageNb",
            node_color_by = "minDist",
            scales = "free") +
    scale_color_viridis()
```

![](data:image/png;base64...)

```
plotSpatial(pancreasSCE,
            img_id = "ImageNb",
            node_color_by = "meanDist",
            scales = "free") +
    scale_color_viridis()
```

![](data:image/png;base64...)

## 7.9 Neighborhood permutation testing

The following section describes how to observe and test the average
number of interactions between cell labels (e.g. cell-types) within
grouping levels (e.g. images). For full descriptions of the testing
approaches, please refer to [Shapiro et al., Nature
Methods](https://www.nature.com/articles/nmeth.4391) (Schapiro et al. [2017](#ref-Shapiro2017)) and
[Schulz et al., Cell
Systems](https://www.sciencedirect.com/science/article/pii/S2405471217305434)
(Schulz et al. [2018](#ref-Schulz2018))

The `imcRtools` package exports the `countInteractions` and
`testInteractions` functions, which summarize all cell-cell interactions
per grouping level (e.g. image). As a result, a table is returned where
each row represents one of all possible cell-type/cell-type interactions
among all grouping levels. Missing entries or `NA`s indicate missing
cell-type labels for this grouping level. The next section gives details
on how interactions are summarized.

### 7.9.1 Summarizing interactions

The `countInteractions` function counts the number of edges
(interactions) between each set of unique cell labels per grouping
level. Simplified, it counts for each cell of type A the number of
neighbors of type B. This count is averaged within each unique grouping
level (e.g. image) in four different ways:

1. `method = "classic"`: The count is divided by the total number of
   cells of type A. The final count can be interpreted as “How many
   neighbors of type B does a cell of type A have on average?”
2. `method = "conditional"`: Previously named “histocat”. The count is
   divided by the number of cells of type A that have at least one neighbor
   of type B. The final count can be interpreted as “How many many neighbors
   of type B has a cell of type A on average, given it has at least one
   neighbor of type B?”.
3. `method = "patch"`: For each cell, the count is binarized to 0 (less
   than `patch_size` neighbors of type B) or 1 (more or equal to
   `patch_size` neighbors of type B). The binarized counts are averaged
   across all cells of type A. The final count can be interpreted as
   “What fraction of cells of type A have at least a given number of
   neighbors of type B?”
4. `method = "interaction"`: The count is divided by the total number of
   interactions from cell type A. The final count can be interpreted as the
   fraction of interactions of cell type A that occur with cell type B.

The `countInteractions` returns a `DataFrame` containing the summarized
counts (`ct`) for all combinations of `from_label`, `to_label` and
`group_by`.

```
out <- countInteractions(pancreasSCE,
                         group_by = "ImageNb",
                         label = "CellType",
                         method = "classic",
                         colPairName = "knn_interaction_graph")
out
```

```
## DataFrame with 27 rows and 4 columns
##      group_by from_label   to_label        ct
##     <integer>   <factor>   <factor> <numeric>
## 1           1 celltype_A celltype_A  2.823529
## 2           1 celltype_A celltype_B  0.823529
## 3           1 celltype_A celltype_C  1.352941
## 4           1 celltype_B celltype_A  2.000000
## 5           1 celltype_B celltype_B  0.625000
## ...       ...        ...        ...       ...
## 23          3 celltype_B celltype_B   4.00000
## 24          3 celltype_B celltype_C   1.00000
## 25          3 celltype_C celltype_A        NA
## 26          3 celltype_C celltype_B   1.13115
## 27          3 celltype_C celltype_C   3.86885
```

### 7.9.2 Testing for significance

In the next instance, one can test if the obtained count is larger or
smaller compared to what is expected from a random distribution of cell
labels. For this, the `testInteractions` function permutes the cell
labels `iter` times and counts interactions as described above. This
approach generates a distribution of the interaction count under a
random distribution of cell labels. The observed interaction count is
compared against this Null distribution to derive z-scores and empirical p-values:

`p_gt`: fraction of perturbations equal or greater than the observed
count

`p_lt`: fraction of perturbations equal or less than the observed count

`zscore`: (observed count - mean of permuted counts) / sd of permuted counts

Based on these empirical p-values, the `interaction` score (attraction
or avoidance), overall `p` value and significance by comparison to
`p_treshold` (`sig` and `sigval`) are derived. All results are returned
in form of a `DataFrame`.

We set the seed within the `SerialParam` (or `MulticoreParam`) function for
reproducibility.

```
out <- testInteractions(pancreasSCE,
                        group_by = "ImageNb",
                        label = "CellType",
                        method = "classic",
                        colPairName = "knn_interaction_graph",
                        BPPARAM = BiocParallel::SerialParam(RNGseed = 123))
out
```

```
## DataFrame with 27 rows and 11 columns
##        group_by  from_label    to_label        ct        p_gt        p_lt
##     <character> <character> <character> <numeric>   <numeric>   <numeric>
## 1             1  celltype_A  celltype_A  2.823529 0.000999001 1.000000000
## 2             1  celltype_A  celltype_B  0.823529 0.001998002 1.000000000
## 3             1  celltype_A  celltype_C  1.352941 1.000000000 0.000999001
## 4             1  celltype_B  celltype_A  2.000000 0.000999001 1.000000000
## 5             1  celltype_B  celltype_B  0.625000 0.154845155 0.911088911
## ...         ...         ...         ...       ...         ...         ...
## 23            3  celltype_B  celltype_B   4.00000 0.000999001 1.000000000
## 24            3  celltype_B  celltype_C   1.00000 1.000000000 0.000999001
## 25            3  celltype_C  celltype_A        NA          NA          NA
## 26            3  celltype_C  celltype_B   1.13115 1.000000000 0.000999001
## 27            3  celltype_C  celltype_C   3.86885 0.000999001 1.000000000
##        zscore interaction           p       sig    sigval
##     <numeric>   <logical>   <numeric> <logical> <numeric>
## 1     8.86391        TRUE 0.000999001      TRUE         1
## 2     3.62203        TRUE 0.001998002      TRUE         1
## 3   -10.20206       FALSE 0.000999001      TRUE        -1
## 4     4.60006        TRUE 0.000999001      TRUE         1
## 5     1.19103        TRUE 0.154845155     FALSE         0
## ...       ...         ...         ...       ...       ...
## 23    9.86285        TRUE 0.000999001      TRUE         1
## 24   -9.86285       FALSE 0.000999001      TRUE        -1
## 25         NA          NA          NA        NA        NA
## 26   -9.47117       FALSE 0.000999001      TRUE        -1
## 27    9.47117        TRUE 0.000999001      TRUE         1
```

### 7.9.3 Visualizing interactions

The `plotInteractions` function is used to visualize interaction networks from an
edge list, typically the output of the `countInteractions`and `testInteractions`
functions.

```
plotInteractions(out,
                 pancreasSCE,
                 group_by = "ImageNb",
                 label = "CellType")
```

![](data:image/png;base64...)

Before visualization, the edge list can be filtered to focus on relevant
cell-cell interactions, groupings, and significance.

In the example below we retain interactions whose fraction of significant pairs
(based on sigval) exceeds 75% and tag the edges as attraction or repulsion.

```
library(dplyr)

out <- out %>% as.data.frame() %>% mutate(pair_id = paste(from_label, to_label, sep = "__"),
                                          is_sig = !is.na(sig))
summary_df <- out %>%
  group_by(pair_id) %>%
  summarise(
    sum_sigval = sum(sigval, na.rm = TRUE),
    total_count = sum(is_sig),
    .groups = "drop"
  ) %>%
  mutate(
    fraction_sig = sum_sigval / total_count,
    int_type = case_when(
      fraction_sig > 0.75 ~ "attraction",
      fraction_sig < -0.75 ~ "repulsion",
      TRUE ~ NA_character_
    )
  ) %>%
  filter(!is.na(int_type))

subset_out <- out %>%
  semi_join(summary_df, by = "pair_id") %>%
  left_join(summary_df %>% select(pair_id, int_type), by = "pair_id")

# Now we can visualise only these filtered edges
plotInteractions(subset_out,
                 pancreasSCE,
                 group_by = "ImageNb",
                 label = "CellType")
```

![](data:image/png;base64...)

You can customize node and edge aesthetics directly using `plotInteractions`
arguments. The plot can also be modified further using `ggplot2` syntax.
Node properties such as color, shape, and size can be controlled using
`scale_color_*`, `scale_shape_*` and `scale_size_*`. Edge aesthetics can be
modified using `scale_edge_*` functions from `ggraph`.

To color edges based on subsetted significant interaction type (attraction, repulsion),
specify the `int_type` column via `edge_color_by`, and use `scale_edge_colour_manual()`
for custom colors.

You can also control edge thickness via `edge_width_by`. For example, “ct”
represents the summarized interaction count derived from `countInteractions`
or `testInteractions`, averaged per cell-pair and grouping level.
In our example, the “ct” value refers to the average neighboring cells of
cell type B from cell type A averaged across all images.

```
library(ggraph)

edge_color <- setNames(c("blue", "red"),c("attraction", "repulsion"))

plotInteractions(subset_out,
                 pancreasSCE,
                 group_by = "ImageNb",
                 label = "CellType",
                 edge_color_by = "int_type",
                 edge_width_by = "ct") +
                 scale_edge_colour_manual(values = edge_color)
```

![](data:image/png;base64...)

Control node properties via: `node_color_by`, `node_size_by`, `node_label_color_by`.

```
plotInteractions(out,
                 pancreasSCE,
                 group_by = "ImageNb",
                 label = "CellType",
                 node_color_by = "name",
                 node_label_color_by = "name",
                 node_size_by = "n_cells")
```

![](data:image/png;base64...)

```
# Define custom colors for node and node_label
node_color <- setNames(c("red", "blue", "green"), c("celltype_A", "celltype_B", "celltype_C"))
plotInteractions(out,
                 pancreasSCE,
                 group_by = "ImageNb",
                 label = "CellType",
                 node_color_by = "name",
                 node_label_color_by = "name",
                 node_size_by = "n_cells")+
  scale_color_manual(values = node_color)
```

![](data:image/png;base64...)

The layout of the graph can be customized using the `graph_layout`argument.
For more information see .

```
# Default is "circle"
plotInteractions(out,
                 pancreasSCE,
                 group_by = "ImageNb",
                 label = "CellType")
```

![](data:image/png;base64...)

```
# Chord diagram layout
plotInteractions(out,
                 pancreasSCE,
                 group_by = "ImageNb",
                 label = "CellType",
                 graph_layout = "chord")
```

![](data:image/png;base64...)

```
# Linear layout
plotInteractions(out,
                 pancreasSCE,
                 group_by = "ImageNb",
                 label = "CellType",
                 graph_layout = "linear")
```

![](data:image/png;base64...)

Furthermore, setting `return_data = TRUE` returns the symbolic edge-list,
along with any specified edge aesthetic parameters and vertex metadata used
for graph construction, as a `list` of two `data.frames`.

```
# return data
plotInteractions(out, pancreasSCE, "CellType", "ImageNb",
                return_data = TRUE)
```

```
## $edges
##    from_label   to_label weight
## 1  celltype_A celltype_A      1
## 2  celltype_A celltype_B      1
## 3  celltype_A celltype_C      1
## 4  celltype_B celltype_A      1
## 5  celltype_B celltype_B      1
## 6  celltype_B celltype_C      1
## 7  celltype_C celltype_A      1
## 8  celltype_C celltype_B      1
## 9  celltype_C celltype_C      1
## 10 celltype_A celltype_A      1
## 11 celltype_A celltype_B      1
## 12 celltype_A celltype_C      1
## 13 celltype_B celltype_A      1
## 14 celltype_B celltype_B      1
## 15 celltype_B celltype_C      1
## 16 celltype_C celltype_A      1
## 17 celltype_C celltype_B      1
## 18 celltype_C celltype_C      1
## 19 celltype_A celltype_A      1
## 20 celltype_A celltype_B      1
## 21 celltype_A celltype_C      1
## 22 celltype_B celltype_A      1
## 23 celltype_B celltype_B      1
## 24 celltype_B celltype_C      1
## 25 celltype_C celltype_A      1
## 26 celltype_C celltype_B      1
## 27 celltype_C celltype_C      1
##
## $vertices
##     CellType n_cells n_group
## 1 celltype_A      62       2
## 2 celltype_B     111       3
## 3 celltype_C     189       3
```

### 7.9.4 Visualizing interactions when choosing method = “conditional”

We first run the testInteractions() functions with the “conditional” method.

```
out <- testInteractions(pancreasSCE,
                        group_by = "ImageNb",
                        label = "CellType",
                        method = "conditional",
                        colPairName = "knn_interaction_graph",
                        BPPARAM = BiocParallel::SerialParam(RNGseed = 123))
```

Interaction z-scores from conditional normalization, described as COZI in [Schiller et al. 2025](https://www.biorxiv.org/content/10.1101/2025.03.31.646289v2), can be
best interpreted by additionally considering the conditional cell ratio (CCR). The CCR is the ratio of cells of type A with at least one neighbor of type B in an image.

We can calculate the CCR for the priorly chosen neighborhood size and append the output from the testInteractions() function as follows:

```
cd <- as.data.table(colData(pancreasSCE))

cond_ratio_df <- as.data.table(colPair(pancreasSCE, "knn_interaction_graph"))[
  , .(from_label = cd$CellType[from],
      to_label   = cd$CellType[to],
      group_by   = cd$ImageNb[from],
      from)
][, .(N = uniqueN(from)), by = .(group_by, from_label, to_label)
][cd[, .(total_from_type = .N), by = .(group_by = ImageNb, from_label = CellType)],
  on = .(group_by, from_label)
][, .(group_by, from_label, to_label, cond_ratio = N / total_from_type)]

out_cr <- merge(
  as.data.table(out)[, `:=`(
    group_by   = as.integer(group_by),
    from_label = as.character(from_label),
    to_label   = as.character(to_label)
  )],
  cond_ratio_df,
  by = c("group_by", "from_label", "to_label"),
  all.x = TRUE
)
```

We visualize both the z-score and the CCR simultaneously in a dotplot to help interpreting results.
With that, you know how many cells of type A neighbor a cell of type B (CCR), and how strong this interaction is (z-score).
For example, if the CCR is very low (small dot) but the z-score is very high, this means that a small amount of cells of type A are strongly
surrounded by cells of type B.
We show how to plot the results in the following:

```
library(RColorBrewer)

p <- out_cr %>%
  filter(!is.na(zscore), !is.na(cond_ratio), sig) %>%
  ggplot(aes(from_label, to_label, size = cond_ratio, color = zscore)) +
  geom_point() +
  theme_bw() +
  scale_size(range = c(1,10)) +
  scale_color_gradient2(low = brewer.pal(11,"RdBu")[10], mid = "white", high = brewer.pal(11,"RdBu")[2], midpoint = 0) +
  facet_wrap(~group_by)

p
```

![](data:image/png;base64...)

# 8 Contributions

Large chunks of the code of the `imcRtools` package is based on the work
of [Vito Zanotelli](https://github.com/votti). Vito has co-developed the
spillover correction approach and translated the interaction testing
approach developed by [Denis Schapiro](https://github.com/DenisSch) and
[Jana Fischer](https://github.com/JanaFischer) into R (formerly known as
the [neighbouRhood](https://github.com/BodenmillerGroup/neighbouRhood) R
package). Jana has furthermore added the “patch” method for interaction
counting and testing. [Tobias Hoch](https://github.com/toobiwankenobi)
has written the first version of reading in the
`ImcSegmentationPipeline` output and the `patchDetection` function.
[Daniel Schulz](https://github.com/SchulzDan) has build the
`aggregateNeighbors` and `minDistToCells` functions and contributed to developing the spatial
clustering approach. [Lasse Meyer](https://github.com/lassedochreden) has
implemented the functions for spatial context analysis and developed the
`detectCommunity` function. [Marlene Lutz](https://github.com/marlene1) has
contributed the “interaction” method for interaction counting and testing, and
implemented the `plotInteractions` function. [Chiara Schiller](https://github.com/chiarasch) has
implemented the zscore calculation within the `testInteractions()` function and introduced the
conditional cell ratio for interpreting results.

# Session info

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
##  [1] RColorBrewer_1.1-3          dplyr_1.1.4
##  [3] ggraph_2.2.2                ggplot2_4.0.0
##  [5] cytomapper_1.22.0           EBImage_4.52.0
##  [7] CATALYST_1.34.0             imcRtools_1.16.0
##  [9] SpatialExperiment_1.20.0    SingleCellExperiment_1.32.0
## [11] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [13] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [15] IRanges_2.44.0              S4Vectors_0.48.0
## [17] BiocGenerics_0.56.0         generics_0.1.4
## [19] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [21] data.table_1.17.8           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] bitops_1.0-9                sf_1.0-21
##   [3] doParallel_1.0.17           tools_4.5.1
##   [5] backports_1.5.0             R6_2.6.1
##   [7] DT_0.34.0                   HDF5Array_1.38.0
##   [9] rhdf5filters_1.22.0         GetoptLong_1.0.5
##  [11] withr_3.0.2                 sp_2.2-0
##  [13] gridExtra_2.3               cli_3.6.5
##  [15] archive_1.1.12              textshaping_1.0.4
##  [17] sandwich_3.1-1              labeling_0.4.3
##  [19] sass_0.4.10                 nnls_1.6
##  [21] mvtnorm_1.3-3               S7_0.2.0
##  [23] readr_2.1.5                 proxy_0.4-27
##  [25] ggridges_0.5.7              systemfonts_1.3.1
##  [27] colorRamps_2.3.4            svglite_2.2.2
##  [29] scater_1.38.0               dichromat_2.0-0.1
##  [31] plotrix_3.8-4               flowCore_2.22.0
##  [33] shape_1.4.6.1               gtools_3.9.5
##  [35] crosstalk_1.2.2             vroom_1.6.6
##  [37] car_3.1-3                   Matrix_1.7-4
##  [39] RProtoBufLib_2.22.0         ggbeeswarm_0.7.2
##  [41] abind_1.4-8                 terra_1.8-70
##  [43] lifecycle_1.0.4             multcomp_1.4-29
##  [45] yaml_2.3.10                 carData_3.0-5
##  [47] rhdf5_2.54.0                SparseArray_1.10.0
##  [49] Rtsne_0.17                  grid_4.5.1
##  [51] promises_1.4.0              crayon_1.5.3
##  [53] shinydashboard_0.7.3        lattice_0.22-7
##  [55] beachmat_2.26.0             cowplot_1.2.0
##  [57] magick_2.9.0                pillar_1.11.1
##  [59] knitr_1.50                  ComplexHeatmap_2.26.0
##  [61] RTriangle_1.6-0.15          rjson_0.2.23
##  [63] codetools_0.2-20            glue_1.8.0
##  [65] V8_8.0.1                    vctrs_0.6.5
##  [67] png_0.1-8                   gtable_0.3.6
##  [69] cachem_1.1.0                xfun_0.53
##  [71] S4Arrays_1.10.0             mime_0.13
##  [73] tidygraph_1.3.1             ConsensusClusterPlus_1.74.0
##  [75] survival_3.8-3              pheatmap_1.0.13
##  [77] iterators_1.0.14            cytolib_2.22.0
##  [79] units_1.0-0                 TH.data_1.1-4
##  [81] bit64_4.6.0-1               bslib_0.9.0
##  [83] irlba_2.3.5.1               svgPanZoom_0.3.4
##  [85] vipor_0.4.7                 KernSmooth_2.23-26
##  [87] otel_0.2.0                  colorspace_2.1-2
##  [89] DBI_1.2.3                   raster_3.6-32
##  [91] tidyselect_1.2.1            curl_7.0.0
##  [93] bit_4.6.0                   compiler_4.5.1
##  [95] BiocNeighbors_2.4.0         h5mread_1.2.0
##  [97] DelayedArray_0.36.0         bookdown_0.45
##  [99] scales_1.4.0                classInt_0.4-11
## [101] distances_0.1.12            tiff_0.1-12
## [103] stringr_1.5.2               digest_0.6.37
## [105] fftwtools_0.9-11            rmarkdown_2.30
## [107] XVector_0.50.0              htmltools_0.5.8.1
## [109] pkgconfig_2.0.3             jpeg_0.1-11
## [111] fastmap_1.2.0               rlang_1.1.6
## [113] GlobalOptions_0.1.2         htmlwidgets_1.6.4
## [115] shiny_1.11.1                farver_2.1.2
## [117] jquerylib_0.1.4             zoo_1.8-14
## [119] jsonlite_2.0.0              BiocParallel_1.44.0
## [121] BiocSingular_1.26.0         RCurl_1.98-1.17
## [123] magrittr_2.0.4              Formula_1.2-5
## [125] scuttle_1.20.0              Rhdf5lib_1.32.0
## [127] Rcpp_1.1.0                  ggnewscale_0.5.2
## [129] viridis_0.6.5               stringi_1.8.7
## [131] MASS_7.3-65                 plyr_1.8.9
## [133] parallel_4.5.1              ggrepel_0.9.6
## [135] graphlayouts_1.2.2          splines_4.5.1
## [137] hms_1.1.4                   circlize_0.4.16
## [139] locfit_1.5-9.12             igraph_2.2.1
## [141] ggpubr_0.6.2                ggsignif_0.6.4
## [143] ScaledMatrix_1.18.0         reshape2_1.4.4
## [145] XML_3.99-0.19               drc_3.0-1
## [147] evaluate_1.0.5              BiocManager_1.30.26
## [149] tzdb_0.5.0                  foreach_1.5.2
## [151] tweenr_2.0.3                httpuv_1.6.16
## [153] tidyr_1.3.1                 purrr_1.1.0
## [155] polyclip_1.10-7             clue_0.3-66
## [157] ggforce_0.5.0               rsvd_1.0.5
## [159] broom_1.0.10                xtable_1.8-4
## [161] e1071_1.7-16                rstatix_0.7.3
## [163] later_1.4.4                 viridisLite_0.4.2
## [165] class_7.3-23                tibble_3.3.0
## [167] memoise_2.0.1               FlowSOM_2.18.0
## [169] beeswarm_0.4.0              cluster_2.1.8.1
## [171] concaveman_1.2.0
```

# References

Angelo, Michael, Sean C. Bendall, Rachel Finck, Matthew B. Hale, Chuck Hitzman, Alexander D. Borowsky, Richard M. Levenson, et al. 2014. “Multiplexed Ion Beam Imaging of Human Breast Tumors.” *Nature Medicine* 20 (4): 436–42.

Bhate, Salil S., Graham L. Barlow, Christian M. Schürch, and Garry P. Nolan. 2022. “Tissue Schematics Map the Specialization of Immune Tissue Motifs and Their Appropriation by Tumors.” *Cell Systems* 13 (2): 109–30.

Bodenmiller, Bernd. 2016. “Multiplexed Epitope-Based Tissue Imaging for Discovery and Healthcare Applications.” *Cell Systems* 2: 225–38.

Chen, Kok Hao, Alistair N. Boettiger, Jeffrey R. Moffitt, Siyuan Wang, and Xiaowei Zhuang. 2015. “Spatially Resolved, Highly Multiplexed Rna Profiling in Single Cells.” *Science* 348: aaa6090.

Chevrier, Stéphane, Helena L. Crowell, Vito R. T. Zanotelli, Stefanie Engler, Mark D. Robinson, and Bernd Bodenmiller. 2017. “Compensation of Signal Spillover in Suspension and Imaging Mass Cytometry.” *Cell Systems* 6: 612–20.

Giesen, Charlotte, Hao A. O. Wang, Denis Schapiro, Nevena Zivanovic, Andrea Jacobs, Bodo Hattendorf, Peter J. Schüffler, et al. 2014. “Highly Multiplexed Imaging of Tumor Tissues with Subcellular Resolution by Mass Cytometry.” *Nature Methods* 11 (4): 417–22.

Greenwald, Noah F, Geneva Miller, Erick Moen, Alex Kong, Adam Kagel, Christine Camacho, Brianna J Mcintosh, et al. 2021. “Whole-Cell Segmentation of Tissue Images with Human-Level Performance Using Large-Scale Data Annotation and Deep Learning.” *bioRxiv*, 1–29.

Gut, Gabriele, Markus D Herrmann, and Lucas Pelkmans. 2018. “Multiplexed Protein Maps Link Subcellular Organization to Cellular States.” *Science* 361: 1–13.

Jackson, Hartland W., Jana R. Fischer, Vito R. T. Zanotelli, H. Raza Ali, Robert Mechera, Savas D. Soysal, Holger Moch, et al. 2020. “The Single-Cell Pathology Landscape of Breast Cancer.” *Nature* 578 (7796): 615–20.

Lin, Jia-Ren, Benjamin Izar, Shu Wang, Clarence Yapp, Shaolin Mei, Parin M. Shah, Sandro Santagata, and Peter K. Sorger. 2018. “Highly Multiplexed Immunofluorescence Imaging of Human Tissues and Tumors Using T-Cycif and Conventional Optical Microscopes.” *eLife* 7: 1–46.

Lubeck, Eric, Ahmet F Coskun, Timur Zhiyentayev, Mubhij Ahmad, and Long Cai. 2014. “Single-Cell in Situ Rna Profiling by Sequential Hybridization.” *Nature Methods* 11: 360–61.

Schapiro, Denis, Hartland W Jackson, Swetha Raghuraman, Jana R Fischer, Vito RT Zanotelli, Daniel Schulz, Charlotte Giesen, Raúl Catena, Zsuzsanna Varga, and Bernd Bodenmiller. 2017. “HistoCAT: Analysis of Cell Phenotypes and Interactions in Multiplex Image Cytometry Data.” *Nature Methods* 14: 873–76.

Schulz, Daniel, Vito RT Zanotelli, Rana R Fischer, Denis Schapiro, Stefanie Engler, Xiao-Kang Lun, Hartland W Jackson, and Bernd Bodenmiller. 2018. “Simultaneous Multiplexed Imaging of mRNA and Proteins with Subcellular Resolution in Breast Cancer Tissue Samples by Mass Cytometry.” *Cell Systems* 6: 25–36.e5.

Schürch, Christian M., Salil S. Bhate, Graham L. Barlow, Darci J. Phillips, Luca Noti, Inti Zlobec, Pauline Chu, et al. 2020. “Coordinated Cellular Neighborhoods Orchestrate Antitumoral Immunity at the Colorectal Cancer Invasive Front.” *Cell* 182 (5): 1341–59.