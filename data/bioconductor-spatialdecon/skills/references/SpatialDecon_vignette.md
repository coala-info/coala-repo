# Use of SpatialDecon in a small GeoMx dataset

* [Installation](#installation)
* [Overview](#overview)
* [Data preparation](#data-preparation)
* [Cell profile matrices](#cell-profile-matrices)
* [Performing basic deconvolution with the spatialdecon function](#performing-basic-deconvolution-with-the-spatialdecon-function)
* [Using the advanced settings of spatialdecon](#using-the-advanced-settings-of-spatialdecon)
* [Plotting deconvolution results](#plotting-deconvolution-results)
* [Other functions](#other-functions)
* [Session Info](#session-info)

### Installation

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("SpatialDecon")
```

### Overview

This vignette demonstrates the use of the SpatialDecon package to estimate cell abundance in spatial gene expression studies.

We’ll analyze a small GeoMx dataset from a lung tumor, looking for abundance of different immune cell types. This dataset has 30 ROIs. In each ROI, Tumor and Microenvironment segments have been profiled separately.

### Data preparation

First, we load the package:

```
library(SpatialDecon)
```

Now let’s load our example data and examine it:

```
data("mini_geomx_dataset")
norm = mini_geomx_dataset$normalized
raw = mini_geomx_dataset$raw
annot = mini_geomx_dataset$annot
dim(raw)
#> [1] 545  30
head(annot)
#>                                       ROI AOI.name    x    y nuclei
#> ICP20th.L11.ICPKilo.ROI10.TME.B09   ROI10      TME 5400 8000    879
#> ICP20th.L11.ICPKilo.ROI10.Tumor.B08 ROI10    Tumor 5400 8000    555
#> ICP20th.L11.ICPKilo.ROI11.TME.B11   ROI11      TME 6000 8000    631
#> ICP20th.L11.ICPKilo.ROI11.Tumor.B10 ROI11    Tumor 6000 8000    569
#> ICP20th.L11.ICPKilo.ROI12.TME.C01   ROI12      TME 6600 8000    703
#> ICP20th.L11.ICPKilo.ROI12.Tumor.B12 ROI12    Tumor 6600 8000    667
raw[seq_len(5), seq_len(5)]
#>        ICP20th.L11.ICPKilo.ROI10.TME.B09 ICP20th.L11.ICPKilo.ROI10.Tumor.B08
#> A2M                                   76                                  20
#> ABCB1                                  9                                  15
#> ACP5                                 115                                  41
#> ADAM12                                12                                  12
#> ADORA3                                14                                   8
#>        ICP20th.L11.ICPKilo.ROI11.TME.B11 ICP20th.L11.ICPKilo.ROI11.Tumor.B10
#> A2M                                  104                                  22
#> ABCB1                                  7                                  10
#> ACP5                                 176                                  56
#> ADAM12                                10                                  11
#> ADORA3                                10                                  13
#>        ICP20th.L11.ICPKilo.ROI12.TME.C01
#> A2M                                   91
#> ABCB1                                 11
#> ACP5                                 120
#> ADAM12                                13
#> ADORA3                                11

# better segment names:
colnames(norm) = colnames(raw) = rownames(annot) =
  paste0(annot$ROI, annot$AOI.name)
```

The spatialdecon function takes 3 arguments of expression data:

1. The normalized data.
2. A matrix of expected background for all data points in the normalized data matrix.
3. Optionally, either a matrix of per-data-point weights, or the raw data, which is used to derive weights (low counts are less statistically stable, and this allows spatialdecon to down-weight them.)

We estimate each data point’s expected background from the negative control probes from its corresponding observation:

```
# use the NegProbe to estimate per-observation background
per.observation.mean.neg = norm["NegProbe", ]
# and define a background matrix in which each column (observation) is the
# appropriate value of per-observation background:
bg = sweep(norm * 0, 2, per.observation.mean.neg, "+")
dim(bg)
#> [1] 545  30
```

A note for background estimation: in studies with two probesets, the genes from each probeset will have distinct background values, and the above code should be run separately for each probeset using its corresponding NegProbe value. Alternatively, the “derive\_GeoMx\_background” can do this automatically:

```
bg2 = derive_GeoMx_background(norm = norm,
                             probepool = rep(1, nrow(norm)),
                             negnames = "NegProbe")
```

### Cell profile matrices

A “cell profile matrix” is a pre-defined matrix that specifies the expected expression profiles of each cell type in the experiment. The SpatialDecon library comes with one such matrix pre-loaded, the “SafeTME” matrix, designed for estimation of immune and stroma cells in the tumor microenvironment. (This matrix was designed to avoid genes commonly expressed by cancer cells; see the SpatialDecon manuscript for details.)

Let’s take a glance at the safeTME matrix:

```
data("safeTME")
data("safeTME.matches")

signif(safeTME[seq_len(3), seq_len(3)], 2)
#>       macrophages  mast B.naive
#> A2M        0.8500 0.044  0.0043
#> ABCB1      0.0021 0.023  0.0250
#> ABCB4      0.0044 0.000  0.2200

heatmap(sweep(safeTME, 1, apply(safeTME, 1, max), "/"),
        labRow = NA, margins = c(10, 5))
```

![](data:image/png;base64...)

The safeTME cell profile matrix

For studies of other tissue types, we have provided a library of cell profile matrices, available on Github and downloadable with the “download\_profile\_matrix” function.

For a complete list of matrices, see [CellProfileLibrary GitHub Page](https://github.com/Nanostring-Biostats/CellProfileLibrary)

Below we download a matrix of cell profiles derived from scRNA-seq of a mouse spleen.

```
mousespleen <- download_profile_matrix(species = "Mouse",
                                       age_group = "Adult",
                                       matrixname = "Spleen_MCA")
dim(mousespleen)
#> [1] 11125     9

mousespleen[1:4,1:4]
#>               Dendritic.cell.S100a4.high Dendritic.cell.Siglech.high
#> 0610009B22Rik                 0.02985075                   0.0000000
#> 0610010F05Rik                 0.00000000                   0.0000000
#> 0610010K14Rik                 0.02985075                   0.0000000
#> 0610012G03Rik                 0.08955224                   0.1111111
#>               Granulocyte Macrophage
#> 0610009B22Rik  0.00000000 0.00000000
#> 0610010F05Rik  0.00000000 0.00000000
#> 0610010K14Rik  0.00000000 0.03846154
#> 0610012G03Rik  0.08571429 0.03846154

head(cellGroups)
#> $Dendritic
#> [1] "Dendritic.cell.S100a4.high"  "Dendritic.cell.Siglech.high"
#>
#> $Granulocyte
#> [1] "Granulocyte"
#>
#> $Macrophage
#> [1] "Macrophage"
#>
#> $`Marginal zone B`
#> [1] "Marginal.zone.B.cell"
#>
#> $Monocyte
#> [1] "Monocyte"
#>
#> $NK
#> [1] "NK.cell"

metadata
#>    Profile Matrix Tissue Species  Strain        Age Age Group
#> 33            MCA Spleen   Mouse C57BL/6 6-10 weeks     Adult
#>                                          URL
#> 33 https://pubmed.ncbi.nlm.nih.gov/29474909/
#>                                                                                        Citation
#> 33 Han, X. et al. Mapping the Mouse Cell Atlas by Microwell-Seq. Cell172, 1091-1107.e17 (2018).

heatmap(sweep(mousespleen, 1, apply(mousespleen, 1, max), "/"),
        labRow = NA, margins = c(10, 5), cexCol = 0.7)
```

![](data:image/png;base64...)

The Mouse Spleen profile matrix

For studies where the provided cell profile matrices aren’t sufficient or if a specific single cell dataset is wanted, we can make a custom profile matrix using the function create\_profile\_matrix().

This mini single cell dataset is a fraction of the data from Kinchen, J. et al.  Structural Remodeling of the Human Colonic Mesenchyme in Inflammatory Bowel Disease. Cell 175, 372-386.e17 (2018).

```
data("mini_singleCell_dataset")

mini_singleCell_dataset$mtx@Dim # genes x cells
#> [1] 1814  250

as.matrix(mini_singleCell_dataset$mtx)[1:4,1:4]
#>          ACTGCTCGTAAGTTCC.S90 TGAAAGAAGGCGCTCT.S66 AGCTTGAGTTTGGGCC.S66
#> PLEKHN1                     0                    0                    0
#> PERM1                       0                    0                    0
#> C1orf159                    0                    0                    0
#> TTLL10                      0                    0                    0
#>          ACGGCCATCGTCTGAA.S66
#> PLEKHN1                     0
#> PERM1                       0
#> C1orf159                    0
#> TTLL10                      0

head(mini_singleCell_dataset$annots)
#>                    CellID  LabeledCellType
#> 2660 ACTGCTCGTAAGTTCC.S90     stromal cell
#> 2162 TGAAAGAAGGCGCTCT.S66       glial cell
#> 368  AGCTTGAGTTTGGGCC.S66 endothelial cell
#> 238  ACGGCCATCGTCTGAA.S66     stromal cell
#> 4158 TCTCTAACACTGTTAG.S90     stromal cell
#> 2611 ACGATGTGTGTGGTTT.S90     stromal cell

table(mini_singleCell_dataset$annots$LabeledCellType)
#>
#>            endothelial cell                  glial cell
#>                          14                          12
#>               pericyte cell                 plasma cell
#>                           3                          30
#> smooth muscle cell of colon                stromal cell
#>                           1                         190
```

**Pericyte cell** and **smooth muscle cell of colon** will be dropped from this matrix due to low cell count. The average expression across all cells of one type is returned so the more cells of one type, the better reflection of the true gene expression. The confidence in these averages can be changed using the minCellNum filter.

```
custom_mtx <- create_profile_matrix(mtx = mini_singleCell_dataset$mtx,            # cell x gene count matrix
                                    cellAnnots = mini_singleCell_dataset$annots,  # cell annotations with cell type and cell name as columns
                                    cellTypeCol = "LabeledCellType",  # column containing cell type
                                    cellNameCol = "CellID",           # column containing cell ID/name
                                    matrixName = "custom_mini_colon", # name of final profile matrix
                                    outDir = NULL,                    # path to desired output directory, set to NULL if matrix should not be written
                                    normalize = FALSE,                # Should data be normalized?
                                    minCellNum = 5,                   # minimum number of cells of one type needed to create profile, exclusive
                                    minGenes = 10,                    # minimum number of genes expressed in a cell, exclusive
                                    scalingFactor = 5,                # what should all values be multiplied by for final matrix
                                    discardCellTypes = TRUE)          # should cell types be filtered for types like mitotic, doublet, low quality, unknown, etc.
#> [1] "Creating Atlas"
#> [1] "1 / 6 : stromal cell"
#> [1] "2 / 6 : glial cell"
#> [1] "3 / 6 : endothelial cell"
#> [1] "4 / 6 : plasma cell"
#> [1] "5 / 6 : pericyte cell"
#> Warning in create_profile_matrix(mtx = mini_singleCell_dataset$mtx, cellAnnots = mini_singleCell_dataset$annots, :
#>  pericyte cell was dropped from matrix because it didn't have enough viable cells based on current filtering thresholds.
#>                                         If this cell type is necessary consider changing minCellNum or minGenes
#> [1] "6 / 6 : smooth muscle cell of colon"
#> Warning in create_profile_matrix(mtx = mini_singleCell_dataset$mtx, cellAnnots = mini_singleCell_dataset$annots, :
#>  smooth muscle cell of colon was dropped from matrix because it didn't have enough viable cells based on current filtering thresholds.
#>                                         If this cell type is necessary consider changing minCellNum or minGenes

head(custom_mtx)
#>          stromal cell glial cell endothelial cell plasma cell
#> PLEKHN1     0.0000000          0        0.0000000  0.05787067
#> PERM1       0.1167131          0        0.0000000  0.00000000
#> C1orf159    0.0000000          0        0.0000000  0.07922668
#> TTLL10      0.0000000          0        0.1853931  0.00000000
#> TAS1R3      0.0000000          0        0.0000000  0.07039008
#> ATAD3C      0.1219237          0        0.0000000  0.07922668

heatmap(sweep(custom_mtx, 1, apply(custom_mtx, 1, max), "/"),
        labRow = NA, margins = c(10, 5), cexCol = 0.7)
```

![](data:image/png;base64...)

Custom profile matrix

Custom matrices can be created from all single cell data classes as long as a counts matrix and cell annotations can be passed to the function. Here is an example of creating a matrix using a Seurat object.

```
library(SeuratObject)
#> Loading required package: sp
#>
#> Attaching package: 'SeuratObject'
#> The following objects are masked from 'package:base':
#>
#>     intersect, t
library(Seurat)

data("mini_singleCell_dataset")

rownames(mini_singleCell_dataset$annots) <- mini_singleCell_dataset$annots$CellID

seuratObject <- CreateSeuratObject(counts = mini_singleCell_dataset$mtx,
                                   meta.data = mini_singleCell_dataset$annots)
Idents(seuratObject) <- seuratObject$LabeledCellType

rm(mini_singleCell_dataset)

annots <- data.frame(cbind(cellType=as.character(Idents(seuratObject)),
                           cellID=names(Idents(seuratObject))))

custom_mtx_seurat <- create_profile_matrix(mtx = Seurat::GetAssayData(object = seuratObject,
                                                                      assay = "RNA",
                                                                      layer = "counts"),
                                           cellAnnots = annots,
                                           cellTypeCol = "cellType",
                                           cellNameCol = "cellID",
                                           matrixName = "custom_mini_colon",
                                           outDir = NULL,
                                           normalize = FALSE,
                                           minCellNum = 5,
                                           minGenes = 10)
#> [1] "Creating Atlas"
#> [1] "1 / 6 : stromal cell"
#> [1] "2 / 6 : glial cell"
#> [1] "3 / 6 : endothelial cell"
#> [1] "4 / 6 : plasma cell"
#> [1] "5 / 6 : pericyte cell"
#> Warning in create_profile_matrix(mtx = Seurat::GetAssayData(object = seuratObject, :
#>  pericyte cell was dropped from matrix because it didn't have enough viable cells based on current filtering thresholds.
#>                                         If this cell type is necessary consider changing minCellNum or minGenes
#> [1] "6 / 6 : smooth muscle cell of colon"
#> Warning in create_profile_matrix(mtx = Seurat::GetAssayData(object = seuratObject, :
#>  smooth muscle cell of colon was dropped from matrix because it didn't have enough viable cells based on current filtering thresholds.
#>                                         If this cell type is necessary consider changing minCellNum or minGenes

head(custom_mtx_seurat)
#>          stromal cell glial cell endothelial cell plasma cell
#> PLEKHN1     0.0000000          0        0.0000000  0.05787067
#> PERM1       0.1167131          0        0.0000000  0.00000000
#> C1orf159    0.0000000          0        0.0000000  0.07922668
#> TTLL10      0.0000000          0        0.1853931  0.00000000
#> TAS1R3      0.0000000          0        0.0000000  0.07039008
#> ATAD3C      0.1219237          0        0.0000000  0.07922668

paste("custom_mtx and custom_mtx_seurat are identical", all(custom_mtx == custom_mtx_seurat))
#> [1] "custom_mtx and custom_mtx_seurat are identical TRUE"
```

### Performing basic deconvolution with the spatialdecon function

Now our data is ready for deconvolution. First we’ll show how to use spatialdecon under the basic settings, omitting optional bells and whistles.

```
res = spatialdecon(norm = norm,
                   bg = bg,
                   X = safeTME,
                   align_genes = TRUE)
str(res)
#> List of 10
#>  $ beta            : num [1:18, 1:30] 8.529 0.738 0.702 0.13 0.253 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:18] "macrophages" "mast" "B.naive" "B.memory" ...
#>   .. ..$ : chr [1:30] "ROI10TME" "ROI10Tumor" "ROI11TME" "ROI11Tumor" ...
#>  $ sigmas          : num [1:18, 1:18, 1:30] 2.9734 -0.0203 -0.0168 -0.018 0.0122 ...
#>   ..- attr(*, "dimnames")=List of 3
#>   .. ..$ : chr [1:18] "macrophages" "mast" "B.naive" "B.memory" ...
#>   .. ..$ : chr [1:18] "macrophages" "mast" "B.naive" "B.memory" ...
#>   .. ..$ : chr [1:30] "ROI10TME" "ROI10Tumor" "ROI11TME" "ROI11Tumor" ...
#>  $ yhat            : num [1:544, 1:30] 59.58 1.68 29.7 2.35 2.15 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:544] "A2M" "ABCB1" "ACP5" "ADAM12" ...
#>   .. ..$ : chr [1:30] "ROI10TME" "ROI10Tumor" "ROI11TME" "ROI11Tumor" ...
#>  $ resids          : num [1:544, 1:30] -1.794 0.287 -0.19 -0.879 0.51 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:544] "A2M" "ABCB1" "ACP5" "ADAM12" ...
#>   .. ..$ : chr [1:30] "ROI10TME" "ROI10Tumor" "ROI11TME" "ROI11Tumor" ...
#>  $ p               : num [1:18, 1:30] 7.57e-07 6.22e-03 5.75e-01 9.29e-01 5.22e-01 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:18] "macrophages" "mast" "B.naive" "B.memory" ...
#>   .. ..$ : chr [1:30] "ROI10TME" "ROI10Tumor" "ROI11TME" "ROI11Tumor" ...
#>  $ t               : num [1:18, 1:30] 4.9461 2.7357 0.5601 0.0889 0.64 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:18] "macrophages" "mast" "B.naive" "B.memory" ...
#>   .. ..$ : chr [1:30] "ROI10TME" "ROI10Tumor" "ROI11TME" "ROI11Tumor" ...
#>  $ se              : num [1:18, 1:30] 1.724 0.27 1.253 1.459 0.396 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:18] "macrophages" "mast" "B.naive" "B.memory" ...
#>   .. ..$ : chr [1:30] "ROI10TME" "ROI10Tumor" "ROI11TME" "ROI11Tumor" ...
#>  $ prop_of_all     : num [1:18, 1:30] 0.4078 0.0353 0.0336 0.0062 0.0121 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:18] "macrophages" "mast" "B.naive" "B.memory" ...
#>   .. ..$ : chr [1:30] "ROI10TME" "ROI10Tumor" "ROI11TME" "ROI11Tumor" ...
#>  $ prop_of_nontumor: num [1:18, 1:30] 0.4078 0.0353 0.0336 0.0062 0.0121 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:18] "macrophages" "mast" "B.naive" "B.memory" ...
#>   .. ..$ : chr [1:30] "ROI10TME" "ROI10Tumor" "ROI11TME" "ROI11Tumor" ...
#>  $ X               : num [1:544, 1:18] 0.74124 0.00185 3.09289 0.01374 0.11294 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:544] "A2M" "ABCB1" "ACP5" "ADAM12" ...
#>   .. ..$ : chr [1:18] "macrophages" "mast" "B.naive" "B.memory" ...
```

We’re most interested in “beta”, the matrix of estimated cell abundances.

```
heatmap(res$beta, cexCol = 0.5, cexRow = 0.7, margins = c(10,7))
```

![](data:image/png;base64...)

Cell abundance estimates

### Using the advanced settings of spatialdecon

spatialdecon has several abilities beyond basic deconvolution:

1. If given the nuclei counts for each region/observation, it returns results on the scale of total cell counts.
2. If given the identities of pure tumor regions/observations, it infers a handful of tumor-specific expression profiles and appends them to the cell profile matrix. Doing this accounts for cancer cell-derived expression from any genes in the cell profile matrix, removing contaminating signal from cancer cells.
3. If given raw count data, it derives per-data-point weights, using an error model derived for GeoMx data.
4. If given a “cellmatches” argument, it sums multiple closely-related cell types into a single score. E.g. if the safeTME matrix is used with the cell-matching data object “safeTME.matches”, it e.g. sums the “T.CD8.naive” and “T.CD8.memory” scores into a single “CD8.T.cells” score.

Let’s take a look at an example cell matching object:

```
str(safeTME.matches)
#> List of 14
#>  $ macrophages      : chr "macrophages"
#>  $ mast             : chr "mast"
#>  $ B                : chr [1:2] "B.naive" "B.memory"
#>  $ plasma           : chr "plasma"
#>  $ CD4.T.cells      : chr [1:2] "T.CD4.naive" "T.CD4.memory"
#>  $ CD8.T.cells      : chr [1:2] "T.CD8.naive" "T.CD8.memory"
#>  $ NK               : chr "NK"
#>  $ pDC              : chr "pDCs"
#>  $ mDCs             : chr "mDCs"
#>  $ monocytes        : chr [1:2] "monocytes.C" "monocytes.NC.I"
#>  $ neutrophils      : chr "neutrophils"
#>  $ Treg             : chr "Treg"
#>  $ endothelial.cells: chr "endothelial.cells"
#>  $ fibroblasts      : chr "fibroblasts"
```

Now let’s run spatialdecon:

```
# vector identifying pure tumor segments:
annot$istumor = (annot$AOI.name == "Tumor")

# run spatialdecon with all the bells and whistles:
restils = spatialdecon(norm = norm,                     # normalized data
                       raw = raw,                       # raw data, used to down-weight low-count observations
                       bg = bg,                         # expected background counts for every data point in norm
                       X = safeTME,                     # safeTME matrix, used by default
                       cellmerges = safeTME.matches,   # safeTME.matches object, used by default
                       cell_counts = annot$nuclei,      # nuclei counts, used to estimate total cells
                       is_pure_tumor = annot$istumor,   # identities of the Tumor segments/observations
                       n_tumor_clusters = 5)            # how many distinct tumor profiles to append to safeTME

str(restils)
#> List of 14
#>  $ beta                : num [1:14, 1:30] 4.9748 0.44963 0.00666 0 0.51277 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:14] "macrophages" "mast" "B" "plasma" ...
#>   .. ..$ : chr [1:30] "ROI10TME" "ROI10Tumor" "ROI11TME" "ROI11Tumor" ...
#>  $ yhat                : num [1:544, 1:30] 26.66 2.55 23.19 1.59 2.55 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:544] "A2M" "ABCB1" "ACP5" "ADAM12" ...
#>   .. ..$ : chr [1:30] "ROI10TME" "ROI10Tumor" "ROI11TME" "ROI11Tumor" ...
#>  $ resids              : num [1:544, 1:30] -0.633 -0.316 0.167 -0.319 0.263 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:544] "A2M" "ABCB1" "ACP5" "ADAM12" ...
#>   .. ..$ : chr [1:30] "ROI10TME" "ROI10Tumor" "ROI11TME" "ROI11Tumor" ...
#>  $ p                   : num [1:14, 1:30] 2.39e-09 8.46e-05 9.79e-01 1.00 7.18e-01 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:14] "macrophages" "mast" "B" "plasma" ...
#>   .. ..$ : chr [1:30] "ROI10TME" "ROI10Tumor" "ROI11TME" "ROI11Tumor" ...
#>  $ t                   : num [1:14, 1:30] 5.9688 3.9311 0.0266 0 0.3609 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:14] "macrophages" "mast" "B" "plasma" ...
#>   .. ..$ : chr [1:30] "ROI10TME" "ROI10Tumor" "ROI11TME" "ROI11Tumor" ...
#>  $ se                  : num [1:14, 1:30] 0.833 0.114 0.25 0.149 1.421 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:14] "macrophages" "mast" "B" "plasma" ...
#>   .. ..$ : chr [1:30] "ROI10TME" "ROI10Tumor" "ROI11TME" "ROI11Tumor" ...
#>  $ beta.granular       : num [1:23, 1:30] 4.9748 0.44963 0.00666 0 0 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:23] "macrophages" "mast" "B.naive" "B.memory" ...
#>   .. ..$ : chr [1:30] "ROI10TME" "ROI10Tumor" "ROI11TME" "ROI11Tumor" ...
#>  $ sigma.granular      : num [1:23, 1:23, 1:30] 0.694663 -0.002567 -0.000412 0.002024 -0.00123 ...
#>   ..- attr(*, "dimnames")=List of 3
#>   .. ..$ : chr [1:23] "macrophages" "mast" "B.naive" "B.memory" ...
#>   .. ..$ : chr [1:23] "macrophages" "mast" "B.naive" "B.memory" ...
#>   .. ..$ : chr [1:30] "ROI10TME" "ROI10Tumor" "ROI11TME" "ROI11Tumor" ...
#>  $ sigma               : num [1:14, 1:14, 1:30] 0.69466 -0.00257 0.00161 -0.00123 0.05047 ...
#>   ..- attr(*, "dimnames")=List of 3
#>   .. ..$ : chr [1:14] "macrophages" "mast" "B" "plasma" ...
#>   .. ..$ : chr [1:14] "macrophages" "mast" "B" "plasma" ...
#>   .. ..$ : chr [1:30] "ROI10TME" "ROI10Tumor" "ROI11TME" "ROI11Tumor" ...
#>  $ prop_of_all         : num [1:14, 1:30] 0.54558 0.04931 0.00073 0 0.05624 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:14] "macrophages" "mast" "B" "plasma" ...
#>   .. ..$ : chr [1:30] "ROI10TME" "ROI10Tumor" "ROI11TME" "ROI11Tumor" ...
#>  $ prop_of_nontumor    : num [1:14, 1:30] 0.54558 0.04931 0.00073 0 0.05624 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:14] "macrophages" "mast" "B" "plasma" ...
#>   .. ..$ : chr [1:30] "ROI10TME" "ROI10Tumor" "ROI11TME" "ROI11Tumor" ...
#>  $ cell.counts         :List of 2
#>   ..$ cells.per.100: num [1:14, 1:30] 20.211 1.827 0.027 0 2.083 ...
#>   .. ..- attr(*, "dimnames")=List of 2
#>   .. .. ..$ : chr [1:14] "macrophages" "mast" "B" "plasma" ...
#>   .. .. ..$ : chr [1:30] "ROI10TME" "ROI10Tumor" "ROI11TME" "ROI11Tumor" ...
#>   ..$ cell.counts  : num [1:14, 1:30] 177.659 16.057 0.238 0 18.312 ...
#>   .. ..- attr(*, "dimnames")=List of 2
#>   .. .. ..$ : chr [1:14] "macrophages" "mast" "B" "plasma" ...
#>   .. .. ..$ : chr [1:30] "ROI10TME" "ROI10Tumor" "ROI11TME" "ROI11Tumor" ...
#>  $ cell.counts.granular:List of 2
#>   ..$ cells.per.100: num [1:18, 1:30] 20.211 1.827 0.027 0 0 ...
#>   .. ..- attr(*, "dimnames")=List of 2
#>   .. .. ..$ : chr [1:18] "macrophages" "mast" "B.naive" "B.memory" ...
#>   .. .. ..$ : chr [1:30] "ROI10TME" "ROI10Tumor" "ROI11TME" "ROI11Tumor" ...
#>   ..$ cell.counts  : num [1:18, 1:30] 177.659 16.057 0.238 0 0 ...
#>   .. ..- attr(*, "dimnames")=List of 2
#>   .. .. ..$ : chr [1:18] "macrophages" "mast" "B.naive" "B.memory" ...
#>   .. .. ..$ : chr [1:30] "ROI10TME" "ROI10Tumor" "ROI11TME" "ROI11Tumor" ...
#>  $ X                   : num [1:544, 1:23] 0.74124 0.00185 3.09289 0.01374 0.11294 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:544] "A2M" "ABCB1" "ACP5" "ADAM12" ...
#>   .. ..$ : chr [1:23] "macrophages" "mast" "B.naive" "B.memory" ...
```

There are quite a few readouts here. Let’s review the important ones:

* beta: the cell abundance scores of the rolled-up/major cell types
* beta.granular: the cell abundance scores of the granular cell types, corresponding to the columns of the cell profile matrix
* yhat, resids: the fitted values and log2-scale residuals from the deconvolution fit. Can be used to measure each observation’s goodness-of-fit, a possible QC metric.
* cell.counts, cell.counts.granular: estimated numbers of each cell type, derived using the nuclei count input
* prop\_of\_nontumor: the beta matrix rescaled to give the proportions of non-tumor cells in each observation.
* X: the cell profile matrix used, including newly-derived tumor-specific columns.

To illustrate the derivation of tumor profiles, let’s look at the cell profile matrix output by spatialdecon:

```
heatmap(sweep(restils$X, 1, apply(restils$X, 1, max), "/"),
         labRow = NA, margins = c(10, 5))
```

![](data:image/png;base64...)

safeTME merged with newly-derived tumor profiles

Note the new tumor-specific columns.

Finally, let’s compare deconvolution results from basic vs. the advanced setting with tumor profiles appended (just for a few cell types):

```
par(mfrow = c(2, 3))
par(mar = c(5,7,2,1))
for (i in seq_len(6)) {
  cell = rownames(res$beta)[i]
  plot(res$beta[cell, ], restils$beta.granular[cell, ],
       xlab = paste0(cell, " score under basic setting"),
       ylab = paste0(cell, " score when tumor\ncells are modelled"),
       pch = 16,
       col = c(rgb(0,0,1,0.5), rgb(1,0,0,0.5))[1 + annot$istumor],
       xlim = range(c(res$beta[cell, ], restils$beta.granular[cell, ])),
       ylim = range(c(res$beta[cell, ], restils$beta.granular[cell, ])))
  abline(0,1)
  if (i == 1) {
    legend("topleft", pch = 16, col = c(rgb(0,0,1,0.5), rgb(1,0,0,0.5)),
           legend = c("microenv.", "tumor"))
  }
}
```

![](data:image/png;base64...)

Cell abundance estimates with and without modelling tumor profiles

So the impact of modelling tumor is two-fold:

* Estimated immune cell content in tumor segments is driven down all the way, or almost all the way, to 0.
* Estimated immune cell abundance in microenvironment segments in suppressed, as part of the gene expression is attributed to cancer cells instead of immune cells.

### Plotting deconvolution results

The SpatialDecon package contains two specialized plotting functions, and a default color palette for the safeTME matrix.

The first function is “TIL\_barplot”, which is just a convenient way of drawing barplots of cell type abundance.

```
# For reference, show the TILs color data object used by the plotting functions
# when safeTME has been used:
data("cellcols")
cellcols
#>       CD4.T.cells       CD8.T.cells              Treg       T.CD4.naive
#>             "red"       "firebrick"         "#FF66FF"         "#CC0000"
#>      T.CD4.memory       T.CD8.naive      T.CD8.memory                NK
#>         "#FF0000"         "#FF6633"         "#FF9900"          "grey10"
#>                 B           B.naive          B.memory            plasma
#>        "darkblue"         "#000099"         "#0000FF"         "#3399CC"
#>               pDC              pDCs       macrophages         monocytes
#>         "#00FFFF"         "#00FFFF"         "#006600"         "#33CC00"
#>       monocytes.C    monocytes.NC.I              mDCs       neutrophils
#>         "#66CC66"         "#33CC00"         "#00FF00"         "#9966CC"
#>              mast       fibroblasts endothelial.cells             tumor
#>         "#FFFF00"         "#999999"         "#996633"         "#333333"

# show just the TME segments, since that's where the immune cells are:
layout(mat = (matrix(c(1, 2), 1)), widths = c(7, 3))
TIL_barplot(restils$cell.counts$cell.counts, draw_legend = TRUE,
            cex.names = 0.5)
```

![](data:image/png;base64...)

Barplots of TIL abundance

```
# or the proportions of cells:
TIL_barplot(restils$prop_of_nontumor[, annot$AOI.name == "TME"],
            draw_legend = TRUE, cex.names = 0.75)
```

![](data:image/png;base64...)

Barplots of TIL abundance

The second function is “florets”, used for plotting cell abundances atop some 2-D projection. Here, we’ll plot cell abundances atop the first 2 principal components of the data:

```
# PCA of the normalized data:
pc = prcomp(t(log2(pmax(norm, 1))))$x[, c(1, 2)]

# run florets function:
par(mar = c(5,5,1,1))
layout(mat = (matrix(c(1, 2), 1)), widths = c(6, 2))
florets(x = pc[, 1], y = pc[, 2],
        b = restils$beta, cex = 2,
        xlab = "PC1", ylab = "PC2")
par(mar = c(0,0,0,0))
frame()
legend("center", fill = cellcols[rownames(restils$beta)],
       legend = rownames(restils$beta), cex = 0.7)
```

![](data:image/png;base64...)

TIL abundance plotted on PC space

So we can see that PC1 roughly tracks many vs. few immune cells, and PC2 tracks the relative abundance of lymphoid/myeloid populations.

### Other functions

The SpatialDecon library includes several helpful functions for further analysis/fine-tuning of deconvolution results.

#### Combining cell types:

When two cell types are too similar, the estimation of their abundances becomes unstable. However, their sum can still be estimated easily. The function “collapseCellTypes” takes a deconvolution results object and collapses any colsely-related cell types you tell it to:

```
matching = list()
matching$myeloid = c( "macrophages", "monocytes", "mDCs")
matching$T.NK = c("CD4.T.cells","CD8.T.cells", "Treg", "NK")
matching$B = c("B")
matching$mast = c("mast")
matching$neutrophils = c("neutrophils")
matching$stroma = c("endothelial.cells", "fibroblasts")

collapsed = collapseCellTypes(fit = restils,
                              matching = matching)

heatmap(collapsed$beta, cexRow = 0.85, cexCol = 0.75)
```

![](data:image/png;base64...)

Cell abundance estimates with related cell types collapsed

#### Inferring an expression profile for a cell type omitted from the profile matrix

Sometimes a cell profile matrix will omit a cell type you know to be present in a tissue. If your data includes any regions that are purely this unmodelled cell type - e.g. because you’ve used the GeoMx platform’s segmentation capability to specifically select them - then you can infer a profile for that cell type and merge it with your cell profile matrix. The algorithm clusters all the observations you designate as purely the unmodelled cell type, and collapses those clusters into as many profiles of that cell type as you wish. For cancer cell, it may be appropriate to specify 10 or more clusters; for highly regular healthy cells, one cluster may suffice.

(Note: this functionality can also be run within the spatialdecon function, as is demonstrated further above.)

```
pure.tumor.ids = annot$AOI.name == "Tumor"
safeTME.with.tumor = mergeTumorIntoX(norm = norm,
                                     bg = bg,
                                     pure_tumor_ids = pure.tumor.ids,
                                     X = safeTME,
                                     K = 3)

heatmap(sweep(safeTME.with.tumor, 1, apply(safeTME.with.tumor, 1, max), "/"),
        labRow = NA, margins = c(10, 5))
```

![](data:image/png;base64...)

safeTME merged with newly-derived tumor profiles

#### Reverse deconvolution

Once cell type abundance has been estimated, we can flip the deconvolution around, modelling the expression data as a function of cell abundances, and thereby deriving:

1. Estimated expression of each gene in each cell type. (Including for genes not present in your cell profile matrix)
2. Fitted expression values for each gene based on cell mixing.
3. Residuals of each gene: how does their expression compare to what cell mixing would predict?
4. Two metrics of how well genes are predicted by/ redundant with cell mixing: correlation between observed and fitted expression, and residual SD.

The function “reversedecon” runs this model.

```
rdecon = reverseDecon(norm = norm,
                      beta = res$beta)
str(rdecon)
#> List of 5
#>  $ coefs   : num [1:545, 1:19] 1.443 1.312 0 0.683 0.976 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:545] "A2M" "ABCB1" "ACP5" "ADAM12" ...
#>   .. ..$ : chr [1:19] "(Intercept)" "macrophages" "mast" "B.naive" ...
#>  $ yhat    : num [1:545, 1:30] 17.47 2.44 32.39 1.11 2.86 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:545] "A2M" "ABCB1" "ACP5" "ADAM12" ...
#>   .. ..$ : chr [1:30] "ROI10TME" "ROI10Tumor" "ROI11TME" "ROI11Tumor" ...
#>  $ resids  : num [1:545, 1:30] -0.0237 -0.2567 -0.3155 0.2016 0.0978 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:545] "A2M" "ABCB1" "ACP5" "ADAM12" ...
#>   .. ..$ : chr [1:30] "ROI10TME" "ROI10Tumor" "ROI11TME" "ROI11Tumor" ...
#>  $ cors    : Named num [1:545] 0.869 0.552 0.961 0.916 0.909 ...
#>   ..- attr(*, "names")= chr [1:545] "A2M" "ABCB1" "ACP5" "ADAM12" ...
#>  $ resid.sd: Named num [1:545] 0.364 0.233 0.386 0.33 0.196 ...
#>   ..- attr(*, "names")= chr [1:545] "A2M" "ABCB1" "ACP5" "ADAM12" ...

# look at the residuals:
heatmap(pmax(pmin(rdecon$resids, 2), -2))
```

![](data:image/png;base64...)

Residuals from reverseDecon

```
# look at the two metrics of goodness-of-fit:
plot(rdecon$cors, rdecon$resid.sd, col = 0)
showgenes = c("CXCL14", "LYZ", "NKG7")
text(rdecon$cors[setdiff(names(rdecon$cors), showgenes)],
     rdecon$resid.sd[setdiff(names(rdecon$cors), showgenes)],
     setdiff(names(rdecon$cors), showgenes), cex = 0.5)
text(rdecon$cors[showgenes], rdecon$resid.sd[showgenes],
     showgenes, cex = 0.75, col = 2)
```

![](data:image/png;base64...)

Genes’ dependency on cell mixing

From the above plot, we can see that genes like CXCL14 vary independently of cell mixing, genes like LYZ are correlated with cell mixing but still have variable expression, and genes like NKG7 serve as nothing but obtuse readouts of cell mixing.

### Session Info

```
sessionInfo()
#> R version 4.5.2 (2025-10-31)
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
#> [1] Seurat_5.4.0        SeuratObject_5.3.0  sp_2.2-0
#> [4] SpatialDecon_1.20.1
#>
#> loaded via a namespace (and not attached):
#>   [1] RcppAnnoy_0.0.23         splines_4.5.2            later_1.4.5
#>   [4] tibble_3.3.1             R.oo_1.27.1              cellranger_1.1.0
#>   [7] polyclip_1.10-7          fastDummies_1.7.5        lifecycle_1.0.5
#>  [10] Rdpack_2.6.6             globals_0.19.0           lattice_0.22-9
#>  [13] MASS_7.3-65              magrittr_2.0.4           GeomxTools_3.14.0
#>  [16] plotly_4.12.0            sass_0.4.10              rmarkdown_2.30
#>  [19] jquerylib_0.1.4          yaml_2.3.12              httpuv_1.6.16
#>  [22] otel_0.2.0               sctransform_0.4.3        spam_2.11-3
#>  [25] spatstat.sparse_3.1-0    reticulate_1.44.1        cowplot_1.2.0
#>  [28] pbapply_1.7-4            minqa_1.2.8              RColorBrewer_1.1-3
#>  [31] abind_1.4-8              EnvStats_3.1.0           Rtsne_0.17
#>  [34] R.cache_0.17.0           purrr_1.2.1              R.utils_2.13.0
#>  [37] BiocGenerics_0.56.0      gdtools_0.5.0            IRanges_2.44.0
#>  [40] S4Vectors_0.48.0         ggrepel_0.9.6            irlba_2.3.7
#>  [43] listenv_0.10.0           spatstat.utils_3.2-1     pheatmap_1.0.13
#>  [46] goftest_1.2-3            RSpectra_0.16-2          spatstat.random_3.4-4
#>  [49] fitdistrplus_1.2-6       parallelly_1.46.1        codetools_0.2-20
#>  [52] tidyselect_1.2.1         farver_2.1.2             lme4_1.1-38
#>  [55] matrixStats_1.5.0        stats4_4.5.2             spatstat.explore_3.7-0
#>  [58] Seqinfo_1.0.0            jsonlite_2.0.0           progressr_0.18.0
#>  [61] ggridges_0.5.7           survival_3.8-6           systemfonts_1.3.1
#>  [64] tools_4.5.2              ica_1.0-3                Rcpp_1.1.1
#>  [67] glue_1.8.0               gridExtra_2.3            xfun_0.56
#>  [70] ggthemes_5.2.0           dplyr_1.2.0              numDeriv_2016.8-1.1
#>  [73] fastmap_1.2.0            NanoStringNCTools_1.18.0 GGally_2.4.0
#>  [76] repmis_0.5.1             boot_1.3-32              digest_0.6.39
#>  [79] R6_2.6.1                 mime_0.13                scattermore_1.2
#>  [82] tensor_1.5.1             dichromat_2.0-0.1        spatstat.data_3.1-9
#>  [85] R.methodsS3_1.8.2        tidyr_1.3.2              generics_0.1.4
#>  [88] fontLiberation_0.1.0     data.table_1.18.2.1      httr_1.4.7
#>  [91] htmlwidgets_1.6.4        ggstats_0.12.0           uwot_0.2.4
#>  [94] pkgconfig_2.0.3          gtable_0.3.6             lmtest_0.9-40
#>  [97] S7_0.2.1                 XVector_0.50.0           htmltools_0.5.9
#> [100] fontBitstreamVera_0.1.1  dotCall64_1.2            scales_1.4.0
#> [103] Biobase_2.70.0           png_0.1-8                logNormReg_0.5-0
#> [106] spatstat.univar_3.1-6    reformulas_0.4.4         knitr_1.51
#> [109] reshape2_1.4.5           rjson_0.2.23             nlme_3.1-168
#> [112] curl_7.0.0               nloptr_2.2.1             cachem_1.1.0
#> [115] zoo_1.8-15               stringr_1.6.0            KernSmooth_2.23-26
#> [118] parallel_4.5.2           miniUI_0.1.2             vipor_0.4.7
#> [121] pillar_1.11.1            grid_4.5.2               vctrs_0.7.1
#> [124] RANN_2.6.2               promises_1.5.0           xtable_1.8-4
#> [127] cluster_2.1.8.2          beeswarm_0.4.0           evaluate_1.0.5
#> [130] cli_3.6.5                compiler_4.5.2           rlang_1.1.7
#> [133] crayon_1.5.3             future.apply_1.20.1      plyr_1.8.9
#> [136] ggbeeswarm_0.7.3         ggiraph_0.9.4            stringi_1.8.7
#> [139] deldir_2.0-4             viridisLite_0.4.3        lmerTest_3.2-0
#> [142] Biostrings_2.78.0        lazyeval_0.2.2           spatstat.geom_3.7-0
#> [145] fontquiver_0.2.1         Matrix_1.7-4             RcppHNSW_0.6.0
#> [148] patchwork_1.3.2          future_1.69.0            ggplot2_4.0.2
#> [151] shiny_1.12.1             rbibutils_2.4.1          ROCR_1.0-12
#> [154] igraph_2.2.1             bslib_0.10.0             readxl_1.4.5
```