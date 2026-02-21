hgu133plus2frmavecs

February 11, 2026

hgu133plus2barcodevecs

Vectors used by barcode function for hgu133plus2.

Description

Parameters of the background distribution for use with the barcode function. These correspond to
version 3.0 of the Gene Expression Barcode website.

Usage

data(hgu133plus2barcodevecs)

Format

A list with 3 elements.

mu
tau
entropy

background means
background standard deviations
observed gene entropy

Examples

data(hgu133plus2barcodevecs)
str(hgu133plus2barcodevecs)

1

2

hgu133plus2frmavecs

hgu133plus2frmavecs

Vectors used by fRMA for hgu133plus2.

Description

Frozen parameter vectors for use with the frma and GNUSE functions.

Usage

data(hgu133plus2frmavecs)
data(hgu133plus2hsentrezgfrmavecs)

Format

A list with 6 or 7 elements.

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

data(hgu133plus2frmavecs)
str(hgu133plus2frmavecs)

Index

∗ datasets

hgu133plus2barcodevecs, 1
hgu133plus2frmavecs, 2

hgu133plus2barcodevecs, 1
hgu133plus2frmavecs, 2
hgu133plus2hsentrezgfrmavecs

(hgu133plus2frmavecs), 2

3

