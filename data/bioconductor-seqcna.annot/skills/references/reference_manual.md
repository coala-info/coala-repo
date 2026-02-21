Package ‘seqCNA.annot’

April 9, 2019

Type Package

Title Annotation for the copy number analysis of deep sequencing

cancer data with seqCNA

Version 1.18.0

Date 2013-03-27

Author David Mosen-Ansorena

Maintainer David Mosen-Ansorena <dmosen.gn@cicbiogune.es>

Import

Depends R (>= 2.10)

Description

Provides annotation on GC content, mappability and genomic features for various genomes

License GPL-3

biocViews Genome, CopyNumberVariationData

git_url https://git.bioconductor.org/packages/seqCNA.annot

git_branch RELEASE_3_8

git_last_commit 4455fbb

git_last_commit_date 2018-10-30

Date/Publication 2019-04-09

R topics documented:

.

.

seqCNA.annot-package .
.
.
.
.
hg18 .
.
.
.
hg18_len .
.
.
.
hg19 .
.
.
.
.
hg19_len .
.
supported.builds .

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

Index

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

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2
2
3
3
4
5

6

1

2

hg18

seqCNA.annot-package

Annotation for the copy number analysis of deep sequencing cancer
data with seqCNA

Description

Provides annotation on GC content, mappability and genomic features for various genomes

Details

Package:
Type:
Version:
Date:
License: GPL-3

seqCNA.annot
Package
0.99.0
2013-03-27

Author(s)

David Mosen-Ansorena

Maintainer: David Mosen-Ansorena <dmosen.gn@cicbiogune.es>

hg18

A table with GC content, mappability and presence of common CNVs
for the hg18 human genome build.

Description

GC content can be used for read count correction, while mappability and CNV information can be
used for window ﬁltering.

Usage

data(hg18)

Format

A data frame with 2881044 observations on the following 3 variables.

GC A numeric vector with the proportion of G and C bases per 1000bp window over the total of

non-N bases.

Mapp A numeric vector with the mean mappability of 35-mers within each 1000bp window.

CNV A numeric vector with the proportion of each window affected by the presence of a common

CNV (frequency > 0.01).

hg18_len

References

3

Integrating common and rare genetic variation in diverse human populations. Altshuler DM, Gibbs
RA, Brooks LD, McEwen JE. Nature. 2010 Sep 2; 467:52-8

Examples

data(hg18)

hg18_len

A table with information on chromosome lengths for the hg18 human
genome build.

Description

The table is used to create genomic windows for the whole chromosome lengths.

Usage

data(hg18_len)

Format

A data frame with 24 observations on the following 2 variables.

chr A factor with levels 1 10 11 12 13 14 15 16 17 18 19 2 20 21 22 3 4 5 6 7 8 9 X Y.

length A numeric vector.

Examples

data(hg18_len)

hg19

A table with GC content, mappability and presence of common CNVs
for the hg19 human genome build.

Description

GC content can be used for read count correction, while mappability and CNV information can be
used for window ﬁltering.

Usage

data(hg19)

4

Format

hg19_len

A data frame with 2881044 observations on the following 3 variables.

GC A numeric vector with the proportion of G and C bases per 1000bp window over the total of

non-N bases.

Mapp A numeric vector with the mean mappability of 35-mers within each 1000bp window.

CNV A numeric vector with the proportion of each window affected by the presence of a common

CNV (frequency > 0.01).

References

Integrating common and rare genetic variation in diverse human populations. Altshuler DM, Gibbs
RA, Brooks LD, McEwen JE. Nature. 2010 Sep 2; 467:52-8

Examples

data(hg19)

hg19_len

A table with information on chromosome lengths for the hg19 human
genome build.

Description

The table is used to create genomic windows for the whole chromosome lengths.

Usage

data(hg19_len)

Format

A data frame with 24 observations on the following 2 variables.

chr A factor with levels 1 10 11 12 13 14 15 16 17 18 19 2 20 21 22 3 4 5 6 7 8 9 X Y.

length A numeric vector.

Examples

data(hg19_len)

supported.builds

5

supported.builds

Names of the genome builds for which the package contains annota-
tion.

Description

A vector with the names of the genome builds with annotation in the package.

Usage

supported.builds()

Value

A vector with the names of the genome builds with annotation in the package.

Author(s)

David Mosen-Ansorena

Examples

supported.builds()

Index

∗Topic Information

supported.builds, 5

∗Topic datasets
hg18, 2
hg18_len, 3
hg19, 3
hg19_len, 4

hg18, 2
hg18_len, 3
hg19, 3
hg19_len, 4

seqCNA.annot (seqCNA.annot-package), 2
seqCNA.annot-package, 2
supported.builds, 5

6

