# VectraPolarisData

Julia Wrobel and Tusharkanti Ghosh1

1Department of Biostatistics and Informatics, Colorado School of Public Health

#### 4 November 2025

#### Abstract

The VectraPolarisData ExperimentHub package provides two large multiplex immunofluorescence datasets collected by Akoya Biosciences Vectra 3 and Vectra Polaris platforms. Image preprocessing (cell segmentation and phenotyping) was performed using Inform software. Data cover are formatted into objects of class SpatialExperiment.

#### Package

VectraPolarisData 1.14.0

# 1 Loading the data

To retrieve a dataset, we can use a dataset’s corresponding named function `<id>()`, where `<id>` should correspond to one a valid dataset identifier (see `?VectraPolarisData`). Below both the lung and ovarian cancer datasets are loaded this way.

```
library(VectraPolarisData)
spe_lung <- HumanLungCancerV3()
spe_ovarian <- HumanOvarianCancerVP()
```

Alternatively, data can loaded directly from Bioconductor’s *[ExperimentHub](https://bioconductor.org/packages/3.22/ExperimentHub)* as follows. First, we initialize a hub instance and store the complete list of records in a variable `eh`. Using `query()`, we then identify any records made available by the `VectraPolarisData` package, as well as their accession IDs (EH7311 for the lung cancer data). Finally, we can load the data into R via `eh[[id]]`, where `id` corresponds to the data entry’s identifier we’d like to load. E.g.:

```
library(ExperimentHub)
eh <- ExperimentHub()        # initialize hub instance
q <- query(eh, "VectraPolarisData") # retrieve 'VectraPolarisData' records
id <- q$ah_id[1]             # specify dataset ID to load
spe <- eh[[id]]              # load specified dataset
```

# 2 Data Representation

Both the `HumanLungCancerV3()` and `HumanOvarianCancerVP()` datasets are stored as `SpatialExperiment` objects. This allows users of our data to interact with methods built for `SingleCellExperiment`, `SummarizedExperiment`, and `SpatialExperiment` class methods in Bioconductor. See [this ebook](https://lmweber.org/OSTA-book/index.html#welcome) for more details on `SpatialExperiment`. To get cell level tabular data that can be stored in this format, raw multiplex.tiff images have been preprocessed, segmented and cell phenotyped using [`Inform`](https://www.akoyabio.com/phenoimager/software/inform-tissue-finder/) software from Akoya Biosciences.

The `SpatialExperiment` class was originally built for spatial transcriptomics data and follows the structure depicted in the schematic below (Righelli et al. 2021):

![](data:image/png;base64...)

To adapt this class structure for multiplex imaging data we use slots in the following way:

* `assays` slot: `intensities`, `nucleus_intensities`, `membrane_intensities`
* `sample_id` slot: contains image identifier. For the VectraOvarianDataVP this also identifies the subject because there is one image per subject
* `colData` slot: Other cell-level characteristics of the marker intensities, cell phenotypes, cell shape characteristics
* `spatialCoordsNames` slot: The `x-` and `y-` coordinates describing the location of the center point in the image for each cell
* `metadata` slot: A dataframe of subject-level patient clinical characteristics.

# 3 Transforming to other data formats

The following code shows how to transform the `SpatialExperiment` class object to a `data.frame` class object, if that is preferred for analysis. The example below is shown using the `HumanOvarianVP` dataset.

```
library(dplyr)

## Assays slots
assays_slot <- assays(spe_ovarian)
intensities_df <- assays_slot$intensities
rownames(intensities_df) <- paste0("total_", rownames(intensities_df))
nucleus_intensities_df<- assays_slot$nucleus_intensities
rownames(nucleus_intensities_df) <- paste0("nucleus_", rownames(nucleus_intensities_df))
membrane_intensities_df<- assays_slot$membrane_intensities
rownames(membrane_intensities_df) <- paste0("membrane_", rownames(membrane_intensities_df))

# colData and spatialData
colData_df <- colData(spe_ovarian)
spatialCoords_df <- spatialCoords(spe_ovarian)

# clinical data
patient_level_df <- metadata(spe_ovarian)$clinical_data

cell_level_df <- as.data.frame(cbind(colData_df,
                                     spatialCoords_df,
                                     t(intensities_df),
                                     t(nucleus_intensities_df),
                                     t(membrane_intensities_df))
                               )

ovarian_df <- full_join(patient_level_df, cell_level_df, by = "sample_id")
```

# 4 Citation Info

The objects provided in this package are rich data sources we encourage others to use in their own analyses. If you do include them in your peer-reviewed work, we ask that you cite our package and the original studies.

To cite the `VectraPolarisData` package, use:

```
@Manual{VectraPolarisData,
    title = {VectraPolarisData: Vectra Polaris and Vectra 3 multiplex single-cell imaging data},
    author = {Wrobel, J and Ghosh, T},
    year = {2022},
    note = {Bioconductor R package version 1.0},
  }
```

To cite the `HumanLungCancerV3()` data in `bibtex` format, use:

```
@article{johnson2021cancer,
  title={Cancer cell-specific MHCII expression as a determinant of the immune infiltrate organization and function in the non-small cell lung cancer tumor microenvironment.},
  author={Johnson, AM and Boland, JM and Wrobel, J and Klezcko, EK and Weiser-Evans, M and Hopp, K and Heasley, L and Clambey, ET and Jordan, K and Nemenoff, RA and others},
  journal={Journal of Thoracic Oncology: Official Publication of the International Association for the Study of Lung Cancer},
  year={2021}
}
```

To cite the `HumanOvarianCancerVP()` data, use:

```
@article{steinhart2021spatial,
  title={The spatial context of tumor-infiltrating immune cells associates with improved ovarian cancer survival},
  author={Steinhart, Benjamin and Jordan, Kimberly R and Bapat, Jaidev and Post, Miriam D and Brubaker, Lindsay W and Bitler, Benjamin G and Wrobel, Julia},
  journal={Molecular Cancer Research},
  volume={19},
  number={12},
  pages={1973--1979},
  year={2021},
  publisher={AACR}
}
```

# 5 Data Dictionaries

Detailed tables representing what is provided in each dataset are listed here

## 5.1 HumanLungCancerV3

In the table below note the following shorthand:

* `[marker]` represents one of: `cd3`, `cd8`, `cd14`, `cd19`, `cd68`, `ck`, `dapi`, `hladr`,
* `[cell region]` represents one of: entire\_cell, membrane, nucleus

**Table 1: data dictionary for HumanLungCancerV3**

| Variable | Slot | Description | Variable coding |
| --- | --- | --- | --- |
| [marker] | assays: intensities | mean total cell intensity for [marker] |  |
| [marker] | assays: nucleus\_intensities | mean nucleus intensity for [marker] |  |
| [marker] | assays: membrane\_intensities | mean membrane intensity for [marker] |  |
| sample\_id |  | image identifier, also subject id for the ovarian data |  |
| cell\_id | colData | cell identifier |  |
| slide\_id | slide identifier, also the patient id for the lung data |  |
| tissue category | type of tissue (indicates a region of the image) | Stroma or Tumor |
| [cell region]\_[marker]\_min | min [cell region] intensity for [marker] |  |
| [cell region]\_[marker]\_max | max [cell region] intensity for [marker] |  |
| [cell region]\_[marker]\_std\_dev | [cell region] std dev of intensity for [marker] |  |
| [cell region]\_[marker]\_total | total [cell region] intensity for [marker] |  |
| [cell region]\_area\_square\_microns | [cell region] area in square microns |  |
| [cell region]\_compactness | [cell region] compactness |  |
| [cell region]\_minor\_axis | [cell region] length of minor axis |  |
| [cell region]\_major\_axis | [cell region] length of major axis |  |
| [cell region]\_axis\_ratio | [cell region] ratio of major and minor axis |  |
| phenotype\_[marker] | cell phenotype label as determined by Inform software |  |
| cell\_x\_position | spatialCoordsNames | cell x coordinate |  |
| cell\_y\_position | cell y coordinate |  |
| gender | metadata | gender | “M”, “F” |
| mhcII\_status | MHCII status, from Johnson et.al. 2021 | “low”, “high” |
| age\_at\_diagnosis | age at diagnosis |  |
| stage\_at\_diagnosis | stage of the cancer when image was collected |  |
| stage\_numeric | numeric version of stage variable |  |
| pack\_years | pack-years of cigarette smoking |  |
| survival\_days | time in days from date of diagnosis to date of death or censoring event |  |
| survival\_status | did the participant pass away? | 0 = no, 1 = yes |
| cause\_of\_death | cause of death |  |
| recurrence\_or\_lung\_ca\_death | did the participant have a recurrence or death event? | 0 = no, 1 = yes |
| time\_to\_recurrence\_days | time in days from date of diagnosis to first recurrent event |  |
| adjuvant\_therapy | whether or not the participant received adjuvant therapy | “No”, “Yes” |

## 5.2 HumanOvarianCancerVP

In the table below note the following shorthand:

* `[marker]` represents one of: `cd3`, `cd8`, `cd19`, `cd68`, `ck`, `dapi`, `ier3`, `ki67`, `pstat3`
* `[cell region]` represents one of: cytoplasm, membrane, nucleus

**Table 2: data dictionary for HumanOvarianCancerVP**

| Variable | Slot | Description | Variable coding |
| --- | --- | --- | --- |
| [marker] | assays: intensities | mean total cell intensity for [marker] |  |
| [marker] | assays: nucleus\_intensities | mean nucleus intensity for [marker] |  |
| [marker] | assays: membrane\_intensities | mean membrane intensity for [marker] |  |
| sample\_id |  | image identifier, also subject id for the ovarian data |  |
| cell\_id | colData | cell identifier |  |
| slide\_id | slide identifier |  |
| tissue category | type of tissue (indicates a region of the image) | Stroma or Tumor |
| [cell region]\_[marker]\_min | min [cell region] intensity for [marker] |  |
| [cell region]\_[marker]\_max | max [cell region] intensity for [marker] |  |
| [cell region]\_[marker]\_std\_dev | [cell region] std dev of intensity for [marker] |  |
| [cell region]\_[marker]\_total | total [cell region] intensity for [marker] |  |
| [cell region]\_area\_square\_microns | [cell region] area in square microns |  |
| [cell region]\_compactness | [cell region] compactness |  |
| [cell region]\_minor\_axis | [cell region] length of minor axis |  |
| [cell region]\_major\_axis | [cell region] length of major axis |  |
| [cell region]\_axis\_ratio | [cell region] ratio of major and minor axis |  |
| cell\_x\_position | spatialCoordsNames | cell x coordinate |  |
| cell\_y\_position | cell y coordinate |  |
| diagnosis | metadata |  |  |
| primary | primary tumor from initial diagnosis? | 0 = no, 1 = yes |
| recurrent | tumor from a recurrent event (not initial diagnosis tumor)? | 0 = no, 1 = yes |
| treatment\_effect | was tumor treated with chemo prior to imaging? | 0 = no, 1 = yes |
| stage | stage of the cancer when image was collected | I,II,II,IV |
| grade | grade of cancer severity (nearly all 3) |  |
| survival\_time | time in months from date of diagnosis to date of death or censoring event |  |
| death | did the participant pass away? | 0 = no, 1 = yes |
| BRCA\_mutation | does the participant have a BRCA mutation? | 0 = no, 1 = yes |
| age\_at\_diagnosis | age at diagnosis |  |
| time\_to\_recurrence | time in months from date of diagnosis to first recurrent event |  |
| parpi\_inhibitor | whether or not the participant received PARPi inhibitor | N = no, Y = yes |
| debulking | subjective rating of how the tumor removal process went | optimal, suboptimal, interval |

**Note**: the `debulking` variable described as `optimal` if surgeon believes tumor area was reduced to 1 cm or below; `suboptimal` if surgeon was unable to remove significant amount of tumor due to various reasons; `interval` if tumor removal came after three cycles of chemo

# 6 Session Info

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
#>  [1] dplyr_1.1.4                 VectraPolarisData_1.14.0
#>  [3] SpatialExperiment_1.20.0    SingleCellExperiment_1.32.0
#>  [5] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [7] GenomicRanges_1.62.0        Seqinfo_1.0.0
#>  [9] IRanges_2.44.0              S4Vectors_0.48.0
#> [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [13] ExperimentHub_3.0.0         AnnotationHub_4.0.0
#> [15] BiocFileCache_3.0.0         dbplyr_2.5.1
#> [17] BiocGenerics_0.56.0         generics_0.1.4
#> [19] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] KEGGREST_1.50.0      rjson_0.2.23         xfun_0.54
#>  [4] bslib_0.9.0          httr2_1.2.1          lattice_0.22-7
#>  [7] vctrs_0.6.5          tools_4.5.1          curl_7.0.0
#> [10] tibble_3.3.0         AnnotationDbi_1.72.0 RSQLite_2.4.3
#> [13] blob_1.2.4           pkgconfig_2.0.3      Matrix_1.7-4
#> [16] lifecycle_1.0.4      compiler_4.5.1       Biostrings_2.78.0
#> [19] htmltools_0.5.8.1    sass_0.4.10          yaml_2.3.10
#> [22] pillar_1.11.1        crayon_1.5.3         jquerylib_0.1.4
#> [25] DelayedArray_0.36.0  cachem_1.1.0         magick_2.9.0
#> [28] abind_1.4-8          tidyselect_1.2.1     digest_0.6.37
#> [31] purrr_1.1.0          bookdown_0.45        BiocVersion_3.22.0
#> [34] fastmap_1.2.0        grid_4.5.1           SparseArray_1.10.1
#> [37] cli_3.6.5            magrittr_2.0.4       S4Arrays_1.10.0
#> [40] withr_3.0.2          filelock_1.0.3       rappdirs_0.3.3
#> [43] bit64_4.6.0-1        rmarkdown_2.30       XVector_0.50.0
#> [46] httr_1.4.7           bit_4.6.0            png_0.1-8
#> [49] memoise_2.0.1        evaluate_1.0.5       knitr_1.50
#> [52] rlang_1.1.6          Rcpp_1.1.0           glue_1.8.0
#> [55] DBI_1.2.3            BiocManager_1.30.26  jsonlite_2.0.0
#> [58] R6_2.6.1
```