hgu133a2frmavecs

February 11, 2026

hgu133a2barcodevecs

Vectors used by barcode function for hgu133a2.

Description

Parameters of the background distribution for use with the barcode function. These correspond to
version 3.0 of the Gene Expression Barcode website.

Usage

data(hgu133a2barcodevecs)

Format

A list with 3 elements.

mu
tau
entropy

background means
background standard deviations
observed gene entropy

Examples

data(hgu133a2barcodevecs)
str(hgu133a2barcodevecs)

hgu133a2frmavecs

Vectors used by fRMA for hgu133a2.

Description

Frozen parameter vectors for use with the frma and GNUSE functions.

Usage

data(hgu133a2frmavecs)
data(hgu133a2hsentrezgfrmavecs)

1

2

Format

A list with 6 or 7 elements.

hgu133a2frmavecs

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

data(hgu133a2frmavecs)
str(hgu133a2frmavecs)

Index

∗ datasets

hgu133a2barcodevecs, 1
hgu133a2frmavecs, 1

hgu133a2barcodevecs, 1
hgu133a2frmavecs, 1
hgu133a2hsentrezgfrmavecs

(hgu133a2frmavecs), 1

3

