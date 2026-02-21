Package ‘spqnData’

February 17, 2026

Version 1.22.0

Title Data for the spqn package

Description Bulk RNA-

seq from GTEx on 4,000 randomly selected, expressed genes. Data has been processed for co-
expression analysis.

Depends R (>= 4.0), SummarizedExperiment

License Artistic-2.0

LazyData FALSE

biocViews Homo_sapiens_Data, ExpressionData, Tissue, RNASeqData

git_url https://git.bioconductor.org/packages/spqnData

git_branch RELEASE_3_22

git_last_commit 30ae52d

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-17

Author Yi Wang [cre, aut],

Kasper Daniel Hansen [aut]

Maintainer Yi Wang <yiwangthu5@gmail.com>

Contents

gtex.4k .

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

1

3

Index

gtex.4k

Example data for the spqn package.

Description

A random sample of 4,000 expressed genes (protein-coding or lincRNAs) from GTEx v6p. The
tissue is Adipose Subcutaneous.

1

2

Usage

data("gtex.4k")

Format

An object of class SummarizedExperiment.

Details

gtex.4k

Data is 350 samples from GTEx v6p. The tissue is Adipose Subcutanous.

We first selected protein-coding or lincRNAs based on the supplied annotation files. Next we kept
genes with a median log2(RPKM) expression greater than zero. This resulted in a data matrix with
12,267 genes of which 11,911 are protein-coding. We stored the mean expression value per gene in
rowData(gtex.4k)$ave_logrpkm.

We next mean centered and variance scaled the expression values so all genes have zero mean and
variance 1. We then removed 4 principal components from this data matrix using the removePrincipalComponents
function from the WGCNA package.

Finally, we randomly selected 4,000 genes.

Additional information on the genes are present in the rowData. The type of gene (lincRNA or
protein-coding) is present in the gene_type column. The average expression of each gene on
the log2(RPKM)-scale, prior to removing principal components, are present in the ave_logrpkm
column.

Source

Original data from gtexportal.org. A script for downloading and processing the paper is included
in scripts/gtex.Rmd.

Examples

data(gtex.4k)

Index

∗ datasets

gtex.4k, 1

gtex.4k, 1

3

