[[![](data:image/png;base64...)](http://bioconductor.org/packages/TCGAbiolinks/)](index.html)

* [Introduction](index.html)
* Data

  + Molecular data
  + [Query](query.html)
  + [Download & Prepare](download_prepare.html)
  + Other data
  + [Clinical data](clinical.html)
  + [Mutation data](mutation.html)
  + [Molecular subtypes](subtypes.html)
  + [ATAC-seq](http://rpubs.com/tiagochst/atac_seq_workshop)
* Analysis

  + [Analysis functions](analysis.html)
  + [Other functions](extension.html)
  + [Importing data to DESeq2](http://rpubs.com/tiagochst/TCGAbiolinks_to_DESEq2)
  + [Glioma classsifier](classifiers.html)
* [Case Study](casestudy.html)

* Workshops
  + TCGA workshop
  + [Workshop - TCGA data analysis](http://rpubs.com/tiagochst/TCGAworkshop)
  + ELMER workshop
  + [Workshop for multi-omics analysis with ELMER](http://rpubs.com/tiagochst/ELMER_workshop)
  + ATAC-Seq workshop
  + [Workshop for ATAC-Seq analysis](http://rpubs.com/tiagochst/atac_seq_workshop)
  + Bioc2017 workshop
  + [Github ELMER/TCGAbiolinks](https://github.com/BioinformaticsFMRP/Bioc2017.TCGAbiolinks.ELMER)
* + TCGAbiolinks package
  + [Github](https://github.com/BioinformaticsFMRP/TCGAbiolinks)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/TCGAbiolinks.html)
  + TCGAbiolinksGUI package
  + [Github](https://github.com/BioinformaticsFMRP/TCGAbiolinksGUI)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/TCGAbiolinksGUI.html)
  + ELMER package
  + [Github](https://github.com/tiagochst/ELMER)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/ELMER.html)
  + ELMER.data package
  + [Github](https://github.com/tiagochst/ELMER)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/ELMER.html)
* + University of São Paulo (USP)
  + [fmrp.usp.br](http://www.fmrp.usp.br/?lang=en)
  + Fundings
  + [FAPESP (16/10436-9)](http://www.bv.fapesp.br/en/pesquisa/?sort=-data_inicio&q2=%28instituicao%3A%22Cedars-Sinai+Medical+Center%22%29+AND+%28%28bolsa_en_exact%3A%22Scholarships+abroad%22+AND+situacao_en_exact%3A%22Ongoing%22%29%29)
  + [FAPESP (16/01389-7)](http://bv.fapesp.br/en/pesquisa/?sort=-data_inicio&q2=%28id_pesquisador_exact%3A679917%29+AND+%28%28bolsa_en_exact%3A%22Scholarships+in+Brazil%22+AND+situacao_en_exact%3A%22Ongoing%22%29%29)

# Compilation of TCGA molecular subtypes

TCGAbiolinks retrieved molecular subtypes information from TCGA samples. The functions `PanCancerAtlas_subtypes` and `TCGAquery_subtype` can be used to get the information tables.

While the `PanCancerAtlas_subtypes` function gives access to a curated table retrieved from synapse (probably with the most updated molecular subtypes) the `TCGAquery_subtype` function has the complete table also with sample information retrieved from the TCGA marker papers.

# `PanCancerAtlas_subtypes`: Curated molecular subtypes.

Data and description retrieved from synapse (<https://www.synapse.org/#!Synapse:syn8402849>)

Synapse has published a single file with all available molecular subtypes that have been described by TCGA (all tumor types and all molecular platforms), which can be accessed using the `PanCancerAtlas_subtypes` function as below:

```
subtypes <- PanCancerAtlas_subtypes()
DT::datatable(
    data = subtypes,
    filter = 'top',
    options = list(scrollX = TRUE, keys = TRUE, pageLength = 5),
    rownames = FALSE
)
```

The columns “Subtype\_Selected” was selected as most prominent subtype classification (from the other columns)

|  | All available molecular data based-subtype | Selected subtype | Number of samples | Link to file | Reference | link to paper |
| --- | --- | --- | --- | --- | --- | --- |
| ACC | mRNA, DNAmeth, protein, miRNA, CNA, COC, C1A.C1B | DNAmeth | 91 | [Link](http://www.cell.com/cms/attachment/2062093088/2063584534/mmc3.xlsx) | Cancer Cell 2016 | [Link](http://www.cell.com/cancer-cell/fulltext/S1535-6108%2816%2930160-X) |
| AML | mRNA and miRNA | mRNA | 187 | [Link](https://tcga-data.nci.nih.gov/docs/publications/laml_2012/TCGA.LAML.cNMF-clustering.20140820.xlsx) | NEJM 2013 | [Link](http://www.nejm.org/doi/full/10.1056/NEJMoa1301689) |
| BLCA | mRNA subtypes | mRNA | 129 | [Link](https://tcga-data.nci.nih.gov/docs/publications/blca_2013/BLCA_cluster-assign-k4.tsv) | Nature 2014 | [Link](http://www.nature.com/nature/journal/v507/n7492/full/nature12965.html) |
| BRCA | PAM50 (mRNA) | PAM50 | 1218 | [Link](https://www.synapse.org/#!Synapse:syn3853594) | Nature 2012 | [Link](http://www.nature.com/nature/journal/v490/n7418/full/nature11412.html#close) |
| GBM/LGG\* | mRNA, DNAmeth, protein, Supervised\_DNAmeth | Supervised\_DNAmeth | 1122 | [Link](http://www.cell.com/cms/attachment/2045372863/2056783242/mmc2.xlsx) | Cell 2016 | [Link](http://www.cell.com/cell/abstract/S0092-8674%2815%2901692-X) |
| Pan-GI (preliminary) ESCA/STAD/COAD/READ | Molecular\_Subtype | Molecular\_Subtype | 1011 | [Link](https://www.cell.com/cms/10.1016/j.ccell.2018.03.010/attachment/f1963baa-114d-4bb6-9595-0854aec15dbf/mmc2.xlsx) | Cancer Cell 2018 | [Link](https://doi.org/10.1016/j.ccell.2018.03.010) |
| HNSC | mRNA, DNAmeth, RPPA, miRNA, CNA, Paradigm | mRNA | 279 | [Link](http://www.nature.com/nature/journal/v517/n7536/extref/nature14129-s2.zip) (TabS7.2) | Nature 2015 | [Link](http://www.nature.com/nature/journal/v517/n7536/full/nature14129.html) |
| KICH | Eosinophilic | Eosinophilic | 66 | [Link](https://www.synapse.org/#!Synapse:syn4463858) | Cancer Cell 2014 | [Link](http://www.cell.com/cancer-cell/abstract/S1535-6108%2814%2900304-3) |
| KIRC | mRNA, miRNA | mRNA | 442 | [Link](http://www.nature.com/nature/journal/v499/n7456/extref/nature12222-s2.zip) | Nature 2013 | [Link](http://www.nature.com/nature/journal/v499/n7456/full/nature12222.html) |
| KIRP | mRNA, DNAmeth, protein, miRNA, CNA, COC | COC | 161 | [Link](http://www.nejm.org/doi/suppl/10.1056/NEJMoa1505917/suppl_file/nejmoa1505917_appendix_3.xlsx) | NEJM 2015 | [Link](http://www.nejm.org/doi/full/10.1056/NEJMoa1505917#t=article) |
| LIHC (preliminary) | mRNA, DNAmeth, protein, miRNA, CNA, Paradigma, iCluster | iCluster | 196 | [Link](https://wiki.nci.nih.gov/download/attachments/139067884/Supplementary%20Tables-1-2016.xlsx?version=1&modificationDate=1452270515000&api=v2) (Table S1A) | not published |  |
| LUAD | DNAmeth, iCluster | iCluster | 230 | [Link](http://www.nature.com/nature/journal/v511/n7511/extref/nature13385-s2.xlsx) (Table S7) | Nature 2014 | [Link](http://www.nature.com/nature/journal/v511/n7511/full/nature13385.html) |
| LUSC | mRNA | mRNA | 178 | [Link](http://www.nature.com/nature/journal/v489/n7417/extref/nature11404-s2.zip) (Data file S7.5) | Nature 2012 | [Link](http://www.nature.com/nature/journal/v489/n7417/full/nature11404.html) |
| OVCA | mRNA | mRNA | 489 | [Link](https://www.synapse.org/#!Synapse:syn4213428) | Nature 2011 | [Link](http://www.nature.com/nature/journal/v474/n7353/full/nature10166.html) |
| PCPG | mRNA, DNAmeth, protein, miRNA, CNA | mRNA | 178 | tableS2 | Cancer Cell 2017 | [Link](http://www.cell.com/cancer-cell/fulltext/S1535-6108%2817%2930001-6) |
| PRAD | mRNA, DNAmeth, protein, miRNA, CNA, icluster, mutation/fusion | mutation/fusion | 333 | [Link](http://www.cell.com/cms/attachment/2062406705/2064289081/mmc2.xls) | Cell 2015 | [Link](http://www.cell.com/cell/abstract/S0092-8674%2815%2901339-2) |
| SKCM | mRNA, DNAmeth, protein, miRNA, mutation | mutation | 331 | [Link](http://www.cell.com/cms/attachment/2048142118/2058244319/mmc2.xlsx) (Table S1D) | Cell 2015 | [Link](http://www.cell.com/cell/abstract/S0092-8674%2815%2900634-0) |
| THCA | mRNA, DNAmeth, protein, miRNA, CNA, histology | mRNA | 496 | [Link](http://www.cell.com/cms/attachment/2019646612/2039684990/mmc3.xlsx) (Table S2 - Tab1) | Cell 2014 | [Link](http://www.cell.com/cell/fulltext/S0092-8674%2814%2901238-0) |
| UCEC | iCluster, MSI, CNA, mRNA | iCluster - updated according to Pan-Gyne/Pathways groups | 538 | [Link](http://www.nature.com/nature/journal/v497/n7447/extref/nature12113-s2.zip) (datafile S1.1) | Nature 2013 | [Link](http://www.nature.com/nature/journal/v497/n7447/full/nature12113.html) |
|  |  |  |  | [Link](https://docs.google.com/spreadsheets/d/1Z1H3mXdO_sk9nc0v8df7VNS_XzXiu6vKGJRbK1qYoh4/edit#gid=2047911448) |  |  |
| UCS (preliminary) | mRNA | mRNA | 57 | [Link](https://www.synapse.org/#!Synapse:syn4214438) | not published |  |

# `TCGAquery_subtype`: Working with molecular subtypes data.

The Cancer Genome Atlas (TCGA) Research Network has reported integrated genome-wide studies of various diseases. We have added some of the subtypes defined by these report in our package:

| TCGA dataset | Link | Paper | Journal |
| --- | --- | --- | --- |
| ACC | doi:10.1016/j.ccell.2016.04.002 | Comprehensive Pan-Genomic Characterization of Adrenocortical Carcinoma. | Cancer cell 2016 |
| BRCA | [https://www.cell.com/cancer-cell/fulltext/S1535-6108(18)30119-3](https://www.cell.com/cancer-cell/fulltext/S1535-6108%2818%2930119-3) | A Comprehensive Pan-Cancer Molecular Study of Gynecologic and Breast Cancers | Cancer cell 2018 |
| BLCA | [http://www.cell.com/cell/fulltext/S0092-8674(17)31056-5](http://www.cell.com/cell/fulltext/S0092-8674%2817%2931056-5) | Comprehensive Molecular Characterization of Muscle-Invasive Bladder Cancer Cell 2017 |  |
| CHOL | <http://www.sciencedirect.com/science/article/pii/S2211124717302140?via%3Dihub> | Integrative Genomic Analysis of Cholangiocarcinoma Identifies Distinct IDH-Mutant Molecular Profiles | Cell Reports 2017 |
| COAD | <http://www.nature.com/nature/journal/v487/n7407/abs/nature11252.html> | Comprehensive molecular characterization of human colon and rectal cancer | Nature 2012 |
| ESCA | <https://www.nature.com/articles/nature20805> | Integrated genomic characterization of oesophageal carcinoma | Nature 2017 |
| GBM | <http://dx.doi.org/10.1016/j.cell.2015.12.028> | Molecular Profiling Reveals Biologically Discrete Subsets and Pathways of Progression in Diffuse Glioma | Cell 2016 |
| HNSC | <http://www.nature.com/nature/journal/v517/n7536/abs/nature14129.html> | Comprehensive genomic characterization of head and neck squamous cell carcinomas | Nature 2015 |
| KICH | <http://www.sciencedirect.com/science/article/pii/S1535610814003043> | The Somatic Genomic Landscape of Chromophobe Renal Cell Carcinoma | Cancer cell 2014 |
| KIRC | <http://www.nature.com/nature/journal/v499/n7456/abs/nature12222.html> | Comprehensive molecular characterization of clear cell renal cell carcinoma | Nature 2013 |
| KIRP | <http://www.nejm.org/doi/full/10.1056/NEJMoa1505917> | Comprehensive Molecular Characterization of Papillary Renal-Cell Carcinoma | NEJM 2016 |
| LIHC | [http://linkinghub.elsevier.com/retrieve/pii/S0092-8674(17)30639-6](http://linkinghub.elsevier.com/retrieve/pii/S0092-8674%2817%2930639-6) | Comprehensive and Integrative Genomic Characterization of Hepatocellular Carcinoma | Cell 2017 |
| LGG | <http://dx.doi.org/10.1016/j.cell.2015.12.028> | Molecular Profiling Reveals Biologically Discrete Subsets and Pathways of Progression in Diffuse Glioma | Cell 2016 |
| LUAD | <http://www.nature.com/nature/journal/v511/n7511/abs/nature13385.html> | Comprehensive molecular profiling of lung adenocarcinoma | Nature 2014 |
| LUSC | <http://www.nature.com/nature/journal/v489/n7417/abs/nature11404.html> | Comprehensive genomic characterization of squamous cell lung cancers | Nature 2012 |
| PAAD | [http://www.cell.com/cancer-cell/fulltext/S1535-6108(17)30299-4](http://www.cell.com/cancer-cell/fulltext/S1535-6108%2817%2930299-4) | Integrated Genomic Characterization of Pancreatic Ductal Adenocarcinoma | Cancer Cell 2017 |
| PCPG | <http://dx.doi.org/10.1016/j.ccell.2017.01.001> | Comprehensive Molecular Characterization of Pheochromocytoma and Paraganglioma | Cancer cell 2017 |
| PRAD | <http://www.sciencedirect.com/science/article/pii/S0092867415013392> | The Molecular Taxonomy of Primary Prostate Cancer | Cell 2015 |
| READ | <http://www.nature.com/nature/journal/v487/n7407/abs/nature11252.html> | Comprehensive molecular characterization of human colon and rectal cancer | Nature 2012 |
| SARC | [http://www.cell.com/cell/fulltext/S0092-8674(17)31203-5](http://www.cell.com/cell/fulltext/S0092-8674%2817%2931203-5) | Comprehensive and Integrated Genomic Characterization of Adult Soft Tissue Sarcomas | Cell 2017 |
| SKCM | <http://www.sciencedirect.com/science/article/pii/S0092867415006340> | Genomic Classification of Cutaneous Melanoma | Cell 2015 |
| STAD | <http://www.nature.com/nature/journal/v511/n7511/abs/nature13385.html> | Comprehensive molecular characterization of gastric adenocarcinoma | Nature 2013 |
| THCA | <http://www.sciencedirect.com/science/article/pii/S0092867414012380> | Integrated Genomic Characterization of Papillary Thyroid Carcinoma | Cell 2014 |
| UCEC | <http://www.nature.com/nature/journal/v497/n7447/abs/nature12113.html> | Integrated genomic characterization of endometrial carcinoma | Nature 2013 |
| UCS | [http://www.cell.com/cancer-cell/fulltext/S1535-6108(17)30053-3](http://www.cell.com/cancer-cell/fulltext/S1535-6108%2817%2930053-3) | Integrated Molecular Characterization of Uterine Carcinosarcoma Cancer | Cell 2017 |
| UVM | [http://www.cell.com/cancer-cell/fulltext/S1535-6108(17)30295-7](http://www.cell.com/cancer-cell/fulltext/S1535-6108%2817%2930295-7) | Integrative Analysis Identifies Four Molecular and Clinical Subsets in Uveal Melanoma | Cancer Cell 2017 |

These subtypes will be automatically added in the summarizedExperiment object through GDCprepare. But you can also use the `TCGAquery_subtype` function to retrieve this information.

```
lgg.gbm.subtype <- TCGAquery_subtype(tumor = "lgg")
```

```
## lgg subtype information from:doi:10.1016/j.cell.2015.12.028
```

A subset of the LGG subytpe is shown below:

# Session Information

---

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
## [1] grid      stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] maftools_2.26.0             jpeg_0.1-11
##  [3] png_0.1-8                   DT_0.34.0
##  [5] dplyr_1.1.4                 SummarizedExperiment_1.40.0
##  [7] Biobase_2.70.0              GenomicRanges_1.62.0
##  [9] Seqinfo_1.0.0               IRanges_2.44.0
## [11] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [13] generics_0.1.4              MatrixGenerics_1.22.0
## [15] matrixStats_1.5.0           TCGAbiolinks_2.38.0
## [17] testthat_3.2.3
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          rstudioapi_0.17.1
##   [3] jsonlite_2.0.0              magrittr_2.0.4
##   [5] GenomicFeatures_1.62.0      farver_2.1.2
##   [7] rmarkdown_2.30              BiocIO_1.20.0
##   [9] fs_1.6.6                    vctrs_0.6.5
##  [11] Rsamtools_2.26.0            memoise_2.0.1
##  [13] RCurl_1.98-1.17             htmltools_0.5.8.1
##  [15] S4Arrays_1.10.0             usethis_3.2.1
##  [17] progress_1.2.3              curl_7.0.0
##  [19] SparseArray_1.10.0          sass_0.4.10
##  [21] bslib_0.9.0                 htmlwidgets_1.6.4
##  [23] desc_1.4.3                  fontawesome_0.5.3
##  [25] plyr_1.8.9                  httr2_1.2.1
##  [27] cachem_1.1.0                GenomicAlignments_1.46.0
##  [29] lifecycle_1.0.4             pkgconfig_2.0.3
##  [31] Matrix_1.7-4                R6_2.6.1
##  [33] fastmap_1.2.0               digest_0.6.37
##  [35] ShortRead_1.68.0            AnnotationDbi_1.72.0
##  [37] ps_1.9.1                    rprojroot_2.1.1
##  [39] pkgload_1.4.1               crosstalk_1.2.2
##  [41] RSQLite_2.4.3               hwriter_1.3.2.1
##  [43] filelock_1.0.3              httr_1.4.7
##  [45] abind_1.4-8                 compiler_4.5.1
##  [47] remotes_2.5.0               bit64_4.6.0-1
##  [49] withr_3.0.2                 downloader_0.4.1
##  [51] S7_0.2.0                    BiocParallel_1.44.0
##  [53] DBI_1.2.3                   pkgbuild_1.4.8
##  [55] R.utils_2.13.0              biomaRt_2.66.0
##  [57] rappdirs_0.3.3              DelayedArray_0.36.0
##  [59] sessioninfo_1.2.3           rjson_0.2.23
##  [61] DNAcopy_1.84.0              tools_4.5.1
##  [63] chromote_0.5.1              otel_0.2.0
##  [65] R.oo_1.27.1                 glue_1.8.0
##  [67] restfulr_0.0.16             promises_1.4.0
##  [69] gtable_0.3.6                tzdb_0.5.0
##  [71] R.methodsS3_1.8.2           tidyr_1.3.1
##  [73] websocket_1.4.4             data.table_1.17.8
##  [75] hms_1.1.4                   xml2_1.4.1
##  [77] XVector_0.50.0              pillar_1.11.1
##  [79] stringr_1.5.2               vroom_1.6.6
##  [81] later_1.4.4                 splines_4.5.1
##  [83] BiocFileCache_3.0.0         lattice_0.22-7
##  [85] deldir_2.0-4                rtracklayer_1.70.0
##  [87] aroma.light_3.40.0          survival_3.8-3
##  [89] bit_4.6.0                   tidyselect_1.2.1
##  [91] Biostrings_2.78.0           knitr_1.50
##  [93] xfun_0.54                   devtools_2.4.6
##  [95] brio_1.1.5                  stringi_1.8.7
##  [97] yaml_2.3.10                 cigarillo_1.0.0
##  [99] TCGAbiolinksGUI.data_1.30.0 evaluate_1.0.5
## [101] codetools_0.2-20            interp_1.1-6
## [103] EDASeq_2.44.0               archive_1.1.12
## [105] tibble_3.3.0                BiocManager_1.30.26
## [107] cli_3.6.5                   processx_3.8.6
## [109] jquerylib_0.1.4             dichromat_2.0-0.1
## [111] Rcpp_1.1.0                  dbplyr_2.5.1
## [113] XML_3.99-0.19               parallel_4.5.1
## [115] ellipsis_0.3.2              ggplot2_4.0.0
## [117] readr_2.1.5                 blob_1.2.4
## [119] prettyunits_1.2.0           latticeExtra_0.6-31
## [121] bitops_1.0-9                pwalign_1.6.0
## [123] scales_1.4.0                purrr_1.1.0
## [125] crayon_1.5.3                BiocStyle_2.38.0
## [127] rlang_1.1.6                 KEGGREST_1.50.0
## [129] rvest_1.0.5
```