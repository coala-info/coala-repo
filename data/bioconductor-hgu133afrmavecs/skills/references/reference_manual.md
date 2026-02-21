hgu133afrmavecs

February 11, 2026

hgu133abarcodevecs

Vectors used by barcode function for hgu133a.

Description

Parameters of the background distribution for use with the barcode function. These correspond to
version 3.0 of the Gene Expression Barcode website.

Usage

data(hgu133abarcodevecs)

Format

A list with 3 elements.

mu
tau
entropy

background means
background standard deviations
observed gene entropy

Examples

data(hgu133abarcodevecs)
str(hgu133abarcodevecs)

hgu133afrmavecs

Vectors used by fRMA for hgu133a.

Description

Frozen parameter vectors for use with the frma and GNUSE functions.

Usage

data(hgu133afrmavecs)
data(hgu133ahsentrezgfrmavecs)

1

2

Format

A list with 6 or 7 elements.

hgu133afrmavecs

normVec
probeVec
probeVarWithin
probeVarBetween
probesetSD
medianSE
version

normalization vector
probe effect vector
within batch probe variance
between batch probe variance
within probeset standard deviation
median standard error for gene expression estimates
the Entrez Gene alternative CDF version if applicable

Examples

data(hgu133afrmavecs)
str(hgu133afrmavecs)

Index

∗ datasets

hgu133abarcodevecs, 1
hgu133afrmavecs, 1

hgu133abarcodevecs, 1
hgu133afrmavecs, 1
hgu133ahsentrezgfrmavecs

(hgu133afrmavecs), 1

3

