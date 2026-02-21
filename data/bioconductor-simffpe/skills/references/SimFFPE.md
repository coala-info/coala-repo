An Introduction to SimFFPE

Lanying Wei

Modified: Nov 11, 2020. Compiled: October 30, 2025

Contents

1

2

3

Introduction .

Input .

.

.

.

Simulation .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

3.1

3.2

Read simulation functions.

Fine-tuning of the simulation .

A

Session info .

.

.

.

.

.

.

.

.

.

.

.

1

Introduction

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

1

1

3

3

3

5

The NGS (Next-Generation Sequencing) reads from FFPE (Formalin-Fixed Paraffin-Embedded)
samples contain numerous artificial chimeric reads, which can lead to false positive structural
variant calls. These ACRs are derived from the combination of two single-stranded DNA
(ss-DNA) fragments with short reverse complementary regions (SRCR). The combined ss-
DNA may come from adjacent or distant genomic regions. The SimFFPE package simulates
these artificial reads as well as normal reads for FFPE samples. The simulation can cover
whole genome, or several chromosomes, or large regions, or whole exome, or targeted regions.
It also supports enzymatic / random fragmentation and paired-end / single-end sequencing
simulations.Fine-tuning can be achieved by adjusting the parameters, and multi-threading is
surported.

2

Input

The essential inputs for the simulation include a FASTA file of the reference genome, a Phred
score profile matrix to simulate Phred scores based on the position on the reads, and a
DataFrame or GenomicRanges object representing the target regions (optional). The Phred
score profile can be estimated from existing BAM files using calcPhredScoreProfile func-
tion (two available examples for Phred score profile are stored in the ’extdata’ directory of
SimFFPE package).

> library(SimFFPE)

> bamFilePath <- system.file("extdata", "example.bam", package = "SimFFPE")

> regionPath <- system.file("extdata", "regionsBam.txt", package = "SimFFPE")

An Introduction to SimFFPE

> regions <- read.table(regionPath)

> PhredScoreProfile <- calcPhredScoreProfile(bamFilePath, targetRegions = regions)

> ## Example Phred score profile with 100 read length

> PhredScoreProfilePath <- system.file("extdata", "PhredScoreProfile1.txt",

+

package = "SimFFPE")

> PhredScoreProfile <- as.matrix(read.table(PhredScoreProfilePath, skip = 1))

> colnames(PhredScoreProfile) <-

strsplit(readLines(PhredScoreProfilePath)[1], "\t")[[1]]

+

> #

> ## Example Phred score profile with 150 read length

>

> PhredScoreProfilePath2 <- system.file("extdata", "PhredScoreProfile2.txt",

+

package = "SimFFPE")

> PhredScoreProfile2 <- as.matrix(read.table(PhredScoreProfilePath2, skip = 1))

> colnames(PhredScoreProfile2) <-

strsplit(readLines(PhredScoreProfilePath2)[1], "\t")[[1]]

+

>

The FASTA file of reference genome can be read in as DNAStringSet with readDNAStringSet
function from Biostrings package. The reference genome example file consists of small regions
of 24 chromosomes from human hg19 reference genome.

> referencePath <- system.file("extdata", "example.fasta", package = "SimFFPE")

> reference <- readDNAStringSet(referencePath)

> reference

DNAStringSet object of length 24:

width seq

names

[1] 30000 AGACTAACATGGA...TCCTTTCTTTCC 1 dna 20000001:20...

[2] 30000 ACATTTCCATTTG...GTAGGCGGGGCA 2 dna 20000001:20...

[3] 30000 TGTTTACACATTT...TGCCCAAAACTT 3 dna 20000001:20...

[4] 30000 GTTTAACGATCTA...TGTCGTCTGCCT 4 dna 20000001:20...

[5] 30000 CCACTTATCTTGT...AGGTGTTTGCTA 5 dna 20000001:20...

...

... ...

[20] 30000 TCAGTTTGGGAGG...AATCTCCTTTAG 20 dna 20000001:2...

[21] 30000 CCCTTCTCCTATC...TAAAATACTCAA 21 dna 20000001:2...

[22] 30000 TGGGAAGGTGGGG...GAAATATTTGTT 22 dna 20000001:2...

[23] 30000 AGAAATGATGGCT...AGGCTCTGAAGA X dna 20000001:20...

[24] 30000 ATGGTATTTGGGA...CAAAAAGGAATG Y dna 20000001:20...

>

To simulate reads of certain regions, a DataFrame or GenomicRanges object representing the
target regions is required (not required when simulating reads on the whole genome / several
chromosomes / large regions). The DataFrame representing the target regions should have
three columns, which indicate chromosomes, start positions and end positions respectively
(one-based coordinate).

> regionPath <- system.file("extdata", "regionsSim.txt", package = "SimFFPE")

> targetRegions <- read.table(regionPath)

2

An Introduction to SimFFPE

3

Simulation

The simulation includes three steps: 1) Simulate artificial chimeric reads derived from the
combination of two ss-DNA segments from adjacent regions on the chromosome. 2) Simulate
artificial chimeric reads derived from the combination of two ss-DNA from distant regions
(distant regions on the same chromosome, or any regions on different chromosomes). 3)
Simulate reads derived from normal sequences. You can also skip any of these steps in the
simulation. There are two functions which can be used for the simulation: readSimFFPE and
targetReadSimFFPE.

3.1

Read simulation functions

To simulate reads on whole genome, or several chromosomes, or large regions, please use the
readSimFFPE function:

> ## Simulate reads of the first three sequences of the reference genome

>

> sourceSeq <- reference[1:3]

> outFile1 <- paste0(tempdir(), "/sim1")

> readSimFFPE(sourceSeq, referencePath, PhredScoreProfile2, outFile1,

+

+

> #

overWrite = TRUE, coverage = 80, readLen = 150,

enzymeCut = TRUE, threads = 2)

> ## Simulate reads of defined regions on the first two sequences of

> ## the reference genome

>

> sourceSeq2 <- DNAStringSet(lapply(reference[1:2], function(x) x[1:10000]))

> outFile2 <- paste0(tempdir(), "/sim2")

> readSimFFPE(sourceSeq2, referencePath, PhredScoreProfile2, outFile2,

+

>

overWrite = TRUE, coverage = 80, readLen = 150, enzymeCut = TRUE)

To simulate reads on whole exome or targeted regions please use the targetReadSimFFPE
function:

> outFile3 <- paste0(tempdir(), "/sim3")

> targetReadSimFFPE(referencePath, PhredScoreProfile, targetRegions, outFile3,

+

+

>

coverage = 120, readLen = 100, meanInsertLen = 180,

sdInsertLen = 50, enzymeCut = FALSE)

Additional information can be found on the help pages for the readSimFFPE function and the
targetReadSimFFPE function.

3.2

Fine-tuning of the simulation

Fine-tuning of the simulation is achievable by the adjustments of some parameters of the
function readSimFFPE and targetReadSimFFPE. You can simulate reads in smaller regions
during fine-tuning to save the runtime. To illustrate the impact of some of these parameters,
screenshots from IGV tools are used (see Figure 1, 2 and 3). These parameters include:

3

An Introduction to SimFFPE

1) enzymeCut: Simulate enzymatic fragmentation. With this fragmentation method, chimeric
read pairs with improper pair orientations might be mapped to exactly the same location on
the reference genome (see Figure 1).

2) chimericProp: Proportion of artificial chimeric fragments. The higher the value, the
greater the proportion of improper paired reads as shown in Figure 1 and 2, the smaller the
proportion of proper paired reads as shown in Figure 3, and the larger the proportion of
proper paired reads with soft-clips as shown in Figure 3.

3) sameChrProp: Proportion of artifact chimeric fragments that are derived from the combi-
nation of two ss-DNA coming from the same chromosome. The higher the value, the greater
the proportion of reads with improper pair orientations as shown in Figure 1, and the smaller
the proportion of reads with their mates mapped to different chromosomes as shown in Figure
2.

4) adjChimProp: Proportion of adjacent ss-DNA combinations among same chromosomal
ss-DNA combinations. sameChrProp * adjChimProp determine the proportion of simulated
adjcent ss-DNA combinations.

5) sameStrandProb: Proportion of same-strand ss-DNA combinations among adjacent ss-
DNA combinations. The higher the value, the greater the proportion of reads with RR and
LL orientations in all reads with improper pair orientations as shown in Figure 1.

6) spikeWidth: The width of chimeric read spike used in the simulation of distant ss-DNA
combinations. As shown in Figure 3, some regions are enriched in reads with paired reads
mapped to other chromosomes, and some others are scarce. The lengths of these regions are
of similar scale, and the parameter "spikeWidth" is used to simulate this length.

7) highNoiseRate and highNoiseProb: The noise rate for each base in noisy reads and the
proportion of these noisy reads. These very noisy reads as well as less noisy reads are shown
in Figure 3.

Figure 1: Simulated reads with improper pair orientations. These read pairs are mapped in RR, LL, or
RL orientations. Black-framed reads are paired reads that are mapped to the same position (enzymatic
fragmentation).

Figure 2: Simulated reads with mate reads mapped to different chromosomes. The different read colors
indicate the different chromosomes that their mate reads mapped to.

Figure 3: Simulated reads mapped in proper pair. Mismatches and soft-clips are shown as colored vertical
lines in reads.

4

An Introduction to SimFFPE

A

Session info

> packageDescription("SimFFPE")

Package: SimFFPE

Type: Package

Title: NGS Read Simulator for FFPE Tissue

Version: 1.22.0

Authors@R: person("Lanying", "Wei",

email="lanying.wei@uni-muenster.de", role =

c("aut", "cre"), comment = c(ORCID =

"0000-0002-4281-8017"))

Description: The NGS (Next-Generation Sequencing)

reads from FFPE (Formalin-Fixed

Paraffin-Embedded) samples contain numerous

artifact chimeric reads (ACRS), which can lead

to false positive structural variant calls.

These ACRs are derived from the combination of

two single-stranded DNA (ss-DNA) fragments with

short reverse complementary regions (SRCRs).

This package simulates these artifact chimeric

reads as well as normal reads for FFPE samples

on the whole genome / several chromosomes /

large regions.

License: LGPL-3

Encoding: UTF-8

Depends: Biostrings

Imports: dplyr, foreach, doParallel, truncnorm,

GenomicRanges, IRanges, Rsamtools, parallel,

graphics, stats, utils, methods

Suggests: BiocStyle

biocViews: Sequencing, Alignment, MultipleComparison,

SequenceMatching, DataImport

git_url:

https://git.bioconductor.org/packages/SimFFPE

git_branch: RELEASE_3_22
git_last_commit: 9123bff
git_last_commit_date: 2025-10-29
Repository: Bioconductor 3.22

Date/Publication: 2025-10-29

Author: Lanying Wei [aut, cre] (ORCID:

<https://orcid.org/0000-0002-4281-8017>)

Maintainer: Lanying Wei <lanying.wei@uni-muenster.de>

Built: R 4.5.1; ; 2025-10-30 06:31:04 UTC; unix

-- File: /tmp/Rtmp7D4sc7/Rinst312b4c550aadf3/SimFFPE/Meta/package.rds

> sessionInfo()

R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

5

An Introduction to SimFFPE

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
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:

[1] stats4

stats

graphics grDevices utils

[6] datasets methods

base

other attached packages:
[1] SimFFPE_1.22.0
[3] Seqinfo_1.0.0
[5] IRanges_2.44.0
[7] BiocGenerics_0.56.0 generics_0.1.4

Biostrings_2.78.0
XVector_0.50.0
S4Vectors_0.48.0

dplyr_1.1.4
BiocManager_1.30.26
tidyselect_1.2.1
GenomicRanges_1.62.0
parallel_4.5.1

loaded via a namespace (and not attached):
[1] BiocStyle_2.38.0
[3] compiler_4.5.1
[5] crayon_1.5.3
[7] Rsamtools_2.26.0
[9] bitops_1.0-9
[11] BiocParallel_1.44.0 yaml_2.3.10
[13] fastmap_1.2.0
[15] knitr_1.50
[17] tibble_3.3.0
[19] rlang_1.1.6
[21] doParallel_1.0.17
[23] cli_3.6.5
[25] digest_0.6.37
[27] lifecycle_1.0.4
[29] evaluate_1.0.5
[31] codetools_0.2-20
[33] pkgconfig_2.0.3
[35] htmltools_0.5.8.1

R6_2.6.1
iterators_1.0.14
pillar_1.11.1
xfun_0.53
truncnorm_1.0-9
magrittr_2.0.4
foreach_1.5.2
vctrs_0.6.5
glue_1.8.0
rmarkdown_2.30
tools_4.5.1

6

