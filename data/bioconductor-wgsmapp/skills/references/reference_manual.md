Package ‘WGSmapp’

February 26, 2026

Type Package

Title Mappability tracks of Whole-genome Sequencing from the ENCODE

Project

Version 1.22.0

Author Rujin Wang

Maintainer Rujin Wang <rujin@email.unc.edu>

Description

This package provides whole-genome mappability tracks on human hg19/hg38 assembly. We em-
ployed the 100-mers mappability track from the ENCODE Project and computed weighted aver-
age of the mappability scores if multiple ENCODE regions overlap with the same bin. “Black-
list” bins, including segmental duplication regions and gaps in reference assembly from telom-
ere, centromere, and/or heterochromatin regions are included. The dataset consists of three as-
sembled .bam files of single-cell whole genome sequencing from 10X for illustration purposes.

Depends R (>= 3.6.0), GenomicRanges

License GPL-2

biocViews ExperimentData, SequencingData, DNASeqData, SingleCellData,

Homo_sapiens_Data, Genome, ENCODE

Encoding UTF-8

LazyData true

RoxygenNote 6.1.1

git_url https://git.bioconductor.org/packages/WGSmapp

git_branch RELEASE_3_22

git_last_commit f6fe54e

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-26

Contents

mapp_hg19 .
mapp_hg38 .

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

. .
. .

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

Index

1

2
2

3

2

mapp_hg38

mapp_hg19

GRanges with mappability scores for hg19

Description

GRanges of mappability track for 100-mers on the GRCh37/hg19 human reference genome from
ENCODE.

Usage

mapp_hg19

Format

A GRanges object with 21591667 ranges and mappability scores

mapp_hg38

GRanges with mappability scores for hg38

Description

Use liftOver utility to convert hg19 coordinates to hg38

Usage

mapp_hg38

Format

A GRanges object with 21584930 ranges and mappability scores

Index

∗ datasets

mapp_hg19, 2
mapp_hg38, 2

mapp_hg19, 2
mapp_hg38, 2

3

