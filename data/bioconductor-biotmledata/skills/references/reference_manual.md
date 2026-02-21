Package ‘biotmleData’

Title Example experimental microarray data set for the ``biotmle'' R

February 12, 2026

package

Version 1.34.0

Description Microarray data (from the Illumina Ref-8 BeadChips
platform) and phenotype-level data from an epidemiological
investigation of benzene exposure, packaged using
``SummarizedExperiemnt'', for use as an example with the
``biotmle'' R package.

Depends R (>= 3.0)

Suggests Biobase, SummarizedExperiment

License file LICENSE

Encoding UTF-8

LazyData true

RoxygenNote 6.0.1

biocViews GeneExpression, DifferentialExpression, Sequencing,

Microarray, RNASeq

git_url https://git.bioconductor.org/packages/biotmleData

git_branch RELEASE_3_22

git_last_commit b18a8d5

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Author Nima Hejazi [aut, cre]

Maintainer Nima Hejazi <nhejazi@berkeley.edu>

Contents

biomarkerTMLEout .
.
.
illuminaData
.
rnaseqTMLEout .

.
.

.

Index

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
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2
2
3

4

1

2

illuminaData

biomarkerTMLEout

Results obtained from running biomarkertmle on the "illuminaData"
sample data

Description

Example results obtained from running the TMLE-based estimation procedure on the example data
included with this package (illuminaData).

Usage

biomarkerTMLEout

Format

A biotmle object containing the results of running biomarkertmle.

These results are included here for the sake of making the vignettes build more quickly. The
user will likely not benefit from using this data set.

Value

A biotmle object containing results from biomarkertmle.

illuminaData

Sample baseline covariates and Illumina microarray data from a 2007
study

Description

A dataset containing various baseline covariates and microarray expression measures from Illumina
arrays used in a 2007 study.

Usage

illuminaData

Format

A SummarizedExperiment containing Illumina microarray data from the Ref-8 BeadChips plat-
form in the "assay" slot and phenotype data on subjects in the "colData" slot:

This is example data to be used in testing the biomarkertmle procedure. Consult the vignettes
for how to use this data.

Value

A SummarizedExperiment containing biomarkers and baseline covariates.

rnaseqTMLEout

3

rnaseqTMLEout

Results obtained from running biomarkertmle on simulated RNA-Seq
data

Description

Example results obtained from running the TMLE-based estimation procedure on next-generation
sequencing (count) data.

Usage

rnaseqTMLEout

Format

A biotmle object containing the results of running biomarkertmle.

These results are included here for the sake of making the vignettes build more quickly. The
user will likely not benefit from using this data set.

Value

A biotmle object containing results from biomarkertmle.

Index

∗ datasets

biomarkerTMLEout, 2
illuminaData, 2
rnaseqTMLEout, 3

biomarkerTMLEout, 2

illuminaData, 2

rnaseqTMLEout, 3

4

