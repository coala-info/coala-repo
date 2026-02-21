An Introduction to FilterFFPE

Lanying Wei

Modified: 20 August, 2020. Compiled: October 29, 2025

Contents

1

2

3

A

Introduction .

Input .

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

Artifact Chimeric Read Filtration .

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

1

3

1

Introduction

The next-generation sequencing (NGS) reads from formalin-fixed paraffin-embedded (FFPE)
samples contain numerous artifact chimeric reads, which can lead to a large number of false
positive structural variation (SV) calls. The FilterFFPE package finds and filters these artifact
chimeric reads from BAM files to improve SV calling performance in FFPE samples.

2

Input

The required input is an indexed BAM file of the FFPE sample, the PCR or optical duplicates
should be marked or removed from the BAM file.
If you plan to filter reads with mapping
quality, or to only keep reads in targeted region, please do that after using FilterFFPE, as
these steps may remove some of the alignments that is useful to the FilterFFPE’s filtering
algorithm. Example of such a BAM file is stored in the ’extdata’ directory of FilterFFPE
package).

3

Artifact Chimeric Read Filtration

The filtration includes two steps: 1) Find artifact chimeric reads from BAM file . 2) Remove
these artifact chimeric reads in the filtered BAM file. findArtifactChimericReads can be
used to find artifact chimeric reads; read names of PCR or optical duplicates of all chimeric
reads are also found and written in a txt file for filtration. filterBamByReadNames can be used
for further filtration, it generates a filtered and indexed BAM file. FFPEReadFilter combines
these two functions.

> library(FilterFFPE)

> # Find artifact chimeric reads

An Introduction to FilterFFPE

> file <- system.file("extdata", "example.bam", package = "FilterFFPE")

> outFolder <- tempdir()

> FFPEReadsFile <- paste0(outFolder, "/example.FFPEReads.txt")

> dupChimFile <- paste0(outFolder, "/example.dupChim.txt")

> artifactReads <- findArtifactChimericReads(file = file, threads = 2,

+

+

> head(artifactReads)

FFPEReadsFile = FFPEReadsFile,

dupChimFile = dupChimFile)

[1] "SRR1523265.24545253" "SRR1523265.31420529"

[3] "SRR1523265.38291385" "SRR1523265.49620943"

[5] "SRR1523265.5056364" "SRR1523265.52887917"

>

> # Filter artifact chimeric reads and PCR or optical duplicates of chimeric reads

> dupChim <- readLines(dupChimFile)

> readsToFilter <- c(artifactReads, dupChim)

> destination <- paste0(outFolder, "/example.FilterFFPE.bam")

> filterBamByReadNames(file = file, readsToFilter = readsToFilter,

+

destination = destination, overwrite=TRUE)

[1] "/tmp/Rtmps1paEJ/example.FilterFFPE.bam"

>

> # Perform finding and filtering with one function

> file <- system.file("extdata", "example.bam", package = "FilterFFPE")

> outFolder <- tempdir()

> FFPEReadsFile <- paste0(outFolder, "/example.FFPEReads.txt")

> dupChimFile <- paste0(outFolder, "/example.dupChim.txt")

> destination <- paste0(outFolder, "/example.FilterFFPE.bam")

> FFPEReadFilter(file = file, threads=2, destination = destination,

+

+

overwrite=TRUE, FFPEReadsFile = FFPEReadsFile,

dupChimFile = dupChimFile)

[1] "/tmp/Rtmps1paEJ/example.FilterFFPE.bam"

>

The generated BAM file can be loaded with scanBam function from Rsamtools package for
further interrogation.

> # load Bam file with scanBAM

> newBam <- Rsamtools::scanBam(destination)

> head(newBam[[1]]$seq)

DNAStringSet object of length 6:

width seq

[1]

[2]

[3]

[4]

[5]

[6]

90 CAGCTGCTCAACCACCTCCTCTCT...CCCTGGCCCTCCCAGCCCACGAT

90 CAGCTGCTCAACCACCTCCTCTCT...CCCTGGCCCTCCCAGCCCACGAT

90 CAGCTGCTCAACCACCTCCTCTCT...CCCTGGCCCTCCCAGCCCACGAT

90 CAGCTGCTCAACCACCTCCTCTCT...CCCTGGCCCTCCCAGCCCACGAT

90 ACCCCACTCCCTGGCCCTCCCAGC...CCTGAACCCCCAGCCTGTGGTTC

90 CCCCCACTCCCTGGCCCTCCCAGC...CCTGAACCCCCAGCCTGTGGTTC

2

An Introduction to FilterFFPE

A

Session info

> packageDescription("FilterFFPE")

Package: FilterFFPE

Type: Package

Title: FFPE Artificial Chimeric Read Filter for NGS

data

Version: 1.20.0

Authors@R: person("Lanying", "Wei",

email="lanying.wei@uni-muenster.de", role =

c("aut", "cre"), comment = c(ORCID =

"0000-0002-4281-8017"))

Description: This package finds and filters

artificial chimeric reads specifically

generated in next-generation sequencing (NGS)

process of formalin-fixed paraffin-embedded

(FFPE) tissues. These artificial chimeric reads

can lead to a large number of false positive

structural variation (SV) calls. The required

input is an indexed BAM file of a FFPE sample.

License: LGPL-3

Encoding: UTF-8

Imports: foreach, doParallel, GenomicRanges, IRanges,

Rsamtools, parallel, S4Vectors

Suggests: BiocStyle

biocViews: StructuralVariation, Sequencing,

Alignment, QualityControl, Preprocessing

git_url:

https://git.bioconductor.org/packages/FilterFFPE

git_branch: RELEASE_3_22
git_last_commit: 5c7f62f
git_last_commit_date: 2025-10-29
Repository: Bioconductor 3.22

Date/Publication: 2025-10-29

Author: Lanying Wei [aut, cre] (ORCID:

<https://orcid.org/0000-0002-4281-8017>)

Maintainer: Lanying Wei <lanying.wei@uni-muenster.de>

Built: R 4.5.1; ; 2025-10-30 03:57:21 UTC; unix

-- File: /tmp/RtmphvWMav/Rinst5b23320d54db4/FilterFFPE/Meta/package.rds

> sessionInfo()

R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default

BLAS:
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LAPACK version 3.12.0

3

An Introduction to FilterFFPE

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

[1] stats

graphics grDevices utils

datasets

[6] methods

base

other attached packages:
[1] FilterFFPE_1.20.0

loaded via a namespace (and not attached):
[1] doParallel_1.0.17
crayon_1.5.3
[3] cli_3.6.5
knitr_1.50
[5] rlang_1.1.6
xfun_0.53
[7] generics_0.1.4
S4Vectors_0.48.0
[9] BiocStyle_2.38.0
Biostrings_2.78.0
[11] htmltools_0.5.8.1
stats4_4.5.1
[13] rmarkdown_2.30
Seqinfo_1.0.0
[15] evaluate_1.0.5
bitops_1.0-9
[17] fastmap_1.2.0
foreach_1.5.2
IRanges_2.44.0
[19] yaml_2.3.10
[21] BiocManager_1.30.26 compiler_4.5.1
[23] codetools_0.2-20
XVector_0.50.0
[25] BiocParallel_1.44.0 digest_0.6.37
[27] parallel_4.5.1
[29] tools_4.5.1
[31] Rsamtools_2.26.0

GenomicRanges_1.62.0
iterators_1.0.14
BiocGenerics_0.56.0

4

