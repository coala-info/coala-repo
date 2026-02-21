Code

* Show All Code
* Hide All Code

# Import and representation of MERFISH mouse ileum data

Ludwig Geistlinger1, Tyrone Lee1, Jeffrey Moffitt2 and Robert Gentleman1

1Center for Computational Biomedicine, Harvard Medical School
2Department of Microbiology, Harvard Medical School

#### 4 November 2025

# 1 Setup

```
library(MerfishData)
library(ExperimentHub)
library(ggplot2)
library(grid)
```

# 2 Data

Spatial transcriptomics protocols based on in situ sequencing or multiplexed
RNA fluorescent hybridization can reveal detailed tissue organization.
However, distinguishing the boundaries of individual cells in such data is
challenging. Current segmentation methods typically approximate cells positions
using nuclei stains.

[Petukhov et al., 2021](https://doi.org/10.1038/s41587-021-01044-w),
describe
[Baysor](https://github.com/kharchenkolab/Baysor),
a segmentation method, which optimizes
2D or 3D cell boundaries considering joint likelihood of transcriptional composition
and cell morphology. Baysor can also perform segmentation based on the detected
transcripts alone.

[Petukhov et al., 2021](https://doi.org/10.1038/s41587-021-01044-w),
compare the results of Baysor segmentation
(mRNA-only) to the results of a deep learning-based segmentation
method called
[Cellpose](https://github.com/MouseLand/cellpose) from
[Stringer et al., 2021](https://doi.org/10.1038/s41592-020-01018-x).
Cellpose applies a machine learning framework for the segmentation of cell
bodies, membranes and nuclei from microscopy images.

[Petukhov et al., 2021](https://doi.org/10.1038/s41587-021-01044-w) apply
Baysor and Cellpose to MERFISH data from cryosections of mouse ileum.
The MERFISH encoding probe library was designed to target 241 genes, including
previously defined markers for the majority of gut cell types.

Def. ileum: the final and longest segment of the small intestine.

Samples were also stained with anti-Na+/K+-ATPase primary antibodies,
oligo-labeled secondary antibodies and DAPI. MERFISH measurements across
multiple fields of view and nine *z* planes were performed to provide
a volumetric reconstruction of the distribution of the targeted
mRNAs, the cell boundaries marked by Na+/K+-ATPase IF and cell
nuclei stained with DAPI.

The data was obtained from the
[datadryad data publication](https://doi.org/10.5061/dryad.jm63xsjb2).

This vignette demonstrates how to obtain the MERFISH mouse ileum dataset from
[Petukhov et al., 2021](https://doi.org/10.1038/s41587-021-01044-w)
from Bioconductor’s [ExperimentHub](https://bioconductor.org/packages/ExperimentHub).

```
eh <- ExperimentHub()
AnnotationHub::query(eh, c("MerfishData", "ileum"))
#> ExperimentHub with 9 records
#> # snapshotDate(): 2025-10-29
#> # $dataprovider: Boston Children's Hospital
#> # $species: Mus musculus
#> # $rdataclass: data.frame, matrix, EBImage
#> # additional mcols(): taxonomyid, genome, description,
#> #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
#> #   rdatapath, sourceurl, sourcetype
#> # retrieve records with, e.g., 'object[["EH7543"]]'
#>
#>            title
#>   EH7543 | Petukhov2021_ileum_molecules
#>   EH7544 | Petukhov2021_ileum_dapi
#>   EH7545 | Petukhov2021_ileum_membrane
#>   EH7547 | Petukhov2021_ileum_baysor_segmentation
#>   EH7548 | Petukhov2021_ileum_baysor_counts
#>   EH7549 | Petukhov2021_ileum_baysor_coldata
#>   EH7550 | Petukhov2021_ileum_baysor_polygons
#>   EH7551 | Petukhov2021_ileum_cellpose_counts
#>   EH7552 | Petukhov2021_ileum_cellpose_coldata
```

## 2.1 Raw data

mRNA molecule data: 820k observations for 241 genes

```
mol.dat <- eh[["EH7543"]]
dim(mol.dat)
#> [1] 819665     12
head(mol.dat)
#>   molecule_id gene x_pixel y_pixel z_pixel      x_um      y_um z_um area
#> 1           1 Maoa    1705    1271       0 -2935.386 -1218.580  2.5    4
#> 2           2 Maoa    1725    1922       0 -2933.229 -1147.614  2.5    4
#> 3           3 Maoa    1753    1863       0 -2930.104 -1154.062  2.5    5
#> 4           4 Maoa    1760    1865       0 -2929.339 -1153.784  2.5    7
#> 5           5 Maoa    1904     794       0 -2913.718 -1270.474  2.5    6
#> 6           6 Maoa    1915    1430       0 -2912.497 -1201.232  2.5    6
#>   total_magnitude brightness  qc_score
#> 1        420.1126   2.021306 0.9543635
#> 2        269.5874   1.828640 0.9082457
#> 3        501.4615   2.001268 0.9772191
#> 4        639.0364   1.960428 0.9913161
#> 5        519.3154   1.937280 0.9832103
#> 6        842.2258   2.147277 0.9925655
length(unique(mol.dat$gene))
#> [1] 241
```

Image data:

1. [DAPI](https://en.wikipedia.org/wiki/DAPI) stain signal:

```
dapi.img <- eh[["EH7544"]]
dapi.img
#> Image
#>   colorMode    : Grayscale
#>   storage.mode : double
#>   dim          : 5721 9392 9
#>   frames.total : 9
#>   frames.render: 9
#>
#> imageData(object)[1:5,1:6,1]
#>      [,1] [,2] [,3] [,4] [,5] [,6]
#> [1,]    0    0    0    0    0    0
#> [2,]    0    0    0    0    0    0
#> [3,]    0    0    0    0    0    0
#> [4,]    0    0    0    0    0    0
#> [5,]    0    0    0    0    0    0
plot(dapi.img, all = TRUE)
```

![](data:image/png;base64...)

```
plot(dapi.img, frame = 1)
```

![](data:image/png;base64...)

2. Membrane Na+/K+ - ATPase immunofluorescence signal:

While total poly(A) and DAPI staining can provide feature-rich costains suitable
for segmentation in cell-sparse tissues such as the brain, such stains are not
as useful for segmentation in cellular-dense tissues.
To address this challenge,
[Petukhov et al., 2021](https://doi.org/10.1038/s41587-021-01044-w)
developed protocols to combine immunofluorescence (IF) of a pan-cell-type cell
surface marker, the Na+/K+-ATPase, with MERFISH.

```
mem.img <- eh[["EH7545"]]
mem.img
#> Image
#>   colorMode    : Grayscale
#>   storage.mode : double
#>   dim          : 5721 9392 9
#>   frames.total : 9
#>   frames.render: 9
#>
#> imageData(object)[1:5,1:6,1]
#>      [,1]        [,2]        [,3]        [,4]        [,5]        [,6]
#> [1,]    0 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
#> [2,]    0 0.007843137 0.007843137 0.007843137 0.007843137 0.007843137
#> [3,]    0 0.007843137 0.007843137 0.007843137 0.007843137 0.007843137
#> [4,]    0 0.007843137 0.007843137 0.007843137 0.007843137 0.007843137
#> [5,]    0 0.007843137 0.007843137 0.007843137 0.007843137 0.007843137
plot(mem.img, all = TRUE)
```

![](data:image/png;base64...)

```
plot(mem.img, frame = 1)
```

![](data:image/png;base64...)

## 2.2 Segmentation

It is also possible to obtain the data in a
[SpatialExperiment](https://bioconductor.org/packages/SpatialExperiment),
which integrates the segmented experimental data and cell metadata, and provides
designated accessors for the spatial coordinates and the image data.

### 2.2.1 Baysor

Obtain dataset segmented with Baysor:

```
spe.baysor <- MouseIleumPetukhov2021(segmentation = "baysor")
spe.baysor
#> class: SpatialExperiment
#> dim: 241 5800
#> metadata(1): polygons
#> assays(2): counts molecules
#> rownames(241): Acsl1 Acta2 ... Vcan Vim
#> rowData names(0):
#> colnames: NULL
#> colData names(7): n_transcripts density ... leiden_final sample_id
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
#> spatialCoords names(2) : x y
#> imgData names(4): sample_id image_id data scaleFactor
```

Inspect dataset:

```
assay(spe.baysor, "counts")[1:5,1:5]
#>        [,1] [,2] [,3] [,4] [,5]
#> Acsl1     0    0    0    0    2
#> Acta2     0  129   86   51   66
#> Ada       0    0    0    0    0
#> Adgrd1    0    2    3    3    0
#> Adgrf5    1    0    0    0    0
assay(spe.baysor, "molecules")["Acsl1",5]
#> SplitDataFrameList of length 1
#> $Acsl1
#> DataFrame with 2 rows and 3 columns
#>           x         y         z
#>   <numeric> <numeric> <numeric>
#> 1      2216        40   68.8410
#> 2      2218        39   82.6091
colData(spe.baysor)
#> DataFrame with 5800 rows and 7 columns
#>      n_transcripts   density elongation      area avg_confidence  leiden_final
#>          <numeric> <numeric>  <numeric> <numeric>      <numeric>   <character>
#> 1               39   0.02159      5.082      1806         0.8647   Endothelial
#> 2              165   0.02016      1.565      8186         0.9528 Smooth Muscle
#> 3              139   0.02279      1.820      6100         0.9762 Smooth Muscle
#> 4               80   0.01828      1.546      4376         0.9076 Smooth Muscle
#> 5               75   0.02479      3.475      3025         0.8952 Smooth Muscle
#> ...            ...       ...        ...       ...            ...           ...
#> 5796             1       NaN        NaN       NaN         1.0000       Removed
#> 5797             9   0.02397      2.587     375.5         0.8405       Removed
#> 5798             4   0.02204     10.760     181.5         0.9962       Removed
#> 5799             1       NaN        NaN       NaN         0.9454       Removed
#> 5800             4   0.03587     17.720     111.5         0.9897       Removed
#>        sample_id
#>      <character>
#> 1          ileum
#> 2          ileum
#> 3          ileum
#> 4          ileum
#> 5          ileum
#> ...          ...
#> 5796       ileum
#> 5797       ileum
#> 5798       ileum
#> 5799       ileum
#> 5800       ileum
head(spatialCoords(spe.baysor))
#>             x         y
#> [1,] 2072.205  16.12821
#> [2,] 2150.691  41.67879
#> [3,] 2079.842  76.07194
#> [4,] 2092.325 165.76250
#> [5,] 2242.400  18.28000
#> [6,] 2236.168  87.64671
imgData(spe.baysor)
#> DataFrame with 2 rows and 4 columns
#>     sample_id    image_id   data scaleFactor
#>   <character> <character> <list>   <numeric>
#> 1       ileum        dapi   ####          NA
#> 2       ileum    membrane   ####          NA
```

### 2.2.2 Cellpose

Obtain dataset segmented with Cellpose:

```
spe.cellpose <- MouseIleumPetukhov2021(segmentation = "cellpose",
                                       use.images = FALSE)
spe.cellpose
#> class: SpatialExperiment
#> dim: 241 8439
#> metadata(0):
#> assays(1): counts
#> rownames(241): Acsl1 Acta2 ... Vcan Vim
#> rowData names(0):
#> colnames: NULL
#> colData names(2): leiden_final sample_id
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
#> spatialCoords names(3) : x y z
#> imgData names(0):
```

Inspect dataset:

```
assay(spe.cellpose, "counts")[1:5,1:5]
#>        [,1] [,2] [,3] [,4] [,5]
#> Acsl1     0    1    0    0    0
#> Acta2     0    0    0    8    1
#> Ada       0    0    0    0    0
#> Adgrd1    0    0    0    0    0
#> Adgrf5    0    0    0    0    0
colData(spe.cellpose)
#> DataFrame with 8439 rows and 2 columns
#>                leiden_final   sample_id
#>                 <character> <character>
#> 1                   Removed       ileum
#> 2                 Stem + TA       ileum
#> 3                   Removed       ileum
#> 4                   Stromal       ileum
#> 5    Enterocyte (Mid Vill..       ileum
#> ...                     ...         ...
#> 8435                Removed       ileum
#> 8436 Enterocyte (Mid Vill..       ileum
#> 8437 Enterocyte (Mid Vill..       ileum
#> 8438                 Goblet       ileum
#> 8439                Removed       ileum
head(spatialCoords(spe.cellpose))
#>             x        y        z
#> [1,] 4333.000 10.66667 64.25156
#> [2,] 3622.941 22.35294 50.21340
#> [3,] 5267.000 18.50000 75.72505
#> [4,] 2819.275 44.34783 51.88014
#> [5,] 5678.636 41.22727 43.80788
#> [6,] 4611.056 40.44444 56.60256
```

### 2.2.3 Segmentation cell counts (by cell type):

Here we inspect the difference in cell counts for the both segmentation methods,
stratified by cell type label obtained from leiden clustering and annotation by
marker gene expression:

```
seg <- rep(c("baysor", "cellpose"), c(ncol(spe.baysor), ncol(spe.cellpose)))
ns <- table(seg, c(spe.baysor$leiden_final, spe.cellpose$leiden_final))
df <- as.data.frame(ns, responseName = "n_cells")
colnames(df)[2] <- "leiden_final"
ggplot(df, aes(
    reorder(leiden_final, n_cells), n_cells, fill = seg)) +
    geom_bar(stat = "identity", position = "dodge") +
    xlab("") +
    ylab("Number of cells") +
    theme_bw() +
    theme(
        panel.grid.minor = element_blank(),
        axis.text.x = element_text(angle = 45, hjust = 1))
```

![](data:image/png;base64...)

# 3 Visualization

For visualization purposes, we focus in the following on the first *z*-plane
of the membrane staining image.

```
mem.img <- imgRaster(spe.baysor, image_id = "membrane")
```

## 3.1 Cell metadata

Overlay cell type annotation as in Figure 6 of the
[publication](https://doi.org/10.1038/s41587-021-01044-w).

```
spe.list <- list(Baysor = spe.baysor, Cellpose = spe.cellpose)
plotTabset(spe.list, mem.img)
```

### 3.1.1 Baysor

#### n\_transcripts

![](data:image/png;base64...)

#### density

![](data:image/png;base64...)

#### elongation

![](data:image/png;base64...)

#### area

![](data:image/png;base64...)

#### avg\_confidence

![](data:image/png;base64...)

#### leiden\_final

![](data:image/png;base64...)

### 3.1.2 Cellpose

#### leiden\_final

![](data:image/png;base64...)

#### z

![](data:image/png;base64...)

## 3.2 Marker gene expression

We can also overlay the individual molecules of selected marker genes such as
the different cluster of differentiation genes assayed in the experiment:

```
gs <- grep("^Cd", unique(mol.dat$gene), value = TRUE)
ind <- mol.dat$gene %in% gs
rel.cols <- c("gene", "x_pixel", "y_pixel")
sub.mol.dat <- mol.dat[ind, rel.cols]
colnames(sub.mol.dat)[2:3] <- sub("_pixel$", "", colnames(sub.mol.dat)[2:3])
plotXY(sub.mol.dat, "gene", mem.img)
```

![](data:image/png;base64...)

## 3.3 Segmentation cell borders

Here, we illustrate segmentation borders for the first *z*-plane:

```
poly <- metadata(spe.baysor)$polygons
poly <- as.data.frame(poly)
poly.z1 <- subset(poly, z == 1)
```

We add holes to the cell polygons:

```
poly.z1 <- addHolesToPolygons(poly.z1)
```

Plot over membrane image:

```
p <- plotRasterImage(mem.img)
p <- p + geom_polygon(
            data = poly.z1,
            aes(x = x, y = y, group = cell, subgroup = subid),
            fill = "lightblue")
p + theme_void()
```

![](data:image/png;base64...)

# 4 Interactive exploration

The MERFISH mouse ileum dataset is part of the
[gallery of publicly available MERFISH datasets](https://moffittlab.connect.hms.harvard.edu/merfish/merfish_homepage.html).

This gallery consists of dedicated
[iSEE](https://bioconductor.org/packages/iSEE) and
[Vitessce](http://vitessce.io/) instances, published on
[Posit Connect](https://posit.co/products/enterprise/connect/),
that enable the interactive exploration of different segmentations,
the expression of marker genes, and overlay of
cell metadata on a spatial grid or a microscopy image.

# 5 SessionInfo

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
#> [1] grid      stats4    stats     graphics  grDevices utils     datasets
#> [8] methods   base
#>
#> other attached packages:
#>  [1] ggpubr_0.6.2                rhdf5_2.54.0
#>  [3] terra_1.8-70                scater_1.38.0
#>  [5] scuttle_1.20.0              ggplot2_4.0.0
#>  [7] ExperimentHub_3.0.0         AnnotationHub_4.0.0
#>  [9] BiocFileCache_3.0.0         dbplyr_2.5.1
#> [11] MerfishData_1.12.0          SpatialExperiment_1.20.0
#> [13] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
#> [15] Biobase_2.70.0              GenomicRanges_1.62.0
#> [17] Seqinfo_1.0.0               IRanges_2.44.0
#> [19] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [21] generics_0.1.4              MatrixGenerics_1.22.0
#> [23] matrixStats_1.5.0           EBImage_4.52.0
#> [25] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] DBI_1.2.3            bitops_1.0-9         gridExtra_2.3
#>   [4] httr2_1.2.1          rlang_1.1.6          magrittr_2.0.4
#>   [7] compiler_4.5.1       RSQLite_2.4.3        png_0.1-8
#>  [10] fftwtools_0.9-11     vctrs_0.6.5          pkgconfig_2.0.3
#>  [13] crayon_1.5.3         fastmap_1.2.0        backports_1.5.0
#>  [16] magick_2.9.0         XVector_0.50.0       labeling_0.4.3
#>  [19] rmarkdown_2.30       ggbeeswarm_0.7.2     purrr_1.1.0
#>  [22] bit_4.6.0            xfun_0.54            cachem_1.1.0
#>  [25] beachmat_2.26.0      jsonlite_2.0.0       blob_1.2.4
#>  [28] rhdf5filters_1.22.0  DelayedArray_0.36.0  Rhdf5lib_1.32.0
#>  [31] BiocParallel_1.44.0  jpeg_0.1-11          tiff_0.1-12
#>  [34] broom_1.0.10         irlba_2.3.5.1        parallel_4.5.1
#>  [37] R6_2.6.1             bslib_0.9.0          RColorBrewer_1.1-3
#>  [40] car_3.1-3            scattermore_1.2      jquerylib_0.1.4
#>  [43] Rcpp_1.1.0           bookdown_0.45        knitr_1.50
#>  [46] Matrix_1.7-4         tidyselect_1.2.1     viridis_0.6.5
#>  [49] dichromat_2.0-0.1    abind_1.4-8          yaml_2.3.10
#>  [52] codetools_0.2-20     curl_7.0.0           lattice_0.22-7
#>  [55] tibble_3.3.0         BumpyMatrix_1.18.0   withr_3.0.2
#>  [58] KEGGREST_1.50.0      S7_0.2.0             evaluate_1.0.5
#>  [61] Biostrings_2.78.0    pillar_1.11.1        BiocManager_1.30.26
#>  [64] filelock_1.0.3       carData_3.0-5        RCurl_1.98-1.17
#>  [67] BiocVersion_3.22.0   scales_1.4.0         glue_1.8.0
#>  [70] tools_4.5.1          BiocNeighbors_2.4.0  ScaledMatrix_1.18.0
#>  [73] ggsignif_0.6.4       locfit_1.5-9.12      cowplot_1.2.0
#>  [76] tidyr_1.3.1          AnnotationDbi_1.72.0 beeswarm_0.4.0
#>  [79] BiocSingular_1.26.0  HDF5Array_1.38.0     vipor_0.4.7
#>  [82] Formula_1.2-5        rsvd_1.0.5           cli_3.6.5
#>  [85] rappdirs_0.3.3       viridisLite_0.4.2    S4Arrays_1.10.0
#>  [88] dplyr_1.1.4          gtable_0.3.6         ggsci_4.1.0
#>  [91] rstatix_0.7.3        sass_0.4.10          digest_0.6.37
#>  [94] ggrepel_0.9.6        SparseArray_1.10.1   rjson_0.2.23
#>  [97] htmlwidgets_1.6.4    farver_2.1.2         memoise_2.0.1
#> [100] htmltools_0.5.8.1    lifecycle_1.0.4      h5mread_1.2.0
#> [103] httr_1.4.7           bit64_4.6.0-1
```