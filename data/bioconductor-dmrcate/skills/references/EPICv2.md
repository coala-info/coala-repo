DMRcate for EPICv2

Peters TJ

October 29, 2025

Summary

Worked example to find DMRs from EPICv2 arrays between B cell

ALL and T cell ALL samples.

if (!require("BiocManager"))

install.packages("BiocManager")

BiocManager::install("DMRcate")

The Illumina Infinium HumanMethylationEPIC v2.0 BeadChip (EPICv2)
extends genomic coverage to more than 920,000 CpG sites. One of the new
characteristics of this array compared to previous versions is that it contains
instances of multiple probes (or “replicates”) that map to the same CpG site.
This is potentially useful for performance testing of probes, but for DMRcate
we need a 1-to-1 mapping of probe to CpG site, otherwise the kernel will be
biased towards those sites with more replicates. This vignette will show how to
pare down an EPICv2 dataset to a suitable format for DMR calling. We use
the AnnotationHub package EPICv2manifest[1] as a backend for this purpose.

library(DMRcate)

We use a subset of samples kindly taken from Noguera-Castells et al. (2023)[2],

for finding DMRs between T cell acute lymphoblastic leukaemia (TALL) and
B cell acute lymphoblastic leukaemia (BALL). We load the beta matrix from
ExperimentHub:

library(ExperimentHub)
eh <- ExperimentHub()
ALLbetas <- eh[["EH9451"]]
head(ALLbetas)

TALL_01
##
## cg00000029_TC21 0.51221200 0.8123723 0.4522275 0.7993704 0.2033696 0.7856451
## cg00000109_TC21 0.87596630 0.4896535 0.8292074 0.2289017 0.6004454 0.9133542
## cg00000155_BC21 0.88927350 0.8942796 0.9044124 0.9417848 0.9060851 0.9204409

BALL_02

BALL_01

BALL_03

BALL_04

BALL_05

1

## cg00000158_BC21 0.91496990 0.9127220 0.9164246 0.9158492 0.9305084 0.9199422
## cg00000165_TC21 0.08777337 0.2067737 0.1017819 0.1056683 0.4797166 0.0651125
## cg00000221_BC21 0.84573060 0.8298593 0.7151204 0.8186862 0.8489285 0.8596191
##
TALL_05
## cg00000029_TC21 0.88279680 0.8663721 0.88071230 0.8594255
## cg00000109_TC21 0.93277520 0.9023123 0.89303100 0.8841929
## cg00000155_BC21 0.91436200 0.9156632 0.91978220 0.9256892
## cg00000158_BC21 0.92858330 0.9306610 0.93371590 0.9376163
## cg00000165_TC21 0.07799849 0.3776332 0.06911442 0.0788177
## cg00000221_BC21 0.85424070 0.8713877 0.88269830 0.8905514

TALL_02

TALL_03

TALL_04

There are 5 TALL samples and 5 BALL samples, which, at a glance, may

have distinct methylation profiles.

plot(density(ALLbetas[,1]), col="forestgreen", xlab="Beta value", ylim=c(0, 6),

main="Noguera-Castells et al. 2023 ALL samples", lwd=2)

invisible(sapply(2:5, function (x) lines(density(ALLbetas[,x]), col="forestgreen", lwd=2)))
invisible(sapply(6:10, function (x) lines(density(ALLbetas[,x]), col="orange", lwd=2)))
legend("topleft", c("B cell ALL", "T cell ALL"), text.col=c("forestgreen", "orange"))

2

Now let’s logit2 transform the betas into M -values, which approximate nor-

mality for linear modelling.

ALLMs <- minfi::logit2(ALLbetas)

Just like with the previous EPIC array, there are subsets of probes whose
target is near a SNP, and also subsets for which there is evidence of cross-
reactivity with other parts of the genome[1], both which can be filtered out
with with rmSNPandCH(). We will filter out the SNP-proximal probes, but for
this vignette, we will retain the EPICv2 probes for which there is evidence
for preferential binding to off-targets, using rmcrosshyb=FALSE, since these off-
targets have also been mapped[1].

nrow(ALLMs)

## [1] 894902

3

0.00.20.40.60.81.00123456Noguera−Castells et al. 2023 ALL samplesBeta valueDensityB cell ALLT cell ALLALLMs.noSNPs <- rmSNPandCH(ALLMs, rmcrosshyb = FALSE)

## Assuming EPICv2 data.
## see ?DMRcatedata and browseVignettes(’DMRcatedata’) for documentation
## loading from cache

Proceeding...

nrow(ALLMs.noSNPs)

## [1] 893321

EPICv2 data contains groups of probes we call “replicates” that map to the
same CpG site. Since DMRcate requires a 1-to-1 relationship between rows
of methylation measurements and CpG loci, lest the kernel become biased to-
wards sites with multiple mappings, we need to attenuate our M -value matrix
to maintain this relationship. cpg.annotate() now does this when arraytype
= "EPICv2", with user options specified by the argument epicv2Filter. The
default is to take the mean of each replicate group (with row name represented
by the first probe in each group that appears in the manifest). However, we
can also select one probe from each replicate group based on its performance
from cross-platform comparisons with EPICv1 and WGBS data (see Peters et
al. 2024)[1]. Probe robustness is measured in terms of either:

• its sensitivity to methylation change and measurement precision, relative
to a platform consensus obtained from matched EPICv1 and whole genome
bisulphite sequencing (WGBS) values[3].

• minimum root mean squared error (RMSE) with WGBS (mainly for probes

that don’t appear on EPICv1)

In some cases, a replicated probe will prove superior in both sensitivity
and precision, however in other cases superior sensitivity and precision is split
between two probes in a replicate group. Alternatively, an individual probe
may have superior sensitivity in a group, but superior precision is incurred by
the group mean. Hence we give the user the option of choosing sensitivity
In cases
or precision, based on their appetite for potential Type I error.
where there is insufficient evidence for superiority, a replicate probe is taken at
random from the group. This strategy is generalised to all replicate groups for
the random option. Figure 1 shows the differences in probe selection based on the
epicv2Filter argument. In practice, the number of differentially methylated
CpGs (and hence DMRs) is unlikely to vary greatly depending onepicv2Filter,
but we provide this optionality to make use of all available probes on the array,
and to potentially update the manifest with more rigorous probe benchmarking
as usage proliferates.

The main event, however, is calling DMRs. Let’s take our replicate-averaged
M -value matrix and specify our hypothesis to call DMRs between T cell and B
cell ALL samples:

4

Figure 1: Variation in probe selection based on the epicv2Filter argument
from cpg.annotate(). Values in the “Random” group may differ when repro-
duced.

5

4453271064841710882722476760610528271840497956336MeanSensitivityPrecisionRandomtype <- gsub("_.*", "", colnames(ALLMs.noSNPs))
type

## [1] "BALL" "BALL" "BALL" "BALL" "BALL" "TALL" "TALL" "TALL" "TALL" "TALL"

design <- model.matrix(~type)
design

(Intercept) typeTALL
0
1
0
1
0
1
0
1
0
1
1
1
1
1
1
1
1
1
1
1

##
## 1
## 2
## 3
## 4
## 5
## 6
## 7
## 8
## 9
## 10
## attr(,"assign")
## [1] 0 1
## attr(,"contrasts")
## attr(,"contrasts")$type
## [1] "contr.treatment"

Now for cpg.annotate(). In addition to epicv2Filter, we have also added
an extra logical argument epicv2Remap giving the user the option of reassigning
probes to an off-target CpG site where there is evidence (based on both in silico
alignment and concordance with WGBS data) that the probe is preferentially
hybridising to that site. As stated previously, this will only apply when you
have specified rmcrosshyb=FALSE in rmSNPandCH().

myannotation <- cpg.annotate("array", object=ALLMs.noSNPs, what = "M",

arraytype = "EPICv2", epicv2Filter = "mean",
epicv2Remap = TRUE,
design=design, coef=2, fdr=0.001)

analysis.type="differential",

IlluminaHumanMethylationEPICv2anno.20a1.hg38

## Loading required package:
##
## Attaching package: ’IlluminaHumanMethylationEPICv2anno.20a1.hg38’
## The following objects are masked from ’package:IlluminaHumanMethylationEPICanno.ilm10b4.hg19’:
##
##
##
##
## EPICv2 specified. Loading manifest...

Islands.UCSC, Locations, Manifest, Other, SNPs.141CommonSingle,
SNPs.142CommonSingle, SNPs.144CommonSingle, SNPs.146CommonSingle,
SNPs.147CommonSingle, SNPs.Illumina

6

## loading from cache
## Remapping 4257 cross-hybridising probes to their more likely offtarget...
## Replicate probes that map to the same CpG site found.
these using strategy:
## Averaging probes that map to the same CpG site...
## Your contrast returned 29047 individually significant probes.
recommend the default setting of pcutoff in dmrcate().

Filtering

mean

We

And then, as usual, call DMRs and annotate them. Unlike previous arrays,

the EPICv2 manifest is in hg38:

dmrcoutput <- dmrcate(myannotation, lambda=1000, C=2)

## Fitting chr1...
## Fitting chr2...
## Fitting chr3...
## Fitting chr4...
## Fitting chr5...
## Fitting chr6...
## Fitting chr7...
## Fitting chr8...
## Fitting chr9...
## Fitting chr10...
## Fitting chr11...
## Fitting chr12...
## Fitting chr13...
## Fitting chr14...
## Fitting chr15...
## Fitting chr16...
## Fitting chr17...
## Fitting chr18...
## Fitting chr19...
## Fitting chr20...
## Fitting chr21...
## Fitting chr22...
## Fitting chrX...
## Fitting chrY...
## Demarcating regions...
## Done!

results.ranges <- extractRanges(dmrcoutput, genome = "hg38")

## see ?DMRcatedata and browseVignettes(’DMRcatedata’) for documentation
## loading from cache

results.ranges

7

ranges strand |

no.cpgs min_smoothed_fdr
<numeric>
0
0
0
0
0
...
5.34528e-41
1.06962e-40
1.10478e-40
1.17061e-40
1.34069e-40

Stouffer
<numeric>

[1]
[2]
[3]
[4]
[5]
...
[5413]
[5414]
[5415]
[5416]
[5417]

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

seqnames
<Rle>
chr6
chr6
chr11
chr6
chr14
...
chr14
chr12

<Rle> | <integer>
41
38
38
28
28
...
2
2
2
5
2
maxdiff

<IRanges>
30882160-30885831
30687420-30690899
2300540-2303171
33296433-33298636
24309705-24314414
...
20436144-20436161
989909-989951
chr8 133150430-133150597
73452188-73452366
chr6
79432175-79432177
chr15

HMFDR
meandiff
<numeric>
<numeric> <numeric> <numeric>
7.55915e-75
[1] 1.50093e-62 3.35855e-07
0.272205
0.696182
[2] 1.98207e-74 1.81471e-07
1.02273e-92
0.333864
0.698081
[3] 9.67480e-127 1.02263e-06 1.64817e-116
0.465320
0.627270
1.24612e-33
[4] 4.97033e-19 2.79592e-08
0.134404
0.660271
1.74338e-68
[5] 3.08456e-63 1.42869e-08
0.397637
0.723681
...
...
...
...
...
...
7.64737e-08
[5413] 3.45044e-08 4.82080e-05
0.455263
0.508742
7.02143e-08
[5414] 3.51155e-08 2.07525e-05
0.351907
0.522598
1.65176e-08
[5415] 2.14817e-08 4.36006e-07
0.549779
0.659607
0.455907
6.63229e-12
[5416] 3.24687e-13 2.53275e-04
0.545741
1.74023e-08 -0.467182 -0.418720
[5417] 7.42320e-09 2.12505e-05

## GRanges object with 5417 ranges and 8 metadata columns:
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
DDR1
[1]
PPP1R18, NRM
[2]
TSPAN32, C11orf21
[3]
[4]
PFDN6, RGL2
[5] LTB4R2, LTB4R, CIDEB
...
...
[5413]
KLHL33
RAD52, AC004803.1
[5414]
<NA>
[5415]
CGAS
[5416]
[5417]
<NA>
-------
seqinfo: 23 sequences from an unspecified genome; no seqlengths

And finally, plotting one of the top DMRs.

8

groups <- c(BALL="forestgreen", TALL="orange")
cols <- groups[as.character(type)]
DMR.plot(ranges=results.ranges, dmr=3, CpGs=myannotation,

what = "Beta", arraytype = "EPICv2", phen.col=cols, genome = "hg38")

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

9

LAPACK version 3.12.0

Chromosome 112.296 mb2.297 mb2.298 mb2.299 mb2.3 mb2.301 mb2.302 mb2.303 mb2.304 mb2.305 mb2.306 mb2.307 mbENSEMBLTSPAN32TSPAN32TSPAN32TSPAN32TSPAN32TSPAN32TSPAN32TSPAN32TSPAN32TSPAN32TSPAN32TSPAN32C11orf21C11orf21C11orf21C11orf21C11orf21DMRBALL_05BALL_04BALL_03BALL_02BALL_0100.20.40.60.8BALLTALL_05TALL_04TALL_03TALL_02TALL_0100.20.40.60.8TALL00.20.40.60.8Group means (with 0.3 CI)BALLTALLdatasets

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
## [1] IlluminaHumanMethylationEPICv2anno.20a1.hg38_1.0.0
## [2] DMRcatedata_2.27.0
## [3] IlluminaHumanMethylationEPICanno.ilm10b4.hg19_0.6.0
## [4] IlluminaHumanMethylationEPICmanifest_0.3.0
## [5] FlowSorted.Blood.EPIC_2.13.0
## [6] minfi_1.56.0
## [7] bumphunter_1.52.0
## [8] locfit_1.5-9.12
## [9] iterators_1.0.14
## [10] foreach_1.5.2
## [11] Biostrings_2.78.0
## [12] XVector_0.50.0
## [13] SummarizedExperiment_1.40.0
## [14] Biobase_2.70.0
## [15] MatrixGenerics_1.22.0
## [16] matrixStats_1.5.0
## [17] GenomicRanges_1.62.0
## [18] Seqinfo_1.0.0
## [19] IRanges_2.44.0
## [20] S4Vectors_0.48.0
## [21] ExperimentHub_3.0.0
## [22] AnnotationHub_4.0.0
## [23] BiocFileCache_3.0.0
## [24] dbplyr_2.5.1
## [25] BiocGenerics_0.56.0
## [26] generics_0.1.4
## [27] DMRcate_3.6.0
##
## loaded via a namespace (and not attached):

10

[1] splines_4.5.1
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

11

## [46] DelayedArray_0.36.0
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

12

## [91] prettyunits_1.2.0
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

13

## [136] rlang_1.1.6
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

[1] Peters, T.J., Meyer, B., Ryan, L., Achinger-Kawecka, J., Song, J., Camp-
bell, E.M., Qu, W., Nair, S., Loi-Luu, P., Stricker, P., Lim, E., Stirzaker,
C., Clark, S.J. and Pidsley, (2024). Characterisation and reproducibility of
the HumanMethylationEPIC v2.0 BeadChip for DNA methylation profil-
ing. BMC Genomics 25, 251. doi:10.1186/s12864-024-10027-5.

[2] Noguera-Castells A, Garcia-Prieto CA, Alvarez-Errico D, Esteller, M.
(2023). Validation of the new EPIC DNA methylation microarray (900K
EPIC v2) for high-throughput profiling of the human DNA methylome.
Epigenetics 18(1), 2185742.

[3] Peters TJ, French HJ, Bradford ST, Pidsley R, Stirzaker C, Varinli H, Nair,
S, Qu W, Song J, Giles KA, Statham AL, Speirs H, Speed TP, Clark, SJ.
(2019). Evaluation of cross-platform and interlaboratory concordance via
consensus modelling of genomic measurements. Bioinformatics, 2019 35(4),
560-570.

14

