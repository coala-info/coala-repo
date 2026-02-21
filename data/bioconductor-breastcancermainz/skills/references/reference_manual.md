Package ‘breastCancerMAINZ’

February 12, 2026

Type Package

Title Gene expression dataset published by Schmidt et al. [2008]

(MAINZ).

Version 1.48.0

Date 2011-02-10

Description Gene expression data from the breast cancer study pub-

lished by Schmidt et al. in 2008, provided as an eSet.

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

git_url https://git.bioconductor.org/packages/breastCancerMAINZ

git_branch RELEASE_3_22

git_last_commit 28f2680

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

mainz .

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

mainz

Gene expression, annotations and clinical data from Schmidt et al.
2008

2

mainz

Description

This dataset contains the gene expression, annotations and clinical data as published in Schmidt et
al. 2008.

Usage

data(mainz)

Format

ExpressionSet with 22283 features and 200 samples, containing:

• exprs(mainz): Matrix containing gene expressions as measured by Affymetrix hgu133a

technology (single-channel, oligonucleotides).

• fData(mainz): AnnotatedDataFrame containing annotations of Affy microarray platform

hgu133a.

• pData(mainz): AnnotatedDataFrame containing Clinical information of the breast cancer

patients whose tumors were hybridized.

• experimentalData(mainz): MIAME object containing information about the dataset.

• annotation(mainz): Name of the affy chip.

Details

This dataset represents the study published by Schmidt et al. 2008.

• Abstract: Estrogen receptor (ER) expression and proliferative activity are established prog-
nostic factors in breast cancer. In a search for additional prognostic motifs, we analyzed the
gene expression patterns of 200 tumors of patients who were not treated by systemic ther-
apy after surgery using a discovery approach. After performing hierarchical cluster analysis,
we identified coregulated genes related to the biological process of proliferation, steroid hor-
mone receptor expression, as well as B-cell and T-cell infiltration. We calculated metagenes
as a surrogate for all genes contained within a particular cluster and visualized the relative
expression in relation to time to metastasis with principal component analysis. Distinct pat-
terns led to the hypothesis of a prognostic role of the immune system in tumors with high
expression of proliferation-associated genes. In multivariate Cox regression analysis, the pro-
liferation metagene showed a significant association with metastasis-free survival of the whole
discovery cohort [hazard ratio (HR), 2.20; 95% confidence interval (95% CI), 1.40-3.46]. The
B-cell metagene showed additional independent prognostic information in carcinomas with
high proliferative activity (HR, 0.66; 95% CI, 0.46-0.97). A prognostic influence of the B-cell
metagene was independently confirmed by multivariate analysis in a first validation cohort
enriched for high-grade tumors (n = 286; HR, 0.78; 95% CI, 0.62-0.98) and a second valida-
tion cohort enriched for younger patients (n = 302; HR, 0.83; 95% CI, 0.7-0.97). Thus, we
could show in three cohorts of untreated, node-negative breast cancer patients that the humoral
immune system plays a pivotal role in metastasis-free survival of carcinomas of the breast.

mainz

Source

3

http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE11121

References

Marcus Schmidt and Daniel Boehm and Christian von Toerne and Eric Steiner and Alexander
Puhl and Heryk Pilch and Hans-Anton Lehr and Jan G. Hengstler and Hainz Koelbl and Mathias
Gehrmann (2008)"The Humoral Immune System Has a Key Prognostic Impact in Node-Negative
Breast Cancer", Cancer Research, 68(13):5405-5413

Examples

## load Biobase package
library(Biobase)
## load the dataset
data(mainz)
## show the first 5 rows and columns of the expression data
exprs(mainz)[1:5,1:5]
## show the first 6 rows of the phenotype data
head(pData(mainz))
## show first 20 feature names
featureNames(mainz)[1:20]
## show the experiment data summary
experimentData(mainz)
## show the used platform
annotation(mainz)
## show the abstract for this dataset
abstract(mainz)

Index

∗ datasets

mainz, 2

mainz, 2

4

