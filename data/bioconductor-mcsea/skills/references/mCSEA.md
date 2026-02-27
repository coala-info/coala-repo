DMRs identification with mCSEA package

true

true

27 November 2025

Abstract

mCSEA (methylathed CpGs Set Enrichment Analysis) searches Differ-
entially Methylated Regions (DMRs) between conditions using methylation
data from Illumina’s 450k or EPIC microarrays. The evaluated DMRs are
predefined regions (promoters, gene bodies, CpG Islands and user-defined
regions). This package contains functions to rank the CpG probes, to
apply a GSEA analysis for DMRs identification, to plot the results and to
integrate them with expression data.

Previous steps

The input of mCSEA is tipically a matrix with the processed β-values for each
probe and sample. If you start from the raw methylation files (like .idat files)
you should first preprocess the data with any of the available packages for that
purpose (e.g. minfi or ChAMP). Minfi includes functions to get a matrix of
β-values (getBeta()) or M-values (getM()). ChAMP output class depends on
the type of analysis performed. For instance, champ.norm() function returns a
matrix, while champ.load() returns a list of results, and one of them is a β-values
matrix. So mCSEA is totally compatible with minfi and ChAMP outputs as
long as a matrix with the methylation values is obtained.

Reading .idat files

Here we provide a minimal example to read .idat files with minfi package.
A samplesheet must be provided in order to read the raw files and generate
a RGChannelSet object. For more information about this step, read minfi’s
vignette.
library(minfi)
minfiDataDir <- system.file("extdata", package = "minfiData")
targets <- read.metharray.sheet(minfiDataDir, verbose = FALSE)
RGset <- read.metharray.exp(targets = targets)

1

Cell type heterogeneity correction

Different cell types proportions across samples are one of the major sources of
variability in methylation data from tissues like blood or saliva (McGregor et
al. (2016)). There are a lot of packages which can be used to estimate cell
types proportions in each sample in order to correct for this bias (reviewed in
McGregor et al. (2016)). Here we supply an example where blood reference data
is used to estimate cell types proportions of each blood sample.
library(FlowSorted.Blood.450k)
library(mCSEA)
data(mcseadata)

cellCounts = estimateCellCounts(RGset)

## Warning in DataFrame(sampleNames = c(colnames(rgSet),
## colnames(referenceRGset)), : 'stringsAsFactors' is ignored
print(cellCounts)

CD4T

CD8T

##
Gran
## 5723646052_R02C02 0.12132355 0.2489442 0.1525943 0.3177123 0.1922554 0.13958941
## 5723646052_R04C01 0.07437663 0.2927509 0.1592739 0.3203660 0.1682549 0.15928208
## 5723646052_R05C02 0.15451979 0.2578973 0.1600397 0.2438732 0.1983064 0.15169740
## 5723646053_R04C02 0.17332656 0.2522868 0.1167347 0.2657515 0.2335970 0.11646712
## 5723646053_R05C02 0.08811529 0.2725395 0.1752246 0.2837298 0.2011335 0.13415227
## 5723646053_R06C02 0.09190789 0.3202139 0.2006286 0.2350504 0.2052394 0.09815978

Bcell

Mono

NK

These proportions could be introduced as covariates in the linear models.

Step 1: Ranking CpGs probes

To run a mCSEA analysis, you must rank all the evaluated CpGs probes with
some metric (e.g. t-statistic, Fold-Change. . . ). You can use rankProbes() function
for that aim, or prepare a ranked list with the same structure as the rankProbes()
output.

We load sample data to show how rankProbes() works:
library(mCSEA)
data(mcseadata)

We loaded to our R environment betaTest and phenoTest objects, in addition
to exprTest, annotation objects and association objects (we will talk about
these after). betaTest is a matrix with the β-values of 10000 EPIC probes for 20
samples. phenoTest is a dataframe with the explanatory variable and covariates
associated to the samples. When you load your own data, the structure of your
objects should be similar.

2

head(betaTest, 3)

9

5

4

2

3

8

7

1

10

##
6
## cg18478105 0.6845279 0.6917252 0.8622046 0.6966168 0.1204777 0.7670960
## cg10605442 0.1370685 0.8450987 0.5480076 0.8671236 0.8300113 0.1667405
## cg27657131 0.1333706 0.6745949 0.8702664 0.9338893 0.8788454 0.1853554
##
12
## cg18478105 0.93804510 0.88166619 0.90385504 0.9287976 0.04052779 0.10765614
## cg10605442 0.08727434 0.10568040 0.11896201 0.1764874 0.73534148 0.05741730
## cg27657131 0.10463463 0.05660229 0.06469281 0.2235293 0.92030432 0.04618165
##
18
## cg18478105 0.1459481 0.8334884 0.1209040 0.07747453 0.7001099 0.7528026
## cg10605442 0.8213965 0.8208602 0.1671381 0.10157830 0.8874912 0.1723724
## cg27657131 0.1374107 0.8432675 0.9642680 0.14536637 0.9372422 0.9315385
##
20
## cg18478105 0.86687272 0.85999403
## cg10605442 0.88836050 0.06521765
## cg27657131 0.06357636 0.50609450
print(phenoTest)

19

14

13

11

15

16

17

##
Case
## 1
Case
## 2
Case
## 3
Case
## 4
Case
## 5
Case
## 6
Case
## 7
Case
## 8
Case
## 9
## 10
Case
## 11 Control
## 12 Control
## 13 Control
## 14 Control
## 15 Control
## 16 Control
## 17 Control
## 18 Control
## 19 Control
## 20 Control

expla cov1
1
2
1
1
3
3
2
2
2
1
1
2
1
1
3
3
2
2
2
1

rankProbes() function uses these two objects as input and apply a linear model
with limma package. By default, rankProbes() considers the first column of
the phenotypes table as the explanatory variable in the model (e.g. cases and
controls) and does not take into account any covariate to adjust the models. You

3

can change this behaviour modifying explanatory and covariates options.

By default, rankProbes() assumes that the methylation data object contains
β-values and transform them to M-values before calculating the linear models. If
your methylation data object contains M-values, you must specify it (typeInput =
“M”). You can also use β-values for models calculation (typeAnalysis = “beta”),
although we do not recommend it due to it has been proven that M-values better
accomplish the statistical assumptions of limma analysis (Du et al. (2010)).
myRank <- rankProbes(betaTest, phenoTest, refGroup = "Control")

## Transforming beta-values to M-values

## Calculating linear model...

## Explanatory variable: expla

## Case group: Case

## Reference group: Control

## Total samples: 20

## Covariates: None

## Categorical variables: expla cov1

## Continuous variables: None

myRank is a named vector with the t-values for each CpG probe.
head(myRank)

## cg18478105 cg10605442 cg27657131 cg08514185 cg13587582 cg25802399
0.7391412
## 2.2625855 -0.4233918 -0.8570958 -0.6892151 -3.0025623

You can also supply rankProbes() function with a SummarizedExperiment object.
In that case, if you don’t specify a pheno object, phenotypes will be extracted
from the SummarizedExperiment object with colData() function.

Paired analysis

It is possible to take into account paired samples in rankProbes() analysis. For
that aim, you should use paired = TRUE parameter and specify the column in
pheno containing pairing information (pairColumn parameter).

Step 2: Searching DMRs in predefined regions

Once you calculated a score for each CpG, you can perform the mCSEA analysis.
For that purpose, you should use mCSEATest() function. This function takes
as input the vector generated in the previous step, the methylation data and
the phenotype information. By default, it searches for differentially methylated

4

promoters, gene bodies and CpG Islands. You can specify the regions you want
to test with regionsTypes option. minCpGs option specifies the minimum amount
of CpGs in a region to be considered in the analysis (5 by default). You can
increase the number of processors to use with nproc option (recommended if you
have enough computational resources). Finally, you should specify if the array
platform is 450k or EPIC with the platform option.
myResults <- mCSEATest(myRank, betaTest, phenoTest,

regionsTypes = "promoters", platform = "EPIC")

## Associating CpG sites to promoters

## Analysing promoters

##

|

## 38 DMRs found (padj < 0.05)

mCSEATest() returns a list with the GSEA results and the association objects for
each region type analyzed, in addition to the input data (methylation, phenotype
and platform).
ls(myResults)

## [1] "methData"
## [4] "promoters"

"pheno"
"promoters_association"

"platform"

promoters is a data frame with the following columns (partially extracted from
fgsea help):

• pval: Estimated P-value.
• padj: P-value adjusted by BH method.
• log2err: Expected error for the standard deviation of the P-value logarithm.
• ES: Enrichment score.
• NES: Normalized enrichment score by number of CpGs associated to the

feature.

• size: Number of CpGs associated to the feature.
• leadingEdge: Leading edge CpGs which drive the enrichment.

head(myResults[["promoters"]][,-7])

|

|

0%

|

|====

|

5%

|

|=======

|

10%

|

|==========

|

15%

|

|==============

| 20% |

|==================

| 25% |

|=====================

| 30% |

|========================

| 35% |

|============================

| 40% |

|================================

|

45%

|

|===================================

|

50%

|

|======================================

|

55%

|

|==========================================

|

60%

|

|==============================================

|

65%

|

|=================================================

|

70%

|

|====================================================

|

75%

|

|========================================================

|

80%

|

|============================================================

|

85%

|

|===============================================================

|

90%

|

|==================================================================

|

95%

|

|======================================================================| 100%

padj

pval

log2err

##
8.672009e-39 4.301317e-36 1.6216996 -0.9624019 -2.239582
## DMD
2.818739e-37 6.990472e-35 1.5894558 -0.9642779 -2.197092
## BANP
9.602555e-16 5.953584e-14 1.0175448 -0.9577816 -1.922100
## KTN1
## XIAP
1.680846e-14 7.579089e-13 0.9759947 -0.9597439 -1.909162
## SEMA3B 6.554464e-14 2.709178e-12 0.9545416 -0.9574653 -1.904629
## GOLGB1 4.795740e-13 1.829759e-11 0.9214260 -0.9610671 -1.818921

NES size
65
59
27
25
25
20

ES

On the other hand, promoters_association is a list with the CpG probes
associated to each feature:

5

head(myResults[["promoters_association"]], 3)

## $YTHDF1
## [1] "cg18478105" "cg10605442" "cg27657131" "cg08514185" "cg13587582"
## [6] "cg25802399" "cg22485414" "cg03501095" "cg24092253" "cg12589387"
##
## $EIF2S3
## [1] "cg09835024" "cg06127902" "cg12275687" "cg00914804" "cg27345735"
## [6] "cg12590845" "cg25034591" "cg16712639" "cg07622257"
##
## $PKN3
## [1] "cg14361672" "cg06550760" "cg14204415" "cg11056832" "cg14036226"
## [6] "cg22365023" "cg20593100"

You can also provide a custom association object between CpG probes and
regions (customAnnotation option). This object should be a list with a structure
similar to this:
head(assocGenes450k, 3)

## $TSPY4
## [1] "cg00050873" "cg03443143" "cg04016144" "cg05544622" "cg09350919"
## [6] "cg15810474" "cg15935877" "cg17834650" "cg17837162" "cg25705492"
## [11] "cg00543493" "cg00903245" "cg01523029" "cg02606988" "cg02802508"
## [16] "cg03535417" "cg04958669" "cg08258654" "cg08635406" "cg10239257"
## [21] "cg13861458" "cg14005657" "cg25538674" "cg26475999"
##
## $TTTY14
## [1] "cg03244189" "cg05230942" "cg10811597" "cg13765957" "cg13845521"
## [6] "cg15281205" "cg26251715"
##
## $NLGN4Y
## [1] "cg03706273" "cg25518695" "cg01073572" "cg01498999" "cg02340092"
## [6] "cg03278611" "cg04419680" "cg05939513" "cg07795413" "cg08816194"
## [11] "cg09300505" "cg09748856" "cg09804407" "cg10990737" "cg18113731"
## [16] "cg19244032" "cg27214488" "cg27265812" "cg27443332"

Step 3: Plotting the results

Once you found some DMRs, you can make a plot with the genomic context of
the interesting ones. For that, you must provide mCSEAPlot() function with
the mCSEATest() results, and you must specify which type of region you want
to plot and the name of the DMR to be plotted (e.g. gene name). There are
some graphical parameters you can adjust (see mCSEAPlot() help). Take into
account that this function connects to some online servers in order to get genomic
information. For that reason, this function could take some minutes to finish

6

the plot, specially the first time it is executed.
mCSEAPlot(myResults, regionType = "promoters",

dmrName = "CLIC6",
transcriptAnnotation = "symbol", makePDF = FALSE)

You can also plot the GSEA results for a DMR with mCSEAPlotGSEA() function.
mCSEAPlotGSEA(myRank, myResults, regionType = "promoters", dmrName = "CLIC6")

7

Chromosome 2136.04 mb36.041 mb36.042 mb36.043 mb0.20.40.60.8DNA MethylationCaseControlKSleadingedgeENSEMBL annotationIntegrating methylation and expression data

If you have both methylation and expression data for the same samples, you can
integrate them in order to discover significant associations between methylation
changes in a DMR and an expression alterations in a close gene. mCSEAIn-
tegrate() considers the DMRs identified by mCSEATest() passing a P-value
threshold (0.05 by default). It calculates the mean methylation for each con-
dition using the leading edge CpGs and performs a correlation test between
this mean DMR methylation and the expression of close genes. This function
automatically finds the genes located within a determined distance (1.5 kb) from
the DMR. Only correlations passing thresholds (0.5 for correlation value and 0.05
por P-value by default) are returned. For promoters, only negative correlations
are returned due to this kind of relationship between promoters methylation
and gene expression has been largely observed (Jones (2012)). On the contrary,
only positive correlations between gene bodies methylation and gene expression
are returned, due to this is a common relationship observed (Jones (2012)). For
CpG islands and custom regions, both positive and negative correlations are
returned, due to they can be located in both promoters and gene bodies.

To test this function, we extracted a subset of 100 genes expression from bone
marrows of 10 healthy and 10 leukemia patients (exprTest). Data was extracted
from leukemiasEset package.
# Explore expression data
head(exprTest, 3)

8

0.000.250.500.751.000250050007500rankenrichment scoreCLIC61

2

3

6

5

4

7
##
## ENSG00000179023 4.145748 4.388779 4.265583 4.374576 4.463465 4.078678 4.335878
## ENSG00000179029 4.485414 5.044662 5.411474 5.590093 5.365381 4.951236 6.626413
## ENSG00000179041 6.618769 6.443408 7.642324 7.989362 7.133374 7.224613 5.853054
14
##
## ENSG00000179023 4.121601 4.163271 4.219654 4.340421 3.917131 4.284802 4.161627
## ENSG00000179029 5.070305 5.582466 5.688895 5.675448 5.053258 5.708689 5.170988
## ENSG00000179041 8.198245 6.847891 6.598557 6.546835 7.211352 7.190893 6.825418
20
##
## ENSG00000179023 4.308718 4.074333 4.171878 4.083548 4.549825 4.199466
## ENSG00000179029 5.480265 5.118550 5.657001 5.257061 5.677323 5.171198
## ENSG00000179041 7.342032 7.309422 6.831020 7.728485 7.214401 6.781880

10

17

15

11

12

13

16

18

19

8

9

# Run mCSEAIntegrate function
resultsInt <- mCSEAIntegrate(myResults, exprTest, "promoters", "ENSEMBL")

## 0 genes removed from exprData due to Standar Deviation = 0

## Integrating promoters methylation with gene expression
resultsInt

Feature regionType

##
## 1

GATA2

promoters ENSG00000179348

Gene Correlation

adjPValue
-0.8908771 1.39373e-07 1.39373e-07

PValue

It is very important to specify the correct gene identifiers used in the expression
data (geneIDs parameter). mCSEAIntegrate() automatically generates correla-
tion plots for the significant results and save them in the directory specified by
folder parameter (current directory by default).

Session info

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

## R version 4.5.2 (2025-10-31)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0
##
## locale:
## [1] LC_CTYPE=en_US.UTF-8
## [3] LC_TIME=en_GB
## [5] LC_MONETARY=en_US.UTF-8
## [7] LC_PAPER=en_US.UTF-8
## [9] LC_ADDRESS=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

9

LAPACK version 3.12.0

Integration plot

Figure 1:
for GATA2 promoter methylation and
ENSG00000179348 expression. Note that, actually, both names refers to the
same gene, but SYMBOL was used to analyze promoters methylation and EN-
SEMBL ID was used as gene identifiers in the expression data.

10

5.56.06.50.20.40.60.8GATA2 promoter methylation vs. ENSG00000179348 expressionCorrelation = −0.89   P−value = 1.4e−07ExpressionMethylationCaseControldatasets

grDevices utils

stats

graphics

stats4
base

## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] parallel
## [8] methods
##
## other attached packages:
## [1] IlluminaHumanMethylation450kanno.ilmn12.hg19_0.6.1
## [2] IlluminaHumanMethylation450kmanifest_0.4.0
## [3] mCSEA_1.30.1
## [4] Homo.sapiens_1.3.1
## [5] TxDb.Hsapiens.UCSC.hg19.knownGene_3.22.1
## [6] org.Hs.eg.db_3.22.0
## [7] GO.db_3.22.0
## [8] OrganismDbi_1.52.0
## [9] GenomicFeatures_1.62.0
## [10] AnnotationDbi_1.72.0
## [11] mCSEAdata_1.30.0
## [12] FlowSorted.Blood.450k_1.48.0
## [13] minfi_1.56.0
## [14] bumphunter_1.52.0
## [15] locfit_1.5-9.12
## [16] iterators_1.0.14
## [17] foreach_1.5.2
## [18] Biostrings_2.78.0
## [19] XVector_0.50.0
## [20] SummarizedExperiment_1.40.0
## [21] Biobase_2.70.0
## [22] MatrixGenerics_1.22.0
## [23] matrixStats_1.5.0
## [24] GenomicRanges_1.62.0
## [25] Seqinfo_1.0.0
## [26] IRanges_2.44.0
## [27] S4Vectors_0.48.0
## [28] BiocGenerics_0.56.0
## [29] generics_0.1.4
##
## loaded via a namespace (and not attached):
##
##
##
##
##
## [11] httr2_1.2.1
## [13] lattice_0.22-7

BiocIO_1.20.0
filelock_1.0.3
preprocessCore_1.72.0
rpart_4.1.24
lifecycle_1.0.4
ensembldb_2.34.0
MASS_7.3-65

[1] splines_4.5.2
[3] bitops_1.0-9
[5] tibble_3.3.0
[7] graph_1.88.0
[9] XML_3.99-0.20

11

## [15] base64_2.0.2
## [17] backports_1.5.0
## [19] limma_3.66.0
## [21] rmarkdown_2.30
## [23] doRNG_1.8.6.2
## [25] Gviz_1.54.0
## [27] DBI_1.2.3
## [29] abind_1.4-8
## [31] purrr_1.2.0
## [33] biovizBase_1.58.0
## [35] nnet_7.3-20
## [37] rappdirs_0.3.3
## [39] genefilter_1.92.0
## [41] annotate_1.88.0
## [43] codetools_0.2-20
## [45] xml2_1.5.0
## [47] UCSC.utils_1.6.0
## [49] beanplot_1.3.1
## [51] base64enc_0.1-3
## [53] GenomicAlignments_1.46.0
## [55] multtest_2.66.0
## [57] survival_3.8-3
## [59] progress_1.2.3
## [61] glue_1.8.0
## [63] SparseArray_1.10.3
## [65] GenomeInfoDb_1.46.1
## [67] HDF5Array_1.38.0
## [69] BiocManager_1.30.27
## [71] latticeExtra_0.6-31
## [73] openssl_2.3.4
## [75] R6_2.6.1
## [77] jpeg_0.1-11
## [79] biomaRt_2.66.0
## [81] cigarillo_1.0.0
## [83] tidyr_1.3.1
## [85] rtracklayer_1.70.0
## [87] prettyunits_1.2.0
## [89] S4Arrays_1.10.0
## [91] gtable_0.3.6
## [93] S7_0.2.1
## [95] htmltools_0.5.8.1
## [97] RBGL_1.86.0
## [99] scales_1.4.0
## [101] rstudioapi_0.17.1
## [103] tzdb_0.5.0
## [105] checkmate_2.3.3

scrime_1.3.5
magrittr_2.0.4
Hmisc_5.2-4
yaml_2.3.10
askpass_1.2.1
cowplot_1.2.0
RColorBrewer_1.1-3
quadprog_1.5-8
AnnotationFilter_1.34.0
RCurl_1.98-1.17
VariantAnnotation_1.56.0
rentrez_1.2.4
BiocStyle_2.38.0
DelayedMatrixStats_1.32.0
DelayedArray_0.36.0
tidyselect_1.2.1
farver_2.1.2
BiocFileCache_3.0.0
illuminaio_0.52.0
jsonlite_2.0.0
Formula_1.2-5
tools_4.5.2
Rcpp_1.1.0
gridExtra_2.3
xfun_0.54
dplyr_1.1.4
withr_3.0.2
fastmap_1.2.0
rhdf5filters_1.22.0
digest_0.6.39
colorspace_2.1-2
dichromat_2.0-0.1
RSQLite_2.4.4
h5mread_1.2.1
data.table_1.17.8
htmlwidgets_1.6.4
httr_1.4.7
pkgconfig_2.0.3
blob_1.2.4
siggenes_1.84.0
fgsea_1.36.0
ProtGenerics_1.42.0
png_0.1-8
knitr_1.50
rjson_0.2.23
nlme_3.1-168

12

## [107] curl_7.0.0
## [109] rhdf5_2.54.0
## [111] foreign_0.8-90
## [113] GEOquery_2.78.0
## [115] grid_4.5.2
## [117] vctrs_0.6.5
## [119] xtable_1.8-4
## [121] htmlTable_2.4.3
## [123] tinytex_0.58
## [125] cli_3.6.5
## [127] Rsamtools_2.26.0
## [129] crayon_1.5.3
## [131] labeling_0.4.3
## [133] interp_1.1-6
## [135] plyr_1.8.9
## [137] deldir_2.0-4
## [139] lazyeval_0.2.2
## [141] BSgenome_1.78.0
## [143] sparseMatrixStats_1.22.0
## [145] ggplot2_4.0.1
## [147] KEGGREST_1.50.0
## [149] memoise_2.0.1
## [151] bit_4.6.0

cachem_1.1.0
stringr_1.6.0
restfulr_0.0.16
pillar_1.11.1
reshape_0.8.10
dbplyr_2.5.1
cluster_2.1.8.1
evaluate_1.0.5
readr_2.1.6
compiler_4.5.2
rlang_1.1.6
rngtools_1.5.2
nor1mix_1.3-3
mclust_6.1.2
stringi_1.8.7
BiocParallel_1.44.0
Matrix_1.7-4
hms_1.1.4
bit64_4.6.0-1
Rhdf5lib_1.32.0
statmod_1.5.1
fastmatch_1.1-6

References

Du, P, X Zhang, C Huang, N Jafari, WA Kibbe, L Hou, and SM Lin. 2010.
“Comparison of Beta-Value and M-Value Methods for Quantifying Methylation
Levels by Microarray Analysis.” BMC Bioinformatics.

Jones, Peter A. 2012. “Functions of DNA Methylation: Islands, Start Sites,
Gene Bodies and Beyond.” Nature Reviews Genetics.

McGregor, K, S Bernatsky, I Colmegna, T Pastinen, A Labbe, and CMT Green-
wood. 2016. “An Evaluation of Methods Correcting for Cell-Type Heterogeneity
in DNA Methylation Studies.” Genome Biology.

13

