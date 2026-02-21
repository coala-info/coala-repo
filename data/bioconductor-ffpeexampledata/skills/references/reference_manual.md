Package ‘ffpeExampleData’

February 12, 2026

Type Package

Title Illumina DASL example microarray data

Version 1.48.0

Date 2011-11-15

Author Levi Waldron

Maintainer Levi Waldron <lwaldron@hsph.harvard.edu>

Description A subset of GSE17565 (April et al. 2009) containing 32 FFPE samples of Burkitts Lym-

phoma and Breast Adenocarcinoma, with a dilution series in technical duplicate.

Depends R (>= 2.10.0), lumi

Suggests genefilter, affy

biocViews Tissue, Genome, MicroarrayData, TissueMicroarrayData, GEO

License GPL (>2)

LazyLoad yes

git_url https://git.bioconductor.org/packages/ffpeExampleData

git_branch RELEASE_3_22

git_last_commit e5f9f29

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

ffpeExampleData-package . .
. .
lumibatch.GSE17565 .

.

.

Index

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2
3

4

1

2

ffpeExampleData-package

ffpeExampleData-package

Illumina DASL example microarray data ~~ package title ~~

Description

A subset of GSE17565 (April et al. 2009) containing 32 FFPE samples of Burkitts Lymphoma and
Breast Adenocarcinoma, with a dilution series in technical duplicate.

Details

Package:
Type:
Version:
Date:
License: GPL (>2)

ffpeExampleData
Package
1.0.0
2011-11-17

Downloaded from the GEO URL:

http://www.ncbi.nlm.nih.gov/projects/geo/query/acc.cgi?acc=GSE17565 .

Raw data were obtained from the supplemental file GSE17565_nonorm_nobkgd.txt.gz, and inserted
into a lumibatch object using the lumi:lumiR command. The metadata from GEO are also curated
for ease of use.

Some analyses of this dataset are done in the ffpe Bioconductor package.

Author(s)

Levi Waldron <lwaldron@hsph.harvard.edu>

References

April C, Klotzle B, Royce T, Wickham-Garcia E et al. Whole-genome gene expression profiling
of formalin-fixed, paraffin-embedded tissue samples. PLoS One 2009 Dec 3;4(12):e8162. PMID:
19997620

Data from accession ID GSE17565 of the Gene Expression Omnibus

Examples

library(lumi)
data(lumibatch.GSE17565)
meta.data <- pData(lumibatch.GSE17565)
expression.data <- exprs(lumibatch.GSE17565)
summary(meta.data)
boxplot(log2(expression.data))

lumibatch.GSE17565

3

lumibatch.GSE17565

Illumina DASL expression data from FFPE tissues.

Description

This lumibatch object contains raw expression data for 32 FFPE samples of Burkitts Lymphoma
and Breast Adenocarcinoma, with dilution series and technical duplicates. From the original study
by April et al. (2009). Sample metadata includes input RNA concentration, cell type, and replicate
#.

Usage

data(lumibatch.GSE17565)

Format

Formal class ’LumiBatch’ [package "lumi"]

Details

Downloaded from the GEO URL:

http://www.ncbi.nlm.nih.gov/projects/geo/query/acc.cgi?acc=GSE17565 .

Raw data were obtained from the supplemental file GSE17565_nonorm_nobkgd.txt.gz, and inserted
into a lumibatch object using the lumi:lumiR command.

Source

April C, Klotzle B, Royce T, Wickham-Garcia E et al. Whole-genome gene expression profiling
of formalin-fixed, paraffin-embedded tissue samples. PLoS One 2009 Dec 3;4(12):e8162. PMID:
19997620

Data from accession ID GSE17565 of the Gene Expression Omnibus

Examples

data(lumibatch.GSE17565)
meta.data <- pData(lumibatch.GSE17565)
expression.data <- exprs(lumibatch.GSE17565)

Index

∗ datasets

lumibatch.GSE17565, 3

ffpeExampleData

(ffpeExampleData-package), 2

ffpeExampleData-package, 2

lumibatch.GSE17565, 3

4

