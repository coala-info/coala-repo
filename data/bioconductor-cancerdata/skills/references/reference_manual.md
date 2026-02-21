Package ‘cancerdata’

February 12, 2026

Type Package

Version 1.48.0

Date 2011-10-26

Title Development and validation of diagnostic tests from

high-dimensional molecular data: Datasets

Author Jan Budczies, Daniel Kosztyla

Maintainer Daniel Kosztyla <danielkossi@hotmail.com>

Description Dataset for the R package cancerclass

Depends R (>= 2.10.1), Biobase

License GPL (>= 2)

biocViews CancerData, MicroarrayData

git_url https://git.bioconductor.org/packages/cancerdata

git_branch RELEASE_3_22

git_last_commit d5f9e37

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

cancerdata-package .
.
.
VEER .
.
.
.
VIJVER .
.
.
YOUNG .

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

. .
. .
. .
. .

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2
2
3
4

5

1

2

VEER

cancerdata-package

Development and validation of diagnostic tests from high-dimensional
molecular data: Datasets

Description

This package contains dataset for the R package cancerclass.

Details

Author(s)

cancerdata
Package:
Package
Type:
1.1.0
Version:
Date:
2010-10-26
License: GPL (>=2)

Jan Budczies <jan.budczies@charite.de>, Daniel Kosztyla <danielkossi@hotmail.com>

References

[1] Michiels S, Koscielny S, Hill C (2005), Prediction of cancer outcome with microarrays: a
multiple random validation strategy, Lancet 365:488-492.

See Also

VEER1

Examples

### see: help(VEER1);

VEER

Breast cancer gene expression data (van’t Veer)

Description

Gene expression data from the breast cancer microarray study of van’t Veer et al. [1]. The data set
VEER includes gene expression values of 24481 genes in 78 tumor samples. The data set VEER1 is
a filtered version [2] of VEER including gene expression values of 4948 genes in 78 tumor samples).

Usage

data(VEER)
data(VEER1)

VIJVER

Value

3

Data and annotations are organized in a ExtressenSet of the package Biobase.

VEER

VEER1

References

ExpressionSet

ExpressionSet

[1] van ’t Veer LJ et al. (2002), Gene expression profiling predicts clinical outcome of breast cancer,
Nature 415:530-536.
[2] Michiels S, Koscielny S, Hill C (2005), Prediction of cancer outcome with microarrays: a
multiple random validation strategy, Lancet 365:488-492.

Examples

### see: help(GOLUB);

VIJVER

Breast cancer gene expression data (Vijver)

Description

Gene expression data from the breast cancer microarray study of Vijver et al. [1]. The data set
VIJVER includes expression values of 24481 genes in 295 tumor samples. The data set VIJVER1
is a filtered version of VIJVER [2] including expression values of 4948 genes in 295 tumor samples.

data(VIJVER)
data(VIJVER1)

Usage

Value

Data and annotations are organized in a ExtressenSet of the package Biobase.

VIJVER

VIJVER1

ExpressionSet

ExpressionSet

References

[1] van de Vijver MJ, He YD, van’t Veer LJ, et al.
predictor of survival in breast cancer. N Engl J Med, 347:1999-2009.
[2] Michiels S, Koscielny S, Hill C (2005), Prediction of cancer outcome with microarrays: a
multiple random validation strategy, Lancet 365:488-493.

(2002): A gene-expression signature as a

Examples

### see: help(GOLUB);

4

YOUNG

YOUNG

Breast cancer gene expression data (van’t Veer, young patients)

Description

Gene expression data from the breast cancer microarray study of van’t Veer et al. [1]. The data set
VEER includes gene expression values of 24481 genes in 19 tumor samples. The data set VEER1 is
a filtered version [2] of VEER including gene expression values of 4948 genes in 19 tumor samples).

Usage

Value

data(YOUNG)
data(YOUNG1)

Data and annotations are organized in a ExtressenSet of the package Biobase.

YOUNG

YOUNG1

ExpressionSet

ExpressionSet

References

[1] van ’t Veer LJ et al (2002), Gene expression profiling predicts clinical outcome of breast cancer,
Nature 415:530-56.
[2] Michiels S, Koscielny S, Hill C (2005), Prediction of cancer outcome with microarrays: a
multiple random validation strategy, Lancet 365:488-492.

Examples

### see: help(GOLUB);

Index

∗ datasets

VEER, 2
VIJVER, 3
YOUNG, 4

∗ package

cancerdata-package, 2

cancerdata (cancerdata-package), 2
cancerdata-package, 2

VEER, 2
VEER1, 2
VEER1 (VEER), 2
VIJVER, 3
VIJVER1 (VIJVER), 3

YOUNG, 4
YOUNG1 (YOUNG), 4

5

