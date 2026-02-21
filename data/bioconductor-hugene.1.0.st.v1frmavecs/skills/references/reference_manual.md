hugene.1.0.st.v1frmavecs

February 11, 2026

hugene.1.0.st.v1barcodevecs

Vectors used by barcode function for hugene.1.0.st.v1.

Description

Parameters of the background distribution for use with the barcode function. These correspond to
version 3.0 of the Gene Expression Barcode website.

Usage

data(hugene.1.0.st.v1barcodevecs)

Format

A list with 3 elements.

mu
tau
entropy

background means
background standard deviations
observed gene entropy

Examples

data(hugene.1.0.st.v1barcodevecs)
str(hugene.1.0.st.v1barcodevecs)

1

2

hugene.1.0.st.v1frmavecs

hugene.1.0.st.v1frmavecs

Vectors used by fRMA for hugene.1.0.st.v1.

Description

Frozen parameter vectors for use with the frma and GNUSE functions.

Usage

data(hugene.1.0.st.v1frmavecs)

Format

A list with 6 elements.

normVec
probeVec
probeVarWithin
probeVarBetween
probesetSD
medianSE
probeVecCore
mapCore

normalization vector
probe effect vector
within batch probe variance
between batch probe variance
within probeset standard deviation
median standard error for gene expression estimates
exon effect vector for summarizing to core transcripts
mapping between exons and core transcripts

Examples

data(hugene.1.0.st.v1frmavecs)
str(hugene.1.0.st.v1frmavecs)

Index

∗ datasets

hugene.1.0.st.v1barcodevecs, 1
hugene.1.0.st.v1frmavecs, 2

hugene.1.0.st.v1barcodevecs, 1
hugene.1.0.st.v1frmavecs, 2

3

