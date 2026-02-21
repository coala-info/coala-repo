Calling DMRs from EPICv1 and 450K data

Peters TJ

October 29, 2025

Summary

This vignette demonstrates how to call DMRs from older versions of

Illumina arrays, namely 450K and EPICv1 (pre-2022).

if (!require("BiocManager"))

install.packages("BiocManager")

BiocManager::install("DMRcate")

Load DMRcate into the workspace:

library(DMRcate)

For this vignette, we will demonstrate DMRcate’s array utility using data
from ExperimentHub, namely Illumina HumanMethylationEPIC data from the
data packages FlowSorted.Blood.EPIC. Specifically, we are interested in the
methylation differences between CD4+ and CD8+ T cells.

library(ExperimentHub)
eh <- ExperimentHub()
FlowSorted.Blood.EPIC <- eh[["EH1136"]]
tcell <- FlowSorted.Blood.EPIC[,colData(FlowSorted.Blood.EPIC)$CD4T==100 |
colData(FlowSorted.Blood.EPIC)$CD8T==100]

Firstly we filter out any probes where any sample has a failed position.
Then we normalise using minfi::preprocessFunnorm. For this vignette, we
will restrict the analysis to chromosome 2. After this, we extract the M -values
from the GenomicRatioSet.

detP <- detectionP(tcell)

## Loading required package:

IlluminaHumanMethylationEPICmanifest

remove <- apply(detP, 1, function (x) any(x > 0.01))
tcell <- preprocessFunnorm(tcell)

1

## [preprocessFunnorm] Background and dye bias correction with noob
## Loading required package:
## [preprocessFunnorm] Mapping to genome
## [preprocessFunnorm] Quantile extraction
## [preprocessFunnorm] Normalization

IlluminaHumanMethylationEPICanno.ilm10b4.hg19

tcell <- tcell[seqnames(tcell) %in% "chr2",]
tcell <- tcell[!rownames(tcell) %in% names(which(remove)),]
tcellms <- getM(tcell)

M -values (logit-transform of beta) are preferable to beta values for signifi-
cance testing via limma since they approximate normality, and provide greater
sensitivity towards the extremes of the distribution, but we will use a beta
matrix for visualisation purposes later on.

Some of the methylation measurements on the array may be confounded by
proximity to SNPs, and cross-hybridisation to other areas of the genome[1, 2].
In particular, probes that are 0, 1, or 2 nucleotides from the methylcytosine of
interest show a markedly different distribution to those farther away, in healthy
tissue (Figure 1).

It is with this in mind that we filter out probes 2 nucleotides or closer to a
SNP that have a minor allele frequency greater than 0.05, and the approximately
48,000 [1, 2] cross-reactive probes on either 450K and/or EPIC, so as to reduce
confounding. Here we use a combination of in silico analyses from [1, 2]. About
4,000 are removed from our M-matrix of 64,729 chromosome 2 probes:

nrow(tcellms)

## [1] 64729

tcellms.noSNPs <- rmSNPandCH(tcellms, dist=2, mafcut=0.05)
nrow(tcellms.noSNPs)

## [1] 60445

Here we have 6 CD8+ T cell assays, and 7 CD4+ T cell assays; we want
to call DMRs between these groups. One of the CD4+ assays is a technical
replicate, so we will average these two replicates like so:

tcell$Replicate

## [1] ""
## [7] ""
## [13] ""

""
""

""
""

""
""
""
"Th2535-1" "Th2535-1" ""

tcell$Replicate[tcell$Replicate==""] <- tcell$Sample_Name[tcell$Replicate==""]
tcellms.noSNPs <- limma::avearrays(tcellms.noSNPs, tcell$Replicate)
tcell <- tcell[,!duplicated(tcell$Replicate)]

2

Figure 1: Beta distribution of 450K probes from publicly available data from
blood samples of healthy individuals [3] by their proximity to a SNP. “All SNP
probes” refers to the 153,113 probes listed by Illumina whose values may po-
tentially be confounded by a SNP.

3

0.00.20.40.60.81.001234Heyn et al. 450k beta distribution by distance to SNPbeta valueDensityDistance from CpG (nucleotides)01234530All probesAll SNP probestcell <- tcell[rownames(tcellms.noSNPs),]
colnames(tcellms.noSNPs) <- colnames(tcell)
assays(tcell)[["M"]] <- tcellms.noSNPs
assays(tcell)[["Beta"]] <- ilogit2(tcellms.noSNPs)

Next we want to annotate our matrix of M-values with relevant information.
We also use the backbone of the limma pipeline for differential array analysis.
We want to compare within patients across tissue samples, so we set up our
variables for a standard limma pipeline, and set coef=2 in cpg.annotate()
since this corresponds to the phenotype comparison in design.

cpg.annotate() takes either a data matrix with Illumina probe IDs, or an

already prepared GenomicRatioSet from minfi.

type <- factor(tcell$CellType)
design <- model.matrix(~type)
myannotation <- cpg.annotate("array", tcell, arraytype = "EPICv1",

analysis.type="differential", design=design, coef=2)

myannotation

## CpGannotated object describing 60445 CpG sites, with independent
## CpG threshold indexed at fdr=0.05 and 2710 significant CpG sites.

Now we can find our most differentially methylated regions with dmrcate().
For each chromosome, two smoothed estimates are computed: one weighted
with per-CpG t-statistics and one not, for a null comparison. The two estimates
are compared via a Satterthwaite approximation[4], and a significance test is
calculated at all hg19 coordinates that an input probe maps to. After fdr-
correction, regions are then aggregated from groups of post-smoothed significant
probes where the distance to the next consecutive probe is less than lambda
nucleotides.

dmrcoutput <- dmrcate(myannotation, lambda=1000, C=2)

## Fitting chr2...
## Demarcating regions...
## Done!

dmrcoutput

## DMResults object with 439 DMRs.
## Use extractRanges() to produce a GRanges object of these.

We can convert our DMR list to a GRanges object, which uses the genome

argument to annotate overlapping gene loci.

4

results.ranges <- extractRanges(dmrcoutput, genome = "hg19")
results.ranges

ranges strand |

HMFDR
<numeric>

[1]
[2]
[3]
[4]
[5]
...
[435]
[436]
[437]
[438]
[439]

no.cpgs min_smoothed_fdr
<numeric>
0.00000e+00
1.60075e-217
2.82449e-203
1.25063e-192
2.04178e-186
...
6.91077e-10
7.61333e-10
7.67192e-10
8.57482e-10
9.29532e-10

seqnames
<Rle>
chr2
chr2
chr2
chr2
chr2
...

* |
* |
* |
* |
* |
... .
* |
* |
* |
* |
* |
Fisher

<Rle> | <integer>
26
3
3
14
5
...
3
2
2
2
2
maxdiff
<numeric> <numeric>

<IRanges>
87014979-87021117
55757156-55758066
86991846-86992657
47382287-47383720
16804409-16805111
...
chr2 177001256-177001263
chr2 173940027-173940121
chr2 121200209-121200256
chr2
97653250-97653274
chr2 235372794-235372807
Stouffer
<numeric>

meandiff
<numeric>
[1] 7.16441e-104 2.37743e-09 7.62396e-121 -0.733427 -0.2363118
2.95110e-18
[2] 2.41969e-12 2.11366e-09
0.3581240
1.08991e-24 -0.530621 -0.3957358
[3] 6.90089e-26 2.73817e-09
7.36384e-23 -0.390790 -0.0725018
[4] 2.75767e-14 1.11231e-08
0.1485379
4.86124e-18
[5] 4.72125e-13 7.23394e-09
...
...
...
...
...
0.0272108
[435] 4.81046e-04 0.021578272
0.0306643
[436] 1.90391e-02 0.009898381
0.0400848
[437] 5.20056e-03 0.013052579
0.0317424
[438] 1.88832e-03 0.019643093
0.0779999
[439] 6.15414e-06 0.000740696

## GRanges object with 439 ranges and 8 metadata columns:
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##

overlapping.genes
<character>
CD8A
[1]
CCDC104
[2]
[3]
RMND5A
[4] C2orf61, RP11-761B3.1
FAM49A
[5]
...
...
HOXD-AS2
[435]
<NA>
[436]
<NA>
[437]
FAM178B
[438]
<NA>
[439]
-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

0.379510
...
1.35216e-03 0.0456072
1.30850e-02 0.0526885
6.73553e-03 0.0408411
3.49786e-03 0.0376177
1.17971e-05 0.0849654

0.541286

5

DMRs are ranked by Fisher’s multiple comparison statistic, but Stouffer
scores and the harmonic mean of the individual component FDRs (HMFDR) are
also given in this object as alternative options for ranking DMR significance.

We can then pass this GRanges object to DMR.plot(), which uses the Gviz

package as a backend for contextualising each DMR.

groups <- c(CD8T="magenta", CD4T="forestgreen")
cols <- groups[as.character(type)]
cols

CD8T
##
CD4T
"magenta"
## "forestgreen"
CD8T
CD8T
##
"magenta"
"magenta"
##
##
CD4T
CD4T
## "forestgreen" "forestgreen"

CD4T

CD8T

CD4T
"magenta" "forestgreen" "forestgreen"
CD4T
"magenta" "forestgreen"

CD8T
"magenta"

CD8T

DMR.plot(ranges=results.ranges, dmr=1, CpGs=myannotation, what="Beta",
arraytype = "EPICv1", phen.col=cols, genome="hg19")

6

Consonant with the expected biology, our top DMR shows the CD8+ T cells
hypomethylated across parts of the CD8A locus. The two distinct hypomethy-
lated sections have been merged because they are less than 1000 bp apart -
specified by lambda in the call to dmrcate(). To call these as separate DMRs,
make lambda smaller.

sessionInfo()

## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0
##

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

7

LAPACK version 3.12.0

Chromosome 287.015 mb87.02 mb87.025 mbCD8ACD8ACD8ACD8ACD8ACD8ACD8ACD8ACD8ADMRX201870610111_R06C01X201870610111_R04C01X201869680030_R01C01X201868590243_R03C01X201868590206_R08C01X201868590193_R03C0100.20.40.60.8CD4TX201869680009_R08C01X201868590267_R08C01X201868590267_R06C01X201868590243_R06C01X201868590206_R05C01X201868590206_R04C0100.20.40.60.8CD8T00.20.40.60.8Group means (with 0.3 CI)CD4TCD8Tdatasets

grDevices utils

stats

graphics

stats4
base

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

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
## [1] parallel
## [8] methods
##
## other attached packages:
## [1] DMRcatedata_2.27.0
## [2] IlluminaHumanMethylationEPICanno.ilm10b4.hg19_0.6.0
## [3] IlluminaHumanMethylationEPICmanifest_0.3.0
## [4] FlowSorted.Blood.EPIC_2.13.0
## [5] minfi_1.56.0
## [6] bumphunter_1.52.0
## [7] locfit_1.5-9.12
## [8] iterators_1.0.14
## [9] foreach_1.5.2
## [10] Biostrings_2.78.0
## [11] XVector_0.50.0
## [12] SummarizedExperiment_1.40.0
## [13] Biobase_2.70.0
## [14] MatrixGenerics_1.22.0
## [15] matrixStats_1.5.0
## [16] GenomicRanges_1.62.0
## [17] Seqinfo_1.0.0
## [18] IRanges_2.44.0
## [19] S4Vectors_0.48.0
## [20] ExperimentHub_3.0.0
## [21] AnnotationHub_4.0.0
## [22] BiocFileCache_3.0.0
## [23] dbplyr_2.5.1
## [24] BiocGenerics_0.56.0
## [25] generics_0.1.4
## [26] DMRcate_3.6.0
##
## loaded via a namespace (and not attached):
##

[1] splines_4.5.1

8

[2] BiocIO_1.20.0
[3] bitops_1.0-9
[4] filelock_1.0.3
[5] cellranger_1.1.0
[6] tibble_3.3.0
[7] R.oo_1.27.1
[8] preprocessCore_1.72.0
[9] XML_3.99-0.19

##
##
##
##
##
##
##
##
## [10] rpart_4.1.24
## [11] lifecycle_1.0.4
## [12] httr2_1.2.1
## [13] edgeR_4.8.0
## [14] base64_2.0.2
## [15] lattice_0.22-7
## [16] ensembldb_2.34.0
## [17] MASS_7.3-65
## [18] scrime_1.3.5
## [19] backports_1.5.0
## [20] magrittr_2.0.4
## [21] limma_3.66.0
## [22] Hmisc_5.2-4
## [23] rmarkdown_2.30
## [24] yaml_2.3.10
## [25] doRNG_1.8.6.2
## [26] askpass_1.2.1
## [27] Gviz_1.54.0
## [28] DBI_1.2.3
## [29] RColorBrewer_1.1-3
## [30] abind_1.4-8
## [31] quadprog_1.5-8
## [32] purrr_1.1.0
## [33] R.utils_2.13.0
## [34] AnnotationFilter_1.34.0
## [35] biovizBase_1.58.0
## [36] RCurl_1.98-1.17
## [37] nnet_7.3-20
## [38] VariantAnnotation_1.56.0
## [39] rappdirs_0.3.3
## [40] rentrez_1.2.4
## [41] genefilter_1.92.0
## [42] annotate_1.88.0
## [43] permute_0.9-8
## [44] DelayedMatrixStats_1.32.0
## [45] codetools_0.2-20
## [46] DelayedArray_0.36.0

9

## [47] xml2_1.4.1
## [48] tidyselect_1.2.1
## [49] UCSC.utils_1.6.0
## [50] farver_2.1.2
## [51] beanplot_1.3.1
## [52] base64enc_0.1-3
## [53] illuminaio_0.52.0
## [54] GenomicAlignments_1.46.0
## [55] jsonlite_2.0.0
## [56] multtest_2.66.0
## [57] Formula_1.2-5
## [58] survival_3.8-3
## [59] missMethyl_1.44.0
## [60] tools_4.5.1
## [61] progress_1.2.3
## [62] Rcpp_1.1.0
## [63] glue_1.8.0
## [64] gridExtra_2.3
## [65] SparseArray_1.10.0
## [66] xfun_0.53
## [67] GenomeInfoDb_1.46.0
## [68] dplyr_1.1.4
## [69] HDF5Array_1.38.0
## [70] withr_3.0.2
## [71] IlluminaHumanMethylation450kanno.ilmn12.hg19_0.6.1
## [72] BiocManager_1.30.26
## [73] fastmap_1.2.0
## [74] latticeExtra_0.6-31
## [75] rhdf5filters_1.22.0
## [76] openssl_2.3.4
## [77] digest_0.6.37
## [78] R6_2.6.1
## [79] colorspace_2.1-2
## [80] gtools_3.9.5
## [81] jpeg_0.1-11
## [82] dichromat_2.0-0.1
## [83] biomaRt_2.66.0
## [84] RSQLite_2.4.3
## [85] cigarillo_1.0.0
## [86] R.methodsS3_1.8.2
## [87] h5mread_1.2.0
## [88] tidyr_1.3.1
## [89] data.table_1.17.8
## [90] rtracklayer_1.70.0
## [91] prettyunits_1.2.0

10

## [92] httr_1.4.7
## [93] htmlwidgets_1.6.4
## [94] S4Arrays_1.10.0
## [95] pkgconfig_2.0.3
## [96] gtable_0.3.6
## [97] blob_1.2.4
## [98] S7_0.2.0
## [99] siggenes_1.84.0
## [100] htmltools_0.5.8.1
## [101] ProtGenerics_1.42.0
## [102] scales_1.4.0
## [103] png_0.1-8
## [104] knitr_1.50
## [105] rstudioapi_0.17.1
## [106] tzdb_0.5.0
## [107] rjson_0.2.23
## [108] nlme_3.1-168
## [109] checkmate_2.3.3
## [110] curl_7.0.0
## [111] org.Hs.eg.db_3.22.0
## [112] cachem_1.1.0
## [113] rhdf5_2.54.0
## [114] stringr_1.5.2
## [115] BiocVersion_3.22.0
## [116] foreign_0.8-90
## [117] AnnotationDbi_1.72.0
## [118] restfulr_0.0.16
## [119] GEOquery_2.78.0
## [120] pillar_1.11.1
## [121] grid_4.5.1
## [122] reshape_0.8.10
## [123] vctrs_0.6.5
## [124] beachmat_2.26.0
## [125] xtable_1.8-4
## [126] cluster_2.1.8.1
## [127] htmlTable_2.4.3
## [128] evaluate_1.0.5
## [129] bsseq_1.46.0
## [130] readr_2.1.5
## [131] GenomicFeatures_1.62.0
## [132] cli_3.6.5
## [133] compiler_4.5.1
## [134] Rsamtools_2.26.0
## [135] rngtools_1.5.2
## [136] rlang_1.1.6

11

## [137] crayon_1.5.3
## [138] nor1mix_1.3-3
## [139] mclust_6.1.1
## [140] interp_1.1-6
## [141] plyr_1.8.9
## [142] stringi_1.8.7
## [143] deldir_2.0-4
## [144] BiocParallel_1.44.0
## [145] lazyeval_0.2.2
## [146] Matrix_1.7-4
## [147] BSgenome_1.78.0
## [148] hms_1.1.4
## [149] sparseMatrixStats_1.22.0
## [150] bit64_4.6.0-1
## [151] ggplot2_4.0.0
## [152] Rhdf5lib_1.32.0
## [153] KEGGREST_1.50.0
## [154] statmod_1.5.1
## [155] highr_0.11
## [156] memoise_2.0.1
## [157] bit_4.6.0
## [158] readxl_1.4.5

References

[1] Pidsley R, Zotenko E, Peters TJ, Lawrence MG, Risbridger GP, Molloy
P, Van Dijk S, Muhlhausler B, Stirzaker C, Clark SJ. Critical evaluation
of the Illumina MethylationEPIC BeadChip microarray for whole-genome
DNA methylation profiling. Genome Biology. 2016 17(1), 208.

[2] Chen YA, Lemire M, Choufani S, Butcher DT, Grafodatskaya D, Zanke
BW, Gallinger S, Hudson TJ, Weksberg R. Discovery of cross-reactive
probes and polymorphic CpGs in the Illumina Infinium HumanMethyla-
tion450 microarray. Epigenetics. 2013 Jan 11;8(2).

[3] Heyn H, Li N, Ferreira HJ, Moran S, Pisano DG, Gomez A, Esteller M.
Distinct DNA methylomes of newborns and centenarians. Proceedings of
the National Academy of Sciences. 2012 109(26), 10522-7.

[4] Satterthwaite FE. An Approximate Distribution of Estimates of Variance

Components., Biometrics Bulletin. 1946 2: 110-114

12

