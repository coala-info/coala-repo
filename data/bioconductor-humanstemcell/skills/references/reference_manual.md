Package ‘humanStemCell’

February 12, 2026

Title Human Stem Cells time course experiment

Version 0.50.0

Author R. Gentleman, N. Le Meur, M. Tewari

Description Affymetrix time course experiment on human stem cells (two time points: undifferenti-

ated and differentiated).

biocViews ExperimentData, Homo_sapiens_Data

Maintainer R. Gentleman <rgentlem@fhcrc.org>

License Artistic-2.0

Depends Biobase (>= 2.5.5), hgu133plus2.db

git_url https://git.bioconductor.org/packages/humanStemCell

git_branch RELEASE_3_22

git_last_commit 7fc3573

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

fhesc .

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

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

1

3

Index

fhesc

Data from a simple experiment on Human stem cells.

Description

Human stem cells were assayed using Affymetrix 133plus 2 arrays. There were six arrays, three
were biological replicates for undifferentiated cells, the other three were biological replicates for
differentiated cells.

Usage

data(fhesc)

1

2

Format

The data are in the form of an ExpressionSet instance.

Details

fhesc

Human Embryonic Stem Cells, H1 Line were cultured under feeder-free conditions. Undifferenti-
ated samples were taken from this pool. The differentiated samples were obtained by maintaining
the cells in culture for 10 - 14 days in the absence of basic fibroblast growth factor and conditioned
medium.

Source

The data were obtained from Dr. M. Tewari.

References

These data were used to prepare the book chapter, R and Bioconductor packages in bioinformatics:
towards systems biology, by Nolwenn LeMeur, Michael Lawrence, Merav Bar, Muneesh Tewari
and Robert Gentleman

Examples

data(fhesc)

Index

∗ datasets

fhesc, 1

fhesc, 1

3

