Package ‘yeastNagalakshmi’

February 17, 2026

Type Package

Title Yeast genome RNA sequencing data based on Nagalakshmi et. al.

Version 1.46.0

Author Martin Morgan <mtmorgan@fhcrc.org>

Maintainer Bioconductor Package Maintainer <maintainer@bioconductor.org>

Description The yeast genome data was retrieved from the sequence read
archive, aligned with bwa, and converted to BAM format with
samtools.

biocViews ExperimentData, Genome, Saccharomyces_cerevisiae_Data,

SequencingData, BiocViews, ChIPSeqData

License Artistic-2.0

git_url https://git.bioconductor.org/packages/yeastNagalakshmi

git_branch RELEASE_3_22

git_last_commit 15fac50

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-17

Contents

yeastNagalakshmi-package . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

1

3

Index

yeastNagalakshmi-package

Yeast genome RNA sequencing data based on Nagalakshmi et. al.

Description

The yeast genome data was retrieved from the sequence read archive, aligned with bwa, and con-
verted to BAM format with samtools.

1

2

Details

yeastNagalakshmi-package

yeastNagalakshmi
Package:
Package
Type:
Version:
0.99.0
biocViews: ExperimentData, yeast
License:

Artistic-2.0

Index:

yeastNagalakshmi-package

The package contains three files in extdata sub-directory. Two of them are pertained to RNA
sequencing data in BAM format, and one is a TranscriptDb object of yeast from transcript anno-
tations available at the UCSC Genome Browser.

Author(s)

Martin Morgan <mtmorgan@fhcrc.org>

Maintainer: Biocore Team c/o BioC user list <bioconductor@stat.math.ethz.ch>

References

Nagalakshmi et. al., The transcriptional landscape of the yeast genome defined by RNA sequencing,
Science, 320:1344:1349, June 2008.

Examples

y <- system.file("extdata", package="yeastNagalakshmi")
dir(y)

Index

∗ package

yeastNagalakshmi-package, 1

yeastNagalakshmi

(yeastNagalakshmi-package), 1

yeastNagalakshmi-package, 1

3

