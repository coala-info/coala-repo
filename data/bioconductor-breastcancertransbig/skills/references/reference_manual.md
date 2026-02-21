Package ‘breastCancerTRANSBIG’

February 12, 2026

Type Package

Title Gene expression dataset published by Desmedt et al. [2007]

(TRANSBIG).

Version 1.48.0

Date 2011-02-10

Description Gene expression data from a breast cancer study pub-
lished by Desmedt et al. in 2007, provided as an eSet.

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

git_url https://git.bioconductor.org/packages/breastCancerTRANSBIG

git_branch RELEASE_3_22

git_last_commit c232dea

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

transbig .

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

transbig

transbig

Gene expression, annotations and clinical data from TRANSBIG 2006

Description

This dataset contains the gene expression, annotations and clinical data as published from TRANS-
BIG in 2006.

Usage

data(transbig)

Format

ExpressionSet with 22283 features and 198 samples, containing:

• exprs(transbig): Matrix containing gene expressions as measured by Affymetrix hgu133a

technology (single-channel, oligonucleotides).

• fData(transbig): AnnotatedDataFrame containing annotations of Affy microarray platform

hgu133a.

• pData(transbig): AnnotatedDataFrame containing Clinical information of the breast cancer

patients whose tumors were hybridized.

• experimentalData(transbig): MIAME object containing information about the dataset.

• annotation(transbig): Name of the affy chip.

Details

This dataset represent the study published by Desmedt et al. in 2006.

• Abstract: Purpose: Recently, a 76-gene prognostic signature able to predict distant metas-
tases in lymph node-negative (N-) breast cancer patients was reported. The aims of this study
conducted by TRANSBIG were to independently validate these results and to compare the
outcome with clinical risk assessment. Experimental Design: Gene expression profiling of
frozen samples from 198 N- systemically untreated patients was done at the Bordet Institute,
blinded to clinical data and independent of Veridex. Genomic risk was defined by Veridex,
blinded to clinical data. Survival analyses, done by an independent statistician, were done
with the genomic risk and adjusted for the clinical risk, defined by Adjuvant! Online. Results:
The actual 5- and 10-year time to distant metastasis were 98% (88-100%) and 94% (83-98%),
respectively, for the good profile group and 76% (68-82%) and 73% (65-79%), respectively,
for the poor profile group. The actual 5- and 10-year overall survival were 98% (88-100%)
and 87% (73-94%), respectively, for the good profile group and 84

Source

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE7390

transbig

References

3

Christine Desmedt and Fanny Piette and Sherene Loi and Yixin Wang and Francoise Lallemand
and Benjamin Haibe-Kains and Giuseppe Viale and Mauro Delorenzi and Yi Zhang and Mahasti
Saghatchian d Assignies and Jonas Bergh and Rosette Lidereau and Paul Ellis and Adrian L. Harris
and Jan G. M. Klijn and John A. Foekens and Fatima Cardoso and Martine J. Piccart and Marc
Buyse and Christos Sotiriou (2007) "Strong Time Dependence of the 76-Gene Prognostic Signature
for Node-Negative Breast Cancer Patients in the TRANSBIG Multicenter Independent Validation
Series", Clinical Cancer Research, 13(11):3207-3214

Examples

## load Biobase package
library(Biobase)
## load the dataset
data(transbig)
## show the first 5 rows and columns of the expression data
exprs(transbig)[1:5,1:5]
## show the first 6 rows of the phenotype data
head(pData(transbig))
## show first 20 feature names
featureNames(transbig)[1:20]
## show the experiment data summary
experimentData(transbig)
## show the used platform
annotation(transbig)
## show the abstract for this dataset
abstract(transbig)

Index

∗ datasets

transbig, 2

transbig, 2

4

