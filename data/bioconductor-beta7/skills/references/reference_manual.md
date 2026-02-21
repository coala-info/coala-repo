Package ‘beta7’

February 12, 2026

Version 1.48.0

Date 2005-10-19

Title Rodriguez et al. (2004) Differential Gene Expression by

Memory/Effector T Helper Cells Bearing the Gut-Homing Receptor
Integrin alpha4 beta7.

Author Jean Yang <jean@biostat.ucsf.edu>

Maintainer Jean Yang <jean@biostat.ucsf.edu>

Description

Data from 6 gpr files aims to identify differential expressed genes between the beta 7+ and beta 7-
memory T helper cells.

License LGPL

Depends R (>= 2.4.0), marray

biocViews ExperimentData, Homo_sapiens_Data, CGHData, MicroarrayData

git_url https://git.bioconductor.org/packages/beta7

git_branch RELEASE_3_22

git_last_commit 9ae99c0

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

beta7 .

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

Index

beta7

Description

Data from Rodriguez et al. (2004) Differential Gene Expression by
Memory/Effector T Helper Cells Bearing the Gut-Homing Receptor
Integrin alpha4 beta7.

1

3

This data package contains an marrayRaw instance for the as well as 6 gpr files of the beta7 mi-
croarray experiment.

1

2

Usage

data(beta7)

Details

beta7

Each arrays(hybridization) involved β7+ cell RNA from a single subject (labeled with one dye)
and β7− cell RNA from the same subject (labeled with the other dye). Target RNA was hybridized
to microarrays containing 23,184 probes including Operon Human version 2 set of 70-mer oligonu-
cleotide probes and 1760 controls spots (e.g. negative, positive and normalization controls spots).

References

M.W. Rodriguez, A. C. Paquet, Y.H. Yang and D. J. Erle, Differential gene expression by integrin
beta7+and beta7-memory T helper cells, BMC Immunology 2004, pp. 5–13.

Examples

data(beta7)
summary(beta7)
dim(beta7@maGf)

Index

∗ datasets

beta7, 1

beta7, 1

3

