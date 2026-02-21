[ELMER](index.html)

* [Introduction](index.html)
* [Data input](input.html)
* Analysis
  + Analysis steps
  + [1 - Creating MAE with distal probes (data input)](analysis_data_input.html)
  + [2 - Identifying differentially methylated probes](analysis_diff_meth.html)
  + [3 - Identifying putative probe-gene pairs](analysis_get_pair.html)
  + [4 - Motif enrichment analysis on the selected probes](analysis_motif_enrichment.html)
  + [5 - Identifying regulatory TFs](analysis_regulatory_tf.html)
  + Compact version with TCGA data
  + [TCGA pipe](pipe.html)
* Plots
  + Plot functions
  + [1 - Scatter plots](plots_scatter.html)
  + [2 - Schematic plots](plots_schematic.html)
  + [3 - Motif enrichment plots](plots_motif_enrichment.html)
  + [4 - Regulatory TF plots](plots_TF.html)
  + [5 - Heatmap plots](plots_heatmap.html)
* [Graphical User interface](analysis_gui.html)
* [Use case](usecase.html)

* + ELMER package
  + [Github](https://github.com/tiagochst/ELMER)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/ELMER.html)
  + ELMER.data package
  + [Github](https://github.com/tiagochst/ELMER)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/ELMER.html)
  + Bioc2017 workshop
  + [Github ELMER/TCGAbiolinks](https://github.com/BioinformaticsFMRP/Bioc2017.TCGAbiolinks.ELMER)
  + TCGAbiolinks package
  + [Github](https://github.com/BioinformaticsFMRP/TCGAbiolinks)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/TCGAbiolinks.html)
* + Cedars-sinai
  + [center4bfg](https://twitter.com/center4bfg)
  + [center4bfg.org](https://center4bfg.org)
  + University of São Paulo (USP)
  + [fmrp.usp.br](http://www.fmrp.usp.br/?lang=en)
  + Fundings
  + [FAPESP (16/10436-9)](http://www.bv.fapesp.br/en/pesquisa/?sort=-data_inicio&q2=%28instituicao%3A%22Cedars-Sinai+Medical+Center%22%29+AND+%28%28bolsa_en_exact%3A%22Scholarships+abroad%22+AND+situacao_en_exact%3A%22Ongoing%22%29%29)
  + [NCI ITCR program (1U01CA184826)](https://itcr.nci.nih.gov/)
  + [Genomic Data Analysis Network NIH/NCI (1U24CA210969)](https://projectreporter.nih.gov/project_info_description.cfm?aid=9210719&icde=31197242&ddparam=&ddvalue=&ddsub=&cr=1&csb=default&cs=ASC)

# 5 - Integrative analysis workshop with TCGAbiolinks and ELMER - Analysis GUI

# Introduction

In this section, we will perform the same analysis performed using ELMER, but instead of doing it programmatically we will use TCGAbiolinksGUI (Silva et al. 2017).

First we will launch the TCGAbiolinksGUI.

```
library(TCGAbiolinksGUI)
TCGAbiolinksGUI()
```

# Downloading data

Please download this two objects:

* [Gene expression Summarized Experiment](https://github.com/BioinformaticsFMRP/Bioc2017.TCGAbiolinks.ELMER/raw/master/data/lusc.exp.rda)
* [DNA methylation Summarized Experiment](https://github.com/BioinformaticsFMRP/Bioc2017.TCGAbiolinks.ELMER/raw/master/data/lusc.met.rda)

# Analysis

## Create MultiAssayExperiment object

To create the MultiAssayExperiment object go to `Integrative analysis/ELMER/Create input data`.

![](data:image/png;base64...)

## Perform analysis

To perform ELMER analysis go to `Integrative analysis/ELMER/Analysis`.

![](data:image/png;base64...)

Select the MAE data created in the previous section.

![](data:image/png;base64...)

Select the groups that will be analysed: Primary solid Tumor and Solid Tissue Normal.

![](data:image/png;base64...)

We will identify probes that are hypomethylated in Primary solid Tumor compared to Solid Tissue Normal.

![](data:image/png;base64...)

For the significant differently methylated probes identified before we will correlated with the 20 nearest genes. Change the value of the field `Number of permutations` to `100`, `Raw P-value cut-off` to `0.05` and `Empirical P value cut-off` to `0.01`.

![](data:image/png;base64...)

There will be no changes in the step 3.

![](data:image/png;base64...)

There will be no changes in the step 4.

![](data:image/png;base64...)

Click on `Run the analysis`.

![](data:image/png;base64...)

If the analysis identified significant regulatory TF the results will be saved into an R object.

![](data:image/png;base64...)

## Visualize results

To visualize the results go to `Integrative analysis/ELMER/Visualize results`.

![](data:image/png;base64...)

Click on `Select results` and select the object created on the previous section.

![](data:image/png;base64...) ![](data:image/png;base64...)

Or the avarage DNA methylation levels of probes of a Motif vs the expression of a TF.

![](data:image/jpeg;base64...)

For each enriched motif you can verify the ranking of sigificances between the correlation of DNA methylation level on the significant paired probes with that motif vs the TF expression (for all human TF).

![](data:image/jpeg;base64...)

The enrichement of each motif can be visualized.

![](data:image/jpeg;base64...)

You can take a look for a gene which was the probe linked.

![](data:image/jpeg;base64...)

You can see the plot and its neraby genes.

![](data:image/jpeg;base64...)

It is possible to visualize the table with the significant differently methylated probes.

![](data:image/jpeg;base64...)

It is possible to visualize the table with the enriched motifs.

![](data:image/jpeg;base64...)

It is possible to visualize the table with the candidates regulatory TF.

![](data:image/jpeg;base64...)

# Session Info

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
##  [1] MultiAssayExperiment_1.36.1 SummarizedExperiment_1.40.0
##  [3] Biobase_2.70.0              MatrixGenerics_1.22.0
##  [5] matrixStats_1.5.0           GenomicRanges_1.62.1
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            sesameData_1.28.0
## [11] ExperimentHub_3.0.0         AnnotationHub_4.0.0
## [13] BiocFileCache_3.0.0         dbplyr_2.5.1
## [15] BiocGenerics_0.56.0         generics_0.1.4
## [17] BiocStyle_2.38.0            dplyr_1.2.0
## [19] DT_0.34.0                   ELMER_2.34.2
## [21] ELMER.data_2.34.0
##
## loaded via a namespace (and not attached):
##   [1] later_1.4.5                 BiocIO_1.20.0
##   [3] bitops_1.0-9                filelock_1.0.3
##   [5] tibble_3.3.1                XML_3.99-0.20
##   [7] rpart_4.1.24                lifecycle_1.0.5
##   [9] httr2_1.2.2                 rstatix_0.7.3
##  [11] doParallel_1.0.17           vroom_1.7.0
##  [13] processx_3.8.6              lattice_0.22-7
##  [15] ensembldb_2.34.0            crosstalk_1.2.2
##  [17] backports_1.5.0             magrittr_2.0.4
##  [19] plotly_4.12.0               Hmisc_5.2-5
##  [21] sass_0.4.10                 rmarkdown_2.30
##  [23] jquerylib_0.1.4             yaml_2.3.12
##  [25] otel_0.2.0                  Gviz_1.54.0
##  [27] chromote_0.5.1              DBI_1.2.3
##  [29] RColorBrewer_1.1-3          abind_1.4-8
##  [31] rvest_1.0.5                 purrr_1.2.1
##  [33] AnnotationFilter_1.34.0     biovizBase_1.58.0
##  [35] RCurl_1.98-1.17             nnet_7.3-20
##  [37] VariantAnnotation_1.56.0    rappdirs_0.3.4
##  [39] circlize_0.4.17             ggrepel_0.9.6
##  [41] codetools_0.2-20            DelayedArray_0.36.0
##  [43] xml2_1.5.2                  tidyselect_1.2.1
##  [45] shape_1.4.6.1               UCSC.utils_1.6.1
##  [47] farver_2.1.2                TCGAbiolinksGUI.data_1.30.0
##  [49] base64enc_0.1-6             GenomicAlignments_1.46.0
##  [51] jsonlite_2.0.0              GetoptLong_1.1.0
##  [53] Formula_1.2-5               iterators_1.0.14
##  [55] systemfonts_1.3.1           foreach_1.5.2
##  [57] tools_4.5.2                 progress_1.2.3
##  [59] ragg_1.5.0                  Rcpp_1.1.1
##  [61] glue_1.8.0                  gridExtra_2.3
##  [63] SparseArray_1.10.8          BiocBaseUtils_1.12.0
##  [65] xfun_0.56                   GenomeInfoDb_1.46.2
##  [67] websocket_1.4.4             withr_3.0.2
##  [69] BiocManager_1.30.27         fastmap_1.2.0
##  [71] latticeExtra_0.6-31         digest_0.6.39
##  [73] R6_2.6.1                    textshaping_1.0.4
##  [75] colorspace_2.1-2            jpeg_0.1-11
##  [77] dichromat_2.0-0.1           biomaRt_2.66.0
##  [79] RSQLite_2.4.5               cigarillo_1.0.0
##  [81] tidyr_1.3.2                 data.table_1.18.2.1
##  [83] rtracklayer_1.70.1          prettyunits_1.2.0
##  [85] httr_1.4.7                  htmlwidgets_1.6.4
##  [87] S4Arrays_1.10.1             pkgconfig_2.0.3
##  [89] gtable_0.3.6                blob_1.3.0
##  [91] ComplexHeatmap_2.26.1       S7_0.2.1
##  [93] XVector_0.50.0              htmltools_0.5.9
##  [95] carData_3.0-6               ProtGenerics_1.42.0
##  [97] clue_0.3-66                 scales_1.4.0
##  [99] png_0.1-8                   knitr_1.51
## [101] rstudioapi_0.18.0           reshape2_1.4.5
## [103] tzdb_0.5.0                  rjson_0.2.23
## [105] checkmate_2.3.4             curl_7.0.0
## [107] cachem_1.1.0                GlobalOptions_0.1.3
## [109] stringr_1.6.0               BiocVersion_3.22.0
## [111] parallel_4.5.2              foreign_0.8-91
## [113] AnnotationDbi_1.72.0        restfulr_0.0.16
## [115] reshape_0.8.10              pillar_1.11.1
## [117] grid_4.5.2                  vctrs_0.7.1
## [119] promises_1.5.0              ggpubr_0.6.2
## [121] car_3.1-5                   cluster_2.1.8.2
## [123] htmlTable_2.4.3             evaluate_1.0.5
## [125] TCGAbiolinks_2.38.0         readr_2.1.6
## [127] GenomicFeatures_1.62.0      cli_3.6.5
## [129] compiler_4.5.2              Rsamtools_2.26.0
## [131] rlang_1.1.7                 crayon_1.5.3
## [133] ggsignif_0.6.4              labeling_0.4.3
## [135] interp_1.1-6                ps_1.9.1
## [137] plyr_1.8.9                  stringi_1.8.7
## [139] viridisLite_0.4.3           deldir_2.0-4
## [141] BiocParallel_1.44.0         Biostrings_2.78.0
## [143] lazyeval_0.2.2              Matrix_1.7-4
## [145] BSgenome_1.78.0             hms_1.1.4
## [147] bit64_4.6.0-1               ggplot2_4.0.2
## [149] KEGGREST_1.50.0             fontawesome_0.5.3
## [151] broom_1.0.12                memoise_2.0.1
## [153] bslib_0.10.0                bit_4.6.0
## [155] downloader_0.4.1
```

# Bibliography

Silva, Tiago C., Antonio Colaprico, Catharina Olsen, Gianluca Bontempi, Michele Ceccarelli, Benjamin P. Berman, and Houtan Noushmehr. 2017. “TCGAbiolinksGUI: A Graphical User Interface to Analyze Cancer Molecular and Clinical Data.” *bioRxiv*. <https://doi.org/10.1101/147496>.