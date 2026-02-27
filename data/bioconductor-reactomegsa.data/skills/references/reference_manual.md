Package ‘ReactomeGSA.data’

February 26, 2026

Type Package

Title Companion data package for the ReactomeGSA package

Version 1.24.0

Description Companion data sets to showcase the functionality of the ReactomeGSA package.

This package contains proteomics and RNA-seq data of the melanoma B-
cell induction study by Griss et al. and scRNA-seq data from
Jerby-Arnon et al.

License Artistic-2.0

Encoding UTF-8

Depends R (>= 3.6), limma, edgeR, ReactomeGSA, Seurat

RoxygenNote 6.1.1

biocViews ExpressionData, RNASeqData, Proteome, Homo_sapiens_Data

BugReports https://github.com/reactome/ReactomeGSA.data

URL https://github.com/reactome/ReactomeGSA.data/issues

git_url https://git.bioconductor.org/packages/ReactomeGSA.data

git_branch RELEASE_3_22

git_last_commit c61ae33

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-26

Author Johannes Griss [aut, cre] (ORCID:

<https://orcid.org/0000-0003-2206-9511>)

Maintainer Johannes Griss <johannes.griss@meduniwien.ac.at>

Contents

griss_melanoma_proteomics . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
griss_melanoma_result
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
griss_melanoma_rnaseq .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
jerby_b_cells

.
.
.

.

.

.

.

.

Index

1

2
2
3
3

4

2

griss_melanoma_result

griss_melanoma_proteomics

Proteomics
melanoma induction study by Griss et al.

intensity-based quantitation data from the B-Cell

Description

The data is available as a EList object containing the aggregated protein intensity values. Normal-
isation was already performed on the PSM level prior to protein-level aggregation.

Usage

griss_melanoma_proteomics

Format

An object of class EList with 6456 rows and 20 columns.

Author(s)

Johannes Griss <johannes.griss@meduniwien.ac.at>

References

Griss et al., Nat Commun. 2019 10(1):4186. doi: 10.1038/s41467-019-12160-2

griss_melanoma_result Example Camera result created based on the melanoma induction

study by Griss et al.

Description

The result is stored as a ReactomeAnalysisResult-class object.

Usage

griss_melanoma_result

Format

An object of class ReactomeAnalysisResult of length 1.

Author(s)

Johannes Griss <johannes.griss@meduniwien.ac.at>

References

Griss et al., Nat Commun. 2019 10(1):4186. doi: 10.1038/s41467-019-12160-2

griss_melanoma_rnaseq

3

griss_melanoma_rnaseq Raw RNA-seq read counts from the B-Cell melanoma induction study

by Griss et al.

Description

The data is available as a DGEList object containing read counts per gene.

Usage

griss_melanoma_rnaseq

Format

An object of class DGEList with 58237 rows and 16 columns.

Author(s)

Johannes Griss <johannes.griss@meduniwien.ac.at>

References

Griss et al., Nat Commun. 2019 10(1):4186. doi: 10.1038/s41467-019-12160-2

jerby_b_cells

Example Seurat object containing B cells extracted from the single-
cell RNA-seq dataset published by Jerby-Arnon et al.

Description

This result is stored as a Seurat object.

Usage

jerby_b_cells

Format

An object of class Seurat with 23686 rows and 920 columns.

References

Jerby-Arnon et al., Cell 2018 1;175(4):984-997.e24. doi:10.1016/j.cell.2018.09.006

Index

∗ datasets

griss_melanoma_proteomics, 2
griss_melanoma_result, 2
griss_melanoma_rnaseq, 3
jerby_b_cells, 3

DGEList, 3

EList, 2

griss_melanoma_proteomics, 2
griss_melanoma_result, 2
griss_melanoma_rnaseq, 3

jerby_b_cells, 3

4

