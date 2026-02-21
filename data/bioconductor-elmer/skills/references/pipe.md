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

# 3.6 - TCGA.pipe: Running ELMER for TCGA data in a compact way

# TCGA.pipe: Running ELMER for TCGA data in a compact way

`TCGA.pipe` is a function for easily downloading TCGA data from GDC using TCGAbiolinks package (Colaprico et al. 2016) and performing all the analyses in ELMER. For illustration purpose, we skip the downloading step. The user can use the `getTCGA` function to download TCGA data or use `TCGA.pipe` by including “download” in the analysis option.

The following command will do distal DNA methylation analysis and predict putative target genes, motif analysis and identify regulatory transcription factors.

```
TCGA.pipe("LUSC",
          wd = "./ELMER.example",
          cores = parallel::detectCores()/2,
          mode = "unsupervised"
          permu.size = 300,
          Pe = 0.01,
          analysis = c("distal.probes","diffMeth","pair","motif","TF.search"),
          diff.dir = "hypo",
          rm.chr = paste0("chr",c("X","Y")))
```

TCGA.pipe: Mode argument

In this new version we added the argument `mode` in the `TCGA.pipe` function. This will automatically set the `minSubgroupFrac` to the following values:

Modes available:

* `unsupervised`:
  + Use 20% of each group to identify differently methylated regions (`minSubgroupFrac` = 0.2 in `get.diff.meth`)
  + Use 40% of all samples to create Unmethytlated (U) and Methylated (M) groups in the other steps (the lowest quintile of samples is the U group and the highest quintile samples is the M group) (`minSubgroupFrac` = 0.4 in `get.pairs` and `get.TFs` functions)
* `supervised`:
  + Use all samples in all functions and set Unmethytlated (U) and Methylated (M) one of the group selected in the analysis.

The `unsupervised` mode should be used when want to be able to detect a specific (possibly unknown) molecular subtype among tumor; these subtypes often make up only a minority of samples, and 20% was chosen as a lower bound for the purposes of statistical power. If you are using pre-defined group labels, such as treated replicates vs. untreated replicated, use `supervised` mode (all samples),

For more information please read the analysis section of the vignette.

# Using mutation data to identify groups

We add in `TCGA.pipe` function (download step) the option to identify mutant samples to perform WT vs Mutant analysis. It will download open [MAF file](https://docs.gdc.cancer.gov/Data/File_Formats/MAF_Format/) from GDC database (Grossman and others 2016), select a gene and identify the which are the mutant samples based on the following classification: (it can be changed using the atgument `mutant_variant_classification`).

Mutations classification

| Argument | Description |
| --- | --- |
| Frame\_Shift\_Del | Mutant |
| Frame\_Shift\_Ins | Mutant |
| Missense\_Mutation | Mutant |
| Nonsense\_Mutation | Mutant |
| Splice\_Site | Mutant |
| In\_Frame\_Del | Mutant |
| In\_Frame\_Ins | Mutant |
| Translation\_Start\_Site | Mutant |
| Nonstop\_Mutation | Mutant |
| Silent | WT |
| 3’UTR | WT |
| 5’UTR | WT |
| 3’Flank | WT |
| 5’Flank | WT |
| IGR1 (intergenic region) | WT |
| Intron | WT |
| RNA | WT |
| Target\_region | WT |

The arguments to be used are below:

`TCGA.pipe` mutation arguments

| Argument | Description |
| --- | --- |
| genes | List of genes for which mutations will be verified. A column in the MAE with the name of the gene will be created with two groups WT (tumor samples without mutation), MUT (tumor samples w/ mutation), NA (not tumor samples) |
| mutant\_variant\_classification | List of GDC variant classification from MAF files to consider a samples mutant. Only used when argument gene is set. |
| group.col | A column defining the groups of the sample. You can view the available columns using: colnames(MultiAssayExperiment::colData(data)). |
| group1 | A group from group.col. ELMER will run group1 vs group2. That means, if direction is hyper, get probes hypermethylated in group 1 compared to group 2. |
| group2 | A group from group.col. ELMER will run group1 vs group2. That means, if direction is hyper, get probes hypermethylated in group 1 compared to group 2. |

Here is an example we TCGA-LUSC data is downloaded and we will compare TP53 Mutant vs TP53 WT samples.

```
TCGA.pipe("LUSC",
          wd = "./ELMER.example",
          cores = parallel::detectCores()/2,
          mode = "supervised"
          genes = "TP53",
          group.col = "TP53",
          group1 = "Mutant",
          group2 = "WT",
          permu.size = 300,
          Pe = 0.01,
          analysis = c("download","diffMeth","pair","motif","TF.search"),
          diff.dir = "hypo",
          rm.chr = paste0("chr",c("X","Y")))
```

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

Colaprico, Antonio, Tiago C. Silva, Catharina Olsen, Luciano Garofano, Claudia Cava, Davide Garolini, Thais S. Sabedot, et al. 2016. “TCGAbiolinks: An R/Bioconductor Package for Integrative Analysis of Tcga Data.” *Nucleic Acids Research* 44 (8): e71. <https://doi.org/10.1093/nar/gkv1507>.

Grossman, Robert L, and others. 2016. “Toward a Shared Vision for Cancer Genomic Data.” *New England Journal of Medicine* 375 (12): 1109–12.