Package ‘DLBCL’

February 12, 2026

Type Package

Title Diffuse large B-cell lymphoma expression data

Version 1.50.0

Date 2010-03-26

Author Marcus Dittrich and Daniela Beisser

Maintainer Marcus Dittrich <marcus.dittrich@biozentrum.uni-wuerzburg.de>

Description This package provides additional expression data on diffuse large B-

cell lymphomas for the BioNet package.

License GPL (>=2)

Depends R(>= 2.11.0), Biobase, graph

LazyLoad yes

URL http://bionet.bioapps.biozentrum.uni-wuerzburg.de/

biocViews ExperimentData, CancerData, MicroarrayData, ChipOnChipData

git_url https://git.bioconductor.org/packages/DLBCL

git_branch RELEASE_3_22

git_last_commit b6d1d8b

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

DLBCL-package .
.
.
dataLym .
.
.
exprLym .
.
interactome .

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

.
.
.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2
2
3
3

5

1

2

dataLym

DLBCL-package

Routines for the functional analysis of biological networks

Description

This package provides an expression set on diffuse large B-cell lymphoma and an protein-protein
interaction network obtained from HPRD release 6. It accompanies the BioNet packages as example
data. For further information on the data and the BioNet package, see references below.

Details

Package:
Type:
Version:
Date:
License:
LazyLoad:

DLBCL
Package
1.2
2010-03-26
GPL (>=2)
yes

Author(s)

Marcus Dittrich, Daniela Beisser

Maintainer: Marcus Dittrich <marcus.dittrich@biozentrum.uni-wuerzburg.de>

References

M. T. Dittrich, G. W. Klau, A. Rosenwald, T. Dandekar and T. Mueller (2008) Identifying func-
tional modules in protein-protein interaction networks: an integrated exact approach. (ISMB2008)
Bioinformatics 24: 13. i223-i231 Jul.

D. Beisser, G. W. Klau, T. Dandekar, T. Mueller and M. Dittrich (2009) BioNet: an R-package for
the Functional Analysis of Biological Networks. Bioinformatics.

A. A. Alizadeh, M. B. Eisen, R. E. Davis et al. (2000) Distinct types of diffuse large B-cell lym-
phoma identified by gene expression profiling. Nature 403: 503-11.

dataLym

Additional data for the lymphoma microarray chip (exprLym)

Description

The dataset contains additional data for the exprLym dataset.
expression, p-values for the survival data, an example score etc.

It includes p-values for the gene

Usage

data(dataLym)

exprLym

References

3

A. Rosenwald et al. (2002). The use of molecular profiling to predict survival after chemotherapy
for diffuse large-B-cell lymphoma. N Engl J Med, 346(25), 1937-1947.

Examples

data(dataLym)
str(dataLym)

exprLym

Expression set diffuse large B-cell lymphomas

Description

The dataset contains an expression set on diffuse large B-cell lymphoma. It accompanies the BioNet
packages as example data. For further information on the data and the BioNet package see:

M. T. Dittrich, G. W. Klau, A. Rosenwald, T. Dandekar and T. Mueller (2008) Identifying func-
tional modules in protein-protein interaction networks: an integrated exact approach. (ISMB2008)
Bioinformatics 24: 13. i223-i231 Jul.

D. Beisser, G. W. Klau, T. Dandekar, T. Mueller and M. Dittrich (2009) BioNet: an R-package for
the Functional Analysis of Biological Networks. Bioinformatics.

A. A. Alizadeh, M. B. Eisen, R. E. Davis et al. (2000) Distinct types of diffuse large B-cell lym-
phoma identified by gene expression profiling. Nature 403: 503-11.

Usage

data(exprLym)

Examples

data(exprLym)
exprs(exprLym)[1:10,]

interactome

Human protein-protein interaction network

Description

The dataset contains the human proteome, extracted from the Human Protein Reference Database
(HPRD) from 2006 that is used in the ABC GCB diffuse large B-cell lymphma analysis. The format
of the dataset is a graph object.

Usage

data(interactome)

4

References

interactome

M. T. Dittrich, G. W. Klau, A. Rosenwald, T. Dandekar, T. Mueller (2008) Identifying functional
modules in protein-protein interaction networks: an integrated exact approach. (ISMB2008) Bioin-
formatics, 24: 13. i223-i231 Jul.

Examples

data(interactome)
interactome

Index

∗ datasets

dataLym, 2
exprLym, 3
interactome, 3

dataLym, 2
DLBCL (DLBCL-package), 2
DLBCL-package, 2

exprLym, 3

interactome, 3

5

