huex.1.0.st.v2frmavecs
February 11, 2026

huex.1.0.st.v2barcodevecs

Vectors used by barcode function for huex.1.0.st.v2.

Description

Parameters of the background distribution for use with the barcode function.

Usage

data(huex.1.0.st.v2barcodevecs)

Format

A list with 3 elements.

mu
tau
entropy

background means
background standard deviations
observed gene entropy

Examples

data(huex.1.0.st.v2barcodevecs)
str(huex.1.0.st.v2barcodevecs)

huex.1.0.st.v2frmavecs

Vectors used by fRMA for huex.1.0.st.v2.

Description

Frozen parameter vectors for use with the frma and GNUSE functions.

Usage

data(huex.1.0.st.v2frmavecs)

1

2

Format

A list with 6 elements.

huex.1.0.st.v2frmavecs

normVec
probeVec
probeVarWithin
probeVarBetween
probesetSD
medianSE
probeVecCore
probeVecExt
probeVecFull
mapCore
mapExt
mapFull

normalization vector
probe effect vector
within batch probe variance
between batch probe variance
within probeset standard deviation
median standard error for gene expression estimates
exon effect vector when summarizing to core transcipts
probe effect vector when summarizing to extended transcipts
probe effect vector when summarizing to full transcipts
mapping between exons and core transcripts
mapping between exons and extended transcripts
mapping between exons and full transcripts

Examples

data(huex.1.0.st.v2frmavecs)
str(huex.1.0.st.v2frmavecs)

Index

∗ datasets

huex.1.0.st.v2barcodevecs, 1
huex.1.0.st.v2frmavecs, 1

huex.1.0.st.v2barcodevecs, 1
huex.1.0.st.v2frmavecs, 1

3

