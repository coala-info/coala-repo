# TENxVisiumData

Helena L. Crowell1

1Department of Molecular Life Sciences, University of Zurich, Zurich, Switzerland

#### 4 November 2025

#### Abstract

The TENxVisiumData ExperimentHub package provides a collection of Visium spatial gene expression datasets by 10X Genomics. Data cover various organisms and tissues, and are formatted into objects of class SpatialExperiment.

#### Package

TENxVisiumData 1.18.0

# 1 Available datasets

The `TENxVisiumData` package provides an R/Bioconductor resource for
[Visium spatial gene expression datasets by 10X Genomics](https://support.10xgenomics.com/spatial-gene-expression/datasets). The package currently includes 13 datasets from 23 samples across two organisms (human and mouse) and 13 tissues:

* HumanBreastCancerIDC
  + [Human Breast Cancer (Block A Section 1)](https://support.10xgenomics.com/spatial-gene-expression/datasets/1.1.0/V1_Breast_Cancer_Block_A_Section_1)
  + [Human Breast Cancer (Block A Section 2)](https://support.10xgenomics.com/spatial-gene-expression/datasets/1.1.0/V1_Breast_Cancer_Block_A_Section_2)
* HumanBreastCancerILC
  + [Human Breast Cancer: Whole Transcriptome Analysis](https://support.10xgenomics.com/spatial-gene-expression/datasets/1.2.0/Parent_Visium_Human_BreastCancer)
  + [Human Breast Cancer: Targeted, Immunology Panel](https://support.10xgenomics.com/spatial-gene-expression/datasets/1.2.0/Targeted_Visium_Human_BreastCancer_Immunology)
* HumanCerebellum
  + [Human Cerebellum: Whole Transcriptome Analysis](https://support.10xgenomics.com/spatial-gene-expression/datasets/1.2.0/Parent_Visium_Human_Cerebellum)
  + [Human Cerebellum: Targeted, Neuroscience Panel](https://support.10xgenomics.com/spatial-gene-expression/datasets/1.2.0/Targeted_Visium_Human_Cerebellum_Neuroscience)
* HumanColorectalCancer
  + [Human Colorectal Cancer: Whole Transcriptome Analysis](https://support.10xgenomics.com/spatial-gene-expression/datasets/1.2.0/Parent_Visium_Human_ColorectalCancer)
  + [Human Colorectal Cancer: Targeted, Gene Signature Panel](https://support.10xgenomics.com/spatial-gene-expression/datasets/1.2.0/Targeted_Visium_Human_ColorectalCancer_GeneSignature)
* HumanGlioblastoma
  + [Human Glioblastoma: Whole Transcriptome Analysis](https://support.10xgenomics.com/spatial-gene-expression/datasets/1.2.0/Parent_Visium_Human_Glioblastoma)
  + [Human Glioblastoma: Targeted, Pan-Cancer Panel](https://support.10xgenomics.com/spatial-gene-expression/datasets/1.2.0/Targeted_Visium_Human_Glioblastoma_Pan_Cancer)
* HumanHeart
  + [Human Heart](https://support.10xgenomics.com/spatial-gene-expression/datasets/1.1.0/V1_Human_Heart)
* HumanLymphNode
  + [Human Lymph Node](https://support.10xgenomics.com/spatial-gene-expression/datasets/1.1.0/V1_Human_Lymph_Node)
* HumanOvarianCancer
  + [Human Ovarian Cancer: Whole Transcriptome Analysis](https://support.10xgenomics.com/spatial-gene-expression/datasets/1.2.0/Parent_Visium_Human_OvarianCancer)
  + [Human Ovarian Cancer: Targeted, Immunology Panel](https://support.10xgenomics.com/spatial-gene-expression/datasets/1.2.0/Targeted_Visium_Human_OvarianCancer_Immunology)
  + [Human Ovarian Cancer: Targeted, Pan-Cancer Panel](https://support.10xgenomics.com/spatial-gene-expression/datasets/1.2.0/Targeted_Visium_Human_OvarianCancer_Pan_Cancer)
* HumanSpinalCord
  + [Human Spinal Cord: Whole Transcriptome Analysis](https://support.10xgenomics.com/spatial-gene-expression/datasets/1.2.0/Parent_Visium_Human_SpinalCord)
  + [Human Spinal Cord: Targeted, Neuroscience Panel](https://support.10xgenomics.com/spatial-gene-expression/datasets/1.2.0/Targeted_Visium_Human_SpinalCord_Neuroscience)
* MouseBrainCoronal
  + [Mouse Brain Section (Coronal)](https://support.10xgenomics.com/spatial-gene-expression/datasets/1.1.0/V1_Adult_Mouse_Brain)
* MouseBrainSagittalAnterior
  + [Mouse Brain Serial Section 1 (Sagittal-Anterior)](https://support.10xgenomics.com/spatial-gene-expression/datasets/1.1.0/V1_Mouse_Brain_Sagittal_Anterior)
  + [Mouse Brain Serial Section 2 (Sagittal-Anterior)](https://support.10xgenomics.com/spatial-gene-expression/datasets/1.1.0/V1_Mouse_Brain_Sagittal_Anterior_Section_2)
* MouseBrainSagittalPosterior
  + [Mouse Brain Serial Section 1 (Sagittal-Posterior)](https://support.10xgenomics.com/spatial-gene-expression/datasets/1.1.0/V1_Mouse_Brain_Sagittal_Posterior)
  + [Mouse Brain Serial Section 2 (Sagittal-Posterior)](https://support.10xgenomics.com/spatial-gene-expression/datasets/1.1.0/V1_Mouse_Brain_Sagittal_Posterior_Section_2)
* MouseKidneyCoronal
  + [Mouse Kidney Section (Coronal)](https://support.10xgenomics.com/spatial-gene-expression/datasets/1.1.0/V1_Mouse_Kidney)

A list of currently available datasets can be obtained using the `ExperimentHub` interface:

```
library(ExperimentHub)
eh <- ExperimentHub()
(q <- query(eh, "TENxVisium"))
```

```
## ExperimentHub with 26 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: 10X Genomics
## # $species: Homo sapiens, Mus musculus
## # $rdataclass: SpatialExperiment
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH6695"]]'
##
##            title
##   EH6695 | HumanBreastCancerIDC
##   EH6696 | HumanBreastCancerILC
##   EH6697 | HumanCerebellum
##   EH6698 | HumanColorectalCancer
##   EH6699 | HumanGlioblastoma
##   ...      ...
##   EH6739 | HumanSpinalCord_v3.13
##   EH6740 | MouseBrainCoronal_v3.13
##   EH6741 | MouseBrainSagittalPosterior_v3.13
##   EH6742 | MouseBrainSagittalAnterior_v3.13
##   EH6743 | MouseKidneyCoronal_v3.13
```

# 2 Loading the data

To retrieve a dataset, we can use a dataset’s corresponding named function `<id>()`, where `<id>` should correspond to one a valid dataset identifier (see `?TENxVisiumData`). E.g.:

```
library(TENxVisiumData)
spe <- HumanHeart()
```

Alternatively, data can loaded directly from Bioconductor’s *[ExerimentHub](https://bioconductor.org/packages/3.22/ExerimentHub)* as follows. First, we initialize a hub instance and store the complete list of records in a variable `eh`. Using `query()`, we then identify any records made available by the `TENxVisiumData` package, as well as their accession IDs (EH1234). Finally, we can load the data into R via `eh[[id]]`, where `id` corresponds to the data entry’s identifier we’d like to load. E.g.:

```
library(ExperimentHub)
eh <- ExperimentHub()        # initialize hub instance
q <- query(eh, "TENxVisium") # retrieve 'TENxVisiumData' records
id <- q$ah_id[1]             # specify dataset ID to load
spe <- eh[[id]]              # load specified dataset
```

# 3 Data representation

Each dataset is provided as a *[SpatialExperiment](https://bioconductor.org/packages/3.22/SpatialExperiment)* (SPE), which extends the *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* (SCE) class with features specific to spatially resolved data:

```
spe
```

```
## class: SpatialExperiment
## dim: 36601 7785
## metadata(0):
## assays(1): counts
## rownames(36601): ENSG00000243485 ENSG00000237613 ... ENSG00000278817
##   ENSG00000277196
## rowData names(1): symbol
## colnames(7785): AAACAAGTATCTCCCA-1 AAACACCAATAACTGC-1 ...
##   TTGTTTGTATTACACG-1 TTGTTTGTGTAAATTC-1
## colData names(1): sample_id
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## spatialCoords names(2) : pxl_col_in_fullres pxl_row_in_fullres
## imgData names(4): sample_id image_id data scaleFactor
```

For details on the SPE class, we refer to the package’s vignette. Briefly, the SPE harbors the following data in addition to that stored in a SCE:

`spatialCoords`; a numeric matrix of spatial coordinates, stored inside the object’s `int_colData`:

```
head(spatialCoords(spe))
```

```
##                    pxl_col_in_fullres pxl_row_in_fullres
## AAACAAGTATCTCCCA-1              15937              17428
## AAACACCAATAACTGC-1              18054               6092
## AAACAGAGCGACTCCT-1               7383              16351
## AAACAGGGTCTATATT-1              15202               5278
## AAACAGTGTTCCTGGG-1              21386               9363
## AAACATTTCCCGGATT-1              18549              16740
```

`spatialData`; a `DFrame` of spatially-related sample metadata, stored as part of the object’s `colData`. This `colData` subset is in turn determined by the `int_metadata` field `spatialDataNames`:

```
head(spatialData(spe))
```

```
## DataFrame with 6 rows and 0 columns
```

`imgData`; a `DFrame` containing image-related data, stored inside the `int_metadata`:

```
imgData(spe)
```

```
## DataFrame with 2 rows and 4 columns
##               sample_id    image_id   data scaleFactor
##             <character> <character> <list>   <numeric>
## 1 HumanBreastCancerIDC1      lowres   ####   0.0247525
## 2 HumanBreastCancerIDC2      lowres   ####   0.0247525
```

Datasets with multiple sections are consolidated into a single SPE with `colData` field `sample_id` indicating each spot’s sample of origin. E.g.:

```
spe <- MouseBrainSagittalAnterior()
table(spe$sample_id)
```

```
##
## MouseBrainSagittalAnterior1 MouseBrainSagittalAnterior2
##                        2695                        2825
```

Datasets of targeted analyses are provided as a *nested* SPE, with whole transcriptome measurements as primary data, and those obtained from targeted panels as `altExp`s. E.g.:

```
spe <- HumanOvarianCancer()
altExpNames(spe)
```

```
## [1] "TargetedImmunology" "TargetedPanCancer"
```

# Session information

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
##  [1] TENxVisiumData_1.18.0       SpatialExperiment_1.20.0
##  [3] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [5] Biobase_2.70.0              GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0           ExperimentHub_3.0.0
## [13] AnnotationHub_4.0.0         BiocFileCache_3.0.0
## [15] dbplyr_2.5.1                BiocGenerics_0.56.0
## [17] generics_0.1.4              BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0      rjson_0.2.23         xfun_0.54
##  [4] bslib_0.9.0          httr2_1.2.1          lattice_0.22-7
##  [7] vctrs_0.6.5          tools_4.5.1          curl_7.0.0
## [10] tibble_3.3.0         AnnotationDbi_1.72.0 RSQLite_2.4.3
## [13] blob_1.2.4           pkgconfig_2.0.3      Matrix_1.7-4
## [16] lifecycle_1.0.4      compiler_4.5.1       Biostrings_2.78.0
## [19] htmltools_0.5.8.1    sass_0.4.10          yaml_2.3.10
## [22] pillar_1.11.1        crayon_1.5.3         jquerylib_0.1.4
## [25] DelayedArray_0.36.0  cachem_1.1.0         magick_2.9.0
## [28] abind_1.4-8          tidyselect_1.2.1     digest_0.6.37
## [31] dplyr_1.1.4          purrr_1.1.0          bookdown_0.45
## [34] BiocVersion_3.22.0   grid_4.5.1           fastmap_1.2.0
## [37] SparseArray_1.10.1   cli_3.6.5            magrittr_2.0.4
## [40] S4Arrays_1.10.0      withr_3.0.2          filelock_1.0.3
## [43] rappdirs_0.3.3       bit64_4.6.0-1        rmarkdown_2.30
## [46] XVector_0.50.0       httr_1.4.7           bit_4.6.0
## [49] png_0.1-8            memoise_2.0.1        evaluate_1.0.5
## [52] knitr_1.50           rlang_1.1.6          Rcpp_1.1.0
## [55] glue_1.8.0           DBI_1.2.3            BiocManager_1.30.26
## [58] jsonlite_2.0.0       R6_2.6.1
```