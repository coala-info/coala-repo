# The SpatialDatasets package

Nicholas Robertson1,2, Farhan Ameen1,2, Alex Qin1,2,3 and Ellis Patrick1,2,3

1Sydney Precision Data Science Centre, University of Sydney, Australia
2School of Mathematics and Statistics, University of Sydney, Australia
3Westmead Institute for Medical Research, University of Sydney, Australia

#### 4 November 2025

#### Package

SpatialDatasets 1.8.0

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Datasets](#datasets)
* [4 Load data](#load-data)
  + [4.1 Load using named accessors](#load-using-named-accessors)
    - [4.1.1 Keren et al. (2018)](#keren-et-al.-2018)
    - [4.1.2 Ferguson et al. (2022)](#ferguson-et-al.-2022)
    - [4.1.3 Schurch et al. (2020)](#schurch-et-al.-2020)
    - [4.1.4 Ali et al. (2020)](#ali-et-al.-2020)
    - [4.1.5 Amancherla et al. (2025)](#amancherla-et-al.-2025)
    - [4.1.6 Vannan et al. (2025)](#vannan-et-al.-2025)
* [5 Generating objects from raw data files](#generating-objects-from-raw-data-files)
* [6 Session information](#session-information)

# 1 Introduction

The `SpatialDatasets` package contains a collection of spatially-resolved omics datasets, which have been formatted into the [SpatialExperiment](https://bioconductor.org/packages/SpatialExperiment), [MoleculeExperiment](https://bioconductor.org/packages/MoleculeExperiment) or [CytoImageList](https://bioconductor.org/packages/cytomapper) Bioconductor classes, for use in examples, demonstrations, and tutorials. The datasets are from several different platforms including IMC, MIBI-TOF, Xenium, CosMx and MERFISH. They have been sourced from various publicly available sources.

# 2 Installation

To install the `SpatialDatasets` package from GitHub:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("SpatialDatasets")
```

# 3 Datasets

The package contains the following datasets:

* `spe_Keren_2018`: A study on triple negative breast cancer containing 40 samples measured using MIBI-TOF published by [Keren et al. (2018)](https://doi.org/10.1016/j.cell.2018.08.039).
* `Ferguson_Images`: A study on head and neck cutaneous squamous cell carcinoma containing 44 samples measured using IMC published by [Ferguson et al. (2022)](https://doi.org/10.1158/1078-0432.CCR-22-1332).
* `spe_Ferguson_2022`: A study on head and neck cutaneous squamous cell carcinoma containing 44 samples measured using IMC published by [Ferguson et al. (2022)](https://doi.org/10.1158/1078-0432.CCR-22-1332).
* `spe_Schurch_2020`: A study on advanced colorectal cancer containing 140 samples measured using CODEX published by [Schurch et al. (2020)](https://doi.org/10.1016/j.cell.2020.07.005).
* `spe_Ali_2020`: A study on breast cancer containing 483 samples measured using IMC published by [Ali et al. (2020)](https://doi.org/10.1038/s43018-020-0026-6).
* `spe_Amancherla_2025`: A study on heart transplant rejection containing 35 samples measured with Xenium published by [Amancherla et al. (2025)](https://doi.org/10.1101/2025.02.28.640852)
* `spe_Vannan_2025`: A study on pulmonary fibrosis containing 35 lung samples
  measured with Xenium published by [Vannan et al. (2025)](https://doi.org/10.1038/s41588-025-02080-x).

# 4 Load data

The following examples show how to load the example datasets as `SpatialExperiment` objects in an R session.

There are two options for loading the datasets: either using named accessor functions or by querying the ExperimentHub database.

## 4.1 Load using named accessors

```
library(SpatialExperiment)
library(SpatialDatasets)
```

```
## Warning: previous export ''Ferguson_Images'' is being replaced
```

```
## Warning: previous export ''spe_Ferguson_2022'' is being replaced
```

```
## Warning: previous export ''fergusonClinical'' is being replaced
```

```
## Warning: previous export ''spe_Schurch_2020'' is being replaced
```

```
## Warning: previous export ''spe_Ali_2020'' is being replaced
```

### 4.1.1 Keren et al. (2018)

A study on triple negative breast cancer containing 40 samples measured using MIBI-TOF published by [Keren et al. (2018)](https://doi.org/10.1016/j.cell.2018.08.039).

```
# load object
spe <- spe_Keren_2018()

# check object
spe
```

```
## class: SpatialExperiment
## dim: 48 197678
## metadata(0):
## assays(1): intensities
## rownames(48): Na Si ... Ta Au
## rowData names(0):
## colnames(197678): 1 2 ... 197677 197678
## colData names(40): CellID imageID ... Censored sample_id
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## spatialCoords names(2) : x y
## imgData names(0):
```

### 4.1.2 Ferguson et al. (2022)

A study on head and neck cutaneous squamous cell carcinoma containing 44 samples measured using IMC published by [Ferguson et al. (2022)](https://doi.org/10.1158/1078-0432.CCR-22-1332).

#### 4.1.2.1 Ferguson Images

In the chunk below, we’ve provided code for generating a `CytoImageList` object from the images `zip` file provided by the `Ferguson_Images()` function.

```
# load object
zip <- Ferguson_Images()
tmp <- tempfile()
unzip(zip, exdir = tmp)

images <- cytomapper::loadImages(
  tmp,
  single_channel = TRUE,
  on_disk = TRUE,
  h5FilesPath = HDF5Array::getHDF5DumpDir()
)

# check object
images
```

```
## CytoImageList containing 44 image(s)
## names(44): ROI001_ROI 01_F3_SP16-001550_1E ROI002_ROI 02_F4_SP16-001550_1E ROI003_ROI 03_F5_SP16-001550_1E ROI005_ROI 05_G4_SP17-002069_1F ROI006_ROI 06_G5_SP17-002069_1F ROI007_ROI 07_G6_SP17-005715_1B ROI008_ROI 08_H2_SP17-005715_1B ROI009_ROI 09_H3_SP17-010876_2D ROI010_ROI 10_H4_SP17-010876_2D ROI011_ROI 11_H5_SP17-010876_2D ROI013_ROI 13_H1_SP17-005715_1B ROI018_ROI 14_B2_Non-met_cSCC_SP11-013104_6B ROI019_ROI 15_B3_Non-met_cSCC_SP11-013104_6E ROI021_ROI 16_B4_Non-met_cSCC_SP11-013104_6B ROI022_ROI 17_D3_Non-met_cSCC_SP12-015701_2H ROI023_ROI 18_D4_Non-met_cSCC_SP12-015701_2H ROI024_ROI 19_D5_Non-met_cSCC_SP13-006090_2P ROI025_ROI 20_A2_NON-MET_cSCC_SP08-10295_2S ROI026_ROI 21_A3_NON-MET_cSCC_SP08-10295_2S ROI027_ROI 22_A4_NON-MET_cSCC_SP08-10295_2S ROI028_ROI 23_A5_NON-MET_cSCC_SP10-013718_1A ROI029_ROI 24_A6_NON-MET_cSCC_SP10-013718_1A ROI030_ROI 25_B6_NON-MET_cSCC_SP11-011125_1J ROI031_ROI 26_B21_NON-MET_cSCC_SP11-013104_6B ROI032_ROI 27_C2_NON-MET_cSCC_SP12-006256_1A ROI033_ROI 28_C3_NON-MET_cSCC_SP12-006256_1B ROI034_ROI 29_C4_NON-MET_cSCC_SP12-006256_1B ROI035_ROI 30_D2_Non-met_cSCC_SP12-015701_2G ROI036_ROI 31_D6_Non-met_cSCC_SP13-006090_2U ROI038_ROI 32_H6_primary_SP17-027309_2E ROI039_ROI 33_I2_primary_SP17-027309_2L ROI040_ROI 34_I3_primary_SP18-011889_1AJ ROI041_ROI 35_I4_primary_SP18-011889_1AJ ROI042_ROI 36_I5_primary_SP18-011889_1AJ ROI043_ROI 37_J3_primary_SP18-013042_1D ROI044_ROI 38_J4_primary_SP18-013042_1D ROI045_ROI 39_J5_primary_SP18-013042_1D ROI046_ROI 40_J6_primary_SP18-014691_5AX ROI047_ROI 41_K1_primary_SP18-014691_5AX ROI048_ROI 42_K2_primary_SP18-014691_5AX ROI049_ROI 43_B1_cScc_primary_SP10-013718_1A ROI050_ROI 44_C1_cscc_primary_SP11-011125_1J ROI051_ROI 45_E1_cscc_primary_SP13-006090_2J ROI055_ROI 46_I1_primary_SP17-027309_2G
## Each image contains 36 channel(s)
## channelNames(36): 139La_139La_panCK.ome 141Pr_141Pr_CD20.ome 142Nd_142Nd_HH3.ome 143Nd_143Nd_CD45RA.ome 146Nd_146Nd_CD8a.ome 147Sm_147Sm_podoplanin.ome 148Nd_148Nd_CD16.ome 149Sm_149Sm_CADM1.ome 150Nd_150Nd_IDO.ome 151Eu_151Eu_PDL1.ome 152Sm_152Sm_CD13.ome 153Eu_153Eu_CD68.ome 154Sm_154Sm_VISTA.ome 155Gd_155Gd_CD31.ome 156Gd_156Gd_CXCR3.ome 158Gd_158Gd_pSTAT3.ome 159Tb_159Tb_CCR7.ome 160Gd_160Gd_CD14.ome 161Dy_161Dy_FX111A.ome 162Dy_162Dy_FoxP3.ome 163Dy_163Dy_PD1.ome 164Dy_164Dy_CD45RO.ome 165Ho_165Ho_OX40.ome 166Er_166Er_NFKBp65.ome 167Er_167Er_CD66a.ome 168Er_168Er_Ki67.ome 169Tm_169Tm_LAG3.ome 170Er_170Er_CD3.ome 171Yb_171Yb_granzB.ome 172Yb_172Yb_PDL2.ome 173Yb_173Yb_CD4.ome 174Yb_174Yb_HLADR.ome 175Lu_175Lu_ICOS.ome 176Yb_176Yb_TIM3.ome 191Ir_191Ir_DNA1.ome 193Ir_193Ir_DNA2.ome
```

#### 4.1.2.2 Ferguson SpatialExperiment Object

```
# load object
spe <- spe_Ferguson_2022()

# check object
spe
```

```
## class: SpatialExperiment
## dim: 36 155913
## metadata(0):
## assays(1): counts
## rownames(36): panCK CD20 ... DNA1 DNA2
## rowData names(0):
## colnames: NULL
## colData names(14): imageID object_id ... group patientID
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## spatialCoords names(2) : x y
## imgData names(1): sample_id
```

### 4.1.3 Schurch et al. (2020)

A study on advanced colorectal cancer containing 140 samples measured using CODEX published by [Schurch et al. (2020)](https://doi.org/10.1016/j.cell.2020.07.005).

```
# load object
spe <- spe_Schurch_2020()

# check object
spe
```

```
## class: SpatialExperiment
## dim: 63 258385
## metadata(0):
## assays(1): intensities
## rownames(63): cd44 foxp3 ... treg_ki67 treg_pd_1
## rowData names(0):
## colnames(258385): cellIDcell_1 cellIDcell_2 ... cellIDcell_258384
##   cellIDcell_258385
## colData names(46): imageID cellID ... tissueType sample_id
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## spatialCoords names(2) : x y
## imgData names(0):
```

### 4.1.4 Ali et al. (2020)

A study on breast cancer containing 483 samples measured using IMC published by [Ali et al. (2020)](https://doi.org/10.1038/s43018-020-0026-6).

```
# load object
spe <- spe_Ali_2020()

# check object
spe
```

```
## class: SpatialExperiment
## dim: 39 433001
## metadata(0):
## assays(1): intensities
## rownames(39): HH3_total CK19 ... CK5 Fibronectin
## rowData names(0):
## colnames(433001): 1 2 ... 433000 433001
## colData names(37): file_id metabricId ... eventRFS sample_id
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## spatialCoords names(2) : Location_Center_X Location_Center_Y
## imgData names(0):
```

### 4.1.5 Amancherla et al. (2025)

A study on heart transplant rejection containing 62 (49 adult and 13 pediatric) samples measured with Xenium published by [Amancherla et al. (2025)](https://doi.org/10.1101/2025.02.28.640852).

```
# load object
spe <- spe_Amancherla_2025()

# check object
spe
```

```
## class: SpatialExperiment
## dim: 477 162638
## metadata(0):
## assays(3): counts logcounts scaledata
## rownames(477): ABCC11 ABHD16A ... XCR1 ZCCHC12
## rowData names(0):
## colnames(162638): aaadcmfp-1_1 aaaghlda-1_1 ... oimehgjn-1_2
##   oimeocni-1_2
## colData names(55): X orig.ident ... lineage sample_id
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## spatialCoords names(2) : x y
## imgData names(0):
```

### 4.1.6 Vannan et al. (2025)

A study on pulmonary fibrosis containing 35 lung samples measured with Xenium published by [Vannan et al. (2025)](https://doi.org/10.1038/s41588-025-02080-x).

```
# load object
spe <- spe_Vannan_2025()

# check object
spe
```

```
## class: SpatialExperiment
## dim: 343 1630319
## metadata(0):
## assays(3): counts logcounts scaledata
## rownames(343): ABCC2 ACKR1 ... YAP1 ZEB1
## rowData names(0):
## colnames(1630319): VUHD090_aaahmeoa-1 VUHD090_aaaidici-1 ...
##   VUILD105MA1_aaabfoke-1 VUILD105MA1_aaabfokf-1
## colData names(30): sample patient ... ident sample_id
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## spatialCoords names(2) : x y
## imgData names(0):
```

# 5 Generating objects from raw data files

For reference, we include code scripts to generate the `SpatialExperiment`, `MoleculeExperiment` or `CytoImageList` objects from the raw data files.

These scripts are saved in `/inst/scripts/` in the source code of the `SpatialDatasets` package. The scripts include references and links to the data files from the original sources for each dataset.

# 6 Session information

```
sessionInfo()
```

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
##  [1] SpatialDatasets_1.8.0       ExperimentHub_3.0.0
##  [3] AnnotationHub_4.0.0         BiocFileCache_3.0.0
##  [5] dbplyr_2.5.1                SpatialExperiment_1.20.0
##  [7] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [9] Biobase_2.70.0              GenomicRanges_1.62.0
## [11] Seqinfo_1.0.0               IRanges_2.44.0
## [13] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [15] generics_0.1.4              MatrixGenerics_1.22.0
## [17] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3            bitops_1.0-9         gridExtra_2.3
##   [4] httr2_1.2.1          rlang_1.1.6          magrittr_2.0.4
##   [7] svgPanZoom_0.3.4     shinydashboard_0.7.3 otel_0.2.0
##  [10] compiler_4.5.1       RSQLite_2.4.3        systemfonts_1.3.1
##  [13] png_0.1-8            fftwtools_0.9-11     vctrs_0.6.5
##  [16] pkgconfig_2.0.3      crayon_1.5.3         fastmap_1.2.0
##  [19] magick_2.9.0         XVector_0.50.0       promises_1.5.0
##  [22] rmarkdown_2.30       ggbeeswarm_0.7.2     purrr_1.1.0
##  [25] bit_4.6.0            xfun_0.54            cachem_1.1.0
##  [28] jsonlite_2.0.0       blob_1.2.4           later_1.4.4
##  [31] rhdf5filters_1.22.0  DelayedArray_0.36.0  Rhdf5lib_1.32.0
##  [34] BiocParallel_1.44.0  terra_1.8-70         jpeg_0.1-11
##  [37] tiff_0.1-12          parallel_4.5.1       R6_2.6.1
##  [40] bslib_0.9.0          RColorBrewer_1.1-3   jquerylib_0.1.4
##  [43] Rcpp_1.1.0           bookdown_0.45        knitr_1.50
##  [46] nnls_1.6             httpuv_1.6.16        Matrix_1.7-4
##  [49] tidyselect_1.2.1     viridis_0.6.5        dichromat_2.0-0.1
##  [52] abind_1.4-8          yaml_2.3.10          EBImage_4.52.0
##  [55] codetools_0.2-20     curl_7.0.0           lattice_0.22-7
##  [58] tibble_3.3.0         shiny_1.11.1         withr_3.0.2
##  [61] KEGGREST_1.50.0      S7_0.2.0             evaluate_1.0.5
##  [64] Biostrings_2.78.0    pillar_1.11.1        BiocManager_1.30.26
##  [67] filelock_1.0.3       sp_2.2-0             RCurl_1.98-1.17
##  [70] BiocVersion_3.22.0   ggplot2_4.0.0        scales_1.4.0
##  [73] xtable_1.8-4         glue_1.8.0           tools_4.5.1
##  [76] locfit_1.5-9.12      rhdf5_2.54.0         grid_4.5.1
##  [79] AnnotationDbi_1.72.0 raster_3.6-32        beeswarm_0.4.0
##  [82] HDF5Array_1.38.0     vipor_0.4.7          cli_3.6.5
##  [85] rappdirs_0.3.3       textshaping_1.0.4    viridisLite_0.4.2
##  [88] S4Arrays_1.10.0      svglite_2.2.2        dplyr_1.1.4
##  [91] gtable_0.3.6         cytomapper_1.22.0    sass_0.4.10
##  [94] digest_0.6.37        SparseArray_1.10.1   rjson_0.2.23
##  [97] htmlwidgets_1.6.4    farver_2.1.2         memoise_2.0.1
## [100] htmltools_0.5.8.1    lifecycle_1.0.4      h5mread_1.2.0
## [103] httr_1.4.7           mime_0.13            bit64_4.6.0-1
```