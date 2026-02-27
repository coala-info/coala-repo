Package ‘scTHI.data’

February 26, 2026

Type Package

Title The package contains examples of single cell data used in

vignettes and examples of the scTHI package; data contain both
tumor cells and immune cells from public dataset of glioma

Version 1.22.0

Description Data for the vignette and tutorial of the package scTHI.

License GPL-2

Depends R (>= 4.0)

Encoding UTF-8

LazyData false

RoxygenNote 6.1.1.9000

biocViews ExperimentData, SingleCellData

git_url https://git.bioconductor.org/packages/scTHI.data

git_branch RELEASE_3_22

git_last_commit a9dd6a5

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-26

Author Francesca Pia Caruso [aut],

Michele Ceccarelli [aut, cre]

Maintainer Michele Ceccarelli <m.ceccarelli@gmail.com>

Contents

.

.

.
.
.

.
.
.

.
H3K27 .
.
.
H3K27.meta .
MGH45 .
.
.
.
MGH45.annotation .
.
scExample .

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

2
2
3
3
3

4

1

2

H3K27.meta

H3K27

Example expression matrix for scTHI.

Description

A 21673 x 5527 matrix patient PatientBCH836 form Filbin, M. G., Tirosh, I., Hovestadt, V., Shaw,
M. L., Escalante, L. E., Mathewson, N. D., ... & Haberler, C. (2018). Developmentaland oncogenic
programs in H3K27M gliomas dissected by single-cell RNA-seq. Science, 360(6386), 331-335.
H3K27

Usage

H3K27

Format

An object of class matrix with 21673 rows and 527 columns.

H3K27.meta

Annotation for the H3K27 e expression matrix for scTHI.

Description

A dataframe 527x9 for the matrix of patient PatientBCH836 form Filbin, M. G., Tirosh, I., Hov-
estadt, V., Shaw, M. L., Escalante, L. E., Mathewson, N. D., ... & Haberler, C. (2018). Develop-
mentaland oncogenic programs in H3K27M gliomas dissected by single-cell RNA-seq. Science,
360(6386), 331-335. H3K27.annotation

Usage

H3K27.meta

Format

An object of class data.frame with 527 rows and 9 columns.

MGH45

3

MGH45

Example expression matrix for scTHI.

Description

A 17584 x 608 matrix patient PatientBCH836 form Venteicher AS, Tirosh I, Hebert C, Yizhak K
et al. Decoupling genetics, lineages, and microenvironment in IDH-mutant gliomas by single-cell
RNA-seq. Science 2017 Mar 31;355(6332) MGH45

Usage

MGH45

Format

An object of class matrix with 17584 rows and 608 columns.

MGH45.annotation

Annotation for Example expression matrix for scTHI.

Description

A 608 x 2 dataframe with the annotation for the MGH4 matrix Venteicher AS, Tirosh I, Hebert C,
Yizhak K et al. Decoupling genetics, lineages, and microenvironment in IDH-mutant gliomas by
single-cell RNA-seq. Science 2017 Mar 31;355(6332) MGH45.annotation

Usage

MGH45.annotation

Format

An object of class data.frame with 608 rows and 2 columns.

scExample

Example expression matrix for scTHI.

Description

A 2000 x 100 matrix from the wiki manual to showcase the use of scTHI scExample

Usage

scExample

Format

An object of class matrix with 2000 rows and 100 columns.

Index

∗ datasets

H3K27, 2
H3K27.meta, 2
MGH45, 3
MGH45.annotation, 3
scExample, 3

H3K27, 2
H3K27.meta, 2

MGH45, 3
MGH45.annotation, 3

scExample, 3

4

