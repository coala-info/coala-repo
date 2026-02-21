# scmeth Vignette

#### Divy S. Kangeyan

#### 2025-10-30

## Contents

1. Introduction
2. Installation
3. Input files
4. Usage

   4.1 Report

   4.2 Functions

---

## 1. Introduction

Though a small chemical change in the genome, DNA methylation has significant impact in several diseases, developmental processes and other biological changes. Hence methylation data should be analyzed carefully to gain biological insights. **scmeth** package offers a few functions to assess the quality of the methylation data.

This bioconductor package contains functions to perform quality control and preprocessing analysis for single-cell methylation data. *scmeth* is especially customized to be used with the output from the FireCloud implementation of methylation pipeline. In addition to individual functions, **report** function in the package provides all inclusive report using most of the functions. If users prefer they can just use the **report** function to gain summary of their data.

## 2. Installation and package loading

**scmeth** is available in bioconductor and can be downloaded using the following commands

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("scmeth")
```

Load the package

```
library(scmeth)
```

## 3. Input files

Main input for most of the function is a *bsseq* object. In the FireCloud implementation it is stored as hdf5 file which can be read via *loadHDF5SummarizedExperiment* function in *HDF5Array* package. Code chunk below shows how it can be loaded.

```
directory <- system.file("extdata", "bismark_data", package='scmeth')
bsObject <- HDF5Array::loadHDF5SummarizedExperiment(directory)
```

## 4. Usage

## 4.1 Report

A comprehensive quality control report can be generated in the package via **report** function. report function takes the bs object, the directory where the report should be saved, organism that this data is obtained from and the genomic build. Following is an example usage of the **report** function.

**report** function also takes two optional arguments: *subSample* and *offset*. With subsample parameter users can choose how many CpGs to consider in the analysis out of all the CpG information available. Our analysis have shown that conducting analysis with one million CpGs is suffice to capture the quality of the samples. However when more CpGs are added they reflect the full data precisely. Offset parameter is to avoid any telomere region when subsetting from the beginning of the data. Hence Offset parameter would avoid first n number of CpGs.

```
report(bsObject, '~/Documents', Hsapiens, "hg38")
```

Command above generated an html report named *qcReport.html*. It will be stored in the indicated directory.

---

## 4.2 Functions

This section will elaborate on some of the main functions and show the usage of these functions based on a sample data set that comes along with the package.

**scmeth** package contains several functions to assess different metrics and success of the sequencing process.

### coverage

One main metric is the CpG coverage. Coverage of the CpG can be assessed in different ways. Very basic one is to check how many CpG were observed in each sample. **coverage** function can be used to get this information.

Loading the data

```
directory <- system.file("extdata", "bismark_data", package='scmeth')
bsObject <- HDF5Array::loadHDF5SummarizedExperiment(directory)
```

```
scmeth::coverage(bsObject)
```

```
## 2017-08-02_HL2F5BBXX_2_AAGAGGCA_AGAAGG_report.txt
##                                               756
## 2017-08-02_HL2F5BBXX_2_AAGAGGCA_AGGATG_report.txt
##                                               424
## 2017-08-02_HL2F5BBXX_2_AAGAGGCA_ATCAAG_report.txt
##                                               333
```

### readmetrics

Read information is important to assess whether sequencing and alignment succeeded. **readmetrics** function outputs a visualization showing number of reads seen in each samples and of those reads what proportion of them were mapped to the reference genome.

```
readmetrics(bsObject)
```

```
##                                              sample   total mapped unmapped
## 1 2017-08-02_HL2F5BBXX_2_AAGAGGCA_AGAAGG_report.txt 1145278 974438   170840
## 2 2017-08-02_HL2F5BBXX_2_AAGAGGCA_AGGATG_report.txt  763055 633756   129299
## 3 2017-08-02_HL2F5BBXX_2_AAGAGGCA_ATCAAG_report.txt  847927 717059   130868
```

### repmask

CpG Islands are characterized by their high GC content, high level of observed to expected ratio of CpGs and length over 500 bp. However some repeat regions in the genome also fit the same criteria although they are not bona fide CpG Island. Therefore it is important to see how many CpGs are observed in the non repeat regions of the genome. **repMask** functions provide information on the CpG coverage in non repeat regions of the genome. In order to build the repeat mask regions of the genome **repmask** function will require the organism and the genome build information.

```
library(BSgenome.Mmusculus.UCSC.mm10)
load(system.file("extdata", 'bsObject.rda', package='scmeth'))
repMask(bs, Mmusculus, "mm10")
```

```
##                     coveredCpgs
## sc-RRBS_zyg_01_chr1       12208
## sc-RRBS_zyg_02_chr1        3056
## sc-RRBS_zyg_03_chr1        6666
```

### Coverage by Chromosome

There are several other ways the number of CpGs captured can be visualized. One of the way is to observe how the CpGs are distributed across different chromosomes. \***chromosomeCoverage** outputs CpG coverage by individual chromosomes.(Since the example data only contains information in chromosome 1 only the CpGs covered in chromosome 1 is shown.)

```
chromosomeCoverage(bsObject)
```

```
##   2017-08-02_HL2F5BBXX_2_AAGAGGCA_AGAAGG_report.txt
## 1                                               756
##   2017-08-02_HL2F5BBXX_2_AAGAGGCA_AGGATG_report.txt
## 1                                               424
##   2017-08-02_HL2F5BBXX_2_AAGAGGCA_ATCAAG_report.txt
## 1                                               333
```

### featureCoverage

Another way to observe the distribution of CpGs is to classify them by the genomic features they belong. Some of the features are very specific to the CpG dense regions such as CpG Islands, CpG Shores, CpG Shelves etc. Others are general genomic features such as introns, exons, promoters etc. This information can be obtained by **featureCoverage** function. In addition to the bs object this function requires the genomic features of interest and the genome build. Each element in the table represents the fraction of CpGs seen in particular cell in specific region compared to all the CpGs seen in that region.

```
#library(annotatr)
featureList <- c('cpg_islands', 'cpg_shores', 'cpg_shelves')
DT::datatable(featureCoverage(bsObject, features=featureList, "hg38"))
```

### cpgDensity

CpGs are not distributed across the genome uniformly. Most of the genome contains very low percentage of CpGs except for the CpG dense regions, i.e. CpG islands. Bisulfite sequencing targets all the CpGs across the genome, however reduced representation bisulfite sequencing (RRBS) target CpG dense CpG islands. Therefore CpG density plot will be a great diagnostic to see whether the protocol succeeded. In order to calculate the CpG density a window length should be specified. By default **cpgDensity** function chooses 1kB regions. Therefore CpG density plot can be used to check whether the protocol specifically targeted CpG dense or CpG sparse regions or whether CpGs were obtained uniformly across the regions.

```
library(BSgenome.Hsapiens.NCBI.GRCh38)
DT::datatable(cpgDensity(bsObject, Hsapiens, windowLength=1000, small=TRUE))
```

### downsample

In addition to the CpG coverage, methylation data can be assessed via down sampling analysis, methylation bias plot and methylation distribution. Down sampling analysis is a technique to assess whether the sequencing process achieved the saturation level in terms of CpG capture. In order to perform down sampling analysis CpGs that are covered at least will be sampled via binomial random sampling with given probability. At each probability level the number of CpGs captured is assessed. If the number of CpG captured attains a plateau then the sequencing was successful. **downsample** function provides a matrix of CpG coverage for each sample at various down sampling rates. The report renders this information into a plot. Downsampling rate ranges from 0.01 to 1, however users can change the downsampling rates.

```
DT::datatable(scmeth::downsample(bsObject))
```

### mbiasPlot

Methylation bias plot shows the methylation along the reads. In a high quality samples methylation across the read would be more or less a horizontal line. However there could be fluctuations in the beginning or the end of the read due to the quality of the bases. Single cell sequencing samples also can show jagged trend in the methylation bias plot due to low read count. Methylation bias can be assessed via **mbiasPlot** function. This function takes the mbias file generated from FireCloud pipeline and generates the methylation bias plot.

```
methylationBiasFile <- '2017-04-21_HG23KBCXY_2_AGGCAGAA_TATCTC_pe.M-bias.txt'
mbiasList <- mbiasplot(mbiasFiles=system.file("extdata", methylationBiasFile,
                                         package='scmeth'))

mbiasDf <- do.call(rbind.data.frame, mbiasList)
meanTable <- stats::aggregate(methylation ~ position + read, data=mbiasDf, FUN=mean)
sdTable <- stats::aggregate(methylation ~ position + read, data=mbiasDf, FUN=sd)
seTable <- stats::aggregate(methylation ~ position + read, data=mbiasDf, FUN=function(x){sd(x)/sqrt(length(x))})
sum_mt<-data.frame('position'=meanTable$position,'read'=meanTable$read,
                       'meth'=meanTable$methylation, 'sdMeth'=sdTable$methylation,
                       'seMeth'=seTable$methylation)

sum_mt$upperCI <- sum_mt$meth + (1.96*sum_mt$seMeth)
sum_mt$lowerCI <- sum_mt$meth - (1.96*sum_mt$seMeth)
sum_mt$read_rep <- paste(sum_mt$read, sum_mt$position, sep="_")

g <- ggplot2::ggplot(sum_mt)
g <- g + ggplot2::geom_line(ggplot2::aes_string(x='position', y='meth',
                                                colour='read'))
g <- g + ggplot2::geom_ribbon(ggplot2::aes_string(ymin = 'lowerCI',
                        ymax = 'upperCI', x='position', fill = 'read'),
                        alpha=0.4)
g <- g + ggplot2::ylim(0,100) + ggplot2::ggtitle('Mbias Plot')
g <- g + ggplot2::ylab('methylation')
g
```

![](data:image/png;base64...)

### methylationDist

**methylationDist** function provides the methylation distribution of the samples. In this visualization methylation is divided into quantiles and ordered according to the cells with the lowest methylation to highest methylation. In single cell analysis almost all CpGs will be in the highest quantile or the lowest quantile. This visualization provides information on whether there are cells with intermediate methylation. Ideally , in single cell methylation most methylation should be either 1 or 0. If there are large number of intermediate methylation this indicates there might be some error in sequencing.

```
methylationDist(bsObject)
```

```
## 2017-08-02_HL2F5BBXX_2_AAGAGGCA_AGAAGG_report.txt
##                                         0.7841647
## 2017-08-02_HL2F5BBXX_2_AAGAGGCA_AGGATG_report.txt
##                                         0.6940448
## 2017-08-02_HL2F5BBXX_2_AAGAGGCA_ATCAAG_report.txt
##                                         0.8130466
```

### bsConversionPlot

Another important metric in methylation analysis is the bisulfite conversion rate. Bisulfite conversion rate indicates out of all the Cytosines in the non CpG context what fraction of them were methylated. Ideally this number should be 1 or 100% indicating none of the non CpG context cytosines are methylated. However in real data this will not be the case, yet bisulfite conversion rate below 95% indicates some problem with sample preparation. **bsConversionPlot** function generates a plot showing this metric for each sample.

```
bsConversionPlot(bsObject)
```

```
##                                              sample       bsc
## 1 2017-08-02_HL2F5BBXX_2_AAGAGGCA_AGAAGG_report.txt 0.9940704
## 2 2017-08-02_HL2F5BBXX_2_AAGAGGCA_AGGATG_report.txt 0.9951570
## 3 2017-08-02_HL2F5BBXX_2_AAGAGGCA_ATCAAG_report.txt 0.9932266
```

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
##  [1] BSgenome.Hsapiens.NCBI.GRCh38_1.3.1000
##  [2] BSgenome.Mmusculus.UCSC.mm10_1.4.3
##  [3] BSgenome_1.78.0
##  [4] rtracklayer_1.70.0
##  [5] BiocIO_1.20.0
##  [6] Biostrings_2.78.0
##  [7] XVector_0.50.0
##  [8] GenomicRanges_1.62.0
##  [9] Seqinfo_1.0.0
## [10] IRanges_2.44.0
## [11] S4Vectors_0.48.0
## [12] BiocGenerics_0.56.0
## [13] generics_0.1.4
## [14] scmeth_1.30.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3                   bitops_1.0-9
##   [3] bsseq_1.46.0                httr2_1.2.1
##   [5] permute_0.9-8               rlang_1.1.6
##   [7] magrittr_2.0.4              matrixStats_1.5.0
##   [9] compiler_4.5.1              RSQLite_2.4.3
##  [11] DelayedMatrixStats_1.32.0   GenomicFeatures_1.62.0
##  [13] png_0.1-8                   vctrs_0.6.5
##  [15] reshape2_1.4.4              stringr_1.5.2
##  [17] pkgconfig_2.0.3             crayon_1.5.3
##  [19] fastmap_1.2.0               dbplyr_2.5.1
##  [21] labeling_0.4.3              Rsamtools_2.26.0
##  [23] rmarkdown_2.30              tzdb_0.5.0
##  [25] UCSC.utils_1.6.0            purrr_1.1.0
##  [27] bit_4.6.0                   xfun_0.53
##  [29] beachmat_2.26.0             cachem_1.1.0
##  [31] cigarillo_1.0.0             GenomeInfoDb_1.46.0
##  [33] jsonlite_2.0.0              blob_1.2.4
##  [35] rhdf5filters_1.22.0         DelayedArray_0.36.0
##  [37] Rhdf5lib_1.32.0             BiocParallel_1.44.0
##  [39] parallel_4.5.1              R6_2.6.1
##  [41] bslib_0.9.0                 stringi_1.8.7
##  [43] RColorBrewer_1.1-3          limma_3.66.0
##  [45] jquerylib_0.1.4             Rcpp_1.1.0
##  [47] SummarizedExperiment_1.40.0 knitr_1.50
##  [49] R.utils_2.13.0              readr_2.1.5
##  [51] Matrix_1.7-4                tidyselect_1.2.1
##  [53] dichromat_2.0-0.1           abind_1.4-8
##  [55] yaml_2.3.10                 codetools_0.2-20
##  [57] curl_7.0.0                  lattice_0.22-7
##  [59] tibble_3.3.0                regioneR_1.42.0
##  [61] plyr_1.8.9                  withr_3.0.2
##  [63] Biobase_2.70.0              KEGGREST_1.50.0
##  [65] S7_0.2.0                    evaluate_1.0.5
##  [67] BiocFileCache_3.0.0         pillar_1.11.1
##  [69] BiocManager_1.30.26         filelock_1.0.3
##  [71] MatrixGenerics_1.22.0       DT_0.34.0
##  [73] vroom_1.6.6                 RCurl_1.98-1.17
##  [75] BiocVersion_3.22.0          hms_1.1.4
##  [77] ggplot2_4.0.0               sparseMatrixStats_1.22.0
##  [79] scales_1.4.0                gtools_3.9.5
##  [81] glue_1.8.0                  tools_4.5.1
##  [83] AnnotationHub_4.0.0         data.table_1.17.8
##  [85] locfit_1.5-9.12             GenomicAlignments_1.46.0
##  [87] XML_3.99-0.19               rhdf5_2.54.0
##  [89] grid_4.5.1                  crosstalk_1.2.2
##  [91] AnnotationDbi_1.72.0        HDF5Array_1.38.0
##  [93] restfulr_0.0.16             annotatr_1.36.0
##  [95] cli_3.6.5                   rappdirs_0.3.3
##  [97] S4Arrays_1.10.0             dplyr_1.1.4
##  [99] gtable_0.3.6                R.methodsS3_1.8.2
## [101] sass_0.4.10                 digest_0.6.37
## [103] SparseArray_1.10.0          rjson_0.2.23
## [105] htmlwidgets_1.6.4           farver_2.1.2
## [107] R.oo_1.27.1                 memoise_2.0.1
## [109] htmltools_0.5.8.1           lifecycle_1.0.4
## [111] h5mread_1.2.0               httr_1.4.7
## [113] statmod_1.5.1               bit64_4.6.0-1
```