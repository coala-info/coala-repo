[![]()](index.html)

# *AMARETTO*

#### Jayendra Shinde1, Celine Everaert2, Shaimaa Bakr1, Mohsen Nabian2, Jishu Xu2,Vincent Carey2, Nathalie Pochet2\*, Olivier Gevaert1\*\* 1 Stanford Center for Biomedical Informatics Research (BMIR), Department of Medicine and Biomedical Data Science, 1265 Welch Rd, Stanford, CA, USA 2 Brigham and Women’s Hospital, Harvard Medical School, Broad Institute of MIT and Harvard, Boston and Cambridge, MA, USA \*npochet@broadinstitute.org \*\*olivier.gevaert@stanford.edu

#### 29 October 2025

Please use [Github issues](https://github.com/gevaertlab/AMARETTO/issues) if you want to file bug reports or feature requests.

# Abstract

Integrating an increasing number of available multi-omics cancer data remains one of the main challenges to improve our understanding of cancer. One of the main challenges is using multi-omics data for identifying novel cancer driver genes. We have developed an algorithm, called AMARETTO, that integrates copy number, DNA methylation and gene expression data to identify a set of driver genes by analyzing cancer samples and connects them to clusters of co-expressed genes, which we define as modules. We applied AMARETTO in a pancancer setting to identify cancer driver genes and their modules on multiple cancer sites. AMARETTO captures modules enriched in angiogenesis, cell cycle and EMT, and modules that accurately predict survival and molecular subtypes. This allows AMARETTO to identify novel cancer driver genes directing canonical cancer pathways.

# Introduction

The package *AMARETTO* contains functions to use the statistical algorithm AMARETTO, an algorithm to identify cancer drivers by integrating a variety of omics data from cancer and normal tissue. Due to the increasing availability of multi-omics data sets, there is a need for computational methods that integrate multi-omics data set and create knowl-edge. Especially in the field of cancer research, large international projects such as The Cancer Genome Atlas (TCGA) and the International Cancer Genome Consortium (ICGC) are producing large quantities of multi-omics data for each cancer site. However it remains unknown which profile is the most meaningful and how to effciently integrate different omics profiles. AMARETTO is an algorithm to unravel cancer drivers by reducing the data dimensionality into cancer modules. AMARETTO first models the effects of genomic/epigenomic data on disease specific gene expression. AMARETTO’s second step involves constructing co-expressed modules to connect the cancer drivers with their downstream targets. We applied AMARETTO to several cancer sites of the TCGA project allowing to identify several cancer driver genes of interest, including novel genes in addition to known drivers of cancer. This package also includes functionality to access TCGA data directly so the user can immediately run AMARETTO on the most recent version of the data.

# Installation Instructions

To install AMARETTO first download the appropriate file for your platform from the Bioconductor website <http://www.bioconductor.org/>. For Windows, start R and select the Packages menu, then Install package from local zip file. Find and highlight the location of the zip file and click on open. For Linux/Unix, use the usual command R CMD INSTALL or install from bioconductor

The package can be installed from the GitHub repository :

```
#-------------------------------------------------------------------------------

install.packages("BiocManager",repos = "http://cran.us.r-project.org")
BiocManager::install("gevaertlab/AMARETTO")

#-------------------------------------------------------------------------------
```

Help files. Detailed information on AMARETTO package functions can be obtained in the help files. For example, to view the help file for the function AMARETTO in an R session, use ?AMARETTO.

# Data Input

AMARETTO combines gene expression, DNA copy number and DNA methylation data into co-expressed gene expression models. Ideally, we recommend a cohort of at least 100 samples for each of these three technologies, where for most patients all data modalities have to be present.AMARETTO can be run with your own data but when interested in TCGA data, AMARETTO can also download TCGA data for you, see the next section.

## Data Access

The data in this vignette is accessible at The Cancer Genome Atlas (TCGA) portal. A programmatic way of downloading data is through the firehose get tool developed by the broad institute (" <https://gdac.broadinstitute.org/>"). Firehose get provides a unified way to download data for all cancer sites and all platforms.

## Gene Expression and Copy Number Alterations

We have provided R functions that directly link with firehose get to download mRNA expression data and copy number data processed by GISTIC. Downloading TCGA data has been tested for twenty five cancer sites (Refer Appendix section for TCGA cancer codes)

We also added COADREAD as a combination of colon and rectal cancer, as reports have shown that both can be seen as a single disease. The cancer code is needed to download data from TCGA and one needs to decide on a target location to save the data locally in the TargetDirectory, e.g. the /Downloads/ folder on a mac.

```
#-------------------------------------------------------------------------------

library(AMARETTO)
TargetDirectory <- tempfile()# data download directory
CancerSite <- "LIHC"
DataSetDirectories <- AMARETTO_Download(CancerSite = CancerSite,
                                        TargetDirectory = TargetDirectory)

#-------------------------------------------------------------------------------
```

We recommend to use one TargetDirectory for all cancer sites, as this will save all data in one hierarchy is convenient when revisting results later on. The directory structure that is created will also include the data version history, so it is easy to report what version of the data is used. AMARETTO\_Download() downloads the data, extracts archives and provides the paths to the downloaded folder for preprocessing.

This is convenient when revisiting a data set because you want to redo-downstream analysis, but not the actual downloading. Running this way, will only set the data paths. The next step is preprocessing.

## DNA Methylation Data

DNA methylation data has to be run by MethylMix which is also computationally intensive and therefore we have chosen to provide add the MethylMix output to the AMARETTO package instead of processing the raw DNA methylation data. This functionality is available in the [MethylMix package](https://www.bioconductor.org/packages/release/bioc/html/MethylMix.html)

## Data Preprocessing

The data preprocessing step will take care of preprocessing the gene expression and DNA copy number data. Data preprocessing is done by Preprocess CancerSite which takes the CancerSite and the data set directories as parameters:

```
#-------------------------------------------------------------------------------
load("../inst/extdata/MethylStates.rda")
ProcessedData <- AMARETTO_Preprocess(DataSetDirectories = DataSetDirectories,
                                    BatchData = BatchData)

#-------------------------------------------------------------------------------
```

This function preprocessed the gene expression data and the DNA copy number data. For the gene expression data, different preprocessing is done for microarray and RNA sequencing data. This involves missing value estimation using K-nearest neighbors. Also genes or patients that have more than 10% missing values are removed. Next, batch correction is done using the Combat method. For certain cancer sites, the gene expression data is split up in separate sub-data sets. This function first uses the preprocessing pipeline on each sub-data set separately and combines the data afterwards. For the DNA copy number data, the GISTIC algorithm output data is used. All genes that are in amplifications or deletions based on GISTIC output are extracted and the segmented DNA copy number data is stored. The segmented DNA copy number data is also batch corrected using Combat.

# Running AMARETTO

In the case that you run AMARETTO with your own data, three data matrices are needed with preprocessed gene expression, DNA copy number and DNA methylation data, where genes are in the rows and patients are in the columns. Once you have your own data in this format or using a previously downloaded TCGA data set, you can start doing analysis with AMARETTO. First, we need to initialize the algorithm by clustering the gene expression data and creating the regulator data object. This is done by the AMARETTO Initialize function and the TCGA LIHC data set:

```
#-------------------------------------------------------------------------------

AMARETTOinit <- AMARETTO_Initialize(ProcessedData = ProcessedDataLIHC,
                                    NrModules = 2, VarPercentage = 50)

#-------------------------------------------------------------------------------
```

Besides the three data sets, you need to decide how many modules to build and how much of the gene expression data is going to be used. For a first run we recommend 100 modules and to use the top 25% most varying genes. The AMARETTOinit object now contains cluster information to initialize an AMARETTO run and also stores the parameters that are required for AMARETTO. Now we can run AMARETTO as follows:

```
#-------------------------------------------------------------------------------

AMARETTOresults <- AMARETTO_Run(AMARETTOinit = AMARETTOinit)

#-------------------------------------------------------------------------------
```

This can take anywhere from 10 minutes up to 1 hour to build the modules for the TCGA cohorts depending on the number of genes that is modeled and the number of patients that is available. The breast cancer data set (BRCA) is the largest data set and will take the longest time to converge. AMARETTO will stop when less than 1% of the genes are reassigned to other modules. Next, one can test the AMARETTO model on the training set by calculating the Rsquare for each module using the AMARETTO EvaluateTestSet function:

```
#-------------------------------------------------------------------------------

AMARETTOtestReport <- AMARETTO_EvaluateTestSet(
                      AMARETTOresults = AMARETTOresults,
                      MA_Data_TestSet = AMARETTOinit$MA_matrix_Var,
                      RegulatorData_TestSet = AMARETTOinit$RegulatorData
                      )

#-------------------------------------------------------------------------------
```

This function will use the training data to calculate the performance for predicting genes expression values based on the selected regulators. Of course, it is more interesting to use an independent test set. In this case only a gene expression data set is needed, for example from the GEO database. This will allow to check how well the AMARETTO modules are generalizing to new data. Take care that the an independent data set needs to be centered and scaled to unit variance. The AMARETTOtestReport will also give information of how many regulators and cluster members are actually present. The Rsquare performance has to be interpreted in this context as if many regulators are absent in the test data set due to platform limitations, the performance will be adversely affected. Finally, modules can be visualized using the AMARETTO VisualizeModule function:

```
#-------------------------------------------------------------------------------
ModuleNr <- 1 #define the module number to visualize

AMARETTO_VisualizeModule(AMARETTOinit = AMARETTOinit,
                         AMARETTOresults = AMARETTOresults,
                         ProcessedData = ProcessedDataLIHC,
                         ModuleNr = ModuleNr)
```

```
## Module 1 has 280 genes and 7 regulators for 45 samples.
## [1] "TCGA-G3-A5SK-01" "TCGA-CC-A123-01"
## [1] 804
## [1] 2
## [1] "MET regulators will be included when available"
## [1] "CNV regulators will be included when available"
```

![](data:image/png;base64...)

Additionaly, to a standard version of the heatmap, one can add sample annotations to interogate biological phenotypes.

# HTML Report of AMARETTO

To retrieve heatmaps for all of the modules and additional tables with gene set enrichment data one can run a HTML report.

```
#-------------------------------------------------------------------------------

gmt_file<-system.file("templates/H.C2CP.genesets.gmt",package="AMARETTO")
AMARETTO_HTMLreport(AMARETTOinit = AMARETTOinit,,
                    AMARETTOresults = AMARETTOresults,
                    ProcessedData = ProcessedDataLIHC,
                    hyper_geo_test_bool = TRUE,
                    hyper_geo_reference = gmt_file,
                    MSIGDB=TRUE)

#-------------------------------------------------------------------------------
```

# References

1. Champion, M. et al. Module Analysis Captures Pancancer Genetically and Epigenetically Deregulated Cancer Driver Genes for Smoking and Antiviral Response. EBioMedicine 27, 156–166 (2018).
2. Gevaert, O., Villalobos, V., Sikic, B. I. & Plevritis, S. K. Identification of ovarian cancer driver genes by using module network integration of multi-omics data. Interface Focus 3, 20130013–20130013 (2013).
3. Gevaert, O. MethylMix: an R package for identifying DNA methylation-driven genes. Bioinformatics 31, 1839–1841 (2015).

# Appendix

| TCGA\_codes | TCGA\_cancers |
| --- | --- |
| BLCA | bladder urothelial carcinoma |
| BRCA | breast invasive carcinoma |
| CESC | cervical squamous cell carcinoma and endocervical adenocarcinoma |
| CHOL | cholangiocarcinoma |
| COAD | colon adenocarcinoma |
| ESCA | esophageal carcinoma |
| GBM | glioblastoma multiforme |
| HNSC | head and neck squamous cell carcinoma |
| KIRC | kidney renal clear cell carcinoma |
| KIRP | kidney renal papillary cell carcinoma |
| LAML | acute myeloid leukemia |
| LGG | brain lower grade glioma |
| LIHC | liver hepatocellular carcinoma |
| LUAD | lung adenocarcinoma |
| LUSC | lung squamous cell carcinoma |
| OV | arian serous cystadenocarcinoma |
| PAAD | pancreatic adenocarcinoma |
| PCPG | pheochromocytoma and paraganglioma |
| READ | rectum adenocarcinoma |
| SARC | sarcoma |
| STAD | stomach adenocarcinoma |
| THCA | thyroid carcinoma |
| THYM | thymoma |
| UCEC | endometrial carcinoma |

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
## [1] grid      parallel  stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
## [1] glmnet_4.1-10         Matrix_1.7-4          AMARETTO_1.26.0
## [4] ComplexHeatmap_2.26.0 dplyr_1.1.4           doParallel_1.0.17
## [7] iterators_1.0.14      foreach_1.5.2         impute_1.84.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3                   gridExtra_2.3
##   [3] httr2_1.2.1                 rlang_1.1.6
##   [5] magrittr_2.0.4              clue_0.3-66
##   [7] GetoptLong_1.0.5            matrixStats_1.5.0
##   [9] compiler_4.5.1              RSQLite_2.4.3
##  [11] reshape2_1.4.4              png_0.1-8
##  [13] callr_3.7.6                 vctrs_0.6.5
##  [15] stringr_1.5.2               pkgconfig_2.0.3
##  [17] shape_1.4.6.1               crayon_1.5.3
##  [19] fastmap_1.2.0               magick_2.9.0
##  [21] dbplyr_2.5.1                XVector_0.50.0
##  [23] rmarkdown_2.30              curatedTCGAData_1.31.3
##  [25] tzdb_0.5.0                  ps_1.9.1
##  [27] bit_4.6.0                   xfun_0.53
##  [29] MultiAssayExperiment_1.36.0 cachem_1.1.0
##  [31] jsonlite_2.0.0              blob_1.2.4
##  [33] DelayedArray_0.36.0         cluster_2.1.8.1
##  [35] R6_2.6.1                    stringi_1.8.7
##  [37] bslib_0.9.0                 RColorBrewer_1.1-3
##  [39] limma_3.66.0                GenomicRanges_1.62.0
##  [41] jquerylib_0.1.4             Rcpp_1.1.0
##  [43] Seqinfo_1.0.0               SummarizedExperiment_1.40.0
##  [45] knitr_1.50                  readr_2.1.5
##  [47] IRanges_2.44.0              BiocBaseUtils_1.12.0
##  [49] splines_4.5.1               tidyselect_1.2.1
##  [51] dichromat_2.0-0.1           abind_1.4-8
##  [53] yaml_2.3.10                 codetools_0.2-20
##  [55] curl_7.0.0                  processx_3.8.6
##  [57] plyr_1.8.9                  lattice_0.22-7
##  [59] tibble_3.3.0                withr_3.0.2
##  [61] Biobase_2.70.0              KEGGREST_1.50.0
##  [63] S7_0.2.0                    evaluate_1.0.5
##  [65] survival_3.8-3              BiocFileCache_3.0.0
##  [67] circlize_0.4.16             ExperimentHub_3.0.0
##  [69] Biostrings_2.78.0           pillar_1.11.1
##  [71] BiocManager_1.30.26         filelock_1.0.3
##  [73] MatrixGenerics_1.22.0       DT_0.34.0
##  [75] stats4_4.5.1                generics_0.1.4
##  [77] hms_1.1.4                   BiocVersion_3.22.0
##  [79] S4Vectors_0.48.0            ggplot2_4.0.0
##  [81] scales_1.4.0                BiocStyle_2.38.0
##  [83] glue_1.8.0                  tools_4.5.1
##  [85] AnnotationHub_4.0.0         Cairo_1.7-0
##  [87] AnnotationDbi_1.72.0        colorspace_2.1-2
##  [89] cli_3.6.5                   rappdirs_0.3.3
##  [91] S4Arrays_1.10.0             gtable_0.3.6
##  [93] sass_0.4.10                 digest_0.6.37
##  [95] BiocGenerics_0.56.0         SparseArray_1.10.0
##  [97] rjson_0.2.23                htmlwidgets_1.6.4
##  [99] farver_2.1.2                memoise_2.0.1
## [101] htmltools_0.5.8.1           lifecycle_1.0.4
## [103] httr_1.4.7                  statmod_1.5.1
## [105] GlobalOptions_0.1.2         bit64_4.6.0-1
```