DMRcate for bisulfite sequencing

Peters TJ

October 29, 2025

Summary

Worked example to find DMRs from whole genome bisulfite sequencing

data.

if (!require("BiocManager"))

install.packages("BiocManager")

BiocManager::install("DMRcate")

Load DMRcate into the workspace:

library(DMRcate)

Bisulfite sequencing assays are fundamentally different to arrays, because
methylation is represented as a pair of methylated and unmethylated reads per
sample, instead of a single beta value. Although we could simply take the logit-
transformed fraction of methylated reads per CpG, this removes the effect of
varying read depth across the genome. For example, a sampling depth of 30
methylated reads and 10 unmethylated reads is a much more precise estimate of
the methylation level of a given CpG site than 3 methylated and 1 unmethylated.
Hence, we take advantage of the fact that the overall effect can be expressed as an
interaction between the coefficient of interest and a two-level factor representing
methylated and unmethylated reads [1].

The example shown here will be performed on a BSseq object containing
bisulfite sequencing of regulatory T cells from various tissues as part of the
tissueTreg package[2], imported using ExperimentHub. First, we will import
the data:

library(ExperimentHub)
eh <- ExperimentHub()
bis_1072 <- eh[["EH1072"]]
bis_1072

## An object of type 'BSseq' with
##

21867550 methylation loci

1

15 samples

##
## has been smoothed with
##
## All assays are in-memory

BSmooth (ns = 70, h = 1000, maxGap = 100000000)

colnames(bis_1072)

## [1] "Fat-Treg-R1"
## [5] "Liver-Treg-R2"
## [9] "Skin-Treg-R3"
## [13] "Lymph-N-Treg-R1" "Lymph-N-Treg-R2" "Lymph-N-Treg-R3"

"Fat-Treg-R2"
"Liver-Treg-R3"
"Lymph-N-Tcon-R1" "Lymph-N-Tcon-R2" "Lymph-N-Tcon-R3"

"Liver-Treg-R1"
"Skin-Treg-R2"

"Fat-Treg-R3"
"Skin-Treg-R1"

The data contains 15 samples: 3 (unmatched) replicates of mouse Tregs
from fat, liver, skin and lymph node, plus a group of 3 CD4+ conventional
lymph node T cells (Tcon). We will annotate the BSseq object to reflect this
phenotypic information:

bsseq::pData(bis_1072) <- data.frame(replicate=gsub(".*-", "", colnames(bis_1072)),

tissue=substr(colnames(bis_1072), 1,

nchar(colnames(bis_1072))-3),

row.names=colnames(bis_1072))

colData(bis_1072)$tissue <- gsub("-", "_", colData(bis_1072)$tissue)
as.data.frame(colData(bis_1072))

##
## Fat-Treg-R1
## Fat-Treg-R2
## Fat-Treg-R3
## Liver-Treg-R1
## Liver-Treg-R2
## Liver-Treg-R3
## Skin-Treg-R1
## Skin-Treg-R2
## Skin-Treg-R3
## Lymph-N-Tcon-R1
## Lymph-N-Tcon-R2
## Lymph-N-Tcon-R3
## Lymph-N-Treg-R1
## Lymph-N-Treg-R2
## Lymph-N-Treg-R3

tissue
replicate
Fat_Treg
R1
Fat_Treg
R2
Fat_Treg
R3
Liver_Treg
R1
Liver_Treg
R2
Liver_Treg
R3
Skin_Treg
R1
Skin_Treg
R2
R3
Skin_Treg
R1 Lymph_N_Tcon
R2 Lymph_N_Tcon
R3 Lymph_N_Tcon
R1 Lymph_N_Treg
R2 Lymph_N_Treg
R3 Lymph_N_Treg

For standardisation purposes (and for DMR.plot to recognise the genome)

we will change the chromosome naming convention to UCSC:

2

library(GenomeInfoDb)
bis_1072 <- renameSeqlevels(bis_1072, mapSeqlevels(seqlevels(bis_1072), "UCSC"))

For demonstration purposes, we will retain CpGs on chromosome 19 only:

bis_1072 <- bis_1072[seqnames(bis_1072)=="chr19",]
bis_1072

## An object of type 'BSseq' with
558056 methylation loci
##
##
15 samples
## has been smoothed with
##
## All assays are in-memory

BSmooth (ns = 70, h = 1000, maxGap = 100000000)

Now we can prepare the model to be fit for sequencing.annotate(). The

arguments are equivalent to cpg.annotate() but for a couple of exceptions:

• There is an extra argument all.cov giving an option whether to retain
only CpGs where all samples have non-zero coverage, or whether to retain
CpGs with only partial sample representation.

• The design matrix should be constructed to reflect the 2-factor structure of

methylated and unmethylated reads. Fortunately, edgeR::modelMatrixMeth()
can take a regular design matrix and transform is into the appropriate
structure ready for model fitting.

tissue <- factor(pData(bis_1072)$tissue)
tissue <- relevel(tissue, "Liver_Treg")

#Regular matrix design
design <- model.matrix(~tissue)
colnames(design) <- gsub("tissue", "", colnames(design))
colnames(design)[1] <- "Intercept"
rownames(design) <- colnames(bis_1072)
design

##
## Fat-Treg-R1
## Fat-Treg-R2
## Fat-Treg-R3
## Liver-Treg-R1
## Liver-Treg-R2
## Liver-Treg-R3
## Skin-Treg-R1
## Skin-Treg-R2

Intercept Fat_Treg Lymph_N_Tcon Lymph_N_Treg Skin_Treg
0
0
0
0
0
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

0
0
0
0
0
0
0
0

0
0
0
0
0
0
0
0

1
1
1
0
0
0
0
0

3

1
1
1
1
1
1
1

## Skin-Treg-R3
## Lymph-N-Tcon-R1
## Lymph-N-Tcon-R2
## Lymph-N-Tcon-R3
## Lymph-N-Treg-R1
## Lymph-N-Treg-R2
## Lymph-N-Treg-R3
## attr(,"assign")
## [1] 0 1 1 1 1
## attr(,"contrasts")
## attr(,"contrasts")$tissue
## [1] "contr.treatment"

0
0
0
0
0
0
0

0
1
1
1
0
0
0

0
0
0
0
1
1
1

1
0
0
0
0
0
0

#Methylation matrix design
methdesign <- edgeR::modelMatrixMeth(design)
methdesign

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
## 11
## 12
## 13
## 14
## 15
## 16
## 17
## 18
## 19
## 20
## 21
## 22
## 23
## 24
## 25
## 26
## 27
## 28

Sample1 Sample2 Sample3 Sample4 Sample5 Sample6 Sample7 Sample8 Sample9
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
1
1
0
0
0
0
0
0
0
0
0
0

0
0
0
0
0
0
0
0
0
0
0
0
0
0
1
1
0
0
0
0
0
0
0
0
0
0
0
0

0
0
0
0
0
0
0
0
1
1
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0

0
0
0
0
0
0
0
0
0
0
0
0
1
1
0
0
0
0
0
0
0
0
0
0
0
0
0
0

1
1
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0

0
0
0
0
1
1
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0

0
0
0
0
0
0
0
0
0
0
1
1
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0

0
0
0
0
0
0
1
1
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0

0
0
1
1
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0

4

## 29
## 30
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
## 11
## 12
## 13
## 14
## 15
## 16
## 17
## 18
## 19
## 20
## 21
## 22
## 23
## 24
## 25
## 26
## 27
## 28
## 29
## 30
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
## 11

0
0

0
0

0
0

0
0

0
0

0
0

0
0

0
0

0
0

0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
1
1

0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
1
1
0
0
0
0
0
0
0
0
0
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
0

0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
1
1
0
0

0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
1
1
0
0
0
0
0
0
0
0

0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
1
1
0
0
0
0
0
0

Sample10 Sample11 Sample12 Sample13 Sample14 Sample15 Intercept Fat_Treg
1
0
1
0
1
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0

0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
1
1
0
0
0
0
Lymph_N_Tcon Lymph_N_Treg Skin_Treg
0
0
0
0
0
0
0
0
0
0
0

0
0
0
0
0
0
0
0
0
0
0

0
0
0
0
0
0
0
0
0
0
0

5

## 12
## 13
## 14
## 15
## 16
## 17
## 18
## 19
## 20
## 21
## 22
## 23
## 24
## 25
## 26
## 27
## 28
## 29
## 30

0
0
0
0
0
0
0
1
0
1
0
1
0
0
0
0
0
0
0

0
0
0
0
0
0
0
0
0
0
0
0
0
1
0
1
0
1
0

0
1
0
1
0
1
0
0
0
0
0
0
0
0
0
0
0
0
0

Just like for cpg.annotate(), we can specify a contrast matrix to find our

comparisons of interest.

cont.mat <- limma::makeContrasts(treg_vs_tcon=Lymph_N_Treg-Lymph_N_Tcon,

fat_vs_ln=Fat_Treg-Lymph_N_Treg,
skin_vs_ln=Skin_Treg-Lymph_N_Treg,
fat_vs_skin=Fat_Treg-Skin_Treg,
levels=methdesign)

cont.mat

##
## Levels
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

Sample1
Sample2
Sample3
Sample4
Sample5
Sample6
Sample7
Sample8
Sample9
Sample10
Sample11
Sample12
Sample13
Sample14

Contrasts

treg_vs_tcon fat_vs_ln skin_vs_ln fat_vs_skin
0
0
0
0
0
0
0
0
0
0
0
0
0
0

0
0
0
0
0
0
0
0
0
0
0
0
0
0

0
0
0
0
0
0
0
0
0
0
0
0
0
0

0
0
0
0
0
0
0
0
0
0
0
0
0
0

6

##
##
##
##
##
##

Sample15
Intercept
Fat_Treg
Lymph_N_Tcon
Lymph_N_Treg
Skin_Treg

0
0
0
-1
1
0

0
0
1
0
-1
0

0
0
0
0
-1
1

0
0
1
0
0
-1

Say we want to find DMRs between the regulatory and conventional T cells
from the lymph node. First we would fit the model, where sequencing.annotate()
transforms counts into log2CPMs (via limma::voom()) and uses limma under
the hood to generate per-CpG t-statistics, indexing the FDR at 0.05:

seq_annot <- sequencing.annotate(bis_1072, methdesign, all.cov = TRUE,

contrasts = TRUE, cont.matrix = cont.mat,
coef = "treg_vs_tcon", fdr=0.05)

## Filtering out all CpGs where at least one sample has zero coverage...
## Processing BSseq object...
## Transforming counts...
## Fitting model...
## Your contrast returned 157 individually significant CpGs.
the default setting of pcutoff in dmrcate().

We recommend

seq_annot

## CpGannotated object describing 506908 CpG sites, with independent
## CpG threshold indexed at fdr=0.05 and 157 significant CpG sites.

And then, just like before, we can call DMRs with dmrcate():

dmrcate.res <- dmrcate(seq_annot, C=2, min.cpgs = 5)

## Fitting chr19...
## Demarcating regions...
## Done!

dmrcate.res

## DMResults object with 9 DMRs.
## Use extractRanges() to produce a GRanges object of these.

treg_vs_tcon.ranges <- extractRanges(dmrcate.res, genome="mm10")

## see ?DMRcatedata and browseVignettes(’DMRcatedata’) for documentation
## loading from cache

treg_vs_tcon.ranges

7

ranges strand |

[1]
[2]
[3]
[4]
[5]
[6]
[7]
[8]
[9]

* |
* |
* |
* |
* |
* |
* |
* |
* |
Fisher

no.cpgs min_smoothed_fdr
<numeric>
4.32351e-94
1.53747e-76
3.43873e-63
3.94008e-59
1.77927e-57
1.74620e-56
1.48257e-54
2.75829e-39
3.80468e-36

<Rle> | <integer>
16
27
26
19
12
13
12
22
10
maxdiff

seqnames
<Rle>
<IRanges>
chr19 29270611-29272005
chr19 36378257-36379597
chr19 40808208-40809554
chr19 46653280-46654180
chr19 26683453-26684174
chr19 32276886-32278089
chr19 29374953-29375393
chr19 41874401-41874895
chr19 57092365-57092646
Stouffer
<numeric>

## GRanges object with 9 ranges and 8 metadata columns:
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

[1] 7.30413e-50 1.53438e-06 9.06017e-52
[2] 5.11228e-45 5.32893e-06 6.32480e-49
[3] 1.57979e-50 7.52023e-05 1.44219e-45
[4] 6.97298e-34 5.32893e-06 1.28153e-35
[5] 3.23045e-25 3.29036e-07 1.30324e-30
[6] 2.50713e-38 5.32893e-06 1.55805e-36
[7] 7.68507e-20 3.13417e-06 3.83714e-26
[8] 1.15140e-30 6.23899e-05 7.96953e-30
[9] 1.28763e-24 7.32179e-06 6.36706e-23
-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

<numeric> <numeric> <numeric>
-4.22353
-6.40482
-3.03550
-6.09625
-3.07494
-4.83855
2.93152
5.18388
-3.53692
-6.40328
3.93201
5.81470
-3.02083
-6.10902
2.56520
4.57011
-3.36472
-4.67645

HMFDR
<numeric>

meandiff overlapping.genes
<character>
Jak2
Pcgf5
Cc2d2b
Wbp1l
Smarca2
Sgms1
Cd274, Gm36043
Rrp12
Ablim1

Looks like the top DMR is associated with the Jak2 locus and hypomethy-

lated in the Treg cells (since meandiff < 0). We can plot it like so:

cols <- as.character(plyr::mapvalues(tissue, unique(tissue),

c("darkorange", "maroon", "blue",

"black", "magenta")))

names(cols) <- tissue

DMR.plot(treg_vs_tcon.ranges, dmr = 1,

CpGs=bis_1072[,tissue %in% c("Lymph_N_Tcon", "Lymph_N_Treg")],
phen.col = cols[tissue %in% c("Lymph_N_Tcon", "Lymph_N_Treg")],
genome="mm10")

8

Now, let’s find DMRs between fat and skin Tregs.

seq_annot <- sequencing.annotate(bis_1072, methdesign, all.cov = TRUE,

contrasts = TRUE, cont.matrix = cont.mat,
coef = "fat_vs_skin", fdr=0.05)

## Filtering out all CpGs where at least one sample has zero coverage...
## Processing BSseq object...
## Transforming counts...
## Fitting model...
## Your contrast returned 5 individually significant CpGs; a small
but real effect. Consider increasing the ’fdr’ parameter using changeFDR(),
but be warned there is an increased risk of Type I errors.

Because this comparison is a bit more subtle, there are very few significantly
differential CpGs at this threshold. So we can use changeFDR() to relax the

9

Chromosome 1929.267 mb29.268 mb29.269 mb29.27 mb29.271 mb29.272 mb29.273 mb29.274 mb29.275 mb29.276 mbJak2Jak2Jak2Jak2Jak2Jak2Jak2Jak2Jak2Jak2Jak2Jak2Jak2Jak2Jak2Jak2Jak2Jak2Jak2Jak2Jak2Jak2Jak2Jak2Jak2CpGsDMRsDMRLymph.N.Tcon.R3Lymph.N.Tcon.R2Lymph.N.Tcon.R100.20.40.60.8Lymph_N_TconLymph.N.Treg.R3Lymph.N.Treg.R2Lymph.N.Treg.R100.20.40.60.8Lymph_N_Treg00.20.40.60.8Group means (with 0.3 CI)Lymph_N_TconLymph_N_TregFDR to 0.25, taking into account that there is an increased risk of false positives.

seq_annot <- changeFDR(seq_annot, 0.25)

## Threshold is now set at FDR=0.25, resulting in 63 significantly differential CpGs.

dmrcate.res <- dmrcate(seq_annot, C=2, min.cpgs = 5)

## Fitting chr19...
## Demarcating regions...
## Done!

fat_vs_skin.ranges <- extractRanges(dmrcate.res, genome="mm10")

## see ?DMRcatedata and browseVignettes(’DMRcatedata’) for documentation
## loading from cache

Now let’s plot the top DMR with not only fat and skin, but with all samples:

cols

Fat_Treg

Fat_Treg

Fat_Treg
##
## "darkorange" "darkorange" "darkorange"
##
##
"blue"
## Lymph_N_Treg Lymph_N_Treg Lymph_N_Treg
"magenta"
##

Skin_Treg
"blue"

Skin_Treg
"blue"

"magenta"

"magenta"

Liver_Treg
"maroon"

Liver_Treg
"maroon"
Skin_Treg Lymph_N_Tcon Lymph_N_Tcon Lymph_N_Tcon
"black"

Liver_Treg
"maroon"

"black"

"black"

DMR.plot(fat_vs_skin.ranges, dmr = 1, CpGs=bis_1072, phen.col = cols, genome="mm10")

10

Here we can see the methylation of skin cells over this region near the Gcnt1
promoter is hypomethylated not only relative to fat, but to the other tissues as
well.

sessionInfo()

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

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LC_NUMERIC=C

11

LAPACK version 3.12.0

Chromosome 1917.349 mb17.35 mb17.351 mb17.352 mb17.353 mb17.354 mb17.355 mb17.356 mb17.357 mb17.358 mb17.359 mbGcnt1Gcnt1Gcnt1Gm59117Gm59117DMRFat.Treg.R3Fat.Treg.R2Fat.Treg.R100.20.40.60.8Fat_TregLiver.Treg.R3Liver.Treg.R2Liver.Treg.R100.20.40.60.8Liver_TregSkin.Treg.R3Skin.Treg.R2Skin.Treg.R100.20.40.60.8Skin_TregLymph.N.Tcon.R3Lymph.N.Tcon.R2Lymph.N.Tcon.R100.20.40.60.8Lymph_N_TconLymph.N.Treg.R3Lymph.N.Treg.R2Lymph.N.Treg.R100.20.40.60.8Lymph_N_Treg00.20.40.60.8Group means (with 0.3 CI)Fat_TregLiver_TregLymph_N_TconLymph_N_TregSkin_Tregdatasets

grDevices utils

stats

graphics

stats4
base

LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

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
## [1] GenomeInfoDb_1.46.0
## [2] bsseq_1.46.0
## [3] tissueTreg_1.29.0
## [4] IlluminaHumanMethylationEPICv2anno.20a1.hg38_1.0.0
## [5] DMRcatedata_2.27.0
## [6] IlluminaHumanMethylationEPICanno.ilm10b4.hg19_0.6.0
## [7] IlluminaHumanMethylationEPICmanifest_0.3.0
## [8] FlowSorted.Blood.EPIC_2.13.0
## [9] minfi_1.56.0
## [10] bumphunter_1.52.0
## [11] locfit_1.5-9.12
## [12] iterators_1.0.14
## [13] foreach_1.5.2
## [14] Biostrings_2.78.0
## [15] XVector_0.50.0
## [16] SummarizedExperiment_1.40.0
## [17] Biobase_2.70.0
## [18] MatrixGenerics_1.22.0
## [19] matrixStats_1.5.0
## [20] GenomicRanges_1.62.0
## [21] Seqinfo_1.0.0
## [22] IRanges_2.44.0
## [23] S4Vectors_0.48.0
## [24] ExperimentHub_3.0.0
## [25] AnnotationHub_4.0.0
## [26] BiocFileCache_3.0.0
## [27] dbplyr_2.5.1
## [28] BiocGenerics_0.56.0
## [29] generics_0.1.4
## [30] DMRcate_3.6.0
##

12

[1] splines_4.5.1
[2] BiocIO_1.20.0
[3] bitops_1.0-9
[4] filelock_1.0.3
[5] cellranger_1.1.0
[6] tibble_3.3.0
[7] R.oo_1.27.1
[8] preprocessCore_1.72.0
[9] XML_3.99-0.19

## loaded via a namespace (and not attached):
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

13

## [45] codetools_0.2-20
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
## [67] dplyr_1.1.4
## [68] HDF5Array_1.38.0
## [69] withr_3.0.2
## [70] IlluminaHumanMethylation450kanno.ilmn12.hg19_0.6.1
## [71] BiocManager_1.30.26
## [72] fastmap_1.2.0
## [73] latticeExtra_0.6-31
## [74] rhdf5filters_1.22.0
## [75] openssl_2.3.4
## [76] digest_0.6.37
## [77] R6_2.6.1
## [78] colorspace_2.1-2
## [79] gtools_3.9.5
## [80] jpeg_0.1-11
## [81] dichromat_2.0-0.1
## [82] biomaRt_2.66.0
## [83] RSQLite_2.4.3
## [84] cigarillo_1.0.0
## [85] R.methodsS3_1.8.2
## [86] h5mread_1.2.0
## [87] tidyr_1.3.1
## [88] data.table_1.17.8
## [89] rtracklayer_1.70.0

14

## [90] prettyunits_1.2.0
## [91] httr_1.4.7
## [92] htmlwidgets_1.6.4
## [93] S4Arrays_1.10.0
## [94] pkgconfig_2.0.3
## [95] gtable_0.3.6
## [96] blob_1.2.4
## [97] S7_0.2.0
## [98] siggenes_1.84.0
## [99] htmltools_0.5.8.1
## [100] ProtGenerics_1.42.0
## [101] scales_1.4.0
## [102] png_0.1-8
## [103] knitr_1.50
## [104] rstudioapi_0.17.1
## [105] tzdb_0.5.0
## [106] rjson_0.2.23
## [107] nlme_3.1-168
## [108] checkmate_2.3.3
## [109] curl_7.0.0
## [110] org.Hs.eg.db_3.22.0
## [111] cachem_1.1.0
## [112] rhdf5_2.54.0
## [113] stringr_1.5.2
## [114] BiocVersion_3.22.0
## [115] foreign_0.8-90
## [116] AnnotationDbi_1.72.0
## [117] restfulr_0.0.16
## [118] GEOquery_2.78.0
## [119] pillar_1.11.1
## [120] grid_4.5.1
## [121] reshape_0.8.10
## [122] vctrs_0.6.5
## [123] beachmat_2.26.0
## [124] xtable_1.8-4
## [125] cluster_2.1.8.1
## [126] htmlTable_2.4.3
## [127] evaluate_1.0.5
## [128] readr_2.1.5
## [129] GenomicFeatures_1.62.0
## [130] cli_3.6.5
## [131] compiler_4.5.1
## [132] Rsamtools_2.26.0
## [133] rngtools_1.5.2
## [134] rlang_1.1.6

15

## [135] crayon_1.5.3
## [136] nor1mix_1.3-3
## [137] mclust_6.1.1
## [138] interp_1.1-6
## [139] plyr_1.8.9
## [140] stringi_1.8.7
## [141] deldir_2.0-4
## [142] BiocParallel_1.44.0
## [143] lazyeval_0.2.2
## [144] Matrix_1.7-4
## [145] BSgenome_1.78.0
## [146] hms_1.1.4
## [147] sparseMatrixStats_1.22.0
## [148] bit64_4.6.0-1
## [149] ggplot2_4.0.0
## [150] Rhdf5lib_1.32.0
## [151] KEGGREST_1.50.0
## [152] statmod_1.5.1
## [153] highr_0.11
## [154] memoise_2.0.1
## [155] bit_4.6.0
## [156] readxl_1.4.5

References

[1] Chen Y, Pal B, Visvader JE, Smyth GK. Differential methylation analysis
of reduced representation bisulfite sequencing experiments using edgeR.
F1000Research. 2017 6, 2055.

[2] Delacher M, Imbusch CD, Weichenhan D, Breiling A, Hotz-Wagenblatt A,
Trager U, ... Feuerer M. (2017). Genome-wide DNA-methylation landscape
defines specialization of regulatory T cells in tissues. Nature Immunology.
2017 18(10), 1160-1172.

16

