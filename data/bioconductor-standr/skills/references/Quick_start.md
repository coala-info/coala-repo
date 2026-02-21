Code

* Show All Code
* Hide All Code

# A quick start guide to the standR package

#### Ning Liu, Dharmesh Bhuva, Ahmed Mohamed, Chin Wee Tan, Melissa Davis

#### 2025-10-30

* [1 Installation](#installation)
* [2 Quick start](#quick-start)
  + [2.1 Load data for this guide](#load-data-for-this-guide)
  + [2.2 QC](#qc)
    - [2.2.1 metadata visualization](#metadata-visualization)
    - [2.2.2 Gene level QC](#gene-level-qc)
    - [2.2.3 ROI level QC](#roi-level-qc)
  + [2.3 Inspection of variations on ROI level](#inspection-of-variations-on-roi-level)
    - [2.3.1 RLE](#rle)
    - [2.3.2 PCA](#pca)
* [3 Data normalization](#data-normalization)
* [4 Batch correction](#batch-correction)
* [5 SessionInfo](#sessioninfo)

# 1 Installation

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("standR")
```

The development version of `standR` can be installed from GitHub:

```
devtools::install_github("DavisLaboratory/standR")
```

# 2 Quick start

```
library(standR)
library(SpatialExperiment)
library(limma)
library(ExperimentHub)
```

## 2.1 Load data for this guide

This is the background for the data:

NanoString GeoMx DSP dataset of diabetic kidney disease (DKD) vs healthy kidney tissue. **Seven slides** were analyzed, **4 DKD and 3 healthy**. Regions of Interest (ROI) were focused two different parts of a kidney’s structure: **tubules or glomeruli**. Individual glomeruli were identified by a pathologist as either **relatively healthy or diseased** regardless if the tissue was DKD or healthy. Tubule ROIs were segmented into **distal (PanCK) and proximal (neg) tubules**. While both distal and proximal tubules are called tubules, they perform very different functions in the kidney.

```
eh <- ExperimentHub()

query(eh, "standR")
```

```
## ExperimentHub with 3 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: Nanostring
## # $species: NA
## # $rdataclass: data.frame
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH7364"]]'
##
##            title
##   EH7364 | GeomxDKDdata_count
##   EH7365 | GeomxDKDdata_sampleAnno
##   EH7366 | GeomxDKDdata_featureAnno
```

```
countFile <- eh[["EH7364"]]
sampleAnnoFile <- eh[["EH7365"]]
featureAnnoFile <- eh[["EH7366"]]

spe <- readGeoMx(countFile, sampleAnnoFile, featureAnnoFile = featureAnnoFile, rmNegProbe = TRUE)
```

## 2.2 QC

### 2.2.1 metadata visualization

Based on the description of the data, we know that all glomerulus are classified as abnormal and healthy, and tubule are classified as neg and PanCK.

We therefore merge the region-related annotations to avoid collinearity, which can affect the process of batch correction.

```
colData(spe)$regions <- paste0(colData(spe)$region,"_",colData(spe)$SegmentLabel) |>
  (\(.) gsub("_Geometric Segment","",.))() |>
  paste0("_",colData(spe)$pathology) |>
  (\(.) gsub("_NA","_ns",.))()

library(ggalluvial)

plotSampleInfo(spe, column2plot = c("SlideName","disease_status","regions"))
```

![](data:image/png;base64...)

### 2.2.2 Gene level QC

```
spe <- addPerROIQC(spe, rm_genes = TRUE)
```

```
plotGeneQC(spe, ordannots = "regions", col = regions, point_size = 2)
```

![](data:image/png;base64...)

Using the `plotGeneQC` function, we can have a look at which were the genes removed and the overall distribution of percentage of non-expressed genes in all ROIs. By default, top 9 genes are plotted here (arranging by mean expression), user can increase the number of plotted genes by changing the `top_n` parameter.

In this case we don’t see any specific biological pattern for the samples expressing this genes (figure above).

### 2.2.3 ROI level QC

In the ROI level QC, we first aim to identify (if any) ROI(s) that have relatively low library size and low cell count because they are considered as low quality samples due to insufficient sequencing depth or lack of RNA in the chosen region.

In this case, looking at the distribution plots of library size and nuclei count, we don’t see any particular spike in the low ends, rather the distributions are relatively smooth. Looking at the dot plot, library sizes are mostly positively correlate with the nuclei count, with some data have relatively low library size while the nuclei count is reasonable. We therefore can try to draw an filtering threshold at the low end of the library size, in this case 50000. By coloring the dot with their slide names, we find that the ROIs below the threshold are all from slide disease1B, suggesting the reason for this might be some technical issues of slide disease1B.

```
plotROIQC(spe, y_threshold = 50000, col = SlideName)
```

![](data:image/png;base64...)

Since library size of 50000 seems to be a reasonable threshold, here we subset the spatial experiment object based on the library size in `colData`.

```
spe <- spe[,rownames(colData(spe))[colData(spe)$lib_size > 50000]]
```

## 2.3 Inspection of variations on ROI level

### 2.3.1 RLE

Here we can see obvious variation from slides to slides, and small variations are also observed within each slide.

```
plotRLExpr(spe, ordannots = "SlideName", assay = 2, col = SlideName)
```

![](data:image/png;base64...)

### 2.3.2 PCA

Here we color the PCA with slide information, and shape by regions (tissue). We can see that PC1 is mainly spread out by regions, especially glomerulus and tubule. And grouping based on slide within each tissue are observed. The subtypes in tubule are clearly separated, but different subtypes of glomerulus is still grouping together. Moreover, diseased tissues and control tissues are mixed as well (disease slides and normal slides).

```
drawPCA(spe, assay = 2, col = SlideName, shape = regions)
```

![](data:image/png;base64...)

# 3 Data normalization

As we observed the technical variations in the data in both RLE and PCA plots. It is necessary to perform normalization in the data.

In the `standR` package, we offer normalization options including TMM, RPKM, TPM, CPM, upperquartile and sizefactor. Among them, RPKM and TPM required gene length information (add `genelength` column to the `rowData` of the object). For TMM, upperquartile and sizefactor, their normalized factor will be stored their `metadata`.

Here we used TMM to normalize the data.

```
colData(spe)$biology <- paste0(colData(spe)$disease_status, "_", colData(spe)$regions)

spe_tmm <- geomxNorm(spe, method = "TMM")
```

# 4 Batch correction

In the Nanostring’s GeoMX DSP protocol, due to the fact that one slide is only big enough for a handful of tissue segments (ROIs), it is common that we see the DSP data being confounded by the batch effect introduced by different slides. In order to establish fair comparison between ROIs later on, it is necessary to remove this batch effect from the data.

To run RUV4 batch correction, we need to provide a list of “negative control genes (NCGs)”.

The function `findNCGs` allows identifying the NCGs from the data. In this case, since the batch effect is mostly introduced by slide, we therefore want to identify NCGs across all slides, so here we set the `batch_name` to “SlideName”, and select the top 500 least variable genes across different slides as NCGs.

```
spe <- findNCGs(spe, batch_name = "SlideName", top_n = 500)

metadata(spe) |> names()
```

```
## [1] "NegProbes"         "lcpm_threshold"    "genes_rm_rawCount"
## [4] "genes_rm_logCPM"   "NCGs"
```

Here we use k of 5 to perform RUV-4 normalization.

```
spe_ruv <- geomxBatchCorrection(spe, factors = "biology",
                   NCGs = metadata(spe)$NCGs, k = 5)
```

We can then inspect the PCA of the corrected data with annotations, to inspect the removal of batch effects, and the retaining of the biological factors.

```
plotPairPCA(spe_ruv, assay = 2, color = disease_status, shape = regions, title = "RUV4")
```

![](data:image/png;base64...)

Moreover, we can also have a look at the RLE plots of the normalized count.

```
plotRLExpr(spe_ruv, assay = 2, color = SlideName) + ggtitle("RUV4")
```

![](data:image/png;base64...)

**For more detailed analysis pipeline and usage of the standR package, please see <https://github.com/DavisLaboratory/GeoMXAnalysisWorkflow>**

# 5 SessionInfo

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
##  [1] ggalluvial_0.12.5           ggplot2_4.0.0
##  [3] ExperimentHub_3.0.0         AnnotationHub_4.0.0
##  [5] BiocFileCache_3.0.0         dbplyr_2.5.1
##  [7] limma_3.66.0                SpatialExperiment_1.20.0
##  [9] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
## [11] Biobase_2.70.0              GenomicRanges_1.62.0
## [13] Seqinfo_1.0.0               IRanges_2.44.0
## [15] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [17] generics_0.1.4              MatrixGenerics_1.22.0
## [19] matrixStats_1.5.0           standR_1.14.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3            gridExtra_2.3        httr2_1.2.1
##   [4] rlang_1.1.6          magrittr_2.0.4       scater_1.38.0
##   [7] compiler_4.5.1       RSQLite_2.4.3        mgcv_1.9-3
##  [10] png_0.1-8            vctrs_0.6.5          pkgconfig_2.0.3
##  [13] crayon_1.5.3         fastmap_1.2.0        backports_1.5.0
##  [16] magick_2.9.0         XVector_0.50.0       scuttle_1.20.0
##  [19] labeling_0.4.3       rmarkdown_2.30       tzdb_0.5.0
##  [22] ggbeeswarm_0.7.2     purrr_1.1.0          bit_4.6.0
##  [25] xfun_0.53            cachem_1.1.0         beachmat_2.26.0
##  [28] jsonlite_2.0.0       blob_1.2.4           DelayedArray_0.36.0
##  [31] BiocParallel_1.44.0  broom_1.0.10         irlba_2.3.5.1
##  [34] parallel_4.5.1       R6_2.6.1             bslib_0.9.0
##  [37] RColorBrewer_1.1-3   car_3.1-3            jquerylib_0.1.4
##  [40] Rcpp_1.1.0           knitr_1.50           readr_2.1.5
##  [43] Matrix_1.7-4         splines_4.5.1        tidyselect_1.2.1
##  [46] viridis_0.6.5        dichromat_2.0-0.1    abind_1.4-8
##  [49] yaml_2.3.10          codetools_0.2-20     curl_7.0.0
##  [52] lattice_0.22-7       tibble_3.3.0         withr_3.0.2
##  [55] KEGGREST_1.50.0      S7_0.2.0             evaluate_1.0.5
##  [58] archive_1.1.12       Biostrings_2.78.0    ggpubr_0.6.2
##  [61] pillar_1.11.1        BiocManager_1.30.26  filelock_1.0.3
##  [64] carData_3.0-5        vroom_1.6.6          BiocVersion_3.22.0
##  [67] hms_1.1.4            scales_1.4.0         glue_1.8.0
##  [70] tools_4.5.1          BiocNeighbors_2.4.0  ScaledMatrix_1.18.0
##  [73] ggsignif_0.6.4       locfit_1.5-9.12      cowplot_1.2.0
##  [76] grid_4.5.1           tidyr_1.3.1          AnnotationDbi_1.72.0
##  [79] edgeR_4.8.0          nlme_3.1-168         patchwork_1.3.2
##  [82] beeswarm_0.4.0       BiocSingular_1.26.0  vipor_0.4.7
##  [85] Formula_1.2-5        rsvd_1.0.5           cli_3.6.5
##  [88] ruv_0.9.7.1          rappdirs_0.3.3       viridisLite_0.4.2
##  [91] S4Arrays_1.10.0      dplyr_1.1.4          gtable_0.3.6
##  [94] rstatix_0.7.3        sass_0.4.10          digest_0.6.37
##  [97] ggrepel_0.9.6        SparseArray_1.10.0   rjson_0.2.23
## [100] farver_2.1.2         memoise_2.0.1        htmltools_0.5.8.1
## [103] lifecycle_1.0.4      httr_1.4.7           statmod_1.5.1
## [106] bit64_4.6.0-1
```