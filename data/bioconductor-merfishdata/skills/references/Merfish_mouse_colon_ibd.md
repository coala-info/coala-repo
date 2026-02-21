Code

* Show All Code
* Hide All Code

# Import and representation of MERFISH mouse colon IBD data

Daniela Corbetta1, Ludwig Geistlinger2, Tyrone Lee2, Jeffrey Moffitt3 and Robert Gentleman2

1Department of Statistical Sciences, University of Padova
2Center for Computational Biomedicine, Harvard Medical School
3Department of Microbiology, Harvard Medical School

#### 4 November 2025

# 1 Setup

After the installation, we proceed by loading the package and additional packages
used in the vignette.

```
library(MerfishData)
library(ExperimentHub)
library(ggplot2)
library(scater)
library(terra)
```

# 2 Data

Gut inflammation involves contributions from immune and non-immune cells,
whose interactions are shaped by the spatial organization of the healthy gut and
its remodeling during inflammation.
The crosstalk between fibroblasts and immune cells is an important axis in this
process, but our understanding has been challenged by incomplete cell-type
definition and biogeography.

To address this challenge,
[Cadinu et al., 2024](https://doi.org/10.1016/j.cell.2024.03.013)
used multiplexed error-robust
fluorescence in situ hybridization
(MERFISH) to profile the expression of 943 genes in 1.35 million cells imaged
across the onset and recovery from a mouse colitis model. To assign RNAs to
individual cells, they used [Baysor](https://github.com/kharchenkolab/Baysor).
They identified diverse cell populations, charted their
spatial organization, and revealed their polarization or recruitment in
inflammation.

This vignette demonstrates how to obtain the MERFISH mouse IBD colon dataset
from [Cadinu et al., 2024](https://doi.org/10.1016/j.cell.2024.03.013)
from Bioconductor’s [ExperimentHub](https://bioconductor.org/packages/ExperimentHub).

The data was obtained from the
[datadryad data publication](https://doi.org/10.5061/dryad.rjdfn2zh3).

```
eh <- ExperimentHub()
AnnotationHub::query(eh, c("MerfishData", "Cadinu2024"))
#> ExperimentHub with 8 records
#> # snapshotDate(): 2025-10-29
#> # $dataprovider: Boston Children's Hospital
#> # $species: Mus musculus
#> # $rdataclass: HDF5Matrix, character, list, data.frame
#> # additional mcols(): taxonomyid, genome, description,
#> #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
#> #   rdatapath, sourceurl, sourcetype
#> # retrieve records with, e.g., 'object[["EH9546"]]'
#>
#>            title
#>   EH9546 | Cadinu2024_ibd_counts
#>   EH9547 | Cadinu2024_ibd_logcounts
#>   EH9548 | Cadinu2024_ibd_coldata
#>   EH9549 | Cadinu2024_ibd_metadata
#>   EH9550 | Cadinu2024_ibd_rownames
#>   EH9551 | Cadinu2024_ibd_blanks_counts
#>   EH9552 | Cadinu2024_ibd_blanks_logcounts
#>   EH9553 | Cadinu2024_ibd_blanks_rownames
```

## 2.1 Segmented data

It is also possible to obtain the data in a [SpatialExperiment](https://bioconductor.org/packages/SpatialExperiment), which
integrates experimental data and cell metadata, and provides designated
accessors for the spatial coordinates.

```
spe <- MouseColonIbdCadinu2024()
spe
#> class: SpatialExperiment
#> dim: 943 1348582
#> metadata(3): colors_tier1 colors_tier2 colors_tier3
#> assays(2): counts logcounts
#> rownames(943): Ackr1 Ackr2 ... Zc3h12a Znrf3
#> rowData names(0):
#> colnames: NULL
#> colData names(12): cell_id sample_id ... tier3 leiden_neigh
#> reducedDimNames(5): PCA UMAP UMAP_Tier1 UMAP_Tier2 UMAP_Tier3
#> mainExpName: NULL
#> altExpNames(1): Blank
#> spatialCoords names(2) : x y
#> imgData names(0):
```

Inspect the data components:

```
counts(spe)[1:5,1:5]
#> <5 x 5> DelayedMatrix object of type "double":
#>       [,1] [,2] [,3] [,4] [,5]
#> Ackr1    0    0    0    0    0
#> Ackr2    0    0    0    0    0
#> Ackr3    0    0    0    0    0
#> Ackr4    0    0    0    0    0
#> Acod1    0    0    0    0    0
logcounts(spe)[1:5,1:5]
#> <5 x 5> DelayedMatrix object of type "double":
#>       [,1] [,2] [,3] [,4] [,5]
#> Ackr1    0    0    0    0    0
#> Ackr2    0    0    0    0    0
#> Ackr3    0    0    0    0    0
#> Ackr4    0    0    0    0    0
#> Acod1    0    0    0    0    0
colData(spe)
#> DataFrame with 1348582 rows and 12 columns
#>               cell_id   sample_id sample_type      mouse_id
#>           <character> <character>    <factor>      <factor>
#> 1       921aabdd-8ec6           0     Healthy 062921_D0_m3a
#> 2       75a81f5a-8326           0     Healthy 062921_D0_m3a
#> 3       8b50251b-6188           0     Healthy 062921_D0_m3a
#> 4       238282d7-771d           0     Healthy 062921_D0_m3a
#> 5       3ab2f7b6-1f1c           0     Healthy 062921_D0_m3a
#> ...               ...         ...         ...           ...
#> 1348578 0da4af94-f339          19        DSS9  062921_D9_m5
#> 1348579 bb64edbf-7028          19        DSS9  062921_D9_m5
#> 1348580 0abd0ca1-db27          19        DSS9  062921_D9_m5
#> 1348581 a450d75d-0753          19        DSS9  062921_D9_m5
#> 1348582 cc87557d-eb57          19        DSS9  062921_D9_m5
#>         technical_repeat_number slice_id      fov   n_genes               tier1
#>                        <factor> <factor> <factor> <integer>            <factor>
#> 1                             1        2      104        67          Epithelial
#> 2                             1        2      104        66          Epithelial
#> 3                             1        2      104        42          Epithelial
#> 4                             1        2      104        36          Epithelial
#> 5                             1        2      104       118          Epithelial
#> ...                         ...      ...      ...       ...                 ...
#> 1348578                       2        1      397        12 Epithelial
#> 1348579                       2        2      113        14 Immune
#> 1348580                       2        1      402        12 Epithelial
#> 1348581                       2        3      219        12 Smooth Muscle Cells
#> 1348582                       2        1      468        12 Fibroblast
#>                tier2        tier3 leiden_neigh
#>             <factor>     <factor>     <factor>
#> 1        Colonocytes  Colonocytes          MU3
#> 2        Colonocytes  Colonocytes          MU3
#> 3        Colonocytes  Colonocytes          MU3
#> 4        Colonocytes  Colonocytes          MU3
#> 5        Colonocytes  Colonocytes          MU3
#> ...              ...          ...          ...
#> 1348578 Stem cells   Stem cells            MU7
#> 1348579 Neutrophil 2 Neutrophil 2          SM2
#> 1348580 Stem cells   Stem cells            MU1
#> 1348581 IASMC 1      IASMC 1               MU8
#> 1348582 IAF 4        IAF 4                 MU8
head(spatialCoords(spe))
#>             x        y
#> [1,] 238.4697 308.1568
#> [2,] 246.4109 303.1072
#> [3,] 249.0404 309.5399
#> [4,] 237.0386 322.2053
#> [5,] 244.5144 317.2789
#> [6,] 270.2699 297.4906
```

The dataset includes cell type labels with three levels of granularity
(variables `tier1`, `tier2`, `tier3` in the `colData`).

```
table(spe$tier1)
#>
#>             Adipose         Endothelial      EntericNervous          Epithelial
#>                 760               59317               24396              381553
#>          Fibroblast                 ICC              Immune Smooth Muscle Cells
#>              298918                3109              256978              323551
table(spe$tier2)
#>
#>                    Adipose                Arterial EC
#>                        760                       9592
#>                   B cell 1                   B cell 2
#>                      14392                      36874
#>            B cell (Aicda+)             Capillarial EC
#>                       2451                      15523
#>                Colonocytes                       DC 2
#>                      75453                       2614
#>                DC (Fscn1+)                        EEC
#>                      10166                       1557
#>          Epithelial (Clu+)                        FRC
#>                       4560                       5077
#>                    Fibro 1                    Fibro 2
#>                      31435                      31368
#>                    Fibro 4                    Fibro 5
#>                      23221                      22173
#>                    Fibro 6                    Fibro 7
#>                      19842                      18080
#>                   Fibro 12                   Fibro 13
#>                       8982                       7894
#>                   Fibro 15               Glia (Apod+)
#>                       5960                       3152
#>               Glia (Gfap+)              Glia (Gfra3+)
#>                       4560                       5207
#>                Glia (Mpz+)                   Goblet 1
#>                        643                      23884
#>                   Goblet 2                      IAE 1
#>                      17891                      32911
#>                      IAE 2                      IAE 3
#>                      39906                      12986
#>                      IAF 1                      IAF 2
#>                       6147                      49567
#>                      IAF 3                      IAF 4
#>                      29991                      16431
#>                      IAF 5                    IASMC 1
#>                       3536                      43792
#>                    IASMC 2                    IASMC 3
#>                      33657                       9029
#>                      ICC 1                      ICC 2
#>                       2249                        860
#>                       ILC2               Lymphatic EC
#>                        776                      15272
#>     Lymphatic EC (Ccl21a+)                    M cells
#>                       6980                        287
#>        Macrophage (Cd163+)       Macrophage (Cxcl10+)
#>                       8518                      25140
#>        Macrophage (Itgax+)         Macrophage (Mrc1+)
#>                      21571                      18415
#>                  Mast cell                   Monocyte
#>                         17                      24292
#>             Neuron (Chat+)             Neuron (Nos1+)
#>                       4831                       6003
#>               Neutrophil 1               Neutrophil 2
#>                      28775                      21292
#>                 Pericyte 1                 Pericyte 2
#>                      12952                       6262
#>                Plasma cell Repair associated  (Arg1+)
#>                      10424                      16554
#>                      SMC 1                      SMC 2
#>                     171823                      63129
#>              SMC Mesentery                 Stem cells
#>                       2121                      64512
#>                          T                         TA
#>                      18769                      91052
#>                  Venous EC                       cDC1
#>                      11950                      12492
table(spe$tier3)
#>
#>                    Adipose                Arterial EC
#>                        760                       9592
#>                   B cell 1                   B cell 2
#>                      14392                      36874
#>            B cell (Aicda+)             Capillarial EC
#>                       2451                      15523
#>                Colonocytes                DC (Ccl22+)
#>                      75453                       2614
#>                DC (Fscn1+)                        EEC
#>                      10166                       1557
#>          Epithelial (Clu+)                        FRC
#>                       4560                       5077
#>                    Fibro 1                    Fibro 2
#>                      31435                      31368
#>                    Fibro 4                    Fibro 5
#>                      23221                      22173
#>                    Fibro 6                    Fibro 7
#>                      19842                      18080
#>                   Fibro 12                   Fibro 13
#>                       8982                       7894
#>                   Fibro 15               Glia (Apod+)
#>                       5960                       3152
#>               Glia (Gfap+)              Glia (Gfra3+)
#>                       4560                       5207
#>                Glia (Mpz+)                   Goblet 1
#>                        643                      23884
#>                   Goblet 2                      IAE 1
#>                      17891                      32911
#>                      IAE 2                      IAE 3
#>                      39906                      12986
#>                      IAF 1                      IAF 2
#>                       6147                      49567
#>                      IAF 3                      IAF 4
#>                      29991                      16431
#>                      IAF 5                    IASMC 1
#>                       3536                      43792
#>                    IASMC 2                    IASMC 3
#>                      33657                       9029
#>                      ICC 1                      ICC 2
#>                       2249                        860
#>                       ILC2              ILC3-LTi-like
#>                        776                       1901
#>               Lymphatic EC     Lymphatic EC (Ccl21a+)
#>                      15272                       6980
#>                    M cells       Macrophage (Cxcl10+)
#>                        287                      25140
#>        Macrophage (Itgax+)        Macrophage (Lyve1+)
#>                      21571                       8518
#>         Macrophage (Mrc1+)                  Mast cell
#>                      18415                         17
#>                   Monocyte                         NK
#>                      24292                       2187
#>             Neuron (Chat+)             Neuron (Nos1+)
#>                       4831                       6003
#>               Neutrophil 1               Neutrophil 2
#>                      28775                      21292
#>                 Pericyte 1                 Pericyte 2
#>                      12952                       6262
#>                Plasma cell Repair associated  (Arg1+)
#>                      10424                      16554
#>                      SMC 1                      SMC 2
#>                     171823                      63129
#>              SMC Mesentery                 Stem cells
#>                       2121                      64512
#>             T (Cd4+ Ccr7+)                   T (Cd8+)
#>                       4379                        627
#>                 T (Mki67+)                         TA
#>                       2598                      91052
#>                        Tfh                       Treg
#>                       2935                       4142
#>                  Venous EC                       cDC1
#>                      11950                      12492
```

The data have been collected before the insurgence of colitis
(`sample_type="Healthy"`) and after some time intervals (3 days, 9 days, 21 days).

```
table(spe$sample_type)
#>
#>    DSS3    DSS9   DSS21 Healthy
#>  299274  660977  148881  239450
```

# 3 Visualization

## 3.1 Reduced dimensions

Replicate Fig. 1C of the [paper](https://doi.org/10.1016/j.cell.2024.03.013), to
visualize cell types in the UMAP space:

```
plotReducedDim(spe, "UMAP", colour_by = "tier1",
               scattermore = TRUE, rasterise = TRUE) +
    scale_color_manual(values = metadata(spe)$colors_tier1) +
    labs(color = "cell type")
```

![](data:image/png;base64...)

## 3.2 Spatial organization

We can also replicate Fig 1.D, to see the spatial distribution of cell types
in one slide:

```
# Filter spatial coordinates for the selected slice ID
slice_coords <- spatialCoords(spe)[spe$mouse_id == "082421_D0_m6" &
                                   spe$sample_type == "Healthy" &
                                   spe$technical_repeat_number == "1" &
                                   spe$slice_id == "2", ]
# Rotate coordinates to have them match the rotation in the paper
slice_coords_vec <- vect(slice_coords, type = "points")
slice_coords_r <- spin(slice_coords_vec, 180)
slice_c <- as.data.frame(slice_coords_r, geom = "XY")
slice_df <- data.frame(x = slice_c[,1],
                       y = slice_c[,2],
                       tier1 = spe$tier1[spe$mouse_id == "082421_D0_m6" &
                                         spe$sample_type == "Healthy" &
                                         spe$technical_repeat_number == "1" &
                                         spe$slice_id == "2"])
# Plot
ggplot(data = slice_df, aes(x = x, y = y, color = tier1)) +
    geom_point(shape = 19, size = 0.5) +
    scale_color_manual(values = metadata(spe)$colors_tier1) +
    guides(colour = guide_legend(override.aes = list(size = 2))) +
    labs(color = "cell type") +
    theme_bw(10)
```

![](data:image/png;base64...)

We can compare the spatial organization of cells before the insurgence
of colitis and at the considered timepoints (after 3, 9, and 21 days):

```
# Filter spatial coordinates for the selected slice ID
slice_coords <- spatialCoords(spe)[(spe$mouse_id == "062921_D0_m3a" &
                                     spe$slice_id=="2") |
                                     (spe$mouse_id == "092421_D3_m1" &
                                     spe$slice_id=="2")|
                                     (spe$mouse_id == "062221_D9_m3" &
                                     spe$slice_id=="2") |
                                     (spe$mouse_id == "082421_D21_m1" &
                                     spe$slice_id=="2"), ]

slice_df <- data.frame(x = scale(slice_coords[, 1], scale = FALSE),
                       y = scale(slice_coords[, 2], scale = FALSE),
                       tier1 = spe$tier1[(spe$mouse_id == "062921_D0_m3a" &
                                     spe$slice_id=="2") |
                                     (spe$mouse_id == "092421_D3_m1" &
                                     spe$slice_id=="2")|
                                     (spe$mouse_id == "062221_D9_m3" &
                                     spe$slice_id=="2") |
                                     (spe$mouse_id == "082421_D21_m1" &
                                     spe$slice_id=="2")],
                       day = spe$sample_type[(spe$mouse_id == "062921_D0_m3a" &
                                     spe$slice_id=="2") |
                                    (spe$mouse_id == "092421_D3_m1" &
                                     spe$slice_id=="2")|
                                     (spe$mouse_id == "062221_D9_m3" &
                                     spe$slice_id=="2") |
                                     (spe$mouse_id == "082421_D21_m1" &
                                     spe$slice_id=="2")])

slice_df$day <- factor(slice_df$day, levels = c("Healthy", "DSS3", "DSS9", "DSS21"))

ggplot(data = slice_df, aes(x = x, y = y, color = tier1)) +
    geom_point(shape = 19, size = 0.5) +
    scale_color_manual(values = metadata(spe)$colors_tier1) +
    theme_bw(10) + guides(colour = guide_legend(override.aes = list(size=2)))+
    labs(color = "cell type") +
    facet_wrap( ~ day, ncol = 2, nrow = 2, scales = "free")
```

![](data:image/png;base64...)

We can also restrict the analysis to a specific macro-group to see the different
distribution of Tier2 cell types. See an example the different composition
of epithelial cells:

```
slice_df$tier2 <- spe$tier2[(spe$mouse_id == "062921_D0_m3a" &
                                     spe$slice_id=="2") |
                                     (spe$mouse_id == "092421_D3_m1" &
                                     spe$slice_id=="2")|
                                     (spe$mouse_id == "062221_D9_m3" &
                                     spe$slice_id=="2") |
                                     (spe$mouse_id == "082421_D21_m1" &
                                     spe$slice_id=="2")]
slice_df$color <- ifelse(slice_df$tier1 == "Epithelial",
                         as.character(slice_df$tier2), "grey")

slice_df$color <- factor(slice_df$color)

colored_df <- slice_df[slice_df$tier1 == "Epithelial", ]

ggplot() +
  geom_point(data = slice_df, aes(x = x, y = y), color = "grey",
             shape = 19, size = 0.1) +
  geom_point(data = colored_df, aes(x = x, y = y, color = tier2),
             shape = 19, size = 0.1) +
  scale_color_manual(values = metadata(spe)$colors_tier2) +
  theme_bw(10) +
  guides(colour = guide_legend(override.aes = list(size = 2))) +
  labs(color = 'cell type') +
  facet_wrap(~ day, ncol = 2, scales = "free")
```

![](data:image/png;base64...)

```
slice_df$color <- ifelse(slice_df$tier1 == "Immune",
                         as.character(slice_df$tier2),
                         "grey")
slice_df$color <- factor(slice_df$color)
colored_df <- subset(slice_df, tier1 == "Immune")

p <- ggplot() +
  geom_point(data = slice_df, aes(x = x, y = y), color = "grey",
             shape = 19, size = 0.1) +
  geom_point(data = colored_df, aes(x = x, y = y, color = tier2),
             shape = 19, size = 0.1) +
  scale_color_manual(values = metadata(spe)$colors_tier2) +
  theme_bw(10) +
  guides(colour = guide_legend(override.aes = list(size = 2))) +
  labs(color = 'cell type') +
  facet_wrap(~ day, ncol = 2, scales = "free")

p
```

![](data:image/png;base64...)

# 4 Interactive exploration

The MERFISH mouse colon IBD dataset is part of the
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
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] rhdf5_2.54.0                terra_1.8-70
#>  [3] scater_1.38.0               scuttle_1.20.0
#>  [5] ggplot2_4.0.0               ExperimentHub_3.0.0
#>  [7] AnnotationHub_4.0.0         BiocFileCache_3.0.0
#>  [9] dbplyr_2.5.1                MerfishData_1.12.0
#> [11] SpatialExperiment_1.20.0    SingleCellExperiment_1.32.0
#> [13] SummarizedExperiment_1.40.0 Biobase_2.70.0
#> [15] GenomicRanges_1.62.0        Seqinfo_1.0.0
#> [17] IRanges_2.44.0              S4Vectors_0.48.0
#> [19] BiocGenerics_0.56.0         generics_0.1.4
#> [21] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [23] EBImage_4.52.0              BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] DBI_1.2.3            bitops_1.0-9         gridExtra_2.3
#>  [4] httr2_1.2.1          rlang_1.1.6          magrittr_2.0.4
#>  [7] compiler_4.5.1       RSQLite_2.4.3        png_0.1-8
#> [10] fftwtools_0.9-11     vctrs_0.6.5          pkgconfig_2.0.3
#> [13] crayon_1.5.3         fastmap_1.2.0        magick_2.9.0
#> [16] XVector_0.50.0       labeling_0.4.3       rmarkdown_2.30
#> [19] ggbeeswarm_0.7.2     purrr_1.1.0          bit_4.6.0
#> [22] xfun_0.54            cachem_1.1.0         beachmat_2.26.0
#> [25] jsonlite_2.0.0       blob_1.2.4           rhdf5filters_1.22.0
#> [28] DelayedArray_0.36.0  Rhdf5lib_1.32.0      BiocParallel_1.44.0
#> [31] jpeg_0.1-11          tiff_0.1-12          irlba_2.3.5.1
#> [34] parallel_4.5.1       R6_2.6.1             bslib_0.9.0
#> [37] RColorBrewer_1.1-3   scattermore_1.2      jquerylib_0.1.4
#> [40] Rcpp_1.1.0           bookdown_0.45        knitr_1.50
#> [43] Matrix_1.7-4         tidyselect_1.2.1     viridis_0.6.5
#> [46] dichromat_2.0-0.1    abind_1.4-8          yaml_2.3.10
#> [49] codetools_0.2-20     curl_7.0.0           lattice_0.22-7
#> [52] tibble_3.3.0         withr_3.0.2          KEGGREST_1.50.0
#> [55] S7_0.2.0             evaluate_1.0.5       Biostrings_2.78.0
#> [58] pillar_1.11.1        BiocManager_1.30.26  filelock_1.0.3
#> [61] RCurl_1.98-1.17      BiocVersion_3.22.0   scales_1.4.0
#> [64] glue_1.8.0           tools_4.5.1          BiocNeighbors_2.4.0
#> [67] ScaledMatrix_1.18.0  locfit_1.5-9.12      cowplot_1.2.0
#> [70] grid_4.5.1           AnnotationDbi_1.72.0 beeswarm_0.4.0
#> [73] BiocSingular_1.26.0  HDF5Array_1.38.0     vipor_0.4.7
#> [76] rsvd_1.0.5           cli_3.6.5            rappdirs_0.3.3
#> [79] viridisLite_0.4.2    S4Arrays_1.10.0      dplyr_1.1.4
#> [82] gtable_0.3.6         sass_0.4.10          digest_0.6.37
#> [85] ggrepel_0.9.6        SparseArray_1.10.1   rjson_0.2.23
#> [88] htmlwidgets_1.6.4    farver_2.1.2         memoise_2.0.1
#> [91] htmltools_0.5.8.1    lifecycle_1.0.4      h5mread_1.2.0
#> [94] httr_1.4.7           bit64_4.6.0-1
```