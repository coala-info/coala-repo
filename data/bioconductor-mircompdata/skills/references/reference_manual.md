Package ‘miRcompData’

February 17, 2026

Version 1.40.0

Date 2015-09-25

Title Data used in the miRcomp package

Description Raw amplification data from a large microRNA mixture /

dilution study. These data are used by the miRcomp package to
assess the performance of methods that estimate expression from
the amplification curves.

Author Matthew N. McCall <mccallm@gmail.com>

Maintainer Matthew N. McCall <mccallm@gmail.com>

Depends R (>= 3.2),

Imports utils

License GPL-3 | file LICENSE

biocViews ExperimentData, ExpressionData, qPCRData, Homo_sapiens_Data

NeedsCompilation no

git_url https://git.bioconductor.org/packages/miRcompData

git_branch RELEASE_3_22

git_last_commit b216de5

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-17

Contents

miRcompData .

.

.

.

.

.

.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2

3

Index

1

2

miRcompData

miRcompData

Data used in the miRcomp package.

Description

Raw amplification data from a large miRNA mixture / dilution study. These data are used my
the miRcomp package to assess the performance of methods that estimate expression from the
amplification curves.

Usage

Format

data(miRcompData)

A data.frame with 9 elements.

Barcode
Well
SampleID
FeatureSet
TargetName
Cycle
Rn
dRn
NumCycle

unique identifier for each multi-well plate
unique identifier for each well in a plate
name given to each sample
either "A" or "B" denoting the two feature groups
target miRNA name
PCR cycle of the amplification
fluorescence signal
background-subtracted fluorescence signal
total number of PCR cycles performed

Examples

data(miRcompData)

Index

∗ datasets

miRcompData, 2

miRcompData, 2

3

