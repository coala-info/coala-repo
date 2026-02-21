# Use of SpatialDecon in a large GeoMx dataset with GeomxTools

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
BiocManager::install("GeoMxTools")
```

### Overview

This vignette demonstrates the use of the SpatialDecon package to estimate cell abundance in spatial gene expression studies.

We’ll analyze a dense GeoMx dataset from a lung tumor, looking for abundance of different immune cell types. This dataset has 30 ROIs. In each ROI, Tumor and Microenvironment segments have been profiled separately.

### Data preparation

First, we load the package:

```
library(SpatialDecon)
library(GeomxTools)
#> Loading required package: Biobase
#> Loading required package: BiocGenerics
#> Loading required package: generics
#>
#> Attaching package: 'generics'
#> The following objects are masked from 'package:base':
#>
#>     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
#>     setequal, union
#>
#> Attaching package: 'BiocGenerics'
#> The following objects are masked from 'package:stats':
#>
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#>
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
#>     as.data.frame, basename, cbind, colnames, dirname, do.call,
#>     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
#>     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
#>     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
#>     unsplit, which.max, which.min
#> Welcome to Bioconductor
#>
#>     Vignettes contain introductory material; view with
#>     'browseVignettes()'. To cite Bioconductor, see
#>     'citation("Biobase")', and for packages 'citation("pkgname")'.
#> Loading required package: NanoStringNCTools
#> Loading required package: S4Vectors
#> Loading required package: stats4
#>
#> Attaching package: 'S4Vectors'
#> The following object is masked from 'package:utils':
#>
#>     findMatches
#> The following objects are masked from 'package:base':
#>
#>     I, expand.grid, unname
#> Loading required package: ggplot2
```

Now let’s load our example data and examine it:

```
data("nsclc")

nsclc <- updateGeoMxSet(nsclc)

dim(nsclc)
#> Features  Samples
#>     1700      199
head(pData(nsclc))
#>                                      Sample_ID Tissue Slide.name   ROI AOI.name
#> ROI01Tumor ICP20th-L11-ICPKilo-ROI01-Tumor-A02    L11    ICPKilo ROI01    Tumor
#> ROI01TME     ICP20th-L11-ICPKilo-ROI01-TME-A03    L11    ICPKilo ROI01      TME
#> ROI02Tumor ICP20th-L11-ICPKilo-ROI02-Tumor-A04    L11    ICPKilo ROI02    Tumor
#> ROI02TME     ICP20th-L11-ICPKilo-ROI02-TME-A05    L11    ICPKilo ROI02      TME
#> ROI03Tumor ICP20th-L11-ICPKilo-ROI03-Tumor-A06    L11    ICPKilo ROI03    Tumor
#> ROI03TME     ICP20th-L11-ICPKilo-ROI03-TME-A07    L11    ICPKilo ROI03      TME
#>            AOI.annotation    x    y nuclei istumor
#> ROI01Tumor          PanCK    0 8000    572    TRUE
#> ROI01TME              TME    0 8000    733   FALSE
#> ROI02Tumor          PanCK  600 8000    307    TRUE
#> ROI02TME              TME  600 8000    697   FALSE
#> ROI03Tumor          PanCK 1200 8000    583    TRUE
#> ROI03TME              TME 1200 8000    484   FALSE
nsclc@assayData$exprs[seq_len(5), seq_len(5)]
#>        ROI01Tumor ROI01TME ROI02Tumor ROI02TME ROI03Tumor
#> ABCF1          55       26         47       30        102
#> ABL1           21       22         27       18         47
#> ACVR1B         89       30         57       29        122
#> ACVR1C          9        7          4        8         14
#> ACVR2A         14       15          9       12         22

# better segment names:
sampleNames(nsclc) <-
  paste0(nsclc$ROI, nsclc$AOI.name)

#This dataset is already on Target level (genes instead of probeIDs in rows),
# just need to reflect that in object.
featureType(nsclc) <- "Target"
```

The spatialdecon function takes 3 arguments of expression data:

1. The normalized data.
2. A matrix of expected background for all data points in the normalized data matrix.
3. Optionally, either a matrix of per-data-point weights, or the raw data, which is used to derive weights (low counts are less statistically stable, and this allows spatialdecon to down-weight them.)

We estimate each data point’s expected background from the negative control probes from its corresponding observation: This study has two probesets, and the genes from each probeset will have distinct background values. The function “derive\_GeoMx\_background” conveniently estimates background of all data points, accounting for which probeset each gene belongs to:

```
bg = derive_GeoMx_background(norm = nsclc@assayData$exprs_norm,
                             probepool = fData(nsclc)$Module,
                             negnames = c("NegProbe-CTP01", "NegProbe-Kilo"))
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

For a complete list of matrices, see [CellProfileLibrary GitHub Page](https://github.com/Nanostring-Biostats/CellProfileLibrary).

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

This mini single cell dataset is a fraction of the data from Kinchen, J. et al. Structural Remodeling of the Human Colonic Mesenchyme in Inflammatory Bowel Disease. Cell 175, 372-386.e17 (2018).

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

### Performing basic deconvolution with the spatialdecon function

Now our data is ready for deconvolution. First we’ll show how to use spatialdecon under the basic settings, omitting optional bells and whistles.

```
res = runspatialdecon(object = nsclc,
                      norm_elt = "exprs_norm",
                      raw_elt = "exprs",
                      X = safeTME,
                      align_genes = TRUE)

str(pData(res))
#> 'data.frame':    199 obs. of  17 variables:
#>  $ Sample_ID       : chr  "ICP20th-L11-ICPKilo-ROI01-Tumor-A02" "ICP20th-L11-ICPKilo-ROI01-TME-A03" "ICP20th-L11-ICPKilo-ROI02-Tumor-A04" "ICP20th-L11-ICPKilo-ROI02-TME-A05" ...
#>  $ Tissue          : chr  "L11" "L11" "L11" "L11" ...
#>  $ Slide.name      : chr  "ICPKilo" "ICPKilo" "ICPKilo" "ICPKilo" ...
#>  $ ROI             : chr  "ROI01" "ROI01" "ROI02" "ROI02" ...
#>  $ AOI.name        : chr  "Tumor" "TME" "Tumor" "TME" ...
#>  $ AOI.annotation  : chr  "PanCK" "TME" "PanCK" "TME" ...
#>  $ x               : int  0 0 600 600 1200 1200 1800 1800 2400 2400 ...
#>  $ y               : num  8000 8000 8000 8000 8000 8000 8000 8000 8000 8000 ...
#>  $ nuclei          : int  572 733 307 697 583 484 506 706 851 552 ...
#>  $ istumor         : logi  TRUE FALSE TRUE FALSE TRUE FALSE ...
#>  $ beta            : num [1:199, 1:18] 4.01 7.63 5.82 17.73 2.59 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:199] "ROI01Tumor" "ROI01TME" "ROI02Tumor" "ROI02TME" ...
#>   .. ..$ : chr [1:18] "macrophages" "mast" "B.naive" "B.memory" ...
#>  $ p               : num [1:199, 1:18] 8.80e-11 0.00 2.72e-11 0.00 2.75e-08 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:199] "ROI01Tumor" "ROI01TME" "ROI02Tumor" "ROI02TME" ...
#>   .. ..$ : chr [1:18] "macrophages" "mast" "B.naive" "B.memory" ...
#>  $ t               : num [1:199, 1:18] 6.49 8.4 6.66 11.59 5.56 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:199] "ROI01Tumor" "ROI01TME" "ROI02Tumor" "ROI02TME" ...
#>   .. ..$ : chr [1:18] "macrophages" "mast" "B.naive" "B.memory" ...
#>  $ se              : num [1:199, 1:18] 0.618 0.908 0.874 1.53 0.466 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:199] "ROI01Tumor" "ROI01TME" "ROI02Tumor" "ROI02TME" ...
#>   .. ..$ : chr [1:18] "macrophages" "mast" "B.naive" "B.memory" ...
#>  $ prop_of_all     : num [1:199, 1:18] 0.208 0.208 0.218 0.412 0.156 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:199] "ROI01Tumor" "ROI01TME" "ROI02Tumor" "ROI02TME" ...
#>   .. ..$ : chr [1:18] "macrophages" "mast" "B.naive" "B.memory" ...
#>  $ prop_of_nontumor: num [1:199, 1:18] 0.208 0.208 0.218 0.412 0.156 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:199] "ROI01Tumor" "ROI01TME" "ROI02Tumor" "ROI02TME" ...
#>   .. ..$ : chr [1:18] "macrophages" "mast" "B.naive" "B.memory" ...
#>  $ sigmas          : num [1:199, 1:18, 1:18] 0.382 0.825 0.764 2.34 0.217 ...
#>   ..- attr(*, "dimnames")=List of 3
#>   .. ..$ : chr [1:199] "ROI01Tumor" "ROI01TME" "ROI02Tumor" "ROI02TME" ...
#>   .. ..$ : chr [1:18] "var1" "var2" "var3" "var4" ...
#>   .. ..$ : chr [1:18] "var1" "var2" "var3" "var4" ...
names(res@assayData)
#> [1] "exprs_norm" "resids"     "exprs"      "yhat"
```

We’re most interested in “beta”, the matrix of estimated cell abundances.

```
heatmap(t(res$beta), cexCol = 0.5, cexRow = 0.7, margins = c(10,7))
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
nsclc$istumor = nsclc$AOI.name == "Tumor"

# run spatialdecon with all the bells and whistles:
restils = runspatialdecon(object = nsclc,
                          norm_elt = "exprs_norm",                # normalized data
                          raw_elt = "exprs",                      # expected background counts for every data point in norm
                          X = safeTME,                            # safeTME matrix, used by default
                          cellmerges = safeTME.matches,           # safeTME.matches object, used by default
                          cell_counts = nsclc$nuclei,      # nuclei counts, used to estimate total cells
                          is_pure_tumor = nsclc$istumor,   # identities of the Tumor segments/observations
                          n_tumor_clusters = 5)                   # how many distinct tumor profiles to append to safeTME

str(pData(restils))
#> 'data.frame':    199 obs. of  21 variables:
#>  $ Sample_ID           : chr  "ICP20th-L11-ICPKilo-ROI01-Tumor-A02" "ICP20th-L11-ICPKilo-ROI01-TME-A03" "ICP20th-L11-ICPKilo-ROI02-Tumor-A04" "ICP20th-L11-ICPKilo-ROI02-TME-A05" ...
#>  $ Tissue              : chr  "L11" "L11" "L11" "L11" ...
#>  $ Slide.name          : chr  "ICPKilo" "ICPKilo" "ICPKilo" "ICPKilo" ...
#>  $ ROI                 : chr  "ROI01" "ROI01" "ROI02" "ROI02" ...
#>  $ AOI.name            : chr  "Tumor" "TME" "Tumor" "TME" ...
#>  $ AOI.annotation      : chr  "PanCK" "TME" "PanCK" "TME" ...
#>  $ x                   : int  0 0 600 600 1200 1200 1800 1800 2400 2400 ...
#>  $ y                   : num  8000 8000 8000 8000 8000 8000 8000 8000 8000 8000 ...
#>  $ nuclei              : int  572 733 307 697 583 484 506 706 851 552 ...
#>  $ istumor             : logi  TRUE FALSE TRUE FALSE TRUE FALSE ...
#>  $ beta                : num [1:199, 1:14] 0.4676 3.819 1.1032 11.857 0.0113 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:199] "ROI01Tumor" "ROI01TME" "ROI02Tumor" "ROI02TME" ...
#>   .. ..$ : chr [1:14] "macrophages" "mast" "B" "plasma" ...
#>  $ p                   : num [1:199, 1:14] 2.23e-01 4.59e-07 5.98e-02 0.00 9.60e-01 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:199] "ROI01Tumor" "ROI01TME" "ROI02Tumor" "ROI02TME" ...
#>   .. ..$ : chr [1:14] "macrophages" "mast" "B" "plasma" ...
#>  $ t                   : num [1:199, 1:14] 1.2174 5.0427 1.8826 8.6252 0.0501 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:199] "ROI01Tumor" "ROI01TME" "ROI02Tumor" "ROI02TME" ...
#>   .. ..$ : chr [1:14] "macrophages" "mast" "B" "plasma" ...
#>  $ se                  : num [1:199, 1:14] 0.384 0.757 0.586 1.375 0.225 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:199] "ROI01Tumor" "ROI01TME" "ROI02Tumor" "ROI02TME" ...
#>   .. ..$ : chr [1:14] "macrophages" "mast" "B" "plasma" ...
#>  $ prop_of_all         : num [1:199, 1:14] 0.3188 0.2163 0.5561 0.524 0.0765 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:199] "ROI01Tumor" "ROI01TME" "ROI02Tumor" "ROI02TME" ...
#>   .. ..$ : chr [1:14] "macrophages" "mast" "B" "plasma" ...
#>  $ prop_of_nontumor    : num [1:199, 1:14] 0.3188 0.2163 0.5561 0.524 0.0765 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:199] "ROI01Tumor" "ROI01TME" "ROI02Tumor" "ROI02TME" ...
#>   .. ..$ : chr [1:14] "macrophages" "mast" "B" "plasma" ...
#>  $ sigma               : num [1:199, 1:14, 1:14] 0.1475 0.5735 0.3434 1.8898 0.0506 ...
#>   ..- attr(*, "dimnames")=List of 3
#>   .. ..$ : chr [1:199] "ROI01Tumor" "ROI01TME" "ROI02Tumor" "ROI02TME" ...
#>   .. ..$ : chr [1:14] "var1" "var2" "var3" "var4" ...
#>   .. ..$ : chr [1:14] "var1" "var2" "var3" "var4" ...
#>  $ beta.granular       : num [1:199, 1:23] 0.4676 3.819 1.1032 11.857 0.0113 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:199] "ROI01Tumor" "ROI01TME" "ROI02Tumor" "ROI02TME" ...
#>   .. ..$ : chr [1:23] "macrophages" "mast" "B.naive" "B.memory" ...
#>  $ sigma.granular      : num [1:199, 1:23, 1:23] 0.1475 0.5735 0.3434 1.8898 0.0506 ...
#>   ..- attr(*, "dimnames")=List of 3
#>   .. ..$ : chr [1:199] "ROI01Tumor" "ROI01TME" "ROI02Tumor" "ROI02TME" ...
#>   .. ..$ : chr [1:23] "var1" "var2" "var3" "var4" ...
#>   .. ..$ : chr [1:23] "var1" "var2" "var3" "var4" ...
#>  $ cell.counts         :'data.frame':    199 obs. of  2 variables:
#>   ..$ cells.per.100: num [1:199, 1:14] 1.1769 9.6119 2.7766 29.8425 0.0284 ...
#>   .. ..- attr(*, "dimnames")=List of 2
#>   .. .. ..$ : chr [1:199] "ROI01Tumor" "ROI01TME" "ROI02Tumor" "ROI02TME" ...
#>   .. .. ..$ : chr [1:14] "macrophages" "mast" "B" "plasma" ...
#>   ..$ cell.counts  : num [1:199, 1:14] 6.732 70.455 8.524 208.002 0.165 ...
#>   .. ..- attr(*, "dimnames")=List of 2
#>   .. .. ..$ : chr [1:199] "ROI01Tumor" "ROI01TME" "ROI02Tumor" "ROI02TME" ...
#>   .. .. ..$ : chr [1:14] "macrophages" "mast" "B" "plasma" ...
#>  $ cell.counts.granular:'data.frame':    199 obs. of  2 variables:
#>   ..$ cells.per.100: num [1:199, 1:18] 1.1769 9.6119 2.7766 29.8425 0.0284 ...
#>   .. ..- attr(*, "dimnames")=List of 2
#>   .. .. ..$ : chr [1:199] "ROI01Tumor" "ROI01TME" "ROI02Tumor" "ROI02TME" ...
#>   .. .. ..$ : chr [1:18] "macrophages" "mast" "B.naive" "B.memory" ...
#>   ..$ cell.counts  : num [1:199, 1:18] 6.732 70.455 8.524 208.002 0.165 ...
#>   .. ..- attr(*, "dimnames")=List of 2
#>   .. .. ..$ : chr [1:199] "ROI01Tumor" "ROI01TME" "ROI02Tumor" "ROI02TME" ...
#>   .. .. ..$ : chr [1:18] "macrophages" "mast" "B.naive" "B.memory" ...
names(restils@assayData)
#> [1] "exprs_norm" "resids"     "exprs"      "yhat"
str(restils@experimentData@other)
#> List of 1
#>  $ SpatialDeconMatrix: num [1:544, 1:23] 0.0137 0.0379 0.2697 0.2754 0.4022 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:544] "ADAM12" "ANGPTL4" "BCAT1" "BCL2A1" ...
#>   .. ..$ : chr [1:23] "macrophages" "mast" "B.naive" "B.memory" ...
```

There are quite a few readouts here. Let’s review the important ones:

* beta: the cell abundance scores of the rolled-up/major cell types
* beta.granular: the cell abundance scores of the granular cell types, corresponding to the columns of the cell profile matrix
* yhat, resids: the fitted values and log2-scale residuals from the deconvolution fit. Can be used to measure each observation’s goodness-of-fit, a possible QC metric.
* cell.counts, cell.counts.granular: estimated numbers of each cell type, derived using the nuclei count input
* prop\_of\_nontumor: the beta matrix rescaled to give the proportions of non-tumor cells in each observation.
* SpatialDeconMatrix: the cell profile matrix used, including newly-derived tumor-specific columns.

To illustrate the derivation of tumor profiles, let’s look at the cell profile matrix output by spatialdecon:

```
heatmap(sweep(restils@experimentData@other$SpatialDeconMatrix, 1, apply(restils@experimentData@other$SpatialDeconMatrix, 1, max), "/"),
         labRow = NA, margins = c(10, 5))
```

![](data:image/png;base64...)

safeTME merged with newly-derived tumor profiles

Note the new tumor-specific columns.

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
o = hclust(dist(t(restils$cell.counts$cell.counts)))$order
layout(mat = (matrix(c(1, 2), 1)), widths = c(7, 3))
TIL_barplot(t(restils$cell.counts$cell.counts[, o]), draw_legend = TRUE,
            cex.names = 0.5)
```

![](data:image/png;base64...)

Barplots of TIL abundance

```
# or the proportions of cells:
temp = replace(restils$prop_of_nontumor, is.na(restils$prop_of_nontumor), 0)
o = hclust(dist(temp[restils$AOI.name == "TME",]))$order
TIL_barplot(t(restils$prop_of_nontumor[restils$AOI.name == "TME",])[, o],
            draw_legend = TRUE, cex.names = 0.75)
```

![](data:image/png;base64...)

Barplots of TIL abundance

The second function is “florets”, used for plotting cell abundances atop some 2-D projection. Here, we’ll plot cell abundances atop the first 2 principal components of the data:

```
# PCA of the normalized data:
pc = prcomp(t(log2(pmax(nsclc@assayData$exprs_norm, 1))))$x[, c(1, 2)]

# run florets function:
par(mar = c(5,5,1,1))
layout(mat = (matrix(c(1, 2), 1)), widths = c(6, 2))
florets(x = pc[, 1], y = pc[, 2],
        b = t(restils$beta), cex = .5,
        xlab = "PC1", ylab = "PC2")
par(mar = c(0,0,0,0))
frame()
legend("center", fill = cellcols[colnames(restils$beta)],
       legend = colnames(restils$beta), cex = 0.7)
```

![](data:image/png;base64...)

TIL abundance plotted on PC space

So we can see that PC1 roughly tracks many vs. few immune cells, and PC2 tracks the relative abundance of lymphoid/myeloid populations.

### Other functions

The SpatialDecon library includes several helpful functions for further analysis/fine-tuning of deconvolution results.

#### Combining cell types:

When two cell types are too similar, the estimation of their abundances becomes unstable. However, their sum can still be estimated easily. The function “collapseCellTypes” takes a deconvolution results object and collapses any closely-related cell types you tell it to:

```
matching = list()
matching$myeloid = c( "macrophages", "monocytes", "mDCs")
matching$T.NK = c("CD4.T.cells","CD8.T.cells", "Treg", "NK")
matching$B = c("B")
matching$mast = c("mast")
matching$neutrophils = c("neutrophils")
matching$stroma = c("endothelial.cells", "fibroblasts")

collapsed = runCollapseCellTypes(object = restils,
                                 matching = matching)

heatmap(t(collapsed$beta), cexRow = 0.85, cexCol = 0.75)
```

![](data:image/png;base64...)

Cell abundance estimates with related cell types collapsed

#### Inferring an expression profile for a cell type omitted from the profile matrix

Sometimes a cell profile matrix will omit a cell type you know to be present in a tissue. If your data includes any regions that are purely this unmodelled cell type - e.g. because you’ve used the GeoMx platform’s segmentation capability to specifically select them - then you can infer a profile for that cell type and merge it with your cell profile matrix. The algorithm clusters all the observations you designate as purely the unmodelled cell type, and collapses those clusters into as many profiles of that cell type as you wish. For cancer cell, it may be appropriate to specify 10 or more clusters; for highly regular healthy cells, one cluster may suffice.

(Note: this functionality can also be run within the spatialdecon function, as is demonstrated further above.)

```
pure.tumor.ids = res$AOI.name == "Tumor"
safeTME.with.tumor = runMergeTumorIntoX(object = nsclc,
                                        norm_elt = "exprs_norm",
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
rdecon = runReverseDecon(object = nsclc,
                         norm_elt = "exprs_norm",
                         beta = res$beta)
str(fData(rdecon))
#> 'data.frame':    1700 obs. of  12 variables:
#>  $ TargetName            : chr  "ABCF1" "ABL1" "ACVR1B" "ACVR1C" ...
#>  $ HUGOSymbol            : chr  "ABCF1" "ABL1" "ACVR1B" "ACVR1C" ...
#>  $ TargetGroup           : chr  "All Probes;Transport of small molecules" "All Probes;Cell Cycle;Signaling by Rho GTPases;DNA Repair;Factors involved in megakaryocyte development and pla"| __truncated__ "All Probes;Signaling by NODAL;Signaling by TGF-beta family members" "All Probes;Signaling by NODAL;Signaling by TGF-beta family members" ...
#>  $ AnalyteType           : chr  "RNA" "RNA" "RNA" "RNA" ...
#>  $ Codeclass             : chr  "Endogenous" "Endogenous" "Endogenous" "Endogenous" ...
#>  $ Module                : int  1 1 1 1 1 1 1 1 1 1 ...
#>  $ CorrelationToNegatives: num  0.597 0.876 0.435 0.928 0.776 ...
#>  $ GlobalOutliers        : num  0 0 0 0 0 0 0 0 0 0 ...
#>  $ Negative              : logi  FALSE FALSE FALSE FALSE FALSE FALSE ...
#>  $ coefs                 : num [1:1700, 1:19] 1.76 1.73 1.15 1.11 1.17 ...
#>   ..- attr(*, "dimnames")=List of 2
#>   .. ..$ : chr [1:1700] "ABCF1" "ABL1" "ACVR1B" "ACVR1C" ...
#>   .. ..$ : chr [1:19] "(Intercept)" "macrophages" "mast" "B.naive" ...
#>  $ cors                  : num  0.809 0.578 0.842 0.195 0.69 ...
#>  $ resid.sd              : num  0.4 0.297 0.464 0.322 0.365 ...
names(rdecon@assayData)
#> [1] "exprs_norm" "resids"     "exprs"      "yhat"

# look at the residuals:
heatmap(pmax(pmin(rdecon@assayData$resids, 2), -2))
```

![](data:image/png;base64...)

Residuals from reverseDecon

```
# look at the two metrics of goodness-of-fit:
plot(fData(rdecon)$cors, fData(rdecon)$resid.sd, col = 0)
showgenes = c("CXCL14", "LYZ", "FOXP3")
text(fData(rdecon)$cors[!rownames(fData(rdecon)) %in% showgenes],
     fData(rdecon)$resid.sd[!rownames(fData(rdecon)) %in% showgenes],
     setdiff(rownames(fData(rdecon)), showgenes), cex = 0.5)
text(fData(rdecon)$cors[rownames(fData(rdecon)) %in% showgenes], fData(rdecon)$resid.sd[rownames(fData(rdecon)) %in% showgenes],
     showgenes, cex = 0.75, col = 2)
```

![](data:image/png;base64...)

Genes’ dependency on cell mixing

From the above plot, we can see that genes like CXCL14 vary independently of cell mixing, genes like LYZ are correlated with cell mixing but still have variable expression, and genes like FOXP3 serve as nothing but obtuse readouts of cell mixing.

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
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] GeomxTools_3.14.0        NanoStringNCTools_1.18.0 ggplot2_4.0.2
#>  [4] S4Vectors_0.48.0         Biobase_2.70.0           BiocGenerics_0.56.0
#>  [7] generics_0.1.4           Seurat_5.4.0             SeuratObject_5.3.0
#> [10] sp_2.2-0                 SpatialDecon_1.20.1
#>
#> loaded via a namespace (and not attached):
#>   [1] RcppAnnoy_0.0.23        splines_4.5.2           later_1.4.5
#>   [4] tibble_3.3.1            R.oo_1.27.1             cellranger_1.1.0
#>   [7] polyclip_1.10-7         fastDummies_1.7.5       lifecycle_1.0.5
#>  [10] Rdpack_2.6.6            globals_0.19.0          lattice_0.22-9
#>  [13] MASS_7.3-65             magrittr_2.0.4          plotly_4.12.0
#>  [16] sass_0.4.10             rmarkdown_2.30          jquerylib_0.1.4
#>  [19] yaml_2.3.12             httpuv_1.6.16           otel_0.2.0
#>  [22] sctransform_0.4.3       spam_2.11-3             spatstat.sparse_3.1-0
#>  [25] reticulate_1.44.1       cowplot_1.2.0           pbapply_1.7-4
#>  [28] minqa_1.2.8             RColorBrewer_1.1-3      abind_1.4-8
#>  [31] EnvStats_3.1.0          Rtsne_0.17              R.cache_0.17.0
#>  [34] purrr_1.2.1             R.utils_2.13.0          gdtools_0.5.0
#>  [37] IRanges_2.44.0          ggrepel_0.9.6           irlba_2.3.7
#>  [40] listenv_0.10.0          spatstat.utils_3.2-1    pheatmap_1.0.13
#>  [43] goftest_1.2-3           RSpectra_0.16-2         spatstat.random_3.4-4
#>  [46] fitdistrplus_1.2-6      parallelly_1.46.1       codetools_0.2-20
#>  [49] tidyselect_1.2.1        farver_2.1.2            lme4_1.1-38
#>  [52] matrixStats_1.5.0       spatstat.explore_3.7-0  Seqinfo_1.0.0
#>  [55] jsonlite_2.0.0          progressr_0.18.0        ggridges_0.5.7
#>  [58] survival_3.8-6          systemfonts_1.3.1       tools_4.5.2
#>  [61] ica_1.0-3               Rcpp_1.1.1              glue_1.8.0
#>  [64] gridExtra_2.3           xfun_0.56               ggthemes_5.2.0
#>  [67] dplyr_1.2.0             withr_3.0.2             numDeriv_2016.8-1.1
#>  [70] fastmap_1.2.0           GGally_2.4.0            repmis_0.5.1
#>  [73] boot_1.3-32             digest_0.6.39           R6_2.6.1
#>  [76] mime_0.13               scattermore_1.2         tensor_1.5.1
#>  [79] dichromat_2.0-0.1       spatstat.data_3.1-9     R.methodsS3_1.8.2
#>  [82] tidyr_1.3.2             fontLiberation_0.1.0    data.table_1.18.2.1
#>  [85] httr_1.4.7              htmlwidgets_1.6.4       ggstats_0.12.0
#>  [88] uwot_0.2.4              pkgconfig_2.0.3         gtable_0.3.6
#>  [91] lmtest_0.9-40           S7_0.2.1                XVector_0.50.0
#>  [94] htmltools_0.5.9         fontBitstreamVera_0.1.1 dotCall64_1.2
#>  [97] scales_1.4.0            png_0.1-8               logNormReg_0.5-0
#> [100] spatstat.univar_3.1-6   reformulas_0.4.4        knitr_1.51
#> [103] reshape2_1.4.5          rjson_0.2.23            nlme_3.1-168
#> [106] curl_7.0.0              nloptr_2.2.1            cachem_1.1.0
#> [109] zoo_1.8-15              stringr_1.6.0           KernSmooth_2.23-26
#> [112] parallel_4.5.2          miniUI_0.1.2            vipor_0.4.7
#> [115] pillar_1.11.1           grid_4.5.2              vctrs_0.7.1
#> [118] RANN_2.6.2              promises_1.5.0          xtable_1.8-4
#> [121] cluster_2.1.8.2         beeswarm_0.4.0          evaluate_1.0.5
#> [124] cli_3.6.5               compiler_4.5.2          rlang_1.1.7
#> [127] crayon_1.5.3            future.apply_1.20.1     plyr_1.8.9
#> [130] ggbeeswarm_0.7.3        ggiraph_0.9.4           stringi_1.8.7
#> [133] deldir_2.0-4            viridisLite_0.4.3       lmerTest_3.2-0
#> [136] Biostrings_2.78.0       lazyeval_0.2.2          spatstat.geom_3.7-0
#> [139] fontquiver_0.2.1        Matrix_1.7-4            RcppHNSW_0.6.0
#> [142] patchwork_1.3.2         future_1.69.0           shiny_1.12.1
#> [145] rbibutils_2.4.1         ROCR_1.0-12             igraph_2.2.1
#> [148] bslib_0.10.0            readxl_1.4.5
```