# Statial

Farhan Ameen1, Sourish Iyengar1, Alex Qin1 and Ellis Patrick1,2

1School of Mathematics and Statistics, University of Sydney, Australia
2Westmead Institute for Medical Research, University of Sydney, Australia

#### 30 October 2025

# Contents

* [1 Installation](#installation)
* [2 Load packages](#load-packages)
* [3 Overview](#overview)
* [4 Loading example data](#loading-example-data)
* [5 Kontextual: Context aware spatial relationships](#kontextual-context-aware-spatial-relationships)
  + [5.1 Using cell type hierarchies to define a “context”](#using-cell-type-hierarchies-to-define-a-context)
  + [5.2 Application on triple negative breast cancer image.](#application-on-triple-negative-breast-cancer-image.)
  + [5.3 Calculating all pairwise relationships](#calculating-all-pairwise-relationships)
  + [5.4 Associating the relationships with survival outcomes.](#associating-the-relationships-with-survival-outcomes.)
* [6 SpatioMark: Identifying continuous changes in cell state](#spatiomark-identifying-continuous-changes-in-cell-state)
  + [6.1 Continuous cell state changes within a single image](#continuous-cell-state-changes-within-a-single-image)
  + [6.2 Continuous cell state changes across all images](#continuous-cell-state-changes-across-all-images)
  + [6.3 Contamination (Lateral marker spill over)](#contamination-lateral-marker-spill-over)
  + [6.4 Associate continuous state changes with survival outcomes](#associate-continuous-state-changes-with-survival-outcomes)
* [7 Region analysis using lisaClust](#region-analysis-using-lisaclust)
* [8 Marker Means](#marker-means)
* [9 Patient classification](#patient-classification)
* [10 References](#references)
* **Appendix**
* [A sessionInfo](#sessioninfo)

# 1 Installation

```
# Install the package from Bioconductor
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}
BiocManager::install("Statial")
```

# 2 Load packages

```
# Loading required packages
library(Statial)
library(spicyR)
library(ClassifyR)
library(lisaClust)
library(dplyr)
library(SingleCellExperiment)
library(ggplot2)
library(ggsurvfit)
library(survival)
library(tibble)
library(treekoR)

theme_set(theme_classic())
nCores <- 1
```

# 3 Overview

There are over 37 trillion cells in the human body, each taking up different forms and functions. The behaviour of these cells can be described by canonical characteristics, but their functions can also dynamically change based on their environmental context. Understanding the interplay between cells is key to understanding their mechanisms of action and how they contribute to human disease. `Statial` is a suite of functions to quantify the spatial relationships between cell types. This guide will provide a step-by-step overview of some key functions within `Statial`.

# 4 Loading example data

To illustrate the functionality of Statial we will use a multiplexed ion beam imaging by time-of-flight (MIBI-TOF) dataset profiling tissue from triple-negative breast cancer patients\(^1\) by Keren et al., 2018. This dataset simultaneously quantifies *in situ* expression of 36 proteins in 34 immune rich patients. *Note:* The data contains some “uninformative” probes and the original cohort included 41 patients.

These images are stored in a `SingleCellExperiment` object called `kerenSCE`. This object contains 57811 cells across 10 images and includes information on cell type and patient survival.

*Note:* The original dataset was reduced down from 41 images to 10 images for the purposes of this vignette, due to size restrictions.

```
# Load breast cancer
data("kerenSCE")

kerenSCE
#> class: SingleCellExperiment
#> dim: 48 57811
#> metadata(0):
#> assays(1): intensities
#> rownames(48): Na Si ... Ta Au
#> rowData names(0):
#> colnames(57811): 1 2 ... 171281 171282
#> colData names(8): x y ... Survival_days_capped Censored
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
```

# 5 Kontextual: Context aware spatial relationships

`Kontextual` is a method for performing inference on cell localisation which explicitly defines the contexts in which spatial relationships between cells can be identified and interpreted. These contexts may represent landmarks, spatial domains, or groups of functionally similar cells which are consistent across regions. By modelling spatial relationships between cells relative to these contexts, `Kontextual` produces robust spatial quantifications that are not confounded by biases such as the choice of region to image and the tissue structure present in the images.

In this example we demonstrate how cell type hierarchies can be used as a means to derive appropriate “contexts” for the evaluation of cell localisation. We then demonstrate the types of conclusions which `Kontextual` enables.

## 5.1 Using cell type hierarchies to define a “context”

A cell type hierarchy may be used to define the “context” in which cell type relationships are evaluated within. A cell type hierarchy defines how cell types are functionally related to one another. The bottom of the hierarchy represents homogeneous populations of a cell type (child), the cell populations at the nodes of the hierarchy represent broader parent populations with shared generalised function. For example CD4 T cells may be considered a child population to the Immune parent population.

There are two ways to define the cell type hierarchy. First, they can be defined based on our biological understanding of the cell types. We can represent this by creating a named list containing the names of each parent and the associated vector of child cell types.

*Note:* The `all` vector must be created to include cell types which do not have a parent e.g. the *undefined* cell type in this data set.

```
# Examine all cell types in image
unique(kerenSCE$cellType)
#>  [1] "Keratin_Tumour" "CD3_Cell"       "B"              "CD4_Cell"
#>  [5] "Dc/Mono"        "Unidentified"   "Macrophages"    "CD8_Cell"
#>  [9] "other immune"   "Endothelial"    "Mono/Neu"       "Mesenchymal"
#> [13] "Neutrophils"    "NK"             "Tumour"         "DC"
#> [17] "Tregs"

# Named list of parents and their child cell types
biologicalHierarchy = list(
  "tumour" = c("Keratin_Tumour", "Tumour"),
  "tcells" = c("CD3_Cell", "CD4_Cell", "CD8_Cell", "Tregs"),
  "myeloid" = c("Dc/Mono", "DC", "Mono/Neu", "Macrophages", "Neutrophils"),
  "tissue" = c("Endothelial", "Mesenchymal")
)

# Adding more broader immune parent populationse
biologicalHierarchy$immune = c(biologicalHierarchy$bcells,
                               biologicalHierarchy$tcells,
                               biologicalHierarchy$myeloid,
                               "NK", "other immune", "B")

# Creating a vector for all cellTypes
all <- unique(kerenSCE$cellType)
```

Alternatively, you can use the `treeKor` bioconductor package [treekoR](http://www.bioconductor.org/packages/release/bioc/html/treekoR.html) to define these hierarchies in a data driven way.

*Note:* These parent populations may not be accurate as we are using a small subset of the data.

```
# Calculate hierarchy using treekoR
kerenTree <- treekoR::getClusterTree(t(assay(kerenSCE, "intensities")),
                            kerenSCE$cellType,
                            hierarchy_method="hopach",
                            hopach_K = 1)

# Convert treekoR result to a name list of parents and children.
treekorParents = getParentPhylo(kerenTree)

treekorParents
#> $parent_1
#> [1] "Dc/Mono"     "Macrophages" "NK"
#>
#> $parent_2
#> [1] "CD3_Cell" "B"        "CD4_Cell" "CD8_Cell" "Tregs"
#>
#> $parent_3
#> [1] "Endothelial" "Mesenchymal" "DC"
#>
#> $parent_4
#> [1] "Unidentified" "other immune" "Mono/Neu"     "Neutrophils"  "Tumour"
```

## 5.2 Application on triple negative breast cancer image.

Here we examine an image highlighted in the Keren et al. 2018 manuscript where accounting for context information enables new conclusions. In image 6 of the Keren et al. dataset, we can see that *p53+ tumour cells* and *immune cells* are dispersed i.e. these two cell types are not mixing. However we can also see that *p53+ tumour cells* appear much more localised to *immune cells* relative to the tumour context (*tumour cells* and *p53+ tumour cells*).

```
# Lets define a new cell type vector
kerenSCE$cellTypeNew <- kerenSCE$cellType

# Select for all cells that express higher than baseline level of p53
p53Pos <- assay(kerenSCE)["p53", ] > -0.300460

# Find p53+ tumour cells
kerenSCE$cellTypeNew[kerenSCE$cellType %in% biologicalHierarchy$tumour] <- "Tumour"
kerenSCE$cellTypeNew[p53Pos & kerenSCE$cellType %in% biologicalHierarchy$tumour] <- "p53_Tumour"

# Group all immune cells under the name "Immune"
kerenSCE$cellTypeNew[kerenSCE$cellType %in% biologicalHierarchy$immune] <- "Immune"

# Plot image 6
kerenSCE |>
  colData() |>
  as.data.frame() |>
  filter(imageID == "6") |>
  filter(cellTypeNew %in% c("Immune", "Tumour", "p53_Tumour")) |>
  arrange(cellTypeNew) |>
  ggplot(aes(x = x, y = y, color = cellTypeNew)) +
  geom_point(size = 1) +
  scale_colour_manual(values = c("Immune" = "#505050", "p53_Tumour" = "#64BC46", "Tumour" = "#D6D6D6")) +
  guides(colour = guide_legend(title = "Cell types", override.aes = list(size = 3)))
```

![](data:image/png;base64...)

`Kontextual` accepts a `SingleCellExperiment` object, a single image, or list of images from a `SingleCellExperiment` object, which gets passed into the `cells` argument. The two cell types which will be evaluated are specified in the `to` and `from` arguments. A parent population must also be specified in the `parent` argument, note the parent cell population must include the `to` cell type. The argument `r` will specify the radius which the cell relationship will be evaluated on. `Kontextual` supports parallel processing, the number of cores can be specified using the `cores` argument. `Kontextual` can take a single value or multiple values for each argument and will test all combinations of the arguments specified.

We can calculate these relationships across all images for a single radius (r = 100). Small radii will examine local spatial relationships, whereas larger radii will examine global spatial relationships.

```
p53_Kontextual <- Kontextual(
  cells = kerenSCE,
  r = 100,
  from = "Immune",
  to = "p53_Tumour",
  parent = c("p53_Tumour", "Tumour"),
  cellType = "cellTypeNew"
)

p53_Kontextual
#>    imageID               test   original  kontextual   r inhomL
#> 1        1 Immune__p53_Tumour -16.212016  -1.6815952 100  FALSE
#> 2       14 Immune__p53_Tumour -14.671281  -4.2879138 100  FALSE
#> 3       18 Immune__p53_Tumour  -1.953366   0.5795853 100  FALSE
#> 4       21 Immune__p53_Tumour -14.300802  -7.1425133 100  FALSE
#> 5       29 Immune__p53_Tumour -20.728463  -7.0172785 100  FALSE
#> 6        3 Immune__p53_Tumour   1.719549  44.5060581 100  FALSE
#> 7       32 Immune__p53_Tumour -18.174569 -10.8972277 100  FALSE
#> 8       35 Immune__p53_Tumour -75.980619 -66.2395276 100  FALSE
#> 9        5 Immune__p53_Tumour         NA          NA 100  FALSE
#> 10       6 Immune__p53_Tumour -24.897348  -1.2724241 100  FALSE
```

The `kontextCurve` function plots the L-function value and Kontextual values over a range of radii. If the points lie above the red line (expected pattern) then localisation is indicated for that radius, if the points lie below the red line then dispersion is indicated.

As seen in the following plot the L-function produces negative values over a range of radii, indicating that *p53+ tumour cells* and *immune cells* are dispersed from one another. However by taking into account the tumour context, `Kontextual` shows positive values over some radii, indicating localisation between *p53+ tumour cells* and *immune cells*.

```
curves <- kontextCurve(
  cells = kerenSCE,
  from = "Immune",
  to = "p53_Tumour",
  parent = c("p53_Tumour", "Tumour"),
  rs = seq(50, 510, 50),
  image = "6",
  cellType = "cellTypeNew",
  cores = nCores
)

kontextPlot(curves)
```

![](data:image/png;base64...)

Alternatively all pairwise cell relationships and their corresponding parent in the dataset can be tested. A data frame with all pairwise combinations can be creating using the `parentCombinations` function. This function takes in a vector of all the cells, as well as the named list of parents and children created earlier in the `parentList` argument. As shown below the output is a data frame specifying the `to`, `from`, and `parent` arguments for `Kontextual`.

*Note:* the output of `getPhyloParent` may also be using the in the `parentList` argument, for example if you wanted to use the treekoR defined hierarchy instead.

```
# Get all relationships between cell types and their parents
parentDf <- parentCombinations(
  all = all,
  parentList = biologicalHierarchy
)
```

## 5.3 Calculating all pairwise relationships

Rather than specifying `to`, `from`, and `parent` in `Kontextual`, the output from `parentCombinations` can be inputed into `Kontextual` using the `parentDf` argument, to examine all pairwise relationships in the dataset. This chunk will take a significant amount of time to run, for demonstration the results have been saved and are loaded in.

```
# Running Kontextual on all relationships across all images.
kerenKontextual <- Kontextual(
  cells = kerenSCE,
  parentDf = parentDf,
  r = 100,
  cores = nCores
)
```

For every pairwise relationship (named accordingly: `from__to__parent`) `Kontextual` outputs the L-function values (original) and the Kontextual value. The relationships where the L-function and Kontextual disagree (e.g. one metric is positive and the other is negative) represent relationships where adding context information results in different conclusions on the spatial relationship between the two cell types.

```
head(kerenKontextual, 10)
#>    imageID                      test   original  kontextual   r inhomL
#> 1        1 Keratin_Tumour__B__immune -32.547645 -20.8129718 100  FALSE
#> 2       14 Keratin_Tumour__B__immune         NA          NA 100  FALSE
#> 3       18 Keratin_Tumour__B__immune  -2.879684  -0.4266132 100  FALSE
#> 4       21 Keratin_Tumour__B__immune         NA          NA 100  FALSE
#> 5       29 Keratin_Tumour__B__immune         NA          NA 100  FALSE
#> 6        3 Keratin_Tumour__B__immune -36.175444 -15.4940620 100  FALSE
#> 7       32 Keratin_Tumour__B__immune -43.187880 -40.6868426 100  FALSE
#> 8       35 Keratin_Tumour__B__immune -66.782273 -46.2862443 100  FALSE
#> 9        5 Keratin_Tumour__B__immune -68.676955 -46.3064625 100  FALSE
#> 10       6 Keratin_Tumour__B__immune -31.393046  -0.4636465 100  FALSE
```

## 5.4 Associating the relationships with survival outcomes.

To examine whether the features obtained from `Statial` are associated with patient outcomes or groupings, we can use the `spicy` function from the `spicyR` package. `spicy` requires the `SingleCellExperiment` object being used to contain a column called `survival`.

```
# add survival column to kerenSCE
kerenSCE$event = 1 - kerenSCE$Censored
kerenSCE$survival = Surv(kerenSCE$Survival_days_capped, kerenSCE$event)
```

In addition to this, the Kontextual results must be converted from a `data.frame` to a wide `matrix`, this can be done using `prepMatrix`. Note, to extract the original L-function values, specify `column = "original"` in `prepMatrix`.

```
# Converting Kontextual result into data matrix
kontextMat <- prepMatrix(kerenKontextual)

# Ensuring rownames of kontextMat match up with the image IDs of the SCE object
kontextMat <- kontextMat[kerenSCE$imageID |> unique(), ]

# Replace NAs with 0
kontextMat[is.na(kontextMat)] <- 0
```

Finally, both the `SingleCellExperiment` object and the Kontextual matrix are passed into the `spicy` function, with `condition = "survival"`. The resulting coefficients and p values can be obtained by accessing the `survivalResults` name.

*Note:* You can specify additional covariates and include a subject id for mixed effects survival modelling, see \code{ for more information.

```
# Running survival analysis
survivalResults = spicy(cells = kerenSCE,
                        alternateResult = kontextMat,
                        condition = "survival",
                        weights = TRUE)

head(survivalResults$survivalResults, 10)
#> # A tibble: 10 × 4
#>    test                           coef se.coef   p.value
#>    <chr>                         <dbl>   <dbl>     <dbl>
#>  1 DC__NK__immune               -0.209    283. 2.95e-178
#>  2 NK__DC__immune               -0.209    285. 3.81e-176
#>  3 NK__DC__myeloid              -0.209    285. 3.81e-176
#>  4 NK__Tumour__tumour           -0.204    233. 1.20e-151
#>  5 CD3_Cell__Tumour__tumour     -0.299    175. 3.95e-129
#>  6 Tumour__NK__immune           -0.232    303. 1.68e-127
#>  7 CD4_Cell__Tumour__tumour     -0.189    188. 8.17e-125
#>  8 other immune__Tumour__tumour -1.84     387. 4.79e-100
#>  9 Tumour__CD4_Cell__immune     -0.271    306. 9.86e- 87
#> 10 Tumour__CD3_Cell__immune     -0.709    264. 2.35e- 73
```

The survival results can also be visualised using the `signifPlot` function.

```
signifPlot(survivalResults)
```

![](data:image/png;base64...)

As we can see from the results `DC__NK__immune` is the one of the most significant pairwise relationship which contributes to patient survival. That is the relationship between dendritic cells and natural killer cells, relative to the parent population of immune cells. We can see that there is a negative coefficient associated with this relationship, which tells us an increase in localisation of these cell types relative to immune cells leads to better survival outcomes for patients.

The association between `DC__NK__immune` and survival can also be visualised on a Kaplan-Meier curve. First, we extract survival data from the `SingleCellExperiment` object and create a survival vector.

```
# Extracting survival data
survData <- kerenSCE |>
  colData() |>
  data.frame() |>
  select(imageID, survival) |>
  unique()

# Creating survival vector
kerenSurv <- survData$survival
names(kerenSurv) <- survData$imageID

kerenSurv
#>     1     3     5     6    14    18    21    29    32    35
#>  2612 3130+ 1683+ 2275+ 4145+ 5063+   635  1319 1568+ 2759+
```

Next, we extract the Kontextual values of this relationship across all images. We then determine if dendritic and natural killer cells are relatively attracted or avoiding in each image by comparing the Kontextual value in each image to the median Kontextual value.

Finally, we plot a Kaplan-Meier curve using the `ggsurvfit` package. As shown below, when dendritic and natural killer cells are more localised to one another relative to the immune cell population, patients tend to have better survival outcomes.

```
# Selecting most significant relationship
survRelationship <- kontextMat[["DC__NK__immune"]]
survRelationship <- ifelse(survRelationship > median(survRelationship), "Localised", "Dispersed")

# Plotting Kaplan-Meier curve
survfit2(kerenSurv ~ survRelationship) |>
  ggsurvfit() +
  ggtitle("DC__NK__immune")
```

![](data:image/png;base64...)

# 6 SpatioMark: Identifying continuous changes in cell state

Changes in cell states can be analytically framed as the change in abundance of a gene or protein within a particular cell type. We can use marker expression to identify and quantify evidence of cell interactions that catalyse cell state changes. This approach measures how protein markers in a cell change with spatial proximity and abundance to other cell types. The methods utilised here will thereby provide a framework to explore how the dynamic behaviour of cells are altered by the agents they are surrounded by.

## 6.1 Continuous cell state changes within a single image

The first step in analysing these changes is to calculate the spatial proximity (`getDistances`) and abundance (`getAbundances`) of each cell to every cell type. These values will then be stored in the `reducedDims` slot of the `SingleCellExperiment` object under the names `distances` and `abundances` respectively.

```
kerenSCE <- getDistances(kerenSCE,
  maxDist = 200,
  nCores = 1
)

kerenSCE <- getAbundances(kerenSCE,
  r = 200,
  nCores = 1
)
```

First, let’s examine the same effect observed earlier with Kontextual - the localisation between p53-positive keratin/tumour cells and macrophages in the context of total keratin/tumour cells for image 6 of the Keren et al. dataset.

Statial provides two main functions to assess this relationship - `calcStateChanges` and `plotStateChanges`. We can use `calcStateChanges` to examine the relationship between 2 cell types for 1 marker in a specific image. In this case, we’re examining the relationship between keratin/tumour cells (`from = Keratin_Tumour`) and macrophages (`to = "Macrophages"`) for the marker p53 (`marker = "p53"`) in `image = "6"`. We can appreciate that the `fdr` statistic for this relationship is significant, with a negative tvalue, indicating that the expression of p53 in keratin/tumour cells decreases as distance from macrophages increases.

```
stateChanges <- calcStateChanges(
  cells = kerenSCE,
  type = "distances",
  image = "6",
  from = "Keratin_Tumour",
  to = "Macrophages",
  marker = "p53",
  nCores = 1
)

stateChanges
#>   imageID primaryCellType otherCellType marker         coef      tval
#> 1       6  Keratin_Tumour   Macrophages    p53 -0.001402178 -7.010113
#>           pval          fdr
#> 1 2.868257e-12 2.868257e-12
```

Statial also provides a convenient function for visualising this interaction - `plotStateChanges`. Here, again we can specify `image = 6` and our main cell types of interest, keratin/tumour cells and macrophages, and our marker p53, in the same format as `calcStateChanges`.

Through this analysis, we can observe that keratin/tumour cells closer to a group of macrophages tend to have higher expression of p53, as observed in the first graph. This relationship is quantified with the second graph, showing an overall decrease of p53 expression in keratin/tumour cells as distance to macrophages increase.

These results allow us to essentially arrive at the same result as Kontextual, which calculated a localisation between p53+ keratin/tumour cells and macrophages in the wider context of keratin/tumour cells.

```
p <- plotStateChanges(
  cells = kerenSCE,
  type = "distances",
  image = "6",
  from = "Keratin_Tumour",
  to = "Macrophages",
  marker = "p53",
  size = 1,
  shape = 19,
  interactive = FALSE,
  plotModelFit = FALSE,
  method = "lm"
)

p
#> $image
```

![](data:image/png;base64...)

```
#>
#> $scatter
```

![](data:image/png;base64...)

## 6.2 Continuous cell state changes across all images

Beyond looking at single cell-to-cell interactions for a single image, we can also look at all interactions across all images. The `calcStateChanges` function provided by Statial can be expanded for this exact purpose - by not specifying cell types, a marker, or an image, `calcStateChanges` will examine the most significant correlations between distance and marker expression across the entire dataset. Here, we’ve filtered out the most significant interactions to only include those found within image 6 of the Keren et al. dataset.

```
stateChanges <- calcStateChanges(
  cells = kerenSCE,
  type = "distances",
  nCores = 1,
  minCells = 100
)

stateChanges |>
  filter(imageID == 6) |>
  head(n = 10)
#>    imageID primaryCellType otherCellType       marker         coef      tval
#> 1        6  Keratin_Tumour  Unidentified           Na  0.004218419  25.03039
#> 2        6  Keratin_Tumour   Macrophages  HLA_Class_1 -0.003823497 -24.69629
#> 3        6  Keratin_Tumour      CD4_Cell  HLA_Class_1 -0.003582774 -23.87797
#> 4        6  Keratin_Tumour  Unidentified Beta.catenin  0.005893120  23.41953
#> 5        6  Keratin_Tumour      CD8_Cell  HLA_Class_1 -0.003154544 -23.13804
#> 6        6  Keratin_Tumour       Dc/Mono  HLA_Class_1 -0.003353834 -22.98944
#> 7        6  Keratin_Tumour      CD3_Cell  HLA_Class_1 -0.003123446 -22.63197
#> 8        6  Keratin_Tumour        Tumour  HLA_Class_1  0.003684079  21.94265
#> 9        6  Keratin_Tumour      CD4_Cell           Fe -0.003457338 -21.43550
#> 10       6  Keratin_Tumour      CD4_Cell   phospho.S6 -0.002892457 -20.50767
#>             pval           fdr
#> 1  6.971648e-127 1.176442e-123
#> 2  7.814253e-124 1.236215e-120
#> 3  1.745242e-116 2.208779e-113
#> 4  1.917245e-112 2.257178e-109
#> 5  5.444541e-110 5.991836e-107
#> 6  1.053130e-108 1.110701e-105
#> 7  1.237988e-105 1.205229e-102
#> 8  8.188258e-100  7.025803e-97
#> 9   1.287478e-95  9.727951e-93
#> 10  3.928912e-88  2.583081e-85
```

In image 6, the majority of the top 10 most significant interactions occur between keratin/tumour cells and an immune population, and many of these interactions appear to involve the HLA class I ligand.

We can examine some of these interactions further with the `plotStateChanges` function. Taking a closer examination of the relationship between macrophages and keratin/tumour HLA class I expression, the plot below shows us a clear visual correlation - as macrophage density increases, keratin/tumour cells increase their expression HLA class I.

Biologically, HLA Class I is a ligand which exists on all nucleated cells, tasked with presenting internal cell antigens for recognition by the immune system, marking aberrant cells for destruction by either CD8+ T cells or NK cells.

```
p <- plotStateChanges(
  cells = kerenSCE,
  type = "distances",
  image = "6",
  from = "Keratin_Tumour",
  to = "Macrophages",
  marker = "HLA_Class_1",
  size = 1,
  shape = 19,
  interactive = FALSE,
  plotModelFit = FALSE,
  method = "lm"
)

p
#> $image
```

![](data:image/png;base64...)

```
#>
#> $scatter
```

![](data:image/png;base64...)

Next, let’s take a look at the top 10 most significant results across all images.

```
stateChanges |> head(n = 10)
#>      imageID primaryCellType otherCellType     marker         coef      tval
#> 8674      35        CD4_Cell             B       CD20 -0.029185750 -40.57355
#> 8770      35        CD4_Cell       Dc/Mono       CD20  0.019125946  40.53436
#> 1819      35               B       Dc/Mono phospho.S6  0.005282065  40.41385
#> 8779      35        CD4_Cell       Dc/Mono phospho.S6  0.004033218  34.72882
#> 1813      35               B       Dc/Mono     HLA.DR  0.011120703  34.15344
#> 1971      35               B  other immune          P  0.011182182  34.14375
#> 8626      35        CD4_Cell      CD3_Cell       CD20  0.016349492  33.91901
#> 1816      35               B       Dc/Mono     H3K9ac  0.005096632  33.99856
#> 2011      35               B  other immune phospho.S6  0.005986586  33.66466
#> 1818      35               B       Dc/Mono   H3K27me3  0.006980810  33.22740
#>               pval           fdr
#> 8674 7.019343e-282 3.553472e-277
#> 8770 1.891267e-281 4.787176e-277
#> 1819 5.306590e-278 8.954694e-274
#> 8779 4.519947e-219 5.720445e-215
#> 1813 8.401034e-212 8.505879e-208
#> 1971 1.056403e-211 8.913225e-208
#> 8626 1.219488e-210 8.819335e-207
#> 1816 3.266533e-210 2.067062e-206
#> 2011 8.545691e-207 4.806856e-203
#> 1818 2.438769e-202 1.234603e-198
```

Immediately, we can appreciate that a couple of these interactions are not biologically plausible. One of the most significant interactions occurs between B cells and CD4 T cells in image 35, where CD4 T cells are found to increase in CD20 expression when in close proximity to B cells. Biologically, CD20 is a highly specific ligand for B cells, and under healthy circumstances are usually not expressed in T cells.

Could this potentially be an artefact of `calcStateChanges`? We can examine the image through the `plotStateChanges` function, where we indeed observe a strong increase in CD20 expression in T cells nearby B cell populations.

```
p <- plotStateChanges(
  cells = kerenSCE,
  type = "distances",
  image = "35",
  from = "CD4_Cell",
  to = "B",
  marker = "CD20",
  size = 1,
  shape = 19,
  interactive = FALSE,
  plotModelFit = FALSE,
  method = "lm"
)

p
#> $image
```

![](data:image/png;base64...)

```
#>
#> $scatter
```

![](data:image/png;base64...)

So why are T cells expressing CD20? This brings us to a key problem of cell segmentation - contamination.

## 6.3 Contamination (Lateral marker spill over)

Contamination, or lateral marker spill over is an issue that results in a cell’s marker expressions being wrongly attributed to another adjacent cell. This issue arises from incorrect segmentation where components of one cell are wrongly determined as belonging to another cell. Alternatively, this issue can arise when antibodies used to tag and measure marker expressions don’t latch on properly to a cell of interest, thereby resulting in residual markers being wrongly assigned as belonging to a cell near the intended target cell. It is important that we either correct or account for this incorrect attribution of markers in our modelling process. This is critical in understanding whether significant cell-cell interactions detected are an artefact of technical measurement errors driven by spill over or are real biological changes that represent a shift in a cell’s state.

To circumvent this problem, Statial provides a function that predicts the probability that a cell is any particular cell type - `calcContamination`. `calcContamination` returns a dataframe of probabilities demarcating the chance of a cell being any particular cell type. This dataframe is stored under `contaminations` in the `reducedDim` slot of the `SingleCellExperiment` object. It also provides the `rfMainCellProb` column, which provides the probability that a cell is indeed the cell type it has been designated. E.g. For a cell designated as CD8, rfMainCellProb could give a 80% chance that the cell is indeed CD8, due to contamination.

We can then introduce these probabilities as covariates into our linear model by setting `contamination = TRUE` as a parameter in our `calcStateChanges` function. However, this is not a perfect solution for the issue of contamination. As we can see, despite factoring in contamination into our linear model, the correlation between B cell density and CD20 expression in CD4 T cells remains one of the most significant interactions in our model.

```
kerenSCE <- calcContamination(kerenSCE)

stateChangesCorrected <- calcStateChanges(
  cells = kerenSCE,
  type = "distances",
  nCores = 1,
  minCells = 100,
  contamination = TRUE
)

stateChangesCorrected |> head(n = 20)
#>       imageID primaryCellType otherCellType      marker         coef      tval
#> 8674       35        CD4_Cell             B        CD20 -0.023889894 -33.90008
#> 8770       35        CD4_Cell       Dc/Mono        CD20  0.015264085  32.39356
#> 29188       3  Keratin_Tumour            DC          Ca -0.014321254 -30.18143
#> 1819       35               B       Dc/Mono  phospho.S6  0.004222383  29.28458
#> 8779       35        CD4_Cell       Dc/Mono  phospho.S6  0.003468998  28.45849
#> 8626       35        CD4_Cell      CD3_Cell        CD20  0.012881677  28.16266
#> 8629       35        CD4_Cell      CD3_Cell      HLA.DR  0.009800014  27.61098
#> 1669       35               B      CD3_Cell      HLA.DR  0.008858106  25.51689
#> 1813       35               B       Dc/Mono      HLA.DR  0.008806006  25.16834
#> 31825       6  Keratin_Tumour  Unidentified          Na  0.004209786  24.59039
#> 27641      21  Keratin_Tumour            DC Pan.Keratin -0.005757295 -24.11212
#> 2011       35               B  other immune  phospho.S6  0.004537029  24.60977
#> 8763       35        CD4_Cell       Dc/Mono      CSF.1R  0.008447613  24.33190
#> 1675       35               B      CD3_Cell  phospho.S6  0.003581337  23.91429
#> 29186       3  Keratin_Tumour            DC          Si -0.005866814 -24.11279
#> 8635       35        CD4_Cell      CD3_Cell  phospho.S6  0.002793668  23.55525
#> 1971       35               B  other immune           P  0.007478411  23.59263
#> 2008       35               B  other immune      H3K9ac  0.004682540  23.51242
#> 1816       35               B       Dc/Mono      H3K9ac  0.003721267  22.90309
#> 31918       6  Keratin_Tumour   Macrophages HLA_Class_1 -0.003405219 -22.62424
#>                pval           fdr
#> 8674  2.992711e-210 1.515030e-205
#> 8770  8.154003e-195 2.063941e-190
#> 29188 4.229842e-168 7.137718e-164
#> 1819  3.286733e-163 4.159689e-159
#> 8779  4.628066e-156 4.685824e-152
#> 8626  2.983322e-153 2.517128e-149
#> 8629  4.685982e-148 3.388902e-144
#> 1669  2.195962e-128 1.389605e-124
#> 1813  2.653694e-125 1.492673e-121
#> 31825 7.932923e-123 4.015963e-119
#> 27641 3.178673e-121 1.462883e-117
#> 2011  2.038755e-120 8.600829e-117
#> 8763  1.999645e-118 7.786924e-115
#> 1675  1.980219e-114 7.160471e-111
#> 29186 2.346383e-114 7.918887e-111
#> 8635  9.462961e-112 2.994081e-108
#> 1971  1.069005e-111 3.183371e-108
#> 2008  5.088892e-111 1.431223e-107
#> 1816  6.384283e-106 1.701042e-102
#> 31918 1.558292e-105 3.944347e-102
```

However, this does not mean factoring in contamination into our linear model was ineffective.

Whilst our correction attempts do not rectify every relationship which arises due to contamination, we show that a significant portion of these relationships are rectified. We can show this by plotting a ROC curve of true positives against false positives. In general, cell type specific markers such as CD4, CD8, and CD20 should not change in cells they are not specific to. Therefore, relationships detected to be significant involving these cell type markers are likely false positives and will be treated as such for the purposes of evaluation. Meanwhile, cell state markers are predominantly likely to be true positives.

Plotting the relationship between false positives and true positives, we’d expect the contamination correction to be greatest in the relationships with the top 100 lowest p values, where we indeed see more true positives than false positives with contamination correction.

```
cellTypeMarkers <- c("CD3", "CD4", "CD8", "CD56", "CD11c", "CD68", "CD45", "CD20")

values <- c("blue", "red")
names(values) <- c("None", "Corrected")

df <- rbind(
  data.frame(TP = cumsum(stateChanges$marker %in% cellTypeMarkers), FP = cumsum(!stateChanges$marker %in% cellTypeMarkers), type = "None"),
  data.frame(TP = cumsum(stateChangesCorrected$marker %in% cellTypeMarkers), FP = cumsum(!stateChangesCorrected$marker %in% cellTypeMarkers), type = "Corrected")
)

ggplot(df, aes(x = TP, y = FP, colour = type)) +
  geom_line() +
  labs(y = "Cell state marker", x = "Cell type marker") +
  scale_colour_manual(values = values)
```

![](data:image/png;base64...)

Here, we zoom in on the ROC curve where the top 100 lowest p values occur, where we indeed see more true positives than false positives with contamination correction.

```
ggplot(df, aes(x = TP, y = FP, colour = type)) +
  geom_line() +
  xlim(0, 100) +
  ylim(0, 1000) +
  labs(y = "Cell state marker", x = "Cell type marker") +
  scale_colour_manual(values = values)
```

![](data:image/png;base64...)

## 6.4 Associate continuous state changes with survival outcomes

Similiar to `Kontextual`, we can run a similar survival analysis using our state changes results. Here, `prepMatrix` extracts the coefficients, or the `coef` column of `stateChanges` by default. To use the t values instead, specify `column = "tval"` in the `prepMatrix` function.

```
# Preparing features for Statial
stateMat <- prepMatrix(stateChanges)

# Ensuring rownames of stateMat match up with rownames of the survival vector
stateMat <- stateMat[names(kerenSurv), ]

# Remove some very small values
stateMat <- stateMat[, colMeans(abs(stateMat) > 0.0001) > .8]

survivalResults <- colTest(stateMat, kerenSurv, type = "survival")

head(survivalResults)
#>                                     coef se.coef  pval adjPval
#> Keratin_Tumour__CD8_Cell__Vimentin 48000    3800 0.000    0.00
#> Keratin_Tumour__Dc/Mono__SMA         700     380 0.065    0.95
#> Keratin_Tumour__other immune__Ki67  1600     880 0.065    0.95
#> Macrophages__CD4_Cell__H3K27me3     1100     600 0.070    0.95
#> Macrophages__CD8_Cell__Ca            960     540 0.077    0.95
#> Macrophages__Keratin_Tumour__P      -170      99 0.079    0.95
#>                                                               cluster
#> Keratin_Tumour__CD8_Cell__Vimentin Keratin_Tumour__CD8_Cell__Vimentin
#> Keratin_Tumour__Dc/Mono__SMA             Keratin_Tumour__Dc/Mono__SMA
#> Keratin_Tumour__other immune__Ki67 Keratin_Tumour__other immune__Ki67
#> Macrophages__CD4_Cell__H3K27me3       Macrophages__CD4_Cell__H3K27me3
#> Macrophages__CD8_Cell__Ca                   Macrophages__CD8_Cell__Ca
#> Macrophages__Keratin_Tumour__P         Macrophages__Keratin_Tumour__P
```

For our state changes results, `Keratin_Tumour__CD4_Cell__Keratin6` is the most significant pairwise relationship which contributes to patient survival. That is, the relationship between HLA class I expression in keratin/tumour cells and their spatial proximity to mesenchymal cells. As there is a negative coeffcient associated with this relationship, which tells us that higher HLA class I expression in keratin/tumour cells nearby mesenchymal cell populations lead to poorer survival outcomes for patients.

```
# Selecting the most significant relationship
survRelationship <- stateMat[["Keratin_Tumour__CD4_Cell__Keratin6"]]
survRelationship <- ifelse(survRelationship > median(survRelationship), "Higher expression in close cells", "Lower expression in close cells")

# Plotting Kaplan-Meier curve
survfit2(kerenSurv ~ survRelationship) |>
  ggsurvfit() +
  add_pvalue() +
  ggtitle("Keratin_Tumour__CD4_Cell__Keratin6")
```

![](data:image/png;base64...)

# 7 Region analysis using lisaClust

Next we can cluster areas with similar spatial interactions to identify regions using lisaClust. Here we set `k = 5` to identify 5 regions.

```
set.seed(51773)

# Preparing features for lisaClust
kerenSCE <- lisaClust::lisaClust(kerenSCE, k = 5)
```

The regions identified by licaClust can be visualised using the `hatchingPlot` function.

```
# Use hatching to visualise regions and cell types.
lisaClust::hatchingPlot(kerenSCE,
  useImages = "5",
  line.spacing = 41, # spacing of lines
  nbp = 100 # smoothness of lines
)
```

![](data:image/png;base64...)

# 8 Marker Means

`Statial` provides functionality to identify the average marker expression of a given cell type in a given region, using the `getMarkerMeans` function. Similar to the analysis above, these features can also be used for survival analysis.

```
cellTypeRegionMeans <- getMarkerMeans(kerenSCE,
  imageID = "imageID",
  cellType = "cellType",
  region = "region"
)

survivalResults <- colTest(cellTypeRegionMeans[names(kerenSurv), ], kerenSurv, type = "survival")

head(survivalResults)
#>                                 coef se.coef    pval adjPval
#> IDO__CD4_Cell__region_4         -140     9.2 0.0e+00 0.0e+00
#> CD20__DC__region_3             -6800   200.0 0.0e+00 0.0e+00
#> p53__CD4_Cell__region_5         -980   160.0 8.7e-10 1.1e-06
#> Lag3__Keratin_Tumour__region_4 -5500   950.0 8.7e-09 7.4e-06
#> CD45RO__Endothelial__region_4   -150    27.0 9.5e-09 7.4e-06
#> CD31__Mono/Neu__region_4        -570   110.0 1.6e-07 1.0e-04
#>                                                       cluster
#> IDO__CD4_Cell__region_4               IDO__CD4_Cell__region_4
#> CD20__DC__region_3                         CD20__DC__region_3
#> p53__CD4_Cell__region_5               p53__CD4_Cell__region_5
#> Lag3__Keratin_Tumour__region_4 Lag3__Keratin_Tumour__region_4
#> CD45RO__Endothelial__region_4   CD45RO__Endothelial__region_4
#> CD31__Mono/Neu__region_4             CD31__Mono/Neu__region_4
```

# 9 Patient classification

Finally we demonstrate how we can use `ClassifyR` to perform patient classification with the features generated from `Statial`. In addition to the kontextual, state changes, and marker means values, we also calculate cell type proportions and region proportions using the `getProp` function in `spicyR`. Here we perform 3 fold cross validation with 10 repeats, using a CoxPH model for survival classification, feature selection is also performed by selecting the top 10 features per fold using a CoxPH model.

```
# Calculate cell type and region proportions
cellTypeProp <- getProp(kerenSCE,
  feature = "cellType",
  imageID = "imageID"
)
regionProp <- getProp(kerenSCE,
  feature = "region",
  imageID = "imageID"
)

# Combine all the features into a list for classification
featureList <- list(
  states = stateMat,
  kontextual = kontextMat,
  regionMarkerMeans = cellTypeRegionMeans,
  cellTypeProp = cellTypeProp,
  regionProp = regionProp
)

# Ensure the rownames of the features match the order of the survival vector
featureList <- lapply(featureList, function(x) x[names(kerenSurv), ])

set.seed(51773)

kerenCV <- crossValidate(
  measurements = featureList,
  outcome = kerenSurv,
  classifier = "CoxPH",
  selectionMethod = "CoxPH",
  nFolds = 5,
  nFeatures = 10,
  nRepeats = 20,
  nCores = 1
)
```

Here, we use the `performancePlot` function to assess the C-index from each repeat of the 3-fold cross-validation. We can see the resulting C-indexes are very variable due to the dataset only containing 10 images.

```
# Calculate AUC for each cross-validation repeat and plot.
performancePlot(kerenCV,
  characteristicsList = list(x = "Assay Name")
) +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
```

![](data:image/png;base64...)

# 10 References

# Appendix

Keren, L., Bosse, M., Marquez, D., Angoshtari, R., Jain, S., Varma, S., Yang, S. R., Kurian, A., Van Valen, D., West, R., Bendall, S. C., & Angelo, M. (2018). A Structured Tumor-Immune Microenvironment in Triple Negative Breast Cancer Revealed by Multiplexed Ion Beam Imaging. Cell, 174(6), 1373-1387.e1319. ([DOI](https://doi.org/10.1016/j.cell.2018.08.039))

# A sessionInfo

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
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] treekoR_1.18.0              tibble_3.3.0
#>  [3] ggsurvfit_1.2.0             ggplot2_4.0.0
#>  [5] SingleCellExperiment_1.32.0 dplyr_1.1.4
#>  [7] lisaClust_1.18.0            ClassifyR_3.14.0
#>  [9] survival_3.8-3              BiocParallel_1.44.0
#> [11] MultiAssayExperiment_1.36.0 SummarizedExperiment_1.40.0
#> [13] Biobase_2.70.0              GenomicRanges_1.62.0
#> [15] Seqinfo_1.0.0               IRanges_2.44.0
#> [17] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [19] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [21] generics_0.1.4              spicyR_1.22.0
#> [23] Statial_1.12.0              BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] bitops_1.0-9                fs_1.6.6
#>   [3] spatstat.sparse_3.1-0       EBImage_4.52.0
#>   [5] httr_1.4.7                  hopach_2.70.0
#>   [7] RColorBrewer_1.1-3          doParallel_1.0.17
#>   [9] numDeriv_2016.8-1.1         tools_4.5.1
#>  [11] doRNG_1.8.6.2               backports_1.5.0
#>  [13] utf8_1.2.6                  R6_2.6.1
#>  [15] HDF5Array_1.38.0            lazyeval_0.2.2
#>  [17] mgcv_1.9-3                  rhdf5filters_1.22.0
#>  [19] GetoptLong_1.0.5            sp_2.2-0
#>  [21] withr_3.0.2                 gridExtra_2.3
#>  [23] coxme_2.2-22                textshaping_1.0.4
#>  [25] cli_3.6.5                   spatstat.explore_3.5-3
#>  [27] sandwich_3.1-1              labeling_0.4.3
#>  [29] sass_0.4.10                 nnls_1.6
#>  [31] mvtnorm_1.3-3               S7_0.2.0
#>  [33] spatstat.data_3.1-9         systemfonts_1.3.1
#>  [35] yulab.utils_0.2.1           ggupset_0.4.1
#>  [37] svglite_2.2.2               colorRamps_2.3.4
#>  [39] dichromat_2.0-0.1           limma_3.66.0
#>  [41] flowCore_2.22.0             simpleSeg_1.12.0
#>  [43] gridGraphics_0.5-1          shape_1.4.6.1
#>  [45] spatstat.random_3.4-2       car_3.1-3
#>  [47] scam_1.2-20                 Matrix_1.7-4
#>  [49] RProtoBufLib_2.22.0         ggbeeswarm_0.7.2
#>  [51] abind_1.4-8                 terra_1.8-70
#>  [53] lifecycle_1.0.4             multcomp_1.4-29
#>  [55] yaml_2.3.10                 edgeR_4.8.0
#>  [57] carData_3.0-5               rhdf5_2.54.0
#>  [59] SparseArray_1.10.0          Rtsne_0.17
#>  [61] grid_4.5.1                  promises_1.4.0
#>  [63] shinydashboard_0.7.3        crayon_1.5.3
#>  [65] bdsmatrix_1.3-7             lattice_0.22-7
#>  [67] magick_2.9.0                cytomapper_1.22.0
#>  [69] pillar_1.11.1               knitr_1.50
#>  [71] ComplexHeatmap_2.26.0       dcanr_1.26.0
#>  [73] rjson_0.2.23                boot_1.3-32
#>  [75] codetools_0.2-20            glue_1.8.0
#>  [77] ggiraph_0.9.2               V8_8.0.1
#>  [79] ggfun_0.2.0                 spatstat.univar_3.1-4
#>  [81] fontLiberation_0.1.0        data.table_1.17.8
#>  [83] vctrs_0.6.5                 png_0.1-8
#>  [85] treeio_1.34.0               Rdpack_2.6.4
#>  [87] gtable_0.3.6                cachem_1.1.0
#>  [89] xfun_0.53                   mime_0.13
#>  [91] rbibutils_2.3               S4Arrays_1.10.0
#>  [93] ConsensusClusterPlus_1.74.0 reformulas_0.4.2
#>  [95] pheatmap_1.0.13             iterators_1.0.14
#>  [97] tinytex_0.57                cytolib_2.22.0
#>  [99] statmod_1.5.1               TH.data_1.1-4
#> [101] nlme_3.1-168                ggtree_4.0.0
#> [103] fontquiver_0.2.1            bslib_0.9.0
#> [105] svgPanZoom_0.3.4            vipor_0.4.7
#> [107] otel_0.2.0                  colorspace_2.1-2
#> [109] raster_3.6-32               tidyselect_1.2.1
#> [111] curl_7.0.0                  compiler_4.5.1
#> [113] diffcyt_1.30.0              h5mread_1.2.0
#> [115] fontBitstreamVera_0.1.1     DelayedArray_0.36.0
#> [117] plotly_4.11.0               bookdown_0.45
#> [119] scales_1.4.0                rappdirs_0.3.3
#> [121] tiff_0.1-12                 stringr_1.5.2
#> [123] SpatialExperiment_1.20.0    digest_0.6.37
#> [125] goftest_1.2-3               fftwtools_0.9-11
#> [127] spatstat.utils_3.2-0        minqa_1.2.8
#> [129] rmarkdown_2.30              XVector_0.50.0
#> [131] jpeg_0.1-11                 htmltools_0.5.8.1
#> [133] pkgconfig_2.0.3             lme4_1.1-37
#> [135] fastmap_1.2.0               rlang_1.1.6
#> [137] GlobalOptions_0.1.2         htmlwidgets_1.6.4
#> [139] ggthemes_5.1.0              shiny_1.11.1
#> [141] ggh4x_0.3.1                 farver_2.1.2
#> [143] jquerylib_0.1.4             zoo_1.8-14
#> [145] jsonlite_2.0.0              RCurl_1.98-1.17
#> [147] magrittr_2.0.4              Formula_1.2-5
#> [149] ggplotify_0.1.3             patchwork_1.3.2
#> [151] Rhdf5lib_1.32.0             Rcpp_1.1.0
#> [153] viridis_0.6.5               ape_5.8-1
#> [155] ggnewscale_0.5.2            gdtools_0.4.4
#> [157] stringi_1.8.7               MASS_7.3-65
#> [159] plyr_1.8.9                  parallel_4.5.1
#> [161] deldir_2.0-4                splines_4.5.1
#> [163] tensor_1.5.1                circlize_0.4.16
#> [165] locfit_1.5-9.12             igraph_2.2.1
#> [167] ggpubr_0.6.2                ranger_0.17.0
#> [169] spatstat.geom_3.6-0         ggsignif_0.6.4
#> [171] rngtools_1.5.2              reshape2_1.4.4
#> [173] XML_3.99-0.19               evaluate_1.0.5
#> [175] BiocManager_1.30.26         httpuv_1.6.16
#> [177] nloptr_2.2.1                foreach_1.5.2
#> [179] tweenr_2.0.3                tidyr_1.3.1
#> [181] purrr_1.1.0                 polyclip_1.10-7
#> [183] clue_0.3-66                 BiocBaseUtils_1.12.0
#> [185] ggforce_0.5.0               xtable_1.8-4
#> [187] broom_1.0.10                tidytree_0.4.6
#> [189] later_1.4.4                 rstatix_0.7.3
#> [191] viridisLite_0.4.2           class_7.3-23
#> [193] lmerTest_3.1-3              aplot_0.2.9
#> [195] beeswarm_0.4.0              FlowSOM_2.18.0
#> [197] cluster_2.1.8.1             concaveman_1.2.0
```