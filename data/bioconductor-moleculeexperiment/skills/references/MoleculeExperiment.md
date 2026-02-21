# An introduction to the MoleculeExperiment Class

Bárbara Zita Peters Couto1,2,3, Nick Robertson1,2,3, Mu-Wei Chung1,2,3, Ellis Patrick1,2,3,4 and Shila Ghazanfar1,2,3

1School of Mathematics and Statistics, The University of Sydney, Sydney, NSW, 2006, Australia
2Charles Perkins Centre, The University of Sydney, Sydney, NSW, 2006, Australia
3Sydney Precision Data Science Centre, The University of Sydney, Sydney, NSW, 2006, Australia
4Westmead Institute for Medical Research, University of Sydney, Australia

#### 30 October 2025

# Contents

* [1 MoleculeExperiment](#moleculeexperiment)
  + [1.1 Why the MoleculeExperiment class?](#why-the-moleculeexperiment-class)
  + [1.2 Installation](#installation)
* [2 Minimal example](#minimal-example)
* [3 The ME object in detail](#the-me-object-in-detail)
  + [3.1 Constructing an ME object](#constructing-an-me-object)
    - [3.1.1 Use case 1: from dataframes to ME object](#use-case-1-from-dataframes-to-me-object)
    - [3.1.2 Use case 2: from machine’s output directory to ME object](#use-case-2-from-machines-output-directory-to-me-object)
  + [3.2 ME object structure](#me-object-structure)
    - [3.2.1 molecules slot](#molecules-slot)
    - [3.2.2 boundaries slot](#boundaries-slot)
* [4 Methods](#methods)
  + [4.1 Getters](#getters)
  + [4.2 Setters](#setters)
  + [4.3 Subsetting](#subsetting)
* [5 From MoleculeExperiment to SpatialExperiment](#from-moleculeexperiment-to-spatialexperiment)
* [6 Case Study: MoleculeExperiment and napari](#case-study-moleculeexperiment-and-napari)
* [7 SessionInfo](#sessioninfo)

# 1 MoleculeExperiment

The R package MoleculeExperiment contains functions to create and work with
objects from the new MoleculeExperiment class. We introduce this class for
analysing molecule-based spatial transcriptomics data (e.g., Xenium by 10X,
CosMx SMI by Nanostring, and Merscope by Vizgen, among others).

## 1.1 Why the MoleculeExperiment class?

The goal of the MoleculeExperiment class is to:
1. Enable analysis of spatial transcriptomics (ST) data at the molecule level,
independent of aggregating to the cell or tissue level.
2. Standardise molecule-based ST data across vendors, to hopefully facilitate
comparison of different data sources and common analytical and visualisation
workflows.
3. Enable aggregation to a `SpatialExperiment` object given combinations of
molecules and segmentation boundaries.

## 1.2 Installation

The latest release of MoleculeExperiment can be installed using:

```
if (!require("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}
BiocManager::install("MoleculeExperiment")
```

# 2 Minimal example

1. Load required libraries.

```
library(MoleculeExperiment)
library(ggplot2)
library(EBImage)
```

2. Create MoleculeExperiment object with example Xenium data, taken over a
   small patch.

```
repoDir <- system.file("extdata", package = "MoleculeExperiment")
repoDir <- paste0(repoDir, "/xenium_V1_FF_Mouse_Brain")

me <- readXenium(repoDir, keepCols = "essential")
me
#> MoleculeExperiment class
#>
#> molecules slot (1): detected
#> - detected:
#> samples (2): sample1 sample2
#> -- sample1:
#> ---- features (137): 2010300C02Rik Acsbg1 ... Zfp536 Zfpm2
#> ---- molecules (962)
#> ---- location range: [4900,4919.98] x [6400.02,6420]
#> -- sample2:
#> ---- features (143): 2010300C02Rik Acsbg1 ... Zfp536 Zfpm2
#> ---- molecules (777)
#> ---- location range: [4900.01,4919.98] x [6400.16,6419.97]
#>
#>
#> boundaries slot (1): cell
#> - cell:
#> samples (2): sample1 sample2
#> -- sample1:
#> ---- segments (5): 67500 67512 67515 67521 67527
#> -- sample2:
#> ---- segments (9): 65043 65044 ... 65070 65071
```

3. Use standardised data in ME object for molecule-level analyses. For example,
   plot a simple digital in-situ, with cell boundaries overlaid.

```
ggplot_me() +
  geom_polygon_me(me, assayName = "cell", fill = "grey") +
  geom_point_me(me) +
  # zoom in to selected patch area
  coord_cartesian(
    xlim = c(4900, 4919.98),
    ylim = c(6400.02, 6420)
  )
```

![](data:image/png;base64...)

We can plot molecules only belonging to specific genes via the `selectFeatures`
argument.

```
ggplot_me() +
  geom_polygon_me(me, assayName = "cell", fill = "grey") +
  geom_point_me(me, byColour = "feature_id", selectFeatures = c("Nrn1", "Slc17a7")) +
  # zoom in to selected patch area
  coord_cartesian(
    xlim = c(4900, 4919.98),
    ylim = c(6400.02, 6420)
  )
```

![](data:image/png;base64...)

4. Finally, it is also possible to go from a MoleculeExperiment object to a
   SpatialExperiment object. This enables the transition from a molecule-level
   analysis to a cell-level analysis with already existing tools.

```
# transform ME to SPE object
spe <- countMolecules(me)
spe
#> class: SpatialExperiment
#> dim: 178 14
#> metadata(0):
#> assays(1): counts
#> rownames(178): 2010300C02Rik Acsbg1 ... Zfp536 Zfpm2
#> rowData names(0):
#> colnames(14): sample1.67500 sample1.67512 ... sample2.65070
#>   sample2.65071
#> colData names(4): sample_id cell_id x_location y_location
#> reducedDimNames(1): spatial
#> mainExpName: NULL
#> altExpNames(0):
#> spatialCoords names(2) : x_location y_location
#> imgData names(0):
```

# 3 The ME object in detail

## 3.1 Constructing an ME object

### 3.1.1 Use case 1: from dataframes to ME object

Here we demonstrate how to work with an ME object from toy data, representing a
scenario where both the detected transcripts information and the boundary
information have already been read into R. This requires the standardisation
of the data with the `dataframeToMEList()` function.

The flexibility of the arguments in `dataframeToMEList()` enable the creation of
a standard ME object across dataframes coming from different vendors of
molecule-based spatial transcriptomics technologies.

1. Generate a toy transcripts data.frame.

```
moleculesDf <- data.frame(
  sample_id = rep(c("sample1", "sample2"), times = c(30, 20)),
  features = rep(c("gene1", "gene2"), times = c(20, 30)),
  x_coords = runif(50),
  y_coords = runif(50)
)
head(moleculesDf)
#>   sample_id features  x_coords  y_coords
#> 1   sample1    gene1 0.5644875 0.2046642
#> 2   sample1    gene1 0.1947096 0.8056139
#> 3   sample1    gene1 0.8514167 0.1470744
#> 4   sample1    gene1 0.7148988 0.8420695
#> 5   sample1    gene1 0.6412390 0.3172619
#> 6   sample1    gene1 0.6933777 0.5709389
```

2. Generate a toy boundaries data.frame.

```
boundariesDf <- data.frame(
  sample_id = rep(c("sample1", "sample2"), times = c(16, 6)),
  cell_id = rep(
    c(
      "cell1", "cell2", "cell3", "cell4",
      "cell1", "cell2"
    ),
    times = c(4, 4, 4, 4, 3, 3)
  ),
  vertex_x = c(
    0, 0.5, 0.5, 0,
    0.5, 1, 1, 0.5,
    0, 0.5, 0.5, 0,
    0.5, 1, 1, 0.5,
    0, 1, 0, 0, 1, 1
  ),
  vertex_y = c(
    0, 0, 0.5, 0.5,
    0, 0, 0.5, 0.5,
    0.5, 0.5, 1, 1,
    0.5, 0.5, 1, 1,
    0, 1, 1, 0, 0, 1
  )
)
head(boundariesDf)
#>   sample_id cell_id vertex_x vertex_y
#> 1   sample1   cell1      0.0      0.0
#> 2   sample1   cell1      0.5      0.0
#> 3   sample1   cell1      0.5      0.5
#> 4   sample1   cell1      0.0      0.5
#> 5   sample1   cell2      0.5      0.0
#> 6   sample1   cell2      1.0      0.0
```

3. Standardise transcripts dataframe to ME list format.

```
moleculesMEList <- dataframeToMEList(moleculesDf,
  dfType = "molecules",
  assayName = "detected",
  sampleCol = "sample_id",
  factorCol = "features",
  xCol = "x_coords",
  yCol = "y_coords"
)
str(moleculesMEList, max.level = 3)
#> List of 1
#>  $ detected:List of 2
#>   ..$ sample1:List of 2
#>   .. ..$ gene1: tibble [20 × 2] (S3: tbl_df/tbl/data.frame)
#>   .. ..$ gene2: tibble [10 × 2] (S3: tbl_df/tbl/data.frame)
#>   ..$ sample2:List of 1
#>   .. ..$ gene2: tibble [20 × 2] (S3: tbl_df/tbl/data.frame)
```

4. Standardise boundaries dataframe to ME list format.

```
boundariesMEList <- dataframeToMEList(boundariesDf,
  dfType = "boundaries",
  assayName = "cell",
  sampleCol = "sample_id",
  factorCol = "cell_id",
  xCol = "vertex_x",
  yCol = "vertex_y"
)
str(boundariesMEList, 3)
#> List of 1
#>  $ cell:List of 2
#>   ..$ sample1:List of 4
#>   .. ..$ cell1: tibble [4 × 2] (S3: tbl_df/tbl/data.frame)
#>   .. ..$ cell2: tibble [4 × 2] (S3: tbl_df/tbl/data.frame)
#>   .. ..$ cell3: tibble [4 × 2] (S3: tbl_df/tbl/data.frame)
#>   .. ..$ cell4: tibble [4 × 2] (S3: tbl_df/tbl/data.frame)
#>   ..$ sample2:List of 2
#>   .. ..$ cell1: tibble [3 × 2] (S3: tbl_df/tbl/data.frame)
#>   .. ..$ cell2: tibble [3 × 2] (S3: tbl_df/tbl/data.frame)
```

5. Create an ME object by using the MoleculeExperiment object constructor.

```
toyME <- MoleculeExperiment(
  molecules = moleculesMEList,
  boundaries = boundariesMEList
)
toyME
#> MoleculeExperiment class
#>
#> molecules slot (1): detected
#> - detected:
#> samples (2): sample1 sample2
#> -- sample1:
#> ---- features (2): gene1 gene2
#> ---- molecules (30)
#> ---- location range: [0.05,0.97] x [0.03,0.99]
#> -- sample2:
#> ---- features (1): gene2
#> ---- molecules (20)
#> ---- location range: [0.01,1] x [0.01,0.94]
#>
#>
#> boundaries slot (1): cell
#> - cell:
#> samples (2): sample1 sample2
#> -- sample1:
#> ---- segments (4): cell1 cell2 cell3 cell4
#> -- sample2:
#> ---- segments (2): cell1 cell2
```

6. Add boundaries from an external segmentation algorithm.

In this example, we use the extent of the molecules of generated for `toyME` to
align the boundaries with the molecules. In general, the extent of the
segmentation is required for this alignment.

```
repoDir <- system.file("extdata", package = "MoleculeExperiment")
segMask <- paste0(repoDir, "/BIDcell_segmask.tif")
boundaries(toyME, "BIDcell_segmentation") <- readSegMask(
  # use the molecule extent to define the boundary extent
  extent(toyME, assayName = "detected"),
  path = segMask, assayName = "BIDcell_segmentation",
  sample_id = "sample1", background_value = 0
)

toyME
#> MoleculeExperiment class
#>
#> molecules slot (1): detected
#> - detected:
#> samples (2): sample1 sample2
#> -- sample1:
#> ---- features (2): gene1 gene2
#> ---- molecules (30)
#> ---- location range: [0.05,0.97] x [0.03,0.99]
#> -- sample2:
#> ---- features (1): gene2
#> ---- molecules (20)
#> ---- location range: [0.01,1] x [0.01,0.94]
#>
#>
#> boundaries slot (2): cell BIDcell_segmentation
#> - cell:
#> samples (2): sample1 sample2
#> -- sample1:
#> ---- segments (4): cell1 cell2 cell3 cell4
#> -- sample2:
#> ---- segments (2): cell1 cell2
#> - BIDcell_segmentation:
#> samples (1): sample1
#> -- sample1:
#> ---- segments (88): 54748 54771 ... 58184 58186
```

Displayed below is the BIDcell segmentation image added to `toyME` as another boundaries

```
BIDcell_segmask_img <- EBImage::readImage(segMask)
EBImage::display(BIDcell_segmask_img, method = "raster")
```

![](data:image/png;base64...)

Finally, a digital in-situ, with cell boundaries and BIDcell segmentation boundaries (red polygons in sample1) can be plotted.

```
ggplot_me() +
  geom_polygon_me(toyME, assayName = "cell", byFill = "segment_id", colour = "black", alpha = 0.3) +
  geom_polygon_me(toyME, assayName = "BIDcell_segmentation", fill = NA, colour = "red" ) +
  geom_point_me(toyME, assayName = "detected", byColour = "feature_id", size = 1) +
  theme_classic()
```

![](data:image/png;base64...)

### 3.1.2 Use case 2: from machine’s output directory to ME object

The MoleculeExperiment package also provides functions to directly work with
the directories containing output files of commonly used technologies.
This is especially useful to work with data from multiple samples.
Here we provide convenience functions to read in data from Xenium (10X
Genomics), CosMx (Nanostring) and Merscope (Vizgen).

```
repoDir <- system.file("extdata", package = "MoleculeExperiment")
repoDir <- paste0(repoDir, "/xenium_V1_FF_Mouse_Brain")

me <- readXenium(repoDir, keepCols = "essential", addBoundaries = "cell")
me
#> MoleculeExperiment class
#>
#> molecules slot (1): detected
#> - detected:
#> samples (2): sample1 sample2
#> -- sample1:
#> ---- features (137): 2010300C02Rik Acsbg1 ... Zfp536 Zfpm2
#> ---- molecules (962)
#> ---- location range: [4900,4919.98] x [6400.02,6420]
#> -- sample2:
#> ---- features (143): 2010300C02Rik Acsbg1 ... Zfp536 Zfpm2
#> ---- molecules (777)
#> ---- location range: [4900.01,4919.98] x [6400.16,6419.97]
#>
#>
#> boundaries slot (1): cell
#> - cell:
#> samples (2): sample1 sample2
#> -- sample1:
#> ---- segments (5): 67500 67512 67515 67521 67527
#> -- sample2:
#> ---- segments (9): 65043 65044 ... 65070 65071
```

readXenium() standardises the transcript and boundary information such that the
column names are consistent across technologies when handling ME objects.

In addition, the `keepCols` argument of `readXenium()` enables the user to
decide if they want to keep all data that is vendor-specific (e.g., column with
qv score), some columns of interest, or only the essential columns. By default,
it is set to `essential`, which refers to feature names, x and y locations in
the transcripts file, and segment ids, x and y locations for the vertices
defining the boundaries in the boundaries file.

For CosMx and Merscope data we provide convenience functions that standardise
the raw transcripts data into a MoleculeExperiment object and additionally read
the boundaries included in the standard data releases.

```
repoDir <- system.file("extdata", package = "MoleculeExperiment")
repoDir <- paste0(repoDir, "/nanostring_Lung9_Rep1")

meCosmx <- readCosmx(repoDir, keepCols = "essential", addBoundaries = "cell")
meCosmx
#> MoleculeExperiment class
#>
#> molecules slot (1): detected
#> - detected:
#> samples (2): sample_1 sample_2
#> -- sample_1:
#> ---- features (969): AATK ABL1 ... YES1 ZFP36
#> ---- molecules (23844)
#> ---- location range: [924.01,1031.94] x [26290,26398]
#> -- sample_2:
#> ---- features (943): AATK ABL1 ... YBX3 ZFP36
#> ---- molecules (7155)
#> ---- location range: [2894.03,3002] x [26290.05,26398]
#>
#>
#> boundaries slot (1): cell
#> - cell:
#> samples (2): sample_1 sample_2
#> -- sample_1:
#> ---- segments (113): 1 2 ... 112 113
#> -- sample_2:
#> ---- segments (83): 114 115 ... 195 196
```

```
repoDir <- system.file("extdata", package = "MoleculeExperiment")
repoDir <- paste0(repoDir, "/vizgen_HumanOvarianCancerPatient2Slice2")
meMerscope <- readMerscope(repoDir,
  keepCols = "essential",
  addBoundaries = "cell"
)
meMerscope
#> MoleculeExperiment class
#>
#> molecules slot (1): detected
#> - detected:
#> samples (1): vizgen_HumanOvarianCancerPatient2Slice2
#> -- vizgen_HumanOvarianCancerPatient2Slice2:
#> ---- features (486): ACKR3 ACTA2 ... ZBED2 ZEB1
#> ---- molecules (15160)
#> ---- location range: [10219.02,10386.83] x [8350.93,8395.3]
#>
#>
#> boundaries slot (1): cell
#> - cell:
#> samples (1): vizgen_HumanOvarianCancerPatient2Slice2
#> -- vizgen_HumanOvarianCancerPatient2Slice2:
#> ---- segments (24): 45862 45865 ... 54562 54564
```

## 3.2 ME object structure

A MoleculeExperiment object contains a @molecules slot and an optional
@boundaries slot.

Both slots have a hierarchical list structure that consists of a nested list,
ultimately ending in a data.frame/tibble. Traditional rectangular data
structures, like dataframes, redundantly store gene names and sample IDs for
the millions of transcripts. In contrast, data in a list enables us to avoid
this redundancy and work with objects of smaller size.

### 3.2.1 molecules slot

The @molecules slot contains molecule-level information. The essential data it
contains is the feature name (e.g., gene names) and x and y locations of the
detected molecules (e.g., transcripts), in each sample. Nevertheless, the user
can also decide to keep all molecule metadata (e.g., subcellular location:
nucleus/cytoplasm).

The nested list in the molecules slot has the following hierarchical structure:
“assay name” > “sample ID” > “feature name” > dataframe/tibble with X and Y
locations (and other additional columns of interest).

```
showMolecules(me)
#> List of 1
#>  $ detected:List of 2
#>   ..$ sample1:List of 137
#>   .. ..$ 2010300C02Rik        : tibble [11 × 2] (S3: tbl_df/tbl/data.frame)
#>   .. ..$ Acsbg1               : tibble [6 × 2] (S3: tbl_df/tbl/data.frame)
#>   .. .. [list output truncated]
#>   ..$ sample2:List of 143
#>   .. ..$ 2010300C02Rik: tibble [9 × 2] (S3: tbl_df/tbl/data.frame)
#>   .. ..$ Acsbg1       : tibble [10 × 2] (S3: tbl_df/tbl/data.frame)
#>   .. .. [list output truncated]
```

### 3.2.2 boundaries slot

The @boundaries slot contains information from segmentation analyses (e.g.,
cell boundaries, or nucleus boundaries).

The nested list in the boundaries slot has the following hierarchical structure:
“assay name” > “sample ID” > “segment ID” > dataframe/tibble with the vertex
coordinates defining the boundaries for each segment. For example, if the
boundary information is for cells, the assay name can be set to “cell”;
or “nucleus” if one is using nucleus boundaries.

```
showBoundaries(me)
#> List of 1
#>  $ cell:List of 2
#>   ..$ sample1:List of 5
#>   .. ..$ 67500: tibble [13 × 2] (S3: tbl_df/tbl/data.frame)
#>   .. ..$ 67512: tibble [13 × 2] (S3: tbl_df/tbl/data.frame)
#>   .. .. [list output truncated]
#>   ..$ sample2:List of 9
#>   .. ..$ 65043: tibble [13 × 2] (S3: tbl_df/tbl/data.frame)
#>   .. ..$ 65044: tibble [13 × 2] (S3: tbl_df/tbl/data.frame)
#>   .. .. [list output truncated]
```

# 4 Methods

Here we introduce basic methods to access and manipulate data in an ME object,
i.e., getters and setters, respectively. We also describe subsetting samples.

## 4.1 Getters

The main getters are molecules() and boundaries(). NOTE: the output of these
methods is the ME nested list, which can be very large on screen. Thus, these
getters should be used when wanting to work with the data. To quickly view the
slot contents, use showMolecules() and showBoundaries() instead.

```
# NOTE: output not shown as it is too large
# access molecules slot (note: assay name needs to be specified)
molecules(me, assayName = "detected")
# access cell boundary information in boundaries slot
boundaries(me, assayName = "cell")
```

For ease of use, these getters have arguments that enable the transformation of
the data from a nested ME list format to a data.frame format.

```
molecules(me, assayName = "detected", flatten = TRUE)
#> # A tibble: 1,739 × 4
#>    x_location y_location feature_id    sample_id
#>  *      <dbl>      <dbl> <chr>         <chr>
#>  1      4918.      6411. 2010300C02Rik sample1
#>  2      4901.      6417. 2010300C02Rik sample1
#>  3      4901.      6417. 2010300C02Rik sample1
#>  4      4910.      6417. 2010300C02Rik sample1
#>  5      4908.      6413. 2010300C02Rik sample1
#>  6      4911.      6407. 2010300C02Rik sample1
#>  7      4915.      6411. 2010300C02Rik sample1
#>  8      4916.      6412. 2010300C02Rik sample1
#>  9      4901.      6415. 2010300C02Rik sample1
#> 10      4906.      6417. 2010300C02Rik sample1
#> # ℹ 1,729 more rows
```

```
boundaries(me, assayName = "cell", flatten = TRUE)
#> # A tibble: 182 × 4
#>    x_location y_location segment_id sample_id
#>  *      <dbl>      <dbl> <chr>      <chr>
#>  1      4905.      6400. 67500      sample1
#>  2      4899.      6401. 67500      sample1
#>  3      4894.      6408. 67500      sample1
#>  4      4890.      6418. 67500      sample1
#>  5      4887.      6423. 67500      sample1
#>  6      4887.      6425. 67500      sample1
#>  7      4890.      6427. 67500      sample1
#>  8      4891.      6427. 67500      sample1
#>  9      4894.      6426. 67500      sample1
#> 10      4908.      6421. 67500      sample1
#> # ℹ 172 more rows
```

Other getters include: features() and segmentIDs().

```
# get features in sample 1
features(me, assayName = "detected")[[1]]
#>   [1] "2010300C02Rik"         "Acsbg1"                "Adamts2"
#>   [4] "Adamtsl1"              "Angpt1"                "Aqp4"
#>   [7] "Arc"                   "Arhgap12"              "Arhgef28"
#>  [10] "BLANK_0022"            "BLANK_0414"            "BLANK_0424"
#>  [13] "Bdnf"                  "Bhlhe40"               "Btbd11"
#>  [16] "Cabp7"                 "Calb1"                 "Calb2"
#>  [19] "Car4"                  "Cbln4"                 "Ccn2"
#>  [22] "Cdh20"                 "Cdh4"                  "Cdh6"
#>  [25] "Cdh9"                  "Chrm2"                 "Clmn"
#>  [28] "Cntn6"                 "Cntnap5b"              "Cplx3"
#>  [31] "Cpne4"                 "Cpne6"                 "Crh"
#>  [34] "Cux2"                  "Dkk3"                  "Dner"
#>  [37] "Dpy19l1"               "Epha4"                 "Fhod3"
#>  [40] "Fos"                   "Gad1"                  "Galnt14"
#>  [43] "Garnl3"                "Gfra2"                 "Gjc3"
#>  [46] "Gli3"                  "Gng12"                 "Gsg1l"
#>  [49] "Gucy1a1"               "Hat1"                  "Hpcal1"
#>  [52] "Id2"                   "Igf2"                  "Igfbp4"
#>  [55] "Igfbp5"                "Igfbp6"                "Igsf21"
#>  [58] "Inpp4b"                "Kcnh5"                 "Kctd12"
#>  [61] "Lamp5"                 "Lypd6"                 "Lyz2"
#>  [64] "Mapk4"                 "Meis2"                 "Myl4"
#>  [67] "Myo16"                 "Ndst3"                 "Necab1"
#>  [70] "NegControlProbe_00031" "NegControlProbe_00062" "Nell1"
#>  [73] "Neto2"                 "Neurod6"               "Npnt"
#>  [76] "Nrep"                  "Nrn1"                  "Nrp2"
#>  [79] "Ntsr2"                 "Nwd2"                  "Opalin"
#>  [82] "Orai2"                 "Pde11a"                "Pde7b"
#>  [85] "Pdzd2"                 "Pdzrn3"                "Penk"
#>  [88] "Pip5k1b"               "Plch1"                 "Plcxd2"
#>  [91] "Plekha2"               "Pou3f1"                "Ppp1r1b"
#>  [94] "Prdm8"                 "Prox1"                 "Prr16"
#>  [97] "Pvalb"                 "Rasgrf2"               "Rasl10a"
#> [100] "Rbp4"                  "Rfx4"                  "Rims3"
#> [103] "Rmst"                  "Ror1"                  "Rorb"
#> [106] "Rprm"                  "Rspo1"                 "Satb2"
#> [109] "Sema3a"                "Sema6a"                "Shisa6"
#> [112] "Sipa1l3"               "Slc17a6"               "Slc17a7"
#> [115] "Slc39a12"              "Slit2"                 "Sncg"
#> [118] "Sorcs3"                "Sox10"                 "Sox11"
#> [121] "Spi1"                  "Strip2"                "Syndig1"
#> [124] "Syt2"                  "Tanc1"                 "Thsd7a"
#> [127] "Tle4"                  "Tmem132d"              "Tox"
#> [130] "Trpc4"                 "Unc13c"                "Vat1l"
#> [133] "Vip"                   "Vwc2l"                 "Wfs1"
#> [136] "Zfp536"                "Zfpm2"
```

```
segmentIDs(me, "cell")
#> $sample1
#> [1] "67500" "67512" "67515" "67521" "67527"
#>
#> $sample2
#> [1] "65043" "65044" "65051" "65055" "65063" "65064" "65067" "65070" "65071"
```

## 4.2 Setters

Main setters include `molecules<-` and `boundaries<-`.
For example, with `boundaries<-` one can add new segmentation assay information
to the boundaries slot. Here we demonstrate this with the nucleus boundaries.

```
repoDir <- system.file("extdata", package = "MoleculeExperiment")
repoDir <- paste0(repoDir, "/xenium_V1_FF_Mouse_Brain")
nucleiMEList <- readBoundaries(
  dataDir = repoDir,
  pattern = "nucleus_boundaries.csv",
  segmentIDCol = "cell_id",
  xCol = "vertex_x",
  yCol = "vertex_y",
  keepCols = "essential",
  boundariesAssay = "nucleus",
  scaleFactorVector = 1
)

boundaries(me, "nucleus") <- nucleiMEList
me # note the addition of the nucleus boundaries to the boundaries slot
#> MoleculeExperiment class
#>
#> molecules slot (1): detected
#> - detected:
#> samples (2): sample1 sample2
#> -- sample1:
#> ---- features (137): 2010300C02Rik Acsbg1 ... Zfp536 Zfpm2
#> ---- molecules (962)
#> ---- location range: [4900,4919.98] x [6400.02,6420]
#> -- sample2:
#> ---- features (143): 2010300C02Rik Acsbg1 ... Zfp536 Zfpm2
#> ---- molecules (777)
#> ---- location range: [4900.01,4919.98] x [6400.16,6419.97]
#>
#>
#> boundaries slot (2): cell nucleus
#> - cell:
#> samples (2): sample1 sample2
#> -- sample1:
#> ---- segments (5): 67500 67512 67515 67521 67527
#> -- sample2:
#> ---- segments (9): 65043 65044 ... 65070 65071
#> - nucleus:
#> samples (2): sample1 sample2
#> -- sample1:
#> ---- segments (5): 67500 67512 67515 67521 67527
#> -- sample2:
#> ---- segments (5): 65044 65051 65055 65063 65064
```

The additional boundaries can be accessed, e.g. for visualisation.

```
ggplot_me() +
  # add cell segments and colour by cell id
  geom_polygon_me(me, byFill = "segment_id", colour = "black", alpha = 0.1) +
  # add molecule points and colour by feature name
  geom_point_me(me, byColour = "feature_id", size = 0.1) +
  # add nuclei segments and colour the border with red
  geom_polygon_me(me, assayName = "nucleus", fill = NA, colour = "red") +
  # zoom in to selected patch area
  coord_cartesian(xlim = c(4900, 4919.98), ylim = c(6400.02, 6420))
```

![](data:image/png;base64...)

## 4.3 Subsetting

We can subset a MoleculeExperiment object via the `subset_by_extent` function.
In this example, we define the new extent which we want to subset, as an area
of 10um from the topleft corner.

```
new_extent = extent(meMerscope, "detected") - c(0, 100, 0, 0)
# new_extent = c(xmin = 924, xmax = 950, ymin = 26290, ymax = 26330)
new_extent
#>      xmin      xmax      ymin      ymax
#> 10219.025 10286.827  8350.930  8395.296

me_sub = subset_by_extent(meMerscope, new_extent)
me_sub
#> MoleculeExperiment class
#>
#> molecules slot (1): detected
#> - detected:
#> samples (1): vizgen_HumanOvarianCancerPatient2Slice2
#> -- vizgen_HumanOvarianCancerPatient2Slice2:
#> ---- features (486): ACKR3 ACTA2 ... ZBED2 ZEB1
#> ---- molecules (7838)
#> ---- location range: [10219.02,10286.51] x [8355.75,8395.3]
#>
#>
#> boundaries slot (1): cell
#> - cell:
#> samples (1): vizgen_HumanOvarianCancerPatient2Slice2
#> -- vizgen_HumanOvarianCancerPatient2Slice2:
#> ---- segments (9): 54543 54545 ... 54562 54564

g1 = ggplot_me() +
  geom_polygon_me(meMerscope, byFill = "segment_id", colour = "black", alpha = 0.1) +
  geom_point_me(meMerscope, byColour = "feature_id", size = 0.1) +
  geom_polygon_me(meMerscope, assayName = "cell", fill = NA, colour = "red") +
  ggtitle("Before subsetting")
g2 = ggplot_me() +
  geom_polygon_me(me_sub, byFill = "segment_id", colour = "black", alpha = 0.1) +
  geom_point_me(me_sub, byColour = "feature_id", size = 0.1) +
  geom_polygon_me(me_sub, assayName = "cell", fill = NA, colour = "red") +
  ggtitle("After subsetting")

g1
```

![](data:image/png;base64...)

```
g2
```

![](data:image/png;base64...)

# 5 From MoleculeExperiment to SpatialExperiment

If one is interested in continuing downstream analysis at the cell-level,
the MoleculeExperiment package also provides a convenience function,
countMolecules(), that enables the transition from a MoleculeExperiment
object to a SpatialExperiment object. With this functionality, it is possible to
use already existing methods for cell-level data analysis.

```
spe <- countMolecules(me, boundariesAssay = "nucleus")
spe
#> class: SpatialExperiment
#> dim: 178 10
#> metadata(0):
#> assays(1): counts
#> rownames(178): 2010300C02Rik Acsbg1 ... Zfp536 Zfpm2
#> rowData names(0):
#> colnames(10): sample1.67500 sample1.67512 ... sample2.65063
#>   sample2.65064
#> colData names(4): sample_id cell_id x_location y_location
#> reducedDimNames(1): spatial
#> mainExpName: NULL
#> altExpNames(0):
#> spatialCoords names(2) : x_location y_location
#> imgData names(0):
```

# 6 Case Study: MoleculeExperiment and napari

Load the demonstration data, which includes molecules for 2 genes.

```
data(small_me)
```

Read in virtual dissection CSV file, exported from napari (screenshot), of the morphology image.

![](data:image/png;base64...)

screenshot of napari for virtual dissection

```
bds_colours <- setNames(
  c("#F8766D", "#00BFC4"),
  c("Region 1", "Region 2")
)

fts_colours <- setNames(
  c("#FFD700", "#90EE90"),
  c("Pou3f1", "Sema3a")
)

file_path <- system.file("extdata/tiny_brain_shape2.csv", package = "MoleculeExperiment")

bds_shape_raw <- read.csv(file = file_path, header = TRUE)
bds_shape_raw$sample_id <- "xenium_tiny_subset"
bds_shape_raw$regionName <- names(bds_colours)[bds_shape_raw$index + 1]

bds_shape <- dataframeToMEList(bds_shape_raw,
  dfType = "boundaries",
  assayName = "virtualDissection",
  sampleCol = "sample_id",
  factorCol = "regionName",
  xCol = "axis.1",
  yCol = "axis.0",
  scaleFactor = 0.2125
)

boundaries(small_me, "virtualDissection") <- bds_shape
```

We can plot the resulting MoleculeExperiment using the following code.

```
g <- ggplot() +
  geom_point_me(
    small_me,
    assayName = "detected", byColour = "feature_id", size = 0.2
  ) +
  geom_polygon_me(
    small_me,
    assayName = "cell", fill = NA, colour = "grey50", size = 0.1
  ) +
  geom_polygon_me(
    small_me,
    assayName = "nucleus", fill = NA, colour = "black", size = 0.1
  ) +
  geom_polygon_me(
    small_me,
    assayName = "virtualDissection", byFill = "segment_id", alpha = 0.3
  ) +
  scale_y_reverse() +
  theme_classic() +
  theme(axis.text = element_blank()) +
  theme(axis.ticks = element_blank()) +
  coord_fixed() +
  scale_colour_manual(values = fts_colours) +
  scale_fill_manual(values = bds_colours) +
  guides(color = guide_legend(override.aes = list(size = 2)))
g
```

![](data:image/png;base64...)

Now that we have added the virtual dissection boundaries, we can use countMolecules to generate psuedobulk expressions over these regions.

```
spe <- countMolecules(
  small_me, boundariesAssay = "virtualDissection")
spe
```

# 7 SessionInfo

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
#> [1] EBImage_4.52.0            ggplot2_4.0.0
#> [3] MoleculeExperiment_1.10.0 BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] SummarizedExperiment_1.40.0 gtable_0.3.6
#>  [3] rjson_0.2.23                xfun_0.53
#>  [5] bslib_0.9.0                 htmlwidgets_1.6.4
#>  [7] rhdf5_2.54.0                Biobase_2.70.0
#>  [9] lattice_0.22-7              rhdf5filters_1.22.0
#> [11] vctrs_0.6.5                 tools_4.5.1
#> [13] bitops_1.0-9                generics_0.1.4
#> [15] stats4_4.5.1                parallel_4.5.1
#> [17] tibble_3.3.0                pkgconfig_2.0.3
#> [19] Matrix_1.7-4                data.table_1.17.8
#> [21] RColorBrewer_1.1-3          S7_0.2.0
#> [23] S4Vectors_0.48.0            lifecycle_1.0.4
#> [25] farver_2.1.2                compiler_4.5.1
#> [27] tinytex_0.57                terra_1.8-70
#> [29] tiff_0.1-12                 Seqinfo_1.0.0
#> [31] codetools_0.2-20            htmltools_0.5.8.1
#> [33] sass_0.4.10                 RCurl_1.98-1.17
#> [35] yaml_2.3.10                 pillar_1.11.1
#> [37] jquerylib_0.1.4             BiocParallel_1.44.0
#> [39] SingleCellExperiment_1.32.0 DelayedArray_0.36.0
#> [41] cachem_1.1.0                magick_2.9.0
#> [43] abind_1.4-8                 tidyselect_1.2.1
#> [45] locfit_1.5-9.12             digest_0.6.37
#> [47] purrr_1.1.0                 dplyr_1.1.4
#> [49] bookdown_0.45               labeling_0.4.3
#> [51] fastmap_1.2.0               grid_4.5.1
#> [53] cli_3.6.5                   SparseArray_1.10.0
#> [55] magrittr_2.0.4              S4Arrays_1.10.0
#> [57] utf8_1.2.6                  dichromat_2.0-0.1
#> [59] withr_3.0.2                 scales_1.4.0
#> [61] bit64_4.6.0-1               rmarkdown_2.30
#> [63] XVector_0.50.0              matrixStats_1.5.0
#> [65] fftwtools_0.9-11            jpeg_0.1-11
#> [67] bit_4.6.0                   png_0.1-8
#> [69] SpatialExperiment_1.20.0    evaluate_1.0.5
#> [71] knitr_1.50                  GenomicRanges_1.62.0
#> [73] IRanges_2.44.0              rlang_1.1.6
#> [75] Rcpp_1.1.0                  glue_1.8.0
#> [77] BiocManager_1.30.26         BiocGenerics_0.56.0
#> [79] jsonlite_2.0.0              Rhdf5lib_1.32.0
#> [81] R6_2.6.1                    MatrixGenerics_1.22.0
```