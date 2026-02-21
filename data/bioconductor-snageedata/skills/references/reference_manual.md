Package ‘SNAGEEdata’

February 17, 2026

Version 1.46.0

Date 2012-01-26

Title SNAGEE data

Author David Venet <davenet@ulb.ac.be>

Maintainer David Venet <davenet@ulb.ac.be>

Depends R (>= 2.6.0)

Suggests ALL, hgu95av2.db, SNAGEE

Description SNAGEE data - gene list and correlation matrix

License Artistic-2.0

biocViews MicroarrayData

URL http://fleming.ulb.ac.be/SNAGEE

git_url https://git.bioconductor.org/packages/SNAGEEdata

git_branch RELEASE_3_22

git_last_commit 36029d4

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-17

Contents

SNAGEEdata-package .
.
.
.
getCC .

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

1
2

3

Index

SNAGEEdata-package

SNAGEE - data

Description

Signal-to-Noise applied to Gene Expression Experiments - database of gene correlations.

1

2

Details

Index:

getCC

Author(s)

getCC

SNAGEEdata
Package:
0.99.0
Version:
Date:
2012-01-26
Depends: R (>= 2.6.0)
Suggests:
License:
URL:

SNAGEE
Artistic-2.0
http://fleming.ulb.ac.be/SNAGEE

Gene-gene correlations and list of genes

David Venet <davenet@ulb.ac.be>

Maintainer: David Venet <davenet@ulb.ac.be>

Examples

# the gene-gene correlations
cc = getCC();

getCC

Gene-gene correlations

Description

Get the gene-gene correlations and the list of genes.

Usage

getCC(mode="complete")

Arguments

mode

Value

Which correlations should be recovered. complete: calculated with all plat-
forms; woAffy: calculated without the Affymetrix platforms.

A list with two elements: g is the list of gene IDs, cc is the upper triangular part of the correlation
matrix.

Examples

# Get the list of genes
geneList = getCC()$g;

Index

getCC, 2

SNAGEEdata (SNAGEEdata-package), 1
SNAGEEdata-package, 1

3

