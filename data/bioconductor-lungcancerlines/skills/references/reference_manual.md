Package ‘LungCancerLines’

February 12, 2026

Type Package

Title Reads from Two Lung Cancer Cell Lines

Version 0.48.0

Author Cory Barr, Michael Lawrence

Maintainer Michael Lawrence <michafla@gene.com>

Imports Rsamtools

Description Reads from an RNA-seq experiment between two lung cancer

cell lines: H1993 (met) and H2073 (primary).
The reads are stored as Fastq files and are meant for use with
the TP53Genome object in the gmapR package.

License Artistic-2.0

biocViews ExperimentData, Genome, CancerData, LungCancerData,

RNASeqData

git_url https://git.bioconductor.org/packages/LungCancerLines

git_branch RELEASE_3_22

git_last_commit a9e2226

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

TP53Genome-package .
.
LungCancerBamFiles .
.
LungCancerFastqFiles

.
.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2
2
3

4

Index

1

2

LungCancerBamFiles

TP53Genome-package

Genomic Sequence of the TP53 Gene Plus a 1-Megabase Region on
Each Side of the Gene

Description

This package was created to use in examples and test sets for the gmapR and VariationTools pack-
ages.

Details

TP53Genome
Package:
Package
Type:
1.0
Version:
2012-09-05
Date:
License: Artistic-2.0

By calling data(p53Genome), users will have access to a GmapGenome object for the TP53 genome.

Author(s)

Cory Barr

Maintainer: Cory Barr <barr.cory@gene.com>

Examples

data(p53Genome)

LungCancerBamFiles

Get the BAM paths

Description

Gets a BamFileList pointing to BAM files containing read alignments for the H1993 and H2073
RNA-seq samples. The files are the “analyzed” BAM files as output by the HTSeqGenie package.

Usage

LungCancerBamFiles()

LungCancerFastqFiles

Details

3

The reads were aligned to genome TP53Genome, using the following parameters:

• splicing: knownGene

• novelsplicing: 1

• indel_penalty: 1

• distant_splice_penalty: 1

• suboptimal_levels: 2

• npaths: 10

Note that the BAM files contain only unique alignments.

Value

A BamFileList pointing to two BAM files, one for H1993, one for H2073.

Author(s)

Michael Lawrence

Examples

LungCancerBamFiles()

LungCancerFastqFiles Get the Fastq paths

Description

Returns a character vector of file paths to the demo Fastq files.

Usage

LungCancerFastqFiles()

Value

A character vector, named according to “H[1993/2073].[first/last]”.

Author(s)

Michael Lawrence

Examples

LungCancerFastqFiles()

Index

LungCancerBamFiles, 2
LungCancerFastqFiles, 3

TP53Genome, 3
TP53Genome (TP53Genome-package), 2
TP53Genome-package, 2

4

