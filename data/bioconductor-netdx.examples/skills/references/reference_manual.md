Package ‘netDx.examples’
February 20, 2020

Title Companion data package to netDx
Version 0.99.3
Author c(person(``Shraddha'', ``Pai'', email = ``shraddha.pai@utoronto.ca'', role = c(``aut'', ``cre'')),

person(``Philipp'',``Weber'',role=``aut''),
person(``Ahmad'',``Shah'', role=``aut''),
person(``Shirley'',``Hui'',role=``aut''),
person(``Ruth'',``Isserlin'',role=``aut''),
person(``Hussam'',``Kaka'', role=``aut''),
person(``Gary D'',``Bader'',role=``aut''))

Maintainer Shraddha Pai <shraddha.pai@utoronto.ca>
Description Companion data package to run vignettes for netDx.
Depends R (>= 3.6)
License MIT
LazyData false
biocViews ExperimentData,PackageTypeData
RoxygenNote 6.1.1
git_url https://git.bioconductor.org/packages/netDx.examples
git_branch master
git_last_commit c5786a4
git_last_commit_date 2019-08-01
Date/Publication 2020-02-20

R topics documented:

.

.
.
.

.
.
.

.
.
cnv_GR .
.
.
genes
.
.
KIRC_dat
.
.
KIRC_group .
.
KIRC_pheno .
.
.
MB.pheno .
MB.xpr
.
.
.
.
MB.xpr_names .
.
.
.
pheno .
.
TCGA_BRCA .
.
.
.
xpr .

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
.
.
.
.
.
.
.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.

Index

1

2
2
3
3
4
4
5
5
6
6
7

8

2

genes

cnv_GR

CNV locations for breast cancer (subset)

Description

Subset of CNV locations for TCGA breast tumour. Each range is associated with a patient (ID)

Source

The Cancer Genome Atlas. (2012). Nature 490:61-70.

References

The Cancer Genome Atlas. (2012). Nature 490:61-70.

Examples

data(TCGA_BRCA)
head(cnv_GR)

genes

Table of gene deﬁnitions (small subsample of human genes)

Description

data.frame object with columns of (gene) RefSeq ID (name), chromosome (chrom), strand, tran-
scription start site (txStart), transcription end site (txEnd), and gene symbol (name2)

Usage

data(genes)

Examples

data(genes)
head(genes)

KIRC_dat

3

KIRC_dat

Clinical and gene expression data for kidney cancer survival.

Description

List with one entry for clinical data ("clinical") and one for gene expression ("rna"). Each entry
contains a data.frame with patient-level measures (columns) for clinical variables or genes (rows).

Usage

data(KIRC_dat)

References

Yuan Y, Van Allen EM, Omberg L, Wagle N, Amin-Mansour A, Sokolov A, Byers LA, Xu Y, Hess
KR, Diao L, Han L, Huang X, Lawrence MS, Weinstein JN, Stuart JM, Mills GB, Garraway LA,
Margolin AA, Getz G, Liang H (2014b) Synapse syn1710286.

Examples

data(KIRC_dat)
head(KIRC_dat)

KIRC_group

Variable groupings for kidney cancer survival data (clinical and gene
expression)

Description

List with one entry for clinical data ("clinical") and one for gene expression ("rna"). Each entry
contains a list with keys being group names, and values containing members for the corresponding
groups. Correspond to data present in KIRC_dat

Usage

data(KIRC_group)

References

Yuan Y, Van Allen EM, Omberg L, Wagle N, Amin-Mansour A, Sokolov A, Byers LA, Xu Y, Hess
KR, Diao L, Han L, Huang X, Lawrence MS, Weinstein JN, Stuart JM, Mills GB, Garraway LA,
Margolin AA, Getz G, Liang H (2014b) Synapse syn1710286.

Examples

data(KIRC_group)
head(KIRC_group)

4

MB.pheno

KIRC_pheno

Sample metadata table for kidney cancer example

Description

data.frame with patient ID (ID), survival status (STATUS) and covariates. Data from the PanCancer
Survival project.

Usage

data(KIRC_pheno)

References

Yuan Y, Van Allen EM, Omberg L, Wagle N, Amin-Mansour A, Sokolov A, Byers LA, Xu Y, Hess
KR, Diao L, Han L, Huang X, Lawrence MS, Weinstein JN, Stuart JM, Mills GB, Garraway LA,
Margolin AA, Getz G, Liang H (2014b) Synapse syn1710286.

Examples

data(KIRC_pheno)
head(KIRC_pheno)

MB.pheno

Gene expression for medulloblastoma example

Description

data.frame with gene expression values (rows) for all patients (columns)

Source

Northcott et al. (2011). J Clin Oncol. 29 (11):1408.

References

Northcott et al. (2011). J Clin Oncol. 29 (11):1408.

Examples

data(MBlastoma)
head(MB.pheno)

MB.xpr

5

MB.xpr

Sample metadata table for medulloblastoma dataset.

Description

data.frame with patient ID and tumour subtype (STATUS)

Usage

data(MB.xpr)

Source

Northcott et al. (2011). J Clin Oncol. 29 (11):1408.

References

Northcott et al. (2011). J Clin Oncol. 29 (11):1408.

Examples

data(MBlastoma)
head(MB.xpr)

MB.xpr_names

Gene names for medulloblastoma expression data

Description

Vector of gene symbols

Source

Northcott et al. (2011). J Clin Oncol. 29 (11):1408.

References

Northcott et al. (2011). J Clin Oncol. 29 (11):1408.

Examples

data(MBlastoma)
head(MB.xpr_names)

6

TCGA_BRCA

pheno

Sample metadata table

Description

data.frame with patient ID (ID), sample type (Type), tumour subtype (STATUS). From TCGA 2012
breast cancer paper (see reference).

Source

The Cancer Genome Atlas. (2012). Nature 490:61-70.

References

The Cancer Genome Atlas. (2012). Nature 490:61-70.

Examples

data(TCGA_BRCA)
head(pheno)

TCGA_BRCA

Breast cancer sample data

Description

Contains three objects: 1) pheno: data frame with sample metadata. data.frame with patient ID
(ID), sample type (Type), tumour subtype (STATUS). 2) xpr: gene expression table 3) cnv_GR:
GenomicRanges object with patient CNVs

Source

The Cancer Genome Atlas. (2012). Nature 490:61-70.

References

The Cancer Genome Atlas. (2012). Nature 490:61-70.

Examples

data(TCGA_BRCA)
head(pheno)
head(xpr)
head(cnv_GR)

xpr

7

xpr

Example expression matrix

Description

data.frame with gene expression for 727 genes (rows) and 40 patients (columns). Data from TCGA
breast cancer subtyping study.

Source

The Cancer Genome Atlas. (2012). Nature 490:61-70.

References

The Cancer Genome Atlas. (2012). Nature 490:61-70.

Examples

data(TCGA_BRCA)
head(xpr)

Index

∗ datasets

cnv_GR, 2
genes, 2
KIRC_dat, 3
KIRC_group, 3
KIRC_pheno, 4
MB.pheno, 4
MB.xpr, 5
MB.xpr_names, 5
pheno, 6
TCGA_BRCA, 6
xpr, 7

cnv_GR, 2

genes, 2

KIRC_dat, 3
KIRC_group, 3
KIRC_pheno, 4

MB.pheno, 4
MB.xpr, 5
MB.xpr_names, 5

pheno, 6

TCGA_BRCA, 6

xpr, 7

8

