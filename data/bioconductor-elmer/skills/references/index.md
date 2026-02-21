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

# ELMER v.2: An R/Bioconductor package to reconstruct gene regulatory networks from DNA methylation and transcriptome profiles

#### Tiago Chedraoui Silva [aut], Lijing Yao [aut], Simon Coetzee [aut], Nicole Gull [ctb], Houtan Noushmehr [ctb], Dennis J. Hazelett [ctb], Peggy Farnham [aut], Hui Shen [ctb], Peter Laird [ctb], De-Chen Lin[ctb], Benjamin P. Berman [aut]

#### 2026-02-05

# Introduction

DNA methylation can be used to identify functional changes at transcriptional enhancers and other cis-regulatory modules (CRMs) in tumors and other primary disease tissues. Our R/Bioconductor package *[ELMER](https://bioconductor.org/packages/3.22/ELMER)* (Enhancer Linking by Methylation/Expression Relationships) provides a systematic approach that reconstructs gene regulatory networks (GRNs) by combining methylation and gene expression data derived from the same set of samples. *[ELMER](https://bioconductor.org/packages/3.22/ELMER)* uses methylation changes at CRMs as the central hub of these networks, using correlation analysis to associate them with both upstream master regulator (MR) transcription factors and downstream target genes.

This package can be easily applied to TCGA public available cancer data sets and custom DNA methylation and gene expression data sets.

ELMER analyses have 5 main steps:

1. Identify distal probes on HM450K or EPIC arrays.
2. Identify distal probes with significantly different DNA methylation level between two groups
3. Identify putative target genes for differentially methylated distal probes.
4. Identify enriched motifs for the distalprobes which are significantly differentially methylated and linked to putative target gene.
5. Identify regulatory TFs whose expression associate with DNA methylation at enriched motifs.

# Package workflow

The package workflow is showed in the figure below:

![](data:image/png;base64...)

ELMER workflow: ELMER receives as input a DNA methylation object, a gene expression object (both can be either a matrix or a SummarizedExperiment object) and a Genomic Ranges (GRanges) object with distal probes to be used as a filter which can be retrieved using the `get.feature.probe` function. The function `createMAE` will create a Multi Assay Experiment object keeping only samples that have both DNA methylation and gene expression data. Genes will be mapped to genomic position and annotated using ENSEMBL database, while for probes it will add annotation from (<http://zwdzwd.github.io/InfiniumAnnotation>). This MAE object will be used as input to the next analysis functions. First, it identifies differentially methylated probes followed by the identification of their nearest genes (10 upstream and 10 downstream) through the `get.diff.meth` and `GetNearGenes` functions respectively. For each probe, it will verify if any of the nearby genes were affected by its change in the DNA methylation level and a list of gene and probes pairs will be outputted from `get.pair` function. For the probes in those pairs, it will search for enriched regulatory Transcription Factors motifs with the `get.enriched.motif` function. Finally, the enriched motifs will be correlated with the level of the transcription factor through the `get.TFs` function. In the figure green Boxes represent user input data, blue boxes represent output object, orange boxes represent auxiliary pre-computed data and gray boxes are functions.

# Main differences between ELMER v2 vs ELMER v1

## Summary table

|  | ELMER Version 1 | ELMER Version 2 |
| --- | --- | --- |
| Primary data structure | mee object (custom data structure) | MAE object (Bioconductor data structure) |
| Auxiliary data | Manually created | Programmatically created |
| Number of human TFs | 1,982 | 1,639 (curated list from Lambert, Samuel A., et al.) |
| Number of TF motifs | 91 | 771 (HOCOMOCO v11 database) |
| TF classification | 78 families | 82 families and 331 subfamilies (TFClass database, HOCOMOCO) |
| Analysis performed | Normal vs tumor samples | Group 1 vs group 2 |
| Statistical grouping | **Unsupervised** only | **Unsupervised** or **supervised** using labeled groups |
| TCGA data source | The Cancer Genome Atlas (TCGA) (not available) | The NCI’s Genomic Data Commons (GDC) |
| Genome of reference | GRCh37 (hg19) | GRCh37 (hg19)/GRCh38 (hg38) |
| DNA methylation platforms | HM450 | EPIC and HM450 |
| Graphical User Interface (GUI) | None | TCGAbiolinksGUI |
| Automatic report | None | HTML summarizing results |
| Annotations | None | StateHub |

## Supervised vs Unsupervised mode

In ELMER v2 we introduce a new concept, the algorithm `mode` that can be either `supervised` or `unsupervised`. In the unsupervised mode (described in ELMER v1), it is assumed that one of the two groups is a heterogeneous mix of different (sometimes unknown) molecular phenotypes. For instance, in the example of Breast Cancer, normal breast tissues (Group A) are relatively homogenous, whereas Breast tumors fall into multiple molecular subtypes.

The assumption of the Unsupervised mode is that methylation changes may be restricted to a subset of one or more molecular subtypes, and thus only be present in a fraction of the samples in the test group. For instance, methylation changes related to estrogen signaling may only be present in LuminalA or LuminalB subtypes.

When this structure is unknown, the Unsupervised mode is the appropriate model, since it only requires changes in a subset of samples (by default, 20%). In contrast, in the Supervised mode, it is assumed that each group represents a more homogenous molecular phenotype, and thus we compare all samples in Group A vs. all samples in Group B. This can be used in the case of direct comparison of tumor subtypes (i.e. Luminal vs. Basal-like tumors), but can also be used in numerous other situations, including sorted cells of different types, or treated vs. untreated samples in perturbation experiments.

# Installing and loading ELMER

To install this package from github (development version), start R and enter:

```
devtools::install_github(repo = "tiagochst/ELMER.data")
devtools::install_github(repo = "tiagochst/ELMER")
```

To install this package from Bioconductor start R and enter:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("ELMER")
```

Then, to load ELMER enter:

# Citing this work

If you used ELMER package or its results, please cite:

* Yao, L., Shen, H., Laird, P. W., Farnham, P. J., & Berman, B. P. “Inferring regulatory element landscapes and transcription factor networks from cancer methylomes.” Genome Biol 16 (2015): 105.
* Yao, Lijing, Benjamin P. Berman, and Peggy J. Farnham. “Demystifying the secret mission of enhancers: linking distal regulatory elements to target genes.” Critical reviews in biochemistry and molecular biology 50.6 (2015): 550-573.
* Tiago C Silva, Simon G Coetzee, Nicole Gull, Lijing Yao, Dennis J Hazelett, Houtan Noushmehr, De-Chen Lin, Benjamin P Berman; ELMER v.2: An R/Bioconductor package to reconstruct gene regulatory networks from DNA methylation and transcriptome profiles, Bioinformatics, , bty902, <https://doi.org/10.1093/bioinformatics/bty902>

If you get TCGA data using `getTCGA` function, please cite TCGAbiolinks package:

* Colaprico A, Silva TC, Olsen C, Garofano L, Cava C, Garolini D, Sabedot T, Malta TM, Pagnotta SM, Castiglioni I, Ceccarelli M, Bontempi G and Noushmehr H. “TCGAbiolinks: an R/Bioconductor package for integrative analysis of TCGA data.” Nucleic acids research (2015): gkv1507.
* Silva, TC, A Colaprico, C Olsen, F D’Angelo, G Bontempi, M Ceccarelli, and H Noushmehr. 2016. “TCGA Workflow: Analyze Cancer Genomics and Epigenomics Data Using Bioconductor Packages [Version 2; Referees: 1 Approved, 1 Approved with Reservations].” F1000Research 5 (1542). doi:10.12688/f1000research.8923.2.
* Grossman, Robert L., et al. “Toward a shared vision for cancer genomic data.” New England Journal of Medicine 375.12 (2016): 1109-1112.

If you get use the Graphical user interface, please cite `TCGAbiolinksGUI` package:

* Silva, Tiago C. and Colaprico, Antonio and Olsen, Catharina and Bontempi, Gianluca and Ceccarelli, Michele and Berman, Benjamin P. and Noushmehr, Houtan. “TCGAbiolinksGUI: A graphical user interface to analyze cancer molecular and clinical data” (bioRxiv 147496; doi: <https://doi.org/10.1101/147496>)

# Bugs and questions

If you have questions, wants to report a bug, please use our github repository: <http://www.github.com/tiagochst/ELMER>

# Paper supplemental material

TCGA-BRCA reports (paper supplemental material) can be found at <https://tiagochst.github.io/ELMER_supplemental/>

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