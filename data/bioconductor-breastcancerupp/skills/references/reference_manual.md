Package ‘breastCancerUPP’

February 12, 2026

Type Package

Title Gene expression dataset published by Miller et al. [2005] (UPP).

Version 1.48.0

Date 2011-02-10

Description Gene expression data from a breast cancer study published by Miller et al. in 2005, pro-

vided as an eSet.

biocViews ExperimentData, CancerData, BreastCancerData,

MicroarrayData, GEO

Author Markus Schroeder, Benjamin Haibe-

Kains, Aedin Culhane, Christos Sotiriou, Gianluca Bontempi, John Quackenbush

Maintainer Markus Schroeder <mschroed@jimmy.harvard.edu>, Benjamin Haibe-

Kains <bhaibeka@jimmy.harvard.edu>

Depends R (>= 2.5.0)

Suggests survcomp, genefu, Biobase

LazyLoad yes

License Artistic-2.0

URL http://compbio.dfci.harvard.edu/

git_url https://git.bioconductor.org/packages/breastCancerUPP

git_branch RELEASE_3_22

git_last_commit cc4bc3b

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

upp .

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

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2

4

Index

1

2

upp

upp

Gene expression, annotations and clinical data from Miller et al. 2005

Description

This dataset contains the gene expression, annotations and clinical data as published in Miller et al.
2005.

Usage

data(upp)

Format

ExpressionSet with 44928 features and 251 samples, containing:

• exprs(upp): Matrix containing gene expressions as measured by Affymetrix hgu133a/hgu133b

technology (single-channel, oligonucleotides).

• fData(upp): AnnotatedDataFrame containing annotations of Affy microarray platform hgu133a

and hgu133b.

• pData(upp): AnnotatedDataFrame containing Clinical information of the breast cancer pa-

tients whose tumors were hybridized.

• experimentalData(upp): MIAME object containing information about the dataset.
• annotation(upp): Name of the affy chip.

Details

This dataset represent the study published by Miller et al. 2005.

• Abstract: Perturbations of the p53 pathway are associated with more aggressive and thera-
peutically refractory tumors. However, molecular assessment of p53 status, by using sequence
analysis and immunohistochemistry, are incomplete assessors of p53 functional effects. We
posited that the transcriptional fingerprint is a more definitive downstream indicator of p53
function. Herein, we analyzed transcript profiles of 251 p53-sequenced primary breast tu-
mors and identified a clinically embedded 32-gene expression signature that distinguishes
p53-mutant and wild-type tumors of different histologies and outperforms sequence-based as-
sessments of p53 in predicting prognosis and therapeutic response. Moreover, the p53 signa-
ture identified a subset of aggressive tumors absent of sequence mutations in p53 yet exhibiting
expression characteristics consistent with p53 deficiency because of attenuated p53 transcript
levels. Our results show the primary importance of p53 functional status in predicting clinical
breast cancer behavior.

Source

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE3494

References

Lance D. Miller and Johanna Smeds and Joshy George and Vinsensius B. Vega and Liza Vergara
and Alexander Ploner and Yudi Pawitan and Per Hall and Sigrid Klaar and Edison T. Liu and Jonas
Bergh (2005) "An expression signature for p53 status in human breast cancer predicts mutation sta-
tus, transcriptional effects, and patient survival" Proceedings of the National Academy of Sciences
of the United States of America 102(38):13550-13555

upp

Examples

3

## load Biobase package
library(Biobase)
## load the dataset
data(upp)
## show the first 5 rows and columns of the expression data
exprs(upp)[1:5,1:5]
## show the first 6 rows of the phenotype data
head(pData(upp))
## show first 20 featuren names
featureNames(upp)[1:20]
## show the experiment data summary
experimentData(upp)
## show the used platform
annotation(upp)
## show the abstract for this dataset
abstract(upp)

Index

∗ datasets
upp, 2

upp, 2

4

