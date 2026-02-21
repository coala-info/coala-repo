YARN: Robust Multi-Tissue RNA-Seq Preprocessing and
Normalization

Joseph N. Paulson & John Quackenbush

2025-10-30

YARN - Yet Another RNa-seq package

The goal of yarn is to expedite large RNA-seq analyses using a combination of previously developed tools.
Yarn is meant to make it easier for the user to perform accurate comparison of conditions by leveraging
many Bioconductor tools and various statistical and normalization techniques while accounting for the large
heterogeneity and sparsity found in very large RNA-seq experiments.

Installation

You can install yarn from github with:
if (!requireNamespace("BiocManager", quietly=TRUE))

install.packages("BiocManager")

BiocManager::install("yarn")

Quick Introduction

If you’re here to grab the GTEx version 6.0 data then look no further than this gist that uses yarn to
download all the data and preprocess it for you.

Preprocessing

Below are a few of the functions we can use to preprocess a large RNA-seq experiment. We follow a particular
procedure where we:

1. Filter poor quality samples
2. Merge samples of similar conditions for increased power
3. Filter genes while preserving tissue or group specificity
4. Normalize while accounting for global differences in tissue distribution

We will make use of the skin dataset for examples. The skin dataset is a small sample of the full GTEx
data that can be downloaded using the downloadGTEx function. The skin dataset looks like this:
skin

element names: exprs

## ExpressionSet (storageMode: lockedEnvironment)
## assayData: 40824 features, 20 samples
##
## protocolData: none
## phenoData
##
##
##
##

varLabels: SAMPID SMATSSCR ... DTHHRDY (65 total)
varMetadata: labelDescription

GTEX-144FL-0626-SM-5LU43 (20 total)

rowNames: GTEX-OHPL-0008-SM-4E3I9 GTEX-145MN-1526-SM-5SI9T ...

1

featureNames: 48350 48365 ... 7565 (40824 total)
fvarLabels: ensembl_gene_id hgnc_symbol ... gene_biotype (6 total)
fvarMetadata: labelDescription

## featureData
##
##
##
## experimentData: use 'experimentData(object)'
## Annotation:

This is a basic workflow. Details will be fleshed out:

0. First always remember to have the library loaded.

library(yarn)

1. Download the GTEx gene count data as an ExpressionSet object or load the sample skin dataset.

For computational reasons we load the sample skin data instead of having the user download the
library(yarn)
data(skin)

2. Check mis-annotation of gender or other phenotypes using group-specific genes
checkMisAnnotation(skin,"GENDER",controlGenes="Y",legendPosition="topleft")

3. Decide what sub-groups should be merged
checkTissuesToMerge(skin,"SMTS","SMTSD")

2

−1001020−10−505MDS component: 1MDS component: 2124. Filter lowly expressed genes

skin_filtered = filterLowGenes(skin,"SMTSD")
dim(skin)

## Features Samples
##
20
40824
dim(skin_filtered)

## Features Samples
20
##

19933

Or group specific genes
tmp = filterGenes(skin,labels=c("X","Y","MT"),featureName = "chromosome_name")
# Keep only the sex names
tmp = filterGenes(skin,labels=c("X","Y","MT"),featureName = "chromosome_name",keepOnly=TRUE)

5. Normalize in a tissue or group-aware manner

plotDensity(skin_filtered,"SMTSD",main=expression('log'[2]*' raw expression'))

3

−150−100−50050100−60−40−2002040SkinMDS component: 1MDS component: 2skin_filtered = normalizeTissueAware(skin_filtered,"SMTSD")
plotDensity(skin_filtered,"SMTSD",normalized=TRUE,main="Normalized")

## normalizedMatrix is assumed to already be log-transformed

4

051015200.000.050.100.15log2 raw expressionoutput$xoutput$densityMat051015200.000.040.080.12Normalizedoutput$xoutput$densityMatHelper functions

Other than checkMisAnnotation and checkTissuesToMerge we provide a few plotting function. We include,
plotCMDS, plotDensity, plotHeatmap.

plotCMDS - PCoA / Classical Multi-Dimensional Scaling of the most variable genes.
data(skin)
res = plotCMDS(skin,pch=21,bg=factor(pData(skin)$SMTSD))

plotDensity - Density plots colored by phenotype of choosing. Allows for inspection of global trend
differences.
filtData = filterLowGenes(skin,"SMTSD")
plotDensity(filtData,groups="SMTSD",legendPos="topleft")

5

−150−100−50050100−60−40−2002040MDS component: 1MDS component: 2plotHeatmap - Heatmap of the most variable genes.
library(RColorBrewer)
tissues = pData(skin)$SMTSD
heatmapColColors=brewer.pal(12,"Set3")[as.integer(factor(tissues))]
heatmapCols = colorRampPalette(brewer.pal(9, "RdBu"))(50)
plotHeatmap(skin,normalized=FALSE,log=TRUE,trace="none",n=10,
col = heatmapCols,ColSideColors = heatmapColColors,cexRow = 0.25,cexCol = 0.25)

6

051015200.000.050.100.15output$xoutput$densityMatCells − Transformed fibroblastsSkin − Not Sun Exposed (Suprapubic)Skin − Sun Exposed (Lower leg)Information

sessionInfo()

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

## R version 4.5.1 Patched (2025-08-23 r88802)
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
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats
##

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

grDevices utils

graphics

datasets

methods

LAPACK version 3.12.0

base

7

GTEX−TKQ1−0008−SM−4DXSOGTEX−XBEW−0008−SM−4AT3YGTEX−X4XY−0008−SM−46MVLGTEX−PWCY−0008−SM−48TE9GTEX−SIU8−0008−SM−4BRUCGTEX−Y111−0008−SM−4SOJ3GTEX−WOFM−0008−SM−4OOSYGTEX−PWOO−0008−SM−48TDUGTEX−Y8DK−0008−SM−4RGM2GTEX−YB5E−0008−SM−4VDT7GTEX−ZE9C−0008−SM−4E3K6GTEX−VUSG−0008−SM−4KL24GTEX−OHPL−0008−SM−4E3I9GTEX−144FL−0626−SM−5LU43GTEX−13SLX−0526−SM−5S2ONGTEX−WK11−2726−SM−3NMAQGTEX−145MN−1526−SM−5SI9TGTEX−WHPG−2626−SM−3NMBRGTEX−145MG−1526−SM−5Q5EMGTEX−13JUV−2726−SM−5LZZ8ENSG00000172867.3ENSG00000167768.4ENSG00000161634.7ENSG00000203782.5ENSG00000124429.13ENSG00000165953.5ENSG00000134765.5ENSG00000178934.4ENSG00000105141.4ENSG00000134760.505101520Value0Color Keyand HistogramCountBiobase_2.70.0

yarn_1.36.0

[1] jsonlite_2.0.0
[3] GenomicFeatures_1.62.0
[5] rmarkdown_2.30
[7] vctrs_0.6.5
[9] memoise_2.0.1

## other attached packages:
## [1] RColorBrewer_1.1-3
## [4] BiocGenerics_0.56.0 generics_0.1.4
##
## loaded via a namespace (and not attached):
##
##
##
##
##
## [11] DelayedMatrixStats_1.32.0
## [13] askpass_1.2.1
## [15] htmltools_0.5.8.1
## [17] progress_1.2.3
## [19] Rhdf5lib_1.32.0
## [21] rhdf5_2.54.0
## [23] KernSmooth_2.23-26
## [25] httr2_1.2.1
## [27] GenomicAlignments_1.46.0
## [29] iterators_1.0.14
## [31] Matrix_1.7-4
## [33] fastmap_1.2.0
## [35] digest_0.6.37
## [37] reshape_0.8.10
## [39] S4Vectors_0.48.0
## [41] RSQLite_2.4.3
## [43] filelock_1.0.3
## [45] abind_1.4-8
## [47] beanplot_1.3.1
## [49] bit64_4.6.0-1
## [51] downloader_0.4.1
## [53] quantro_1.44.0
## [55] DBI_1.2.3
## [57] gplots_3.2.0
## [59] MASS_7.3-65
## [61] rappdirs_0.3.3
## [63] rjson_0.2.23
## [65] caTools_1.18.3
## [67] rentrez_1.2.4
## [69] quadprog_1.5-8
## [71] restfulr_0.0.16
## [73] rhdf5filters_1.22.0
## [75] gtable_0.3.6
## [77] preprocessCore_1.72.0
## [79] data.table_1.17.8
## [81] xml2_1.4.1
## [83] foreach_1.5.2
## [85] stringr_1.5.2
## [87] genefilter_1.92.0
## [89] dplyr_1.1.4
## [91] lattice_0.22-7
## [93] rtracklayer_1.70.0
## [95] GEOquery_2.78.0
## [97] tidyselect_1.2.1

magrittr_2.0.4
farver_2.1.2
BiocIO_1.20.0
multtest_2.66.0
Rsamtools_2.26.0
RCurl_1.98-1.17
tinytex_0.57
S4Arrays_1.10.0
curl_7.0.0
SparseArray_1.10.0
nor1mix_1.3-3
plyr_1.8.9
cachem_1.1.0
lifecycle_1.0.4
pkgconfig_2.0.3
R6_2.6.1
MatrixGenerics_1.22.0
siggenes_1.84.0
AnnotationDbi_1.72.0
GenomicRanges_1.62.0
base64_2.0.2
httr_1.4.7
compiler_4.5.1
rngtools_1.5.2
doParallel_1.0.17
S7_0.2.0
BiocParallel_1.44.0
HDF5Array_1.38.0
biomaRt_2.66.0
openssl_2.3.4
DelayedArray_0.36.0
gtools_3.9.5
tools_4.5.1
glue_1.8.0
h5mread_1.2.0
nlme_3.1-168
grid_4.5.1
tzdb_0.5.0
tidyr_1.3.1
hms_1.1.4
XVector_0.50.0
pillar_1.11.1
limma_3.66.0
splines_4.5.1
BiocFileCache_3.0.0
survival_3.8-3
bit_4.6.0
annotate_1.88.0
locfit_1.5-9.12

8

## [99] Biostrings_2.78.0
## [101] IRanges_2.44.0
## [103] edgeR_4.8.0
## [105] stats4_4.5.1
## [107] scrime_1.3.5
## [109] matrixStats_1.5.0
## [111] yaml_2.3.10
## [113] codetools_0.2-20
## [115] tibble_3.3.0
## [117] cli_3.6.5
## [119] xtable_1.8-4
## [121] Rcpp_1.1.0
## [123] png_0.1-8
## [125] parallel_4.5.1
## [127] ggplot2_4.0.0
## [129] prettyunits_1.2.0
## [131] doRNG_1.8.6.2
## [133] bitops_1.0-9
## [135] illuminaio_0.52.0
## [137] crayon_1.5.3
## [139] KEGGREST_1.50.0

knitr_1.50
Seqinfo_1.0.0
SummarizedExperiment_1.40.0
xfun_0.53
statmod_1.5.1
stringi_1.8.7
evaluate_1.0.5
cigarillo_1.0.0
minfi_1.56.0
bumphunter_1.52.0
dichromat_2.0-0.1
dbplyr_2.5.1
XML_3.99-0.19
readr_2.1.5
blob_1.2.4
mclust_6.1.1
sparseMatrixStats_1.22.0
scales_1.4.0
purrr_1.1.0
rlang_1.1.6

9

