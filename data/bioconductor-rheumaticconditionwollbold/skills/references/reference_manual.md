Package ‘rheumaticConditionWOLLBOLD’

February 26, 2026

Type Package

Title Normalized gene expression dataset published by Wollbold et al.

[2009] (WOLLBOLD).

Version 1.48.0

Date 2011-16-12

Description Normalized gene expression data from rheumatic diseases from study published by Woll-

bold et al. in 2009, provided as an eSet.

biocViews ExperimentData, Tissue, MicroarrayData, MultiChannelData,
ChipOnChipData, TissueMicroarrayData, GEO, ArrayExpress

Author Alejandro Quiroz-Zarate, John Quackenbush

Maintainer Alejandro Quiroz-Zarate <aquiroz@hsph.harvard.edu>

Depends R (>= 2.10.0)

Suggests genefilter, Biobase, hgu133plus2.db

LazyLoad yes

License Artistic-2.0

URL http://compbio.dfci.harvard.edu/

git_url https://git.bioconductor.org/packages/rheumaticConditionWOLLBOLD

git_branch RELEASE_3_22

git_last_commit d33f4c1

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-26

Contents

wollbold .

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

2

4

Index

1

2

wollbold

wollbold

Gene expression, annotations and clinical data from Wollbold et al.
2009

Description

This dataset contains the normalized gene expression, annotations and clinical data from the work
published in Wollbold et al. 2009.

Usage

data(wollbold)

Format

ExpressionSet with 54675 features and 60 samples, containing:

• exprs(wollbold): Matrix containing normalized (Robust Multi-Array average expression
measure normalization from R rma) gene expressions as measured by Affymetrix hgu133plus2
technology (single-channel, oligonucleotides).

• fData(wollbold): AnnotatedDataFrame containing annotations of Affy microarray platform

hgu133plus2.

• pData(wollbold): AnnotatedDataFrame containing Clinical information of the patients with
rheumatic diseases whose synovial membrane samples obtained from tissue excision were
hybridized.

• experimentData(wollbold): MIAME object containing information about the dataset.

• annotation(wollbold): Name of the affy chip.

Details

This dataset represents the study published by Wollbold et al. 2009.

• Abstract: Background: Due to the rapid data accumulation on pathogenesis and progression
of chronic inflammation, there is an increasing demand for approaches to analyse the under-
lying regulatory networks. For example, rheumatoid arthritis (RA) is a chronic inflammatory
disease, characterised by joint destruction and perpetuated by activated synovial fibroblasts
(SFB). These abnormally express and/or secrete pro-inflammatory cytokines, collagens caus-
ing joint fibrosis, or tissue- degrading enzymes resulting in destruction of the extra-cellular
matrix (ECM). We applied three methods to analyse ECM regulation: data discretisation to fil-
ter out noise and to reduce complexity, Boolean network construction to implement logic rela-
tionships, and formal concept analysis (FCA) for the formation of minimal, but complete rule
sets from the data. Results: First, we extracted literature information to develop an interac-
tion network containing 18 genes representing ECM formation and destruction. Subsequently,
we constructed an asynchronous Boolean network with biologically plausible time intervals
for mRNA and protein production, secretion, and inactivation. Experimental gene expression
data was obtained from SFB stimulated by TGFB1 or by TNFa and discretised thereafter.
The Boolean functions of the initial network were improved iteratively by the comparison of
the simulation runs to the experimental data and by exploitation of expert knowledge. This
resulted in adapted networks for both cytokine stimulation conditions. The simulations were
further analysed by the attribute exploration algorithm of FCA, integrating the observed time

wollbold

3

series in a fine-tuned and automated manner. The resulting temporal rules yielded new con-
tributions to controversially discussed aspects of fibroblast biology (e.g., considerable expres-
sion of TNF and MMP9 by fibroblasts stimulation) and corroborated previously known facts
(e.g., co-expression of collagens and MMPs after TNF? stimulation), but also revealed some
discrepancies to literature knowledge (e.g., MMP1 expression in the absence of FOS). Conclu-
sion: The newly developed method successfully and iteratively integrated expert knowledge at
different steps, resulting in a promising solution for the in-depth understanding of regulatory
pathways in disease dynamics. The knowledge base containing all the temporal rules may be
queried to predict the functional consequences of observed or hypothetical gene expression
disturbances. Furthermore, new hypotheses about gene relations were derived which await
further experimental validation.

Source

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE13837

References

Johannes Wollbold, Rene Huber, Dirk Pojlers, Dirk Koczan, Reinhard Guthke, Raimund W Kinne
and Ulrike Gausmann (2009). "Adapted Boolean Network Models for Extracellular Matrix Forma-
tion". BMC Systems Biology, 3:7

Examples

## load Biobase package
library(Biobase)
## load the dataset
data(wollbold)
## show the first 5 rows and columns of the expression data
exprs(wollbold)[1:5,1:5]
## show the first 6 rows of the phenotype data
head(pData(wollbold))
## show first 20 feature names
featureNames(wollbold)[1:20]
## show the experiment data summary
experimentData(wollbold)
## show the used platform
annotation(wollbold)
## show the abstract for this dataset
abstract(wollbold)

Index

∗ datasets

wollbold, 2

wollbold, 2

4

