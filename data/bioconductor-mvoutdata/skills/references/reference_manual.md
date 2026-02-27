Package ‘mvoutData’

February 26, 2026

Title affy and illumina raw data for assessing outlier detector

performance

Description affy and illumina raw data for assessing outlier detector performance

Version 1.46.0

Author VJ Carey <stvjc@channing.harvard.edu>

Depends R (>= 2.10.0), methods, Biobase (>= 2.5.5), affy (>= 1.23.4),

lumi

Maintainer VJ Carey <stvjc@channing.harvard.edu>

License Artistic-2.0

biocViews ExperimentData, MicroarrayData

git_url https://git.bioconductor.org/packages/mvoutData

git_branch RELEASE_3_22

git_last_commit bd9ace8

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-26

Contents

s12c .

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

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

1

3

Index

s12c

raw expression data for evaluation of outlier detection algorithms

Description

raw expression data for evaluation of outlier detection algorithms

Usage

data(s12c); data(ILM1)

1

2

Format

s12c

s12c is an AffyBatch created from SpikeIn U133a, with first two samples contaminated. ILM1 is
the result of lumi::lumiR applied to the CSV file supplied by Illumina Inc. for the MAQC study (19
arrays).

Examples

data(s12c)
s12c

Index

∗ datasets

s12c, 1

ILM1 (s12c), 1

s12c, 1

3

