# MethylMix

### An R package for identifying DNA methylation driven genes

#### Olivier Gevaert Stanford Center for Biomedical Informatics Department of Medicine 1265 Welch Road Stanford CA, 94305-5479

#### 2025-10-30

##1. Getting started

**Installing the package.** To install the *MethylMix* package, the easiest way is through bioconductor:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install(MethylMix)
```

Other ways to install MethylMix is to first download the appropriate file for your platform from the Bioconductor website <http://www.bioconductor.org/>. For Windows, start R and select the `Packages` menu, then `Install package from local zip file`. Find and highlight the location of the zip file and click on `open`. For Linux/Unix, use the usual command `R CMD INSTALL` or install from bioconductor.

**Loading the package.** To load the `MethylMix` package in your R session, type `library(MethylMix)`.

**Help files.** Detailed information on `MethylMix` package functions can be obtained in the help files. For example, to view the help file for the function `MethylMix` in a R session, use `?MethylMix`.

##2. Introduction

DNA methylation is a mechanism whereby a methyl-group is added onto a CpG site. Methylation of these CpG sites is associated with gene silencing and is an important mechanism for normal tissue development and is often involved in diseases such as cancer. Recently, many high throughput data has been generated profiling CpG site methylation on a genome wide bases. This has created large amounts of data on DNA methylation for many disease. Computational analysis of DNA methylation data is required to identify potentiall aberrant DNA methylation compared to normal tissue. MethylMix (Gevaert 2015; Gevaert, Tibshirani & Plevritis 2015) was developed to tackle this question using a computational approach. MethylMix identifies differential and functional DNA methylation by using a beta mixture model to identify subpopulations of samples with different DNA methylation compared to normal tissue. Functional DNA methylation refers to a significant negative correlation based on matched gene expression data. Together MethylMix outputs hyper and hypomethylated genes which can be used for downstream analysis, and are called MethylMix drivers. MethylMix was designed for cis-regulated promoter differential methylation and works best when specific CpG sites are profiled associated with a gene. For example using data from the 27k and 450k Infinium platforms.

##3. Data access and preprocessing

The `MethylMix` package provides functions to access and preprocess data at The Cancer Genome Atlas (TCGA) portal. Given a cancer type indicated by TCGA’s code and a path to save downloaded files, all the download and preprocess of data can be executed with:

```
cancerSite <- "OV"
targetDirectory <- paste0(getwd(), "/")
GetData(cancerSite, targetDirectory)
```

All functions in the `MethylMix` package can be run in parallel, if the user provides a parallel set up, like the following:

```
cancerSite <- "OV"
targetDirectory <- paste0(getwd(), "/")

library(doParallel)
cl <- makeCluster(5)
registerDoParallel(cl)
GetData(cancerSite, targetDirectory)
stopCluster(cl)
```

The `GetData` function downloads DNA methylation data and gene expression. The methylation data is provided using 27k or 450k Illumina platforms. If both 27k and 450k files are found, the data is carefully combined. For gene expression, either microarray (Agilent), RNA sequencing data or both are available. The `MethylMix` package downloads RNA sequencing data for all cancer sites except for ovarian and gliobastoma cancer sites (few RNA-seq samples available). For the preprocessing of the data, we package perform missing value estimation and batch correction (using Combat). Finally, as in the TCGA case, when only probe level Illumina data is available, mapping probes to genes is recommended before building mixture models. This allows to focus on cis- regulated differential methylation by only focusing on differential methylation of CpG sites to their closest gene transcripts. Both the 27k and 450k Illumina platforms have database R packages that provide the necessary mapping information. We use the annotation to map probes to genes, before clustering the probes within each gene. This whole process can take a long time, depending of the size of the data.

It is also possible to perform each one of these task individually using other functions in the `MethylMix` package, as in the following example:

```
cancerSite <- "OV"
targetDirectory <- paste0(getwd(), "/")

cl <- makeCluster(5)
registerDoParallel(cl)

# Downloading methylation data
METdirectories <- Download_DNAmethylation(cancerSite, targetDirectory)
# Processing methylation data
METProcessedData <- Preprocess_DNAmethylation(cancerSite, METdirectories)
# Saving methylation processed data
saveRDS(METProcessedData, file = paste0(targetDirectory, "MET_", cancerSite, "_Processed.rds"))

# Downloading gene expression data
GEdirectories <- Download_GeneExpression(cancerSite, targetDirectory)
# Processing gene expression data
GEProcessedData <- Preprocess_GeneExpression(cancerSite, GEdirectories)
# Saving gene expression processed data
saveRDS(GEProcessedData, file = paste0(targetDirectory, "GE_", cancerSite, "_Processed.rds"))

# Clustering probes to genes methylation data
METProcessedData <- readRDS(paste0(targetDirectory, "MET_", cancerSite, "_Processed.rds"))
res <- ClusterProbes(METProcessedData[[1]], METProcessedData[[2]])

# Putting everything together in one file
toSave <- list(METcancer = res[[1]], METnormal = res[[2]], GEcancer = GEProcessedData[[1]],
    GEnormal = GEProcessedData[[2]], ProbeMapping = res$ProbeMapping)
saveRDS(toSave, file = paste0(targetDirectory, "data_", cancerSite, ".rds"))

stopCluster(cl)
```

For user supplied data not from TCGA, the user can provide DNA methylation beta-values(normal and cancer) and gene expression data in the form of a data.matrix object in R with the rows corresponding to the genes and the columns to the sample. Once the three matrices: METcancer, METnormal and GEnormal are created, the last step is to cluster the methylation data:

```
METcancer = matrix(data = methylation_data, nrow = nb_of_genes, ncol = nb_of_samples)
METnormal = matrix(data = methylation_data, nrow = nb_of_genes, ncol = nb_of_samples)
GEcancer = matrix(data = expression_data, nrow = nb_of_genes, ncol = nb_of_samples)
ClusterProbes(MET_Cancer, MET_Normal, CorThreshold = 0.4)
```

If the data contains batches, the user must provide numeric batch data within the matrices. MethylMix can be applied on all illumina arrays, including the newly released Epic platform and any array that outputs beta values. At the moment there are no restrictions to input sequencing-based methylation data, if the data is formatted in proportions however, as mixture modeling is computationally expensive, Methylmix will require more time to finish.

## 4. Data input for MethylMix

To run MethylMix three data sets of a particular disease are required. The first one is the methylation data for the disease samples, `METcancer`, which allows to identify methylation states associated with a disease for each gene of interest. The second is an appropriate normal or baseline methylation data, `METnormal`, which is used to distinguish between hyper or increased methylation vs. hypo or decreased methylation. Finally, the third data set is matched gene expression data for the disease samples, `GEcancer`, which is used to identify functional differnential methylation by focusing only on differentialy methylation that has a significant inversely correlated effect on gene expression.

Each of these three data sets are matrix objects with genes in the rows with unique rownames (e.g. gene symbols) and samples or patients in the columns with unique patient names. The `GetData` function described before saves an R object which contains these matrices in the correct format.

As example, small data sets from TCGA of gliobastoma samples are availabe in the `MethylMix` package:

```
library(MethylMix)
library(doParallel)
```

```
## Loading required package: foreach
```

```
## Loading required package: iterators
```

```
## Loading required package: parallel
```

```
data(METcancer)
data(METnormal)
data(GEcancer)
head(METcancer[, 1:4])
```

```
##        TCGA.02.0001 TCGA.02.0003 TCGA.02.0006 TCGA.02.0007
## ERBB2      0.066976     0.056493      0.16083     0.059322
## FAAH       0.251890     0.193620      0.29216     0.856140
## FNDC3B     0.691420     0.563600      0.54231     0.306230
## FOXD1      0.084173     0.091946      0.19121     0.752810
## HOXD10     0.511220     0.505300      0.50494     0.717150
## IRX2       0.308940     0.622350      0.50465     0.725770
```

```
head(METnormal)
```

```
##        X4321207019_B X4321207026_C X4321207042_E X4321207042_K
## ERBB2        0.14834      0.105520      0.088934      0.084731
## FAAH         0.21961      0.279150      0.196890      0.220890
## FNDC3B       0.76382      0.784840      0.796010      0.752130
## FOXD1        0.13591      0.074815      0.085960      0.088573
## HOXD10       0.20063      0.166590      0.162870      0.200730
## IRX2         0.12246      0.087822      0.073123      0.104640
```

```
head(GEcancer[, 1:4])
```

```
##        TCGA.02.0001 TCGA.02.0003 TCGA.02.0006 TCGA.02.0007
## ERBB2     -0.191840     -1.24440    -0.026743     1.524600
## FAAH      -0.075087     -0.70167    -0.580130    -1.237400
## FNDC3B     0.033780     -0.64668    -0.356230    -0.050206
## FOXD1      0.102790      0.11901     0.155030    -1.002300
## HOXD10     2.371300      3.07750     1.547000     2.330500
## IRX2      -1.575300     -3.83290    -1.599900    -4.688700
```

## 5. Running MethylMix

Using the example gliobastoma data provided in the package, `MethylMix` can be to identify hypo and hypermethylated genes run as follows:

```
MethylMixResults <- MethylMix(METcancer, GEcancer, METnormal)
```

```
## Found 251 samples with both methylation and expression data.
## Correlating methylation data with gene expression...
```

```
##
## Found 9 transcriptionally predictive genes.
##
## Starting Beta mixture modeling.
## Running Beta mixture model on 9 genes and on 251 samples.
## ERBB2 :  2  components are best.
## FAAH :  2  components are best.
## FOXD1 :  2  components are best.
## ME1 :  2  components are best.
## MGMT :  2  components are best.
## OAS1 :  2  components are best.
## SOX10 :  2  components are best.
## TRAF6 :  2  components are best.
## ZNF217 :  2  components are best.
```

Or in parallel:

```
library(doParallel)
cl <- makeCluster(5)
registerDoParallel(cl)
MethylMixResults <- MethylMix(METcancer, GEcancer, METnormal)
stopCluster(cl)
```

The output from the `MethylMix` function is a list with the following elements:

* `MethylationDrivers`: Genes identified as transcriptionally predictive and differentially methylated by MethylMix.
* `NrComponents`: The number of methylation states found for each driver gene.
* `MixtureStates`: A list with the DM-values for each driver gene.
* `MethylationStates`: Matrix with DM-values for all driver genes (rows) and all samples (columns).
* `Classifications`: Matrix with integers indicating to which mixture component each cancer sample was assigned to, for each gene.
* `Models`: Beta mixture model parameters for each driver gene.

Differential Methylation values (DM-values) are defined as the difference between the methylation mean in one mixture component of cancer samples and the methylation mean in the normal samples, for a given gene.

```
MethylMixResults$MethylationDrivers
```

```
## [1] "ERBB2"  "FAAH"   "FOXD1"  "ME1"    "MGMT"   "OAS1"   "SOX10"  "TRAF6"
## [9] "ZNF217"
```

```
MethylMixResults$NrComponents
```

```
##  ERBB2   FAAH  FOXD1    ME1   MGMT   OAS1  SOX10  TRAF6 ZNF217
##      2      2      2      2      2      2      2      2      2
```

```
MethylMixResults$MixtureStates
```

```
## $ERBB2
##          [,1]
## [1,] 0.000000
## [2,] 0.318555
##
## $FAAH
##           [,1]
## [1,] 0.0000000
## [2,] 0.3973068
##
## $FOXD1
##           [,1]
## [1,] 0.0000000
## [2,] 0.2217989
##
## $ME1
##           [,1]
## [1,] 0.1418296
## [2,] 0.5834757
##
## $MGMT
##           [,1]
## [1,] 0.0000000
## [2,] 0.3141419
##
## $OAS1
##            [,1]
## [1,] -0.3391054
## [2,]  0.0000000
##
## $SOX10
##           [,1]
## [1,] 0.0000000
## [2,] 0.2076643
##
## $TRAF6
##           [,1]
## [1,] 0.0000000
## [2,] 0.2452776
##
## $ZNF217
##            [,1]
## [1,] -0.1724214
## [2,]  0.1875210
```

```
MethylMixResults$MethylationStates[, 1:5]
```

```
##        TCGA.02.0001 TCGA.02.0003 TCGA.02.0006 TCGA.02.0007 TCGA.02.0009
## ERBB2     0.0000000    0.0000000    0.0000000    0.0000000    0.0000000
## FAAH      0.0000000    0.0000000    0.0000000    0.3973068    0.3973068
## FOXD1     0.0000000    0.0000000    0.2217989    0.2217989    0.2217989
## ME1       0.5834757    0.5834757    0.5834757    0.5834757    0.1418296
## MGMT      0.0000000    0.0000000    0.3141419    0.0000000    0.0000000
## OAS1     -0.3391054    0.0000000   -0.3391054   -0.3391054    0.0000000
## SOX10     0.2076643    0.2076643    0.2076643    0.2076643    0.2076643
## TRAF6     0.2452776    0.0000000    0.0000000    0.0000000    0.0000000
## ZNF217   -0.1724214   -0.1724214   -0.1724214   -0.1724214   -0.1724214
```

```
MethylMixResults$Classifications[, 1:5]
```

```
##        TCGA.02.0001 TCGA.02.0003 TCGA.02.0006 TCGA.02.0007 TCGA.02.0009
## ERBB2             1            1            1            1            1
## FAAH              1            1            1            2            2
## FOXD1             1            1            2            2            2
## ME1               2            2            2            2            1
## MGMT              1            1            2            1            1
## OAS1              1            2            1            1            2
## SOX10             2            2            2            2            2
## TRAF6             2            1            1            1            1
## ZNF217            1            1            1            1            1
```

```
# MethylMixResults$Models
```

## 6. Graphical output

The `MethylMix` package also provides functions to visually represent the findings:

```
# Plot the most famous methylated gene for glioblastoma
plots <- MethylMix_PlotModel("MGMT", MethylMixResults, METcancer)
plots$MixtureModelPlot
```

![](data:image/png;base64...)

```
# Plot MGMT also with its normal methylation variation
plots <- MethylMix_PlotModel("MGMT", MethylMixResults, METcancer, METnormal = METnormal)
plots$MixtureModelPlot
```

![](data:image/png;base64...)

```
# Plot a MethylMix model for another gene
plots <- MethylMix_PlotModel("ZNF217", MethylMixResults, METcancer, METnormal = METnormal)
plots$MixtureModelPlot
```

![](data:image/png;base64...)

```
# Also plot the inverse correlation with gene expression (creates two separate
# plots)
plots <- MethylMix_PlotModel("MGMT", MethylMixResults, METcancer, GEcancer, METnormal)
plots$MixtureModelPlot
plots$CorrelationPlot
```

![](data:image/png;base64...) ![](data:image/png;base64...)

```
# Plot all functional and differential genes
for (gene in MethylMixResults$MethylationDrivers) {
    MethylMix_PlotModel(gene, MethylMixResults, METcancer, METnormal = METnormal)
}
```

## 7. References

Gevaert O. MethylMix: an R package for identifying DNA methylation-driven genes. Bioinformatics (Oxford, England). 2015;31(11):1839-41. doi:10.1093/bioinformatics/btv020.

Gevaert O, Tibshirani R, Plevritis SK. Pancancer analysis of DNA methylation-driven genes using MethylMix. Genome Biology. 2015;16(1):17. doi:10.1186/s13059-014-0579-8.

Pierre-Louis Cedoz, Marcos Prunello, Kevin Brennan, Olivier Gevaert; MethylMix 2.0: an R package for identifying DNA methylation genes. Bioinformatics. doi:10.1093/bioinformatics/bty156.

## 8. Sesssion Info

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
## [1] parallel  stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
## [1] doParallel_1.0.17 iterators_1.0.14  foreach_1.5.2     MethylMix_2.40.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6       jsonlite_2.0.0     dplyr_1.1.4        compiler_4.5.1
##  [5] tidyselect_1.2.1   RPMM_1.25          dichromat_2.0-0.1  cluster_2.1.8.1
##  [9] jquerylib_0.1.4    scales_1.4.0       yaml_2.3.10        fastmap_1.2.0
## [13] ggplot2_4.0.0      R6_2.6.1           generics_0.1.4     knitr_1.50
## [17] tibble_3.3.0       bslib_0.9.0        pillar_1.11.1      RColorBrewer_1.1-3
## [21] rlang_1.1.6        cachem_1.1.0       xfun_0.53          sass_0.4.10
## [25] S7_0.2.0           cli_3.6.5          magrittr_2.0.4     formatR_1.14
## [29] digest_0.6.37      grid_4.5.1         lifecycle_1.0.4    vctrs_0.6.5
## [33] evaluate_1.0.5     glue_1.8.0         farver_2.1.2       codetools_0.2-20
## [37] rmarkdown_2.30     tools_4.5.1        pkgconfig_2.0.3    htmltools_0.5.8.1
```