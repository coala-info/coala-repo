rTRMui: a shiny user interface for the
identification of transcriptional regulatory
modules

Diego Diez

October 30, 2025

1

Introduction

To install rTRMui you need to have installed rTRM and shiny. To use rTRMui
load the library and then just run runTRM() from the R prompt:

> library(rTRMui)
> runTRM()

This will open a web browser and show the rTRMui home page (Figure
1). Instructions on how to use rTRMui are available in the Help tab from the
rTRMui server. Example datasets can be downloaded from the home page and
used with the Tutorial.

2 System information

> sessionInfo()

R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LAPACK version 3.12.0

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_GB
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

1

Figure 1: rTRMui home page showing the TRM indentified using the sample
datasets from the tutorial.

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats

graphics

other attached packages:
[1] rTRMui_1.48.0

grDevices utils

datasets

methods

base

loaded via a namespace (and not attached):

[1] KEGGREST_1.50.0
[3] rjson_0.2.23
[5] lattice_0.22-7
[7] tools_4.5.1
[9] generics_0.1.4

[11] curl_7.0.0

SummarizedExperiment_1.40.0
Biobase_2.70.0
vctrs_0.6.5
bitops_1.0-9
stats4_4.5.1
parallel_4.5.1

2

Example sessionData inputNetwork parametersList of enriched motifs in Sox2 peaksList of expressed genes in mouse ESCTarget organismPlotTableTranscription factorsTutorialHelpAboutTarget transcription factorExpressed genesQuery transcription factorsFilter Ubiquitin/Sumo from PPIesc_expressed.txtsox2_motifs.txtExtended TRMStrict TRMBridge distanceSox2mouseFALSETRUE1Motif (rTRM) identiﬁerrTRMui: Identification of TranscriptionalRegulatory ModulesHdac2Pou5f1Sox15Sox2Sall4EsrrbKlf4Rad21C2H2 zinc finger factorsHigh−mobility group (HMG) domain factorsHomeo domain factorsNuclear receptors with C4 zinc fingersunclassifiedUpload completeChoose fileChoose fileUpload complete???[13] AnnotationDbi_1.72.0
[15] MotifDb_1.52.0
[17] pkgconfig_2.0.3
[19] data.table_1.17.8
[21] S4Vectors_0.48.0
[23] rTRM_1.48.0
[25] Rsamtools_2.26.0
[27] Seqinfo_1.0.0
[29] httpuv_1.6.16
[31] RCurl_1.98-1.17
[33] later_1.4.4
[35] BiocParallel_1.44.0
[37] cachem_1.1.0
[39] abind_1.4-8
[41] digest_0.6.37
[43] fastmap_1.2.0
[45] SparseArray_1.10.0
[47] magrittr_2.0.4
[49] XML_3.99-0.19
[51] bit64_4.6.0-1
[53] XVector_0.50.0
[55] matrixStats_1.5.0
[57] bit_4.6.0
[59] png_0.1-8
[61] shiny_1.11.1
[63] IRanges_2.44.0
[65] rtracklayer_1.70.0
[67] Rcpp_1.1.0
[69] DBI_1.2.3
[71] splitstackshape_1.4.8
[73] MatrixGenerics_1.22.0

RSQLite_2.4.3
blob_1.2.4
Matrix_1.7-4
cigarillo_1.0.0
lifecycle_1.0.4
compiler_4.5.1
Biostrings_2.78.0
codetools_0.2-20
htmltools_0.5.8.1
yaml_2.3.10
crayon_1.5.3
DelayedArray_0.36.0
org.Hs.eg.db_3.22.0
mime_0.13
restfulr_0.0.16
grid_4.5.1
cli_3.6.5
S4Arrays_1.10.0
promises_1.4.0
org.Mm.eg.db_3.22.0
httr_1.4.7
igraph_2.2.1
otel_0.2.0
memoise_2.0.1
GenomicRanges_1.62.0
BiocIO_1.20.0
rlang_1.1.6
xtable_1.8-4
BiocGenerics_0.56.0
R6_2.6.1
GenomicAlignments_1.46.0

3

