mogene.1.0.st.v1frmavecs

February 25, 2026

mogene.1.0.st.v1barcodevecs

Vectors used by barcode function for mogene.1.0.st.v1.

Description

Parameters of the background distribution for use with the barcode function. These correspond to
version 3.0 of the Gene Expression Barcode website.

Usage

data(mogene.1.0.st.v1barcodevecs)

Format

A list with 3 elements.

mu
tau
entropy

background means
background standard deviations
observed gene entropy

Examples

data(mogene.1.0.st.v1barcodevecs)
str(mogene.1.0.st.v1barcodevecs)

1

2

mogene.1.0.st.v1frmavecs

mogene.1.0.st.v1frmavecs

Vectors used by fRMA for mogene.1.0.st.v1.

Description

Frozen parameter vectors for use with the frma and GNUSE functions.

Usage

data(mogene.1.0.st.v1frmavecs)

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

data(mogene.1.0.st.v1frmavecs)
str(mogene.1.0.st.v1frmavecs)

Index

∗ datasets

mogene.1.0.st.v1barcodevecs, 1
mogene.1.0.st.v1frmavecs, 2

mogene.1.0.st.v1barcodevecs, 1
mogene.1.0.st.v1frmavecs, 2

3

