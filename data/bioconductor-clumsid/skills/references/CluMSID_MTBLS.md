# Using CluMSID with a Publicly Available MetaboLights Data Set

#### Tobias Depke

#### October 29, 2025

# Introduction

In this tutorial, we would like to demonstate the use of CluMSID with a publicly available LC-MS/MS data set deposited on [MetaboLights](https://www.ebi.ac.uk/metabolights/). We chose data set MTBLS433 that can be accessed on the MetaboLights web page (<https://www.ebi.ac.uk/metabolights/MTBLS433>) and which has been published in the following article:

Kalogiouri, N. P., Alygizakis, N. A., Aalizadeh, R., & Thomaidis, N. S. (2016). Olive oil authenticity studies by target and nontarget LC–QTOF-MS combined with advanced chemometric techniques. *Analytical and bioanalytical chemistry*, 408(28), 7955-7970.

The authors analysed olive oil of various providence using reversed-phase ultra high performance liquid chromatography–electrospray ionisation quadrupole time of flight tandem mass spectrometry in negative mode with auto-MS/MS fragmentation.

As a representative pooled sample is not provided, we will combine MS2 data from several runs and use the peak picking done by the authors of the study for the merging of MS2 spectra. Some metabolite annotations are also included in the MTBLS433 data set which we will integrate into our analysis.

```
library(CluMSID)
library(CluMSIDdata)
```

# Extract MS2 spectra from multiple \*.mzML files

For demonstration, not all files from the analysis will be included into the analysis. Four data files from the data set have been chosen that represent olive oil samples from different regions in Greece:

* `YH1_GA7_01_10463.mzML`: YH1, from Komi
* `AX1_GB5_01_10470.mzML`: AX1, from Megaloxori
* `LP1_GB3_01_10467.mzML`: LP1, from Moria
* `BR1_GB6_01_10471.mzML`: BR1, from Agia Paraskevi

Note that these are mzML files that can be processed the exact same way as mzXML files.

Furthermore, we would like to use the peak picking and annotation data from the original authors which we can read from the file `m_mtbls433_metabolite_profiling_mass_spectrometry_v2_maf.tsv`.

First, we extract MS2 spectra from the respective files separately by using `extractMS2spectra()`. Then, we just combine the resulting lists into one list using base R functionality:

```
YH1 <- system.file("extdata", "YH1_GA7_01_10463.mzML",
                    package = "CluMSIDdata")
AX1 <- system.file("extdata", "AX1_GB5_01_10470.mzML",
                    package = "CluMSIDdata")
LP1 <- system.file("extdata", "LP1_GB3_01_10467.mzML",
                    package = "CluMSIDdata")
BR1 <- system.file("extdata", "BR1_GB6_01_10471.mzML",
                    package = "CluMSIDdata")

YH1list <- extractMS2spectra(YH1)
AX1list <- extractMS2spectra(AX1)
LP1list <- extractMS2spectra(LP1)
BR1list <- extractMS2spectra(BR1)

raw_oillist <- c(YH1list, AX1list, LP1list, BR1list)
```

# Merge spectra with external peak list

First, we import the peak list by reading the respective table and filtering for the relevant information. We only need the columns `metabolite_identification`, `mass_to_charge` and `rentention_time` and we would like to replace `"unknown"` with an empty field in the `metabolite_identification` column. Plus, the features do not have a unique identifier in the table but we can easily generate that from *m/z* and RT. Note that the retention time in the raw data is given in seconds and in the data table it is in minutes, so we have to convert. For the sake of consistency, we also change the column names. We use `tidyverse` syntax but users can do as they prefer.

```
raw_mtbls_df <- system.file("extdata",
                "m_mtbls433_metabolite_profiling_mass_spectrometry_v2_maf.tsv",
                package = "CluMSIDdata")

require(magrittr)

mtbls_df <- readr::read_delim(raw_mtbls_df, "\t") %>%
    dplyr::mutate(metabolite_identification =
                stringr::str_replace(metabolite_identification,
                                    "unknown", "")) %>%
    dplyr::mutate(id = paste0("M", mass_to_charge, "T", retention_time)) %>%
    dplyr::mutate(retention_time = retention_time * 60) %>%
    dplyr::select(id,
            mass_to_charge,
            retention_time,
            metabolite_identification) %>%
    dplyr::rename(mz = mass_to_charge,
            rt = retention_time,
            annotation = metabolite_identification)
```

This peak list, or its first three columns, can now be used to merge spectra. We exclude spectra that do not match to any of the peaks in the peak list. As we are not very familiar with instrumental setup, we set the limits for retention time and *m/z* deviation a little wider. To make an educated guess on mass accuracy, we take a look at an identified metabolite, its measured *m/z* and its theoretical *m/z*. We use arachidic acid [M-H]-, whose theoretical *m/z* is 311.2956:

```
## Define theoretical m/z
th <- 311.2956

## Get measured m/z for arachidic acid data from mtbls_df
ac <- mtbls_df %>%
    dplyr::filter(annotation == "Arachidic acid") %>%
    dplyr::select(mz) %>%
    as.numeric()

## Calculate relative m/z difference in ppm
abs(th - ac)/th * 1e6
#> [1] 28.91143
```

So, we will work with an an *m/z* tolerance of 30ppm (which seems rather high for a high resolution mass spectrometer).

A 30ppm mass accuracy necessitates an *m/z* tolerance of 60ppm, because deviations can go both ways:

```
oillist <- mergeMS2spectra(raw_oillist,
                                peaktable = mtbls_df[,1:3],
                                exclude_unmatched = TRUE,
                                rt_tolerance = 60,
                                mz_tolerance = 3e-5)
```

# Add annotations

To add annotations, we use `mtbls_df` as well, as described in the General Tutorial:

```
fl <- featureList(oillist)
fl_annos <- dplyr::left_join(fl, mtbls_df, by = "id")

annolist <- addAnnotations(oillist, fl_annos, annotationColumn = 6)
```

# Generate distance matrix

For the generation of the distance matrix, too, we use an *m/z* tolerance of 30ppm:

```
distmat <- distanceMatrix(annolist, mz_tolerance = 3e-5)
```

# Explore data

To explore the data, we have a look at a cluster dendrogram:

```
HCplot(distmat, h = 0.7, cex = 0.7)
```

![](data:image/png;base64...)

**Figure 1:** Circularised dendrogram as a result of agglomerative hierarchical clustering with average linkage as agglomeration criterion based on MS2 spectra similarities of the MTBLS433 LC-MS/MS example data set. Each leaf represents one feature and colours encode cluster affiliation of the features. Leaf labels display feature IDs. Distance from the central point is indicative of the height of the dendrogram.

Since it was not in the focus of their study, the authors identified only a few metabolites. If we look at the positions of these metabolites in the cluster dendrogram, we see that the poly-unsaturated fatty acids alpha-linolenic acid and alpha-linolenic acid are nicely separated from the saturated fatty acids stearic acid and arachidic acid. We would expect the latter to cluster together but a look at the spectra reveals that stearic acid barely produces any fragment ions and mainly contains the unfragmented [M-H]- parent ion:

```
specplot(getSpectrum(annolist, "annotation", "Stearic acid"))
```

![](data:image/png;base64...)

**Figure 2:** Barplot for the feature M283.2642T14.62, identified as stearic acid, displaying fragment *m/z* on the x-axis and intensity normalised to the maximum intensity on the y-axis.

In contrast, arachidic acid produces a much richer spectrum:

```
specplot(getSpectrum(annolist, "annotation", "Arachidic acid"))
```

![](data:image/png;base64...)

**Figure 3:** Barplot for the feature M311.3046T15.1, identified as arachidic acid, displaying fragment *m/z* on the x-axis and intensity normalised to the maximum intensity on the y-axis.

Inspecting the features that cluster close to arachidic acid shows that many of them have an exact *m/z* that conforms with other fatty acids of different chain length or saturation (within the *m/z* tolerance), e.g. the neighbouring feature M339.2125T15.32 that could be arachidonic acid [M+Cl]-.

Looking at oleic acid [M-H]-, we see that it clusters very closely to M563.5254T13.93, whose *m/z* is consistent with oleic acid [2M-H]- and some other possible adducts.

As a last example, the only identified metabolite that does not belong to the class of fatty acids is acetosyringone, a phenolic secondary plant metabolite. It forms part of a rather dense cluster in the dendrogram, suggesting high spectral similarities to the other members of the cluster. It would be interesting to try to annotate more of these metabolite to find out if they are also phenolic compounds.

In conclusion, we demonstrated how to use `CluMSID` with a publicly available data set from the MetaboLights repository and how to include external information such as peak lists or feature annotations into a `CluMSID` workflow. In doing so, we had a look on a few example findings that could help to annotate more of the features in the data set and thereby showed the usefulness of `CluMSID` for samples very different from the ones in the other tutorials.

# Session Info

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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#>  [1] magrittr_2.0.4      metaMSdata_1.45.0   metaMS_1.46.0
#>  [4] CAMERA_1.66.0       xcms_4.8.0          BiocParallel_1.44.0
#>  [7] Biobase_2.70.0      BiocGenerics_0.56.0 generics_0.1.4
#> [10] CluMSIDdata_1.25.0  CluMSID_1.26.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3          rstudioapi_0.17.1
#>   [3] jsonlite_2.0.0              MultiAssayExperiment_1.36.0
#>   [5] farver_2.1.2                MALDIquant_1.22.3
#>   [7] rmarkdown_2.30              fs_1.6.6
#>   [9] vctrs_0.6.5                 base64enc_0.1-3
#>  [11] htmltools_0.5.8.1           S4Arrays_1.10.0
#>  [13] BiocBaseUtils_1.12.0        progress_1.2.3
#>  [15] SparseArray_1.10.0          Formula_1.2-5
#>  [17] mzID_1.48.0                 sass_0.4.10
#>  [19] KernSmooth_2.23-26          bslib_0.9.0
#>  [21] htmlwidgets_1.6.4           plyr_1.8.9
#>  [23] impute_1.84.0               plotly_4.11.0
#>  [25] cachem_1.1.0                igraph_2.2.1
#>  [27] lifecycle_1.0.4             iterators_1.0.14
#>  [29] pkgconfig_2.0.3             Matrix_1.7-4
#>  [31] R6_2.6.1                    fastmap_1.2.0
#>  [33] MatrixGenerics_1.22.0       clue_0.3-66
#>  [35] digest_0.6.37               colorspace_2.1-2
#>  [37] pcaMethods_2.2.0            GGally_2.4.0
#>  [39] S4Vectors_0.48.0            Hmisc_5.2-4
#>  [41] GenomicRanges_1.62.0        Spectra_1.20.0
#>  [43] httr_1.4.7                  abind_1.4-8
#>  [45] compiler_4.5.1              bit64_4.6.0-1
#>  [47] withr_3.0.2                 doParallel_1.0.17
#>  [49] backports_1.5.0             htmlTable_2.4.3
#>  [51] S7_0.2.0                    DBI_1.2.3
#>  [53] ggstats_0.11.0              gplots_3.2.0
#>  [55] MASS_7.3-65                 MsExperiment_1.12.0
#>  [57] DelayedArray_0.36.0         gtools_3.9.5
#>  [59] caTools_1.18.3              mzR_2.44.0
#>  [61] tools_4.5.1                 PSMatch_1.14.0
#>  [63] foreign_0.8-90              ape_5.8-1
#>  [65] nnet_7.3-20                 glue_1.8.0
#>  [67] dbscan_1.2.3                nlme_3.1-168
#>  [69] QFeatures_1.20.0            grid_4.5.1
#>  [71] checkmate_2.3.3             cluster_2.1.8.1
#>  [73] reshape2_1.4.4              gtable_0.3.6
#>  [75] tzdb_0.5.0                  preprocessCore_1.72.0
#>  [77] tidyr_1.3.1                 sna_2.8
#>  [79] data.table_1.17.8           hms_1.1.4
#>  [81] MetaboCoreUtils_1.18.0      XVector_0.50.0
#>  [83] foreach_1.5.2               pillar_1.11.1
#>  [85] stringr_1.5.2               vroom_1.6.6
#>  [87] limma_3.66.0                robustbase_0.99-6
#>  [89] dplyr_1.1.4                 lattice_0.22-7
#>  [91] bit_4.6.0                   tidyselect_1.2.1
#>  [93] RBGL_1.86.0                 knitr_1.50
#>  [95] gridExtra_2.3               IRanges_2.44.0
#>  [97] Seqinfo_1.0.0               ProtGenerics_1.42.0
#>  [99] SummarizedExperiment_1.40.0 stats4_4.5.1
#> [101] xfun_0.53                   statmod_1.5.1
#> [103] MSnbase_2.36.0              matrixStats_1.5.0
#> [105] DEoptimR_1.1-4              stringi_1.8.7
#> [107] statnet.common_4.12.0       lazyeval_0.2.2
#> [109] yaml_2.3.10                 evaluate_1.0.5
#> [111] codetools_0.2-20            archive_1.1.12
#> [113] MsCoreUtils_1.22.0          tibble_3.3.0
#> [115] BiocManager_1.30.26         graph_1.88.0
#> [117] cli_3.6.5                   affyio_1.80.0
#> [119] rpart_4.1.24                jquerylib_0.1.4
#> [121] network_1.19.0              dichromat_2.0-0.1
#> [123] Rcpp_1.1.0                  MassSpecWavelet_1.76.0
#> [125] coda_0.19-4.1               XML_3.99-0.19
#> [127] parallel_4.5.1              readr_2.1.5
#> [129] ggplot2_4.0.0               prettyunits_1.2.0
#> [131] AnnotationFilter_1.34.0     bitops_1.0-9
#> [133] viridisLite_0.4.2           MsFeatures_1.18.0
#> [135] scales_1.4.0                affy_1.88.0
#> [137] ncdf4_1.24                  purrr_1.1.0
#> [139] crayon_1.5.3                rlang_1.1.6
#> [141] vsn_3.78.0
```