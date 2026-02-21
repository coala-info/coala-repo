An Introduction to the GenomicAlignments Package

Hervé Pagès

October 30, 2025

Contents

1 Introduction

2 GAlignments: Genomic Alignments

2.1 Load a ‘BAM’ file into a GAlignments object
2.2 Simple accessor methods .
.
2.3 More accessor methods .

. . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

. . . . .

. . . . .

. .

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

3 GAlignmentPairs: Pairs of Genomic Alignments

4 GAlignmentsList: Groups of Genomic Alignments

5 Session Information

1 Introduction

1

1
2
3
3

4

4

4

The GenomicAlignments package serves as the foundation for representing genomic alignments within the Biocon-
ductor project. In the Bioconductor package hierarchy, it builds upon the GenomicRanges (infrastructure) package
and provides support for many Bioconductor packages.

This package defines three classes: GAlignments, GAlignmentPairs, and GAlignmentsList), which are used to

represent genomic alignments, pairs of genomic alignments, and groups of genomic alignments.

The GenomicAlignments package is available at bioconductor.org and can be downloaded via BiocManager::install:

> if (!require("BiocManager"))
install.packages("BiocManager")
+
> BiocManager::install("GenomicAlignments")

> library(GenomicAlignments)

2 GAlignments: Genomic Alignments

The GAlignments class which is a container for storing a set of genomic alignments. The class is intended to support
alignments in general, not only those coming from a ’Binary Alignment Map’ or ’BAM’ files. Also alignments with
gaps in the reference sequence (a.k.a. gapped alignments) are supported which, for example, makes the class suited
for storing junction reads from an RNA-seq experiment.

More precisely, a GAlignments object is a vector-like object where each element describes an alignment, that is,

how a given sequence (called query or read, typically short) aligns to a reference sequence (typically long).

As shown later in this document, a GAlignments object can be created from a ’BAM’ file. In that case, each
element in the resulting object will correspond to a record in the file. One important thing to note though is that not all

1

the information present in the BAM/SAM records is stored in the object. In particular, for now, we discard the query
sequences (SEQ field), the query ids (QNAME field), the query qualities (QUAL), the mapping qualities (MAPQ) and
any other information that is not needed in order to support the basic set of operations described in this document.
This also means that multi-reads (i.e. reads with multiple hits in the reference) don’t receive any special treatment i.e.
the various SAM/BAM records corresponding to a multi-read will show up in the GAlignments object as if they were
coming from different/unrelated queries. Also paired-end reads will be treated as single-end reads and the pairing
information will be lost. This might change in the future.

2.1 Load a ‘BAM’ file into a GAlignments object

First we use the readGAlignments function from the GenomicAlignments package to load a toy ‘BAM’ file into a
GAlignments object:

> library(GenomicAlignments)
> aln1_file <- system.file("extdata", "ex1.bam", package="Rsamtools")
> aln1 <- readGAlignments(aln1_file)
> aln1

GAlignments object with 3271 alignments and 0 metadata columns:

start

cigar

qwidth

end
<Rle> <Rle> <character> <integer> <integer> <integer>
36
37
39
41
43
...
1558
1558
1562
1566
1567

1
3
5
6
9
...
1524
1524
1528
1532
1533

36M
35M
35M
36M
35M
...
35M
35M
35M
35M
35M

36
35
35
36
35
...
35
35
35
35
35

[1]
[2]
[3]
[4]
[5]
...
[3267]
[3268]
[3269]
[3270]
[3271]

seqnames strand

seq1
seq1
seq1
seq1
seq1
...
seq2
seq2
seq2
seq2
seq2
width

+
+
+
+
+
...
+
+
-
-
-
njunc
<integer> <integer>
0
0
0
0
0
...
0
0
0
0
0

[1]
[2]
[3]
[4]
[5]
...
[3267]
[3268]
[3269]
[3270]
[3271]
-------
seqinfo: 2 sequences from an unspecified genome

36
35
35
36
35
...
35
35
35
35
35

> length(aln1)

[1] 3271

2

3271 ‘BAM’ records were loaded into the object.
Note that readGAlignments would have discarded any ‘BAM’ record describing an unaligned query (see
description of the <flag> field in the SAM Format Specification 1 for more information). The reader interested in
tracking down these events can always use the scanBam function but this goes beyond the scope of this document.

2.2 Simple accessor methods

There is one accessor per field displayed by the show method and it has the same name as the field. All of them return
a vector or factor of the same length as the object:

> head(seqnames(aln1))

factor-Rle of length 6 with 1 run

Lengths:
6
Values : seq1

Levels(2): seq1 seq2

> seqlevels(aln1)

[1] "seq1" "seq2"

> head(strand(aln1))

factor-Rle of length 6 with 1 run

Lengths: 6
Values : +

Levels(3): + - *

> head(cigar(aln1))

[1] "36M" "35M" "35M" "36M" "35M" "35M"

> head(qwidth(aln1))

[1] 36 35 35 36 35 35

> head(start(aln1))

[1]

1

3 5 6 9 13

> head(end(aln1))

[1] 36 37 39 41 43 47

> head(width(aln1))

[1] 36 35 35 36 35 35

> head(njunc(aln1))

[1] 0 0 0 0 0 0

2.3 More accessor methods

[coming soon...]

1http://samtools.sourceforge.net/SAM1.pdf

3

3 GAlignmentPairs: Pairs of Genomic Alignments

[coming soon...]

4 GAlignmentsList: Groups of Genomic Alignments

[coming soon...]

5 Session Information

All of the output in this vignette was produced under the following conditions:

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

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats4
[7] methods

stats
base

graphics

grDevices utils

datasets

other attached packages:

[1] pasillaBamSubset_0.47.0
[2] GenomicAlignments_1.46.0
[3] SummarizedExperiment_1.40.0
[4] Biobase_2.70.0
[5] MatrixGenerics_1.22.0
[6] matrixStats_1.5.0
[7] Rsamtools_2.26.0
[8] Biostrings_2.78.0
[9] XVector_0.50.0

[10] GenomicRanges_1.62.0
[11] IRanges_2.44.0
[12] S4Vectors_0.48.0
[13] Seqinfo_1.0.0
[14] BiocGenerics_0.56.0
[15] generics_0.1.4
[16] RNAseqData.HNRNPC.bam.chr14_0.47.0

4

[17] BiocStyle_2.38.0

loaded via a namespace (and not attached):

[1] Matrix_1.7-4
[4] BiocManager_1.30.26 crayon_1.5.3
[7] parallel_4.5.1

jsonlite_2.0.0

jquerylib_0.1.4
fastmap_1.2.0
S4Arrays_1.10.0

[10] yaml_2.3.10
[13] R6_2.6.1
[16] DelayedArray_0.36.0 bookdown_0.45
[19] rlang_1.1.6
[22] sass_0.4.10
[25] grid_4.5.1
[28] evaluate_1.0.5
[31] abind_1.4-8
[34] htmltools_0.5.8.1

cachem_1.1.0
SparseArray_1.10.0
digest_0.6.37
cigarillo_1.0.0
rmarkdown_2.30

compiler_4.5.1
bitops_1.0-9
BiocParallel_1.44.0
lattice_0.22-7
knitr_1.50
bslib_0.9.0
xfun_0.53
cli_3.6.5
lifecycle_1.0.4
codetools_0.2-20
tools_4.5.1

5

