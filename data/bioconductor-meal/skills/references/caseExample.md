# Expression and Methylation Analysis with MEAL

Carlos Ruiz1,2 and Juan R. González1,2\*

1ISGlobal, Centre for Research in Environmental Epidemiology (CREAL), Barcelona, Spain
2Bioinformatics Research Group in Epidemiology

\*juanr.gonzalez@isglobal.org

#### 30 October 2025

#### Package

MEAL 1.40.0

# 1 Introduction

Experiments comprising different omic data analyses are becoming common. In this cases, the researchers are interested in analyzing the different omic types independently as well as finding association between the different layers.

In this vignette, we present how address to an analysis of methylation and expression data using *[MEAL](https://bioconductor.org/packages/3.22/MEAL)*. We will show how to analyze each data type independently and how to integrate the results of both analyses. We will also exemplify how to run an analysis when we are interested in our target region.

We will use the data from *brgedata* package. This package contains data from a spanish children cohort. We will work with the methylation and the expression data encapsulated in a `GenomicRatioSet` and in an `ExpressionSet` respectively. In our analysis, we will evaluate the effect of sex on methylation and expression. We will also deeply explore changes in a region of chromosome 11 around MMP3, a gene differently expressed in men and women (chr11:102600000-103300000).

Let’s start by loading the required packages and data:

```
library(MEAL)
library(brgedata)
library(MultiDataSet)
library(missMethyl)
library(minfi)
library(GenomicRanges)
library(ggplot2)
```

From the six objects of *brgedata*, we will focus on those containing methylation and expression data: brge\_methy and brge\_gexp.

brge\_methy is a `GenomicRatioSet` with methylation data corresponding to the Illumina Human Methylation 450K. It contains 392277 probes and 20 samples. The object contains 9 phenotypic variables (age, sex and cell types proportions):

```
data(brge_methy)
brge_methy
```

```
## class: GenomicRatioSet
## dim: 392277 20
## metadata(0):
## assays(1): Beta
## rownames(392277): cg13869341 cg24669183 ... cg26251715 cg25640065
## rowData names(14): Forward_Sequence SourceSeq ...
##   Regulatory_Feature_Group DHS
## colnames(20): x0017 x0043 ... x0077 x0079
## colData names(9): age sex ... Mono Neu
## Annotation
##   array: IlluminaHumanMethylation450k
##   annotation: ilmn12.hg19
## Preprocessing
##   Method: NA
##   minfi version: NA
##   Manifest version: NA
```

```
colData(brge_methy)
```

```
## DataFrame with 20 rows and 9 columns
##             age      sex           NK     Bcell       CD4T       CD8T
##       <numeric> <factor>    <numeric> <numeric>  <numeric>  <numeric>
## x0017         4   Female -5.81386e-19 0.1735078 0.20406869  0.1009741
## x0043         4   Female  1.64826e-03 0.1820172 0.16171272  0.1287722
## x0036         4   Male    1.13186e-02 0.1690173 0.15546368  0.1277417
## x0041         4   Female  8.50822e-03 0.0697158 0.00732789  0.0321861
## x0032         4   Male    0.00000e+00 0.1139780 0.22230399  0.0216090
## ...         ...      ...          ...       ...        ...        ...
## x0018         4   Female    0.0170284 0.0781698   0.112735 0.06796816
## x0057         4   Female    0.0000000 0.0797774   0.111072 0.00910489
## x0061         4   Female    0.0000000 0.1640266   0.224203 0.13125212
## x0077         4   Female    0.0000000 0.1122731   0.168056 0.07840593
## x0079         4   Female    0.0120148 0.0913650   0.205830 0.11475389
##               Eos      Mono       Neu
##         <numeric> <numeric> <numeric>
## x0017 0.00000e+00 0.0385654  0.490936
## x0043 0.00000e+00 0.0499542  0.491822
## x0036 0.00000e+00 0.1027105  0.459632
## x0041 0.00000e+00 0.0718280  0.807749
## x0032 2.60504e-18 0.0567246  0.575614
## ...           ...       ...       ...
## x0018 8.37770e-03 0.0579535  0.658600
## x0057 4.61887e-18 0.1015260  0.686010
## x0061 8.51074e-03 0.0382647  0.429575
## x0077 6.13397e-02 0.0583411  0.515284
## x0079 0.00000e+00 0.0750535  0.513597
```

brge\_gexp is an `ExpressionSet` with the expression data corresponding to an Affimetrix GeneChip Human Gene 2.0 ST Array. It contains 67528 features and 100 samples as well as two phenotypic variables (age and sex):

```
data(brge_gexp)
brge_gexp
```

```
## ExpressionSet (storageMode: lockedEnvironment)
## assayData: 67528 features, 100 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: x0001 x0002 ... x0139 (100 total)
##   varLabels: age sex
##   varMetadata: labelDescription
## featureData
##   featureNames: TC01000001.hg.1 TC01000002.hg.1 ...
##     TCUn_gl000247000001.hg.1 (67528 total)
##   fvarLabels: transcript_cluster_id probeset_id ... notes (11 total)
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation:
```

```
lapply(pData(brge_gexp), table)
```

```
## $age
##
##  4
## 99
##
## $sex
##
## Female   Male
##     48     51
```

Finally, we will create a `GenomicRanges` with our target region:

```
targetRange <- GRanges("chr11:102600000-103300000")
```

Let’s illustrate the use of this package by analyzing the effect of the sex in methylation and expression. First, a genome wide analysis will be performed and then the region funcionalities will be introduced. It should be noticed that methylation and expression analyses will include hypothesis testing and visualitzation.

# 2 Methylation Analysis

## 2.1 Running the analyses

This demonstration will show how to perform a probe methylation analysis. To run a more complete analysis, including DMR methods, see *[MEAL](https://bioconductor.org/packages/3.22/MEAL)* vignette.

The function `runDiffMeanAnalysis` detects probes differentially methylated using `limma`. This function accepts a `GenomicRatioSet`, an `ExpressionSet` or a `SummarizedExperiment`, so it can analyze methylation and gene expression data. We can pass our model to function `runDiffMeanAnalysis` with the parameter `model`. We are interested in evaluating the effect of sex and We will include cell counts as covariables to adjust their effect:

```
cellCounts <- colnames(colData(brge_methy))[3:9]
methRes <- runDiffMeanAnalysis(set = brge_methy,
                       model = formula(paste("~ sex +", paste(cellCounts, collapse = "+"))))
methRes
```

```
## Object of class 'ResultSet'
##  . created with: DAProbe
##  . sva:
##  . #results: 1 ( error: 1 )
##  . featureData: 392277 probes x 19 variables
```

```
names(methRes)
```

```
## [1] "DiffMean"
```

The analysis generates a `ResultSet` object containing the results of our analysis. The first step after running the pipeline will be evaluate how this model fits the data. A common way to evaluate the goodness of fit of these models is by making a QQplot on the p-values of the linear regression. This plot compares the distribution of p-values obtained in the analysis with a theoretical distribution. Our plot also shows the lambda, a measure of inflation. If lambda is higher than 1, the p-values are smaller than expected. If it is lower than 1, p-values are bigger than expected. In both causes, the most common cause is that we should include more variables in the model.

We can get a QQplot with the function `plot`. When applied to a `ResultSet`, we can make different plots depending on the method. We can select the name of the result with the parameter `rid` and the kind of plot with the parameter `type`. We will set `rid` to “DiffMean” to use limma results and `type` to “qq” to get a QQplot:

```
plot(methRes, rid = "DiffMean", type = "qq")
```

![](data:image/png;base64...)

When there are few CpGs modicated, we expect points in the QQplot lying on the theoretical line. However, as all the CpGs from the sexual chromosomes will be differentially methylated between males and females, we obtained a S-shape. In this case, lambda is lower than 1 (0.851).

There are different ways to address this issue. An option is to include other covariates in our model. When we do not have more covariates, as it is our case, we can apply Surrogate Variable Analysis (SVA) to the data. SVA is a statistical technique that tries to determine hidden covariates or SV (Surrogate Variables) based on the measurements. This method is very useful to correct inflation when we do not have the variables that are missing in the model. Our function `runPipeline` includes the parameter `sva` that runs SVA and includes these variables as covariates in the linear model. More information can be found in *[MEAL](https://bioconductor.org/packages/3.22/MEAL)* vignette.

We can get an overview of the results using a Manhattan plot. A Manhattan plot represents the p-value of each CpG versus their location in the genome. This representation is useful to find genomic regions exhibiting differentiated behaviours. We can get a Manhattan plot from a `ResultSet` using the function `plot` and setting `type` to “manhattan”. We will highlight the CpGs of our target region by passing a `GenomicRanges` to highlight argument. `GenomicRanges` passed to `plot` should have chromosomes coded as number:

```
targetRangeNum <- GRanges("11:102600000-103300000")
plot(methRes, rid = "DiffMean", type = "manhattan", main = "Differences in Means", highlight = targetRangeNum)
```

![](data:image/png;base64...)

There are no genomic regions with a lot of CpGs with differences in means. Our target region does not seem to be very different from the rest. On the other hand, chromosome X has a lot of CpGs with big differences in variance. Our target region does not look different.

# 3 Expression Analysis

## 3.1 Running the analysis

The expression analysis can be performed in the same way than methylation. The main difference is that an `ExpressionSet` will be used instead of a `GenomicRatioSet`. We will run the same model than for methylation. We will check the effect of sex on gene expression and we will further evaluate our target region:

```
targetRange <- GRanges("chr11:102600000-103300000")
gexpRes <- runDiffMeanAnalysis(set = brge_gexp, model = ~ sex)
names(gexpRes)
```

```
## [1] "DiffMean"
```

As we did with methylation data, the first step will be check the goodness of our model. To do so, we will run a QQ-plot using the p-values of the differences of means:

```
plot(gexpRes, rid = "DiffMean", type = "qq")
```

![](data:image/png;base64...)

Most of the p-values lie on the theoretical line and the lambda is close to 1 (0.94). Therefore, we will not need to include other covariates in our model.

We will now get a general overview of the results. In gene expression data, it is very common to use a Volcano plot which shows the change in expression of a probe against their p-value. We can easily make these plots using the function `plot` and setting the argument `type` to **volcano**:

```
plot(gexpRes, rid = "DiffMean", type = "volcano") + ggtitle("Differences in Means")
```

![](data:image/png;base64...)

Several transcripts have a big difference in mean gene expression and a very small p-value. Transcripts with a positive fold change have a higher expression in boys than in girls and are placed in chromosome Y (name starts by TC0Y). Transcripts with a negative fold change, have a lower expression in boys than in girls and are placed in chromosome X (name starts by TC0X).

We can get an overview of the genome distribution of these transcripts by plotting a Manhattan plot. We will also highlight the transcripts of our target region:

```
targetRange <- GRanges("chr11:102600000-103300000")
plot(gexpRes, rid = "DiffMean", type = "manhattan", main = "Differences in Means", highlight = targetRangeNum)
```

![](data:image/png;base64...)

There are several transcripts with highly significant differences in means in chromosomes X and Y. However, transcripts in our target region are not significantly changed.

# 4 Methylation and gene expression integration

We have included in *[MEAL](https://bioconductor.org/packages/3.22/MEAL)* two ways to assess association between gene expression and DNA methylation. The first option is to simultaneously examine the gene expression and DNA methylation results of a target region. We can do this with the function `plotRegion` and passing two ResultSets.

We will examine the methylation and gene expression results in our target region. For the sake of clarity, we will only print DiffMean and bumphunter results.

```
plotRegion(rset = methRes, rset2 = gexpRes, range = targetRange)
```

![](data:image/png;base64...)

Differences in methylation are represented in black and differences in gene expression are represented in blue. We can see that CpGs with high differences are near transcripts with highest differences expression.

We can get a quantitative estimate of the association between methylation and gene expression using the function `correlationMethExprs`. This function applies a method previously described in (Steenaard et al. [2015](#ref-Steenaard2015)). CpGs and expression probes are paired by proximity. Expression probes are paired to a CpG if they are completely inside a range of \(\pm\) 250Kb from the CpG. This distance of 250Kb is set by default but it can be changed with the parameter flank (whose units are bases). The correlation between methylation and expression is done by a linear regression.

To account for technical (e.g. batch) or biological (e.g. sex, age) artifacts, a model including those variables (z) is fitted: \[ x\_{ij} = \sum\_{k = 1}^K{\beta\_{ik} z\_{kj}} + r\_{ij}, i = 1, ..., P \] where \(x\_{ij}\) is the methylation or expression level of probe i (P is the total number of probes) for individual j, \(\beta\_{ik}\) is the effect of variable k at probe i, \(z\_{kj}\) is the value of variable k (K is the total number of covariates) for indivudal j and \(r\_{ij}\) is the residual value of probe i and individual j. The residuals of methylation and expression are used to assess the correlation.

Therefore, let’s create a new `MultiDataSet` with expression and methylation data. The function `createMultiDataSet` creates an empty `MultiDataSet`. Then, we can add gene expression and methylation datasets with the function `add_genexp` and `add_methy`:

```
multi <- createMultiDataSet()
multi <- add_genexp(multi, brge_gexp)
multi <- add_methy(multi, brge_methy)
```

In this analysis, we will only take into account the probes in our target region. We can subset our MultiDataSet passing a `GenomicRanges` to the third position of `[`:

```
multi.filt <- multi[, , targetRange]
```

Now, we will compute the correlation between the CpGs and the expression probes.

```
methExprs <- correlationMethExprs(multi.filt)
head(methExprs)
```

```
##          cpg           exprs       Beta        se     P.Value adj.P.Val
## 1 cg08804111 TC11002235.hg.1  0.7496396 0.2143482 0.002572113 0.7462925
## 2 cg09615874 TC11002239.hg.1 -2.2805946 0.6419809 0.002275597 0.7462925
## 3 cg02344527 TC11003311.hg.1 -3.8018045 1.1008235 0.002834022 0.7462925
## 4 cg01766252 TC11002232.hg.1  7.9602956 2.4425111 0.004357524 0.8538027
## 5 cg16466334 TC11002239.hg.1  5.8514095 1.8510037 0.005403815 0.8538027
## 6 cg13759446 TC11000962.hg.1 -7.6725222 2.8959170 0.016308600 0.8747493
```

The results shows the CpG name, the expression probe, the linear regression coeffcient and its standard error, and the p-value and adjusted p-value (using B&H). Results are ordered by the adjusted p-value, so we can see than in our data there are no correlated CpGs-expression probes.

# 5 Conclusions

This case example shows the main functionalities of *[MEAL](https://bioconductor.org/packages/3.22/MEAL)* package. It has been shown how to evaluate the effect of a phenotype on the methylation and on the expression at genome wide and at region level. Finally, the integration between methylation and expression is tested by checking if there are expression probes correlated to the methylated probes.

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
## [1] parallel  stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] missMethyl_1.44.0
##  [2] IlluminaHumanMethylationEPICv2anno.20a1.hg38_1.0.0
##  [3] IlluminaHumanMethylationEPICanno.ilm10b4.hg19_0.6.0
##  [4] brgedata_1.31.0
##  [5] ggplot2_4.0.0
##  [6] minfiData_0.55.0
##  [7] IlluminaHumanMethylation450kanno.ilmn12.hg19_0.6.1
##  [8] IlluminaHumanMethylation450kmanifest_0.4.0
##  [9] minfi_1.56.0
## [10] bumphunter_1.52.0
## [11] locfit_1.5-9.12
## [12] iterators_1.0.14
## [13] foreach_1.5.2
## [14] Biostrings_2.78.0
## [15] XVector_0.50.0
## [16] SummarizedExperiment_1.40.0
## [17] MatrixGenerics_1.22.0
## [18] matrixStats_1.5.0
## [19] GenomicRanges_1.62.0
## [20] Seqinfo_1.0.0
## [21] IRanges_2.44.0
## [22] S4Vectors_0.48.0
## [23] MEAL_1.40.0
## [24] MultiDataSet_1.38.0
## [25] Biobase_2.70.0
## [26] BiocGenerics_0.56.0
## [27] generics_0.1.4
## [28] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] splines_4.5.1             BiocIO_1.20.0
##   [3] filelock_1.0.3            bitops_1.0-9
##   [5] tibble_3.3.0              preprocessCore_1.72.0
##   [7] rpart_4.1.24              XML_3.99-0.19
##   [9] httr2_1.2.1               lifecycle_1.0.4
##  [11] ensembldb_2.34.0          lattice_0.22-7
##  [13] MASS_7.3-65               base64_2.0.2
##  [15] scrime_1.3.5              backports_1.5.0
##  [17] magrittr_2.0.4            Hmisc_5.2-4
##  [19] limma_3.66.0              sass_0.4.10
##  [21] rmarkdown_2.30            jquerylib_0.1.4
##  [23] yaml_2.3.10               doRNG_1.8.6.2
##  [25] askpass_1.2.1             Gviz_1.54.0
##  [27] DBI_1.2.3                 RColorBrewer_1.1-3
##  [29] abind_1.4-8               quadprog_1.5-8
##  [31] purrr_1.1.0               AnnotationFilter_1.34.0
##  [33] biovizBase_1.58.0         RCurl_1.98-1.17
##  [35] nnet_7.3-20               VariantAnnotation_1.56.0
##  [37] rappdirs_0.3.3            ggrepel_0.9.6
##  [39] rentrez_1.2.4             genefilter_1.92.0
##  [41] vegan_2.7-2               annotate_1.88.0
##  [43] permute_0.9-8             DelayedMatrixStats_1.32.0
##  [45] codetools_0.2-20          DelayedArray_0.36.0
##  [47] xml2_1.4.1                tidyselect_1.2.1
##  [49] UCSC.utils_1.6.0          farver_2.1.2
##  [51] beanplot_1.3.1            base64enc_0.1-3
##  [53] BiocFileCache_3.0.0       illuminaio_0.52.0
##  [55] GenomicAlignments_1.46.0  jsonlite_2.0.0
##  [57] multtest_2.66.0           Formula_1.2-5
##  [59] survival_3.8-3            progress_1.2.3
##  [61] tools_4.5.1               Rcpp_1.1.0
##  [63] glue_1.8.0                gridExtra_2.3
##  [65] SparseArray_1.10.0        xfun_0.53
##  [67] mgcv_1.9-3                GenomeInfoDb_1.46.0
##  [69] dplyr_1.1.4               HDF5Array_1.38.0
##  [71] withr_3.0.2               BiocManager_1.30.26
##  [73] fastmap_1.2.0             latticeExtra_0.6-31
##  [75] rhdf5filters_1.22.0       openssl_2.3.4
##  [77] digest_0.6.37             R6_2.6.1
##  [79] colorspace_2.1-2          jpeg_0.1-11
##  [81] biomaRt_2.66.0            dichromat_2.0-0.1
##  [83] RSQLite_2.4.3             cigarillo_1.0.0
##  [85] h5mread_1.2.0             tidyr_1.3.1
##  [87] calibrate_1.7.7           data.table_1.17.8
##  [89] rtracklayer_1.70.0        htmlwidgets_1.6.4
##  [91] prettyunits_1.2.0         httr_1.4.7
##  [93] S4Arrays_1.10.0           pkgconfig_2.0.3
##  [95] gtable_0.3.6              blob_1.2.4
##  [97] S7_0.2.0                  siggenes_1.84.0
##  [99] htmltools_0.5.8.1         bookdown_0.45
## [101] ProtGenerics_1.42.0       scales_1.4.0
## [103] png_0.1-8                 rstudioapi_0.17.1
## [105] knitr_1.50                tzdb_0.5.0
## [107] rjson_0.2.23              checkmate_2.3.3
## [109] nlme_3.1-168              curl_7.0.0
## [111] org.Hs.eg.db_3.22.0       cachem_1.1.0
## [113] rhdf5_2.54.0              stringr_1.5.2
## [115] foreign_0.8-90            AnnotationDbi_1.72.0
## [117] restfulr_0.0.16           GEOquery_2.78.0
## [119] pillar_1.11.1             grid_4.5.1
## [121] reshape_0.8.10            vctrs_0.6.5
## [123] dbplyr_2.5.1              xtable_1.8-4
## [125] cluster_2.1.8.1           htmlTable_2.4.3
## [127] evaluate_1.0.5            qqman_0.1.9
## [129] readr_2.1.5               tinytex_0.57
## [131] GenomicFeatures_1.62.0    magick_2.9.0
## [133] cli_3.6.5                 compiler_4.5.1
## [135] Rsamtools_2.26.0          rlang_1.1.6
## [137] crayon_1.5.3              rngtools_1.5.2
## [139] labeling_0.4.3            nor1mix_1.3-3
## [141] interp_1.1-6              mclust_6.1.1
## [143] plyr_1.8.9                stringi_1.8.7
## [145] deldir_2.0-4              BiocParallel_1.44.0
## [147] lazyeval_0.2.2            Matrix_1.7-4
## [149] BSgenome_1.78.0           hms_1.1.4
## [151] sparseMatrixStats_1.22.0  bit64_4.6.0-1
## [153] Rhdf5lib_1.32.0           KEGGREST_1.50.0
## [155] statmod_1.5.1             memoise_2.0.1
## [157] bslib_0.9.0               bit_4.6.0
```

# References

Steenaard, Rebecca V, Symen Ligthart, Lisette Stolk, Marjolein J Peters, Joyce B van Meurs, Andre G Uitterlinden, Albert Hofman, Oscar H Franco, and Abbas Dehghan. 2015. “Tobacco smoking is associated with methylation of genes related to coronary artery disease.” *Clinical Epigenetics* 7 (1): 54. <https://doi.org/10.1186/s13148-015-0088-y>.