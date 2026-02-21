Code

* Show All Code
* Hide All Code

# Import and representation of MERFISH mouse hypothalamus data

Ludwig Geistlinger1, Tyrone Lee1, Jeffrey Moffitt2 and Robert Gentleman1

1Center for Computational Biomedicine, Harvard Medical School
2Department of Microbiology, Harvard Medical School

#### 4 November 2025

# 1 Installation

To install the package, start R and enter:

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("MerfishData")
```

# 2 Setup

After the installation, we proceed by loading the package and additional packages
used in the vignette.

```
library(MerfishData)
library(ExperimentHub)
library(ggpubr)
```

# 3 Data

[Moffitt et al., 2018](https://doi.org/10.1126/science.aau5324)
developed an imaging-based cell type identification and mapping method and
combined it with single-cell RNA-sequencing to create a molecularly annotated
and spatially resolved cell atlas of the mouse hypothalamic preoptic region.

Def. hypothalamic preoptic region: is a part of the anterior hypothalamus that
controls essential social behaviors and homeostatic functions.

Cell segmentation was carried out based on total polyadenylated mRNA and
DAPI nuclei costains. Combinatorial smFISH imaging was used for the
identification and spatial expression profiling of 161 genes in 1,027,848 cells
from 36 mice (16 female, 20 male).

The data was obtained from the
[datadryad data publication](https://doi.org/10.5061/dryad.8t8s248).

This vignette demonstrates how to obtain the MERFISH mouse hypothalamic preoptic
region dataset from [Moffitt et al., 2018](https://doi.org/10.1126/science.aau5324)
from Bioconductor’s [ExperimentHub](https://bioconductor.org/packages/ExperimentHub).

```
eh <- ExperimentHub()
AnnotationHub::query(eh, c("MerfishData", "hypothalamus"))
#> ExperimentHub with 2 records
#> # snapshotDate(): 2025-10-29
#> # $dataprovider: Howard Hughes Medical Institute
#> # $species: Mus musculus
#> # $rdataclass: data.frame
#> # additional mcols(): taxonomyid, genome, description,
#> #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
#> #   rdatapath, sourceurl, sourcetype
#> # retrieve records with, e.g., 'object[["EH7546"]]'
#>
#>            title
#>   EH7546 | Mofitt2018_hypothalamus_segmentation
#>   EH7553 | Mofitt2018_hypothalamus_molecules
```

Note: complementary scRNA-seq of ~31,000 cells dissociated and captured from the
preoptic region of the hypothalamus from multiple male and female mice is available
on GEO ([GSE113576](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE113576)).

## 3.1 Segmented data

It is also possible to obtain the data in a [SpatialExperiment](https://bioconductor.org/packages/SpatialExperiment), which integrates experimental data and cell metadata, and provides designated accessors for the spatial coordinates.

```
spe <- MouseHypothalamusMoffitt2018()
spe
#> class: SpatialExperiment
#> dim: 135 73642
#> metadata(0):
#> assays(2): exprs molecules
#> rownames(135): Ace2 Adora2a ... Ttn Ttyh2
#> rowData names(0):
#> colnames: NULL
#> colData names(6): cell_id sample_id ... cell_class neuron_cluster_id
#> reducedDimNames(0):
#> mainExpName: smFISH
#> altExpNames(2): Blank seqFISH
#> spatialCoords names(3) : x y z
#> imgData names(0):
```

Inspect the data components:

```
assay(spe)[1:5,1:5]
#>              [,1]      [,2]     [,3]      [,4]     [,5]
#> Ace2     0.000000 0.0000000 0.000000 0.0000000 0.000000
#> Adora2a  1.638275 0.0000000 0.000000 0.0000000 0.000000
#> Aldh1l1 21.299750 1.5788733 2.701349 1.8451161 6.352415
#> Amigo2   0.000000 0.0000000 5.402654 0.9225604 0.000000
#> Ano3     1.638275 0.7894518 0.000000 0.0000000 0.000000
assay(spe, "molecules")["Aldh1l1",1]
#> SplitDataFrameList of length 1
#> $Aldh1l1
#> DataFrame with 13 rows and 3 columns
#>             x         y         z
#>     <numeric> <numeric> <numeric>
#> 1    -3213.17   2608.99       1.5
#> 2    -3211.52   2609.89       1.5
#> 3    -3208.59   2607.12       1.5
#> 4    -3216.04   2611.64       3.0
#> 5    -3208.68   2606.96       3.0
#> ...       ...       ...       ...
#> 9    -3215.51   2611.82       6.0
#> 10   -3213.33   2606.30       6.0
#> 11   -3211.82   2606.43       6.0
#> 12   -3215.51   2611.82       7.5
#> 13   -3209.87   2607.32       9.0
colData(spe)
#> DataFrame with 73642 rows and 6 columns
#>                      cell_id   sample_id         sex    behavior    cell_class
#>                  <character> <character> <character> <character>   <character>
#> 1     6749ccb4-2ed1-4029-9..           1      Female       Naive     Astrocyte
#> 2     6cac74bd-4ea7-4701-8..           1      Female       Naive    Inhibitory
#> 3     9f29bd57-16a5-4b26-b..           1      Female       Naive    Inhibitory
#> 4     d7eb4e0b-276e-47e3-a..           1      Female       Naive    Inhibitory
#> 5     54434f3a-eba9-4aec-a..           1      Female       Naive    Inhibitory
#> ...                      ...         ...         ...         ...           ...
#> 73638 7d6f8abd-4529-44a9-b..           1      Female       Naive   OD Mature 2
#> 73639 21d04afa-0699-4c35-8..           1      Female       Naive     Ambiguous
#> 73640 9e7e7c84-7dcc-4eef-a..           1      Female       Naive OD Immature 1
#> 73641 6b666f81-7b73-4100-9..           1      Female       Naive   OD Mature 2
#> 73642 fdcddd97-7701-462a-b..           1      Female       Naive   OD Mature 2
#>       neuron_cluster_id
#>             <character>
#> 1                    NA
#> 2                   I-5
#> 3                   I-6
#> 4                   I-5
#> 5                   I-9
#> ...                 ...
#> 73638                NA
#> 73639                NA
#> 73640                NA
#> 73641                NA
#> 73642                NA
head(spatialCoords(spe))
#>              x         y    z
#> [1,] -893.6953 -906.7108 0.26
#> [2,] -890.0563 -893.4568 0.26
#> [3,] -891.7111 -882.0988 0.26
#> [4,] -885.9867 -759.2063 0.26
#> [5,] -884.8158 -906.4486 0.26
#> [6,] -885.5992 -772.0895 0.26
```

Def. Bregma: The bregma is the anatomical point on the skull at which the coronal
suture is intersected perpendicularly by the sagittal suture. Used here as a
reference point for the twelve 1.8- by 1.8-mm imaged slices along the z-axis.

The anterior position of the preoptic region is at Bregma +0.26.

```
table(spatialCoords(spe)[,"z"])
#>
#> -0.29 -0.24 -0.19 -0.14 -0.09 -0.04  0.01  0.06  0.11  0.16  0.21  0.26
#>  6508  6412  6507  6605  6184  6152  6110  6144  5796  6064  5576  5584
```

Cell type assignment:

```
table(spe$cell_class)
#>
#>     Ambiguous     Astrocyte Endothelial 1 Endothelial 2 Endothelial 3
#>          9269          8393          3799           581          1369
#>     Ependymal    Excitatory    Inhibitory     Microglia OD Immature 1
#>          1961         11757         24761          1472          2457
#> OD Immature 2   OD Mature 1   OD Mature 2   OD Mature 3   OD Mature 4
#>            91           952          5736            39           367
#>     Pericytes
#>           638
```

# 4 Visualization

Visualize cell centroids and annotated cell type labels as in Figure 3E of the
[paper](https://doi.org/10.1126/science.aau5324)
for six different anterior-posterior positions from a single female mouse.

```
relz <- c(0.26, 0.16, 0.06, -0.04, -0.14, -0.24)
cdat <- data.frame(colData(spe), spatialCoords(spe))
cdat <- subset(cdat, cell_class != "Ambiguous")
cdat$cell_class <- sub(" [1-4]$", "", cdat$cell_class)
cdat <- subset(cdat, z %in% relz)
cdat$z <- as.character(cdat$z)
zum <- paste(0:5 * 100, "um")
names(zum) <- as.character(relz)
cdat$z <- unname(zum[cdat$z])
```

```
pal <- get_palette("simpsons", 9)
names(pal) <- c("Endothelial", "Excitatory", "OD Immature", "Astrocyte", "Mural",
                "Microglia", "Ependymal", "Inhibitory", "OD Mature")
ggscatter(cdat, x = "x", y = "y", color = "cell_class", facet.by = "z",
          shape = 20, size = 1, palette = pal) +
          guides(color = guide_legend(override.aes = list(size = 3)))
#> Warning: No shared levels found between `names(values)` of the manual scale and the
#> data's fill values.
```

![](data:image/png;base64...)

# 5 Interactive exploration

The MERFISH mouse hypothalamus dataset is part of the
[gallery of publicly available MERFISH datasets](https://moffittlab.connect.hms.harvard.edu/merfish/merfish_homepage.html).

This gallery consists of dedicated
[iSEE](https://bioconductor.org/packages/iSEE) and
[Vitessce](http://vitessce.io/) instances, published on
[Posit Connect](https://posit.co/products/enterprise/connect/),
that enable the interactive exploration of different segmentations,
the expression of marker genes, and overlay of
cell metadata on a spatial grid or a microscopy image.

# 6 SessionInfo

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
#>  [76] grid_4.5.1           tidyr_1.3.1          AnnotationDbi_1.72.0
#>  [79] beeswarm_0.4.0       BiocSingular_1.26.0  HDF5Array_1.38.0
#>  [82] vipor_0.4.7          Formula_1.2-5        rsvd_1.0.5
#>  [85] cli_3.6.5            rappdirs_0.3.3       viridisLite_0.4.2
#>  [88] S4Arrays_1.10.0      dplyr_1.1.4          gtable_0.3.6
#>  [91] ggsci_4.1.0          rstatix_0.7.3        sass_0.4.10
#>  [94] digest_0.6.37        ggrepel_0.9.6        SparseArray_1.10.1
#>  [97] rjson_0.2.23         htmlwidgets_1.6.4    farver_2.1.2
#> [100] memoise_2.0.1        htmltools_0.5.8.1    lifecycle_1.0.4
#> [103] h5mread_1.2.0        httr_1.4.7           bit64_4.6.0-1
```