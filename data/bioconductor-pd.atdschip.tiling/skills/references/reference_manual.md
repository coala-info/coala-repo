Package ‘pd.atdschip.tiling’

February 17, 2026

Title Platform Design Info for Affymetrix Atdschip_tiling

Description Platform Design Info for Affymetrix Atdschip_tiling

Version 0.48.0

Author Kristof De Beuf

Maintainer Kristof De Beuf <kristof.debeuf@ugent.be>

LazyLoad yes

Depends R (>= 2.14.0), methods, RSQLite (>= 0.10.0), oligoClasses (>=

1.15.58), oligo (>= 1.17.3), DBI

Imports Biostrings (>= 2.21.11), IRanges (>= 1.11.31), S4Vectors

License Artistic-2.0

biocViews Arabidopsis_thaliana_Data, MicroarrayData, SNPData

ZipData no

git_url https://git.bioconductor.org/packages/pd.atdschip.tiling

git_branch RELEASE_3_22

git_last_commit 9cc1e35

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-17

Contents

data:pmSequence .
pd.atdschip.tiling .

.
.

.
.

.
.

.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2
2

3

Index

1

2

pd.atdschip.tiling

data:pmSequence

Sequence data for PM probes.

Description

Sequence data for PM probes.

Usage

data(pmSequence)

Format

Sequences are stored within an DataFrame object with two columns: ’fid’ and ’sequence’.

Examples

data(pmSequence)

pd.atdschip.tiling

Annotation package for pd.atdschip.tiling.

Description

Annotation package for pd.atdschip.tiling built with pdInfoBuilder.

Details

This package is to be used in conjunction with the oligo package. It contains the platform design
information for the AGRONOMICS1 tiling array for the plant species Arabidopsis thaliana (TAIR8
Genomebuild).

Index

∗ datasets

data:pmSequence, 2

∗ package

pd.atdschip.tiling, 2

bgSequence (data:pmSequence), 2

data:bgSequence (data:pmSequence), 2
data:mmSequence (data:pmSequence), 2
data:pmSequence, 2

mmSequence (data:pmSequence), 2

pd.atdschip.tiling, 2
pmSequence (data:pmSequence), 2

3

