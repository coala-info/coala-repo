Package ‘colonCA’

February 12, 2026

Title exprSet for Alon et al. (1999) colon cancer data

Version 1.52.0

Author Sylvia Merk

Description exprSet for Alon et al. (1999) colon cancer data

Maintainer W Sylvia Merk <sylvia.merk@ukmuenster.de>

License LGPL

Depends Biobase (>= 2.5.5)

biocViews ExperimentData, Tissue, CancerData, ColonCancerData,

MicroarrayData, TissueMicroarrayData

git_url https://git.bioconductor.org/packages/colonCA

git_branch RELEASE_3_22

git_last_commit 44fe793

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

colonCA .

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

colonCA

Data from the microarray experiment done by Alon et al. (1999)

Description

The data package contains an exprSet instance for the Alon et al. (1999) colon cancer data. 62
samples (40 tumor samples, 22 normal samples) from colon-cancer patients were analyzed with an
Affymetrix oligonucleotide Hum6000 array.

Usage

data(colonCA)

1

colonCA

2

Format

Expression set with 2000 genes and 62 samples.
There are 3 covariates listed.

• expNr: Number of sample.

• samp: Sample code.

positive: Normal tissue, negative: Tumor tissue

• class: Tissue identity.

n: Normal tissue, t: Tumor tissue

Details

40 samples are from tumors (labelled as "negative") and 22 samples are from normal (labelled as
"positive") biopsies from healthy parts of the colons of the same patients.
Two thousand out of around 6500 genes were selected based on the confidence in the measured
expression levels (for details refer to publication). No further preprocessing (normalization etc.)
was done.

Note: the featureNames in this dataset were not unique when submitted; make.names(unique=TRUE)
was run and some featureNames have suffix .1, .2, etc. added to establish uniqueness.

Source

http://microarray.princeton.edu/oncology/affydata/index.html

References

U. Alon et al. (1999): Broad patterns of gene expression revealed by clustering analysis of tumor
and normal colon tissue probed by oligonucleotide arrays. Proc. Natl. Acad. Sci. USA 96, 6745-
6750

Examples

library(Biobase)
data(colonCA)
xx <- exprs(colonCA)
dim(xx)
xx[1:5,1:5]

colonCA$class
featureNames(colonCA)[1:20]
colnames(xx) <- as.character(colonCA$class)
xx[1:5,1:5]

Index

∗ datasets

colonCA, 1

colonCA, 1

3

