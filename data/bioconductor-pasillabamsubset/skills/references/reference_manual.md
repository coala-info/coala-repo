Package ‘pasillaBamSubset’

February 26, 2026

Title Subset of BAM files from ``Pasilla'' experiment

Description Subset of BAM files untreated1.bam (single-end reads) and
untreated3.bam (paired-end reads) from ``Pasilla'' experiment
(Pasilla knock-down by Brooks et al., Genome Research 2011).
See the vignette in the pasilla data package for how BAM files
untreated1.bam and untreated3.bam were obtained from the RNA-Seq
read sequence data that is provided by NCBI Gene Expression Omnibus
under accession numbers GSM461176 to GSM461181. Also contains
the DNA sequence for fly chromosome 4 to which the reads can
be mapped.

Version 0.48.0

Encoding UTF-8

Author Hervé Pagès

Maintainer Hervé Pagès <hpages.on.github@gmail.com>

biocViews ExperimentData, Genome, DNASeqData, RNASeqData

Suggests pasilla

License LGPL

git_url https://git.bioconductor.org/packages/pasillaBamSubset

git_branch RELEASE_3_22

git_last_commit 0384ee4

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-26

Contents

pasillaBamSubset-package . .

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2

3

Index

1

2

pasillaBamSubset-package

pasillaBamSubset-package

Utilities returning the paths to BAM files untreated1_chr4.bam and
untreated3_chr4.bam

Description

BAM file untreated1_chr4.bam contains the subset of untreated1.bam (single-end reads, "Pasilla"
experiment) where only alignments located on chr4 (Fly) were kept.

BAM file untreated3_chr4.bam contains the subset of untreated3.bam (paired-end reads, "Pasilla"
experiment) where only alignments located on chr4 (Fly) were kept.

FASTA file dm3_chr4.fa contains the full sequence of the D. melanogaster chromosome 4.

untreated1_chr4, untreated3_chr4 and chr4 return the path to those files.

Usage

untreated1_chr4()
untreated3_chr4()
dm3_chr4()

Details

See the pasilla data package for details about the "Pasilla" experiment (RNA-seq, Fly).

BAM files untreated1.bam and untreated3.bam contain single-end and paired-end reads aligned to
reference genome BDGP Release 5 (aka the dm3 genome on the UCSC Genome Browser).

Fasta file dm3_chr4.fa from UCSC, the Apr. 2006 assembly of the D. melanogaster genome (dm3,
BDGP Release 5): DNA sequence for fly chromosome 4.

Examples

untreated1_chr4()
untreated3_chr4()
dm3_chr4()

Index

∗ utilities

pasillaBamSubset-package, 2

dm3_chr4 (pasillaBamSubset-package), 2

pasillaBamSubset

(pasillaBamSubset-package), 2

pasillaBamSubset-package, 2

untreated1_chr4

(pasillaBamSubset-package), 2

untreated3_chr4

(pasillaBamSubset-package), 2

3

