mouse4302frmavecs
February 25, 2026

mouse4302barcodevecs

Vectors used by barcode function for mouse4302.

Description

Parameters of the background distribution for use with the barcode function. These correspond to
version 3.0 of the Gene Expression Barcode website.

Usage

data(mouse4302barcodevecs)

Format

A list with 3 elements.

mu
tau
entropy

background means
background standard deviations
observed gene entropy

Examples

data(mouse4302barcodevecs)
str(mouse4302barcodevecs)

mouse4302frmavecs

Vectors used by fRMA for mouse4302.

Description

Frozen parameter vectors for use with the frma and GNUSE functions.

Usage

data(mouse4302frmavecs)
data(mouse4302mmentrezgfrmavecs)

1

2

Format

A list with 6 or 7 elements.

mouse4302frmavecs

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

data(mouse4302frmavecs)
str(mouse4302frmavecs)

Index

∗ datasets

mouse4302barcodevecs, 1
mouse4302frmavecs, 1

mouse4302barcodevecs, 1
mouse4302frmavecs, 1
mouse4302mmentrezgfrmavecs

(mouse4302frmavecs), 1

3

