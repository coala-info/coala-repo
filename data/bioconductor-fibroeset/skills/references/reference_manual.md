Package ‘fibroEset’

February 12, 2026

Title exprSet for Karaman et al. (2003) fibroblasts data

Version 1.52.0

Date 2009-09-14

Author Sylvia Merk

Description exprSet for Karaman et al. (2003) human, bonobo and gorilla fibroblasts data

Maintainer Sylvia Merk <merk@ibe.med.uni-muenchen.de>

License LGPL

Depends Biobase (>= 2.5.5)

biocViews ExperimentData, Genome, Homo_sapiens_Data, MicroarrayData,

ChipOnChipData

git_url https://git.bioconductor.org/packages/fibroEset

git_branch RELEASE_3_22

git_last_commit cbae377

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

fibroEset .

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

Index

fibroEset

Description

Data from the microarray experiment of human, bonobo and gorilla
cultured fibroblasts done by Karaman et al. (2003)

1

3

Total RNA from early-passage primary fibroblast cell lines from 18 human, 10 bonobo and 11
gorilla donors was extracted and gene-expression analysis performed using Affymetrix U95Av2.

Usage

data(fibroEset)

1

2

Format

fibroEset

Expression set with 12625 genes and 46 samples.
There are 2 covariates listed.

• samp: sample code.

• species: The species the sample was obtained from.

h: human (Homo sapiens), b: bonobo (Pan paniscus), g: gorilla (Gorilla gorilla)

Details

Data preprocessing (as described in the publication):
The raw expression scores for every gene in every sample were generated using AFFYMETRIX
GENECHIP 5.0. Normalization was done by calculating multiplicative scaling factors on the basis
of the median intensity of the 60th to 95th percentile of gene-expression scores. All gene-expression
scores below 100 were set to 100 to minimize noise associated with less robust measurements of
rare transcripts.

The usage of a human chip can cause mismatches between the ape RNA samples and human
oligonucleotide probes. Because 16 perfect match probes interrogate each gene, the effect of mis-
matches should be minimal (Hacia et al. 1998).

Source

http://lichad.usc.edu/supplement/index.html

References

Karaman M.W., Houck M.L., Chemnick L.G., Nagpal S., Chawannakul D., Sudano D., Pike B.L.,
Ho V.V., Ryder O.A. & Hacia J.G. (2003) Comparative Analysis of Gene-Expression Patterns in
Human and African Great Ape Cultured Fibroblasts. Genome Research 13, 1619-1630.

Hacia J.G. et al. (1998) Evolutionary sequence comparisons using high-density oligonucleotide
arrays. Nature genetics 18, 155-158.

Examples

library(Biobase)
data(fibroEset)
xx <- exprs(fibroEset)
colnames(xx) <- as.character(fibroEset$species)
dim(xx)
xx[1:5,1:5]
fibroEset$species
featureNames(fibroEset)[1:20]

Index

∗ datasets

fibroEset, 1

fibroEset, 1

3

