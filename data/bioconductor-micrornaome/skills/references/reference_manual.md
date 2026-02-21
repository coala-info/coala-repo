Package ‘microRNAome’

February 17, 2026

Version 1.32.0

Date 2022-11-07

Title SummarizedExperiment for the microRNAome project

Description This package provides a SummarizedExperiment object of
read counts for microRNAs across tissues, cell-types, and
cancer cell-lines. The read count matrix was prepared and
provided by the author of the study: Towards the human cellular
microRNAome.

Author Matthew N. McCall <mccallm@gmail.com>, Marc K. Halushka

<mhalush1@jhmi.edu>, Arun H. Patil <arun26feb@gmail.com>

Maintainer Matthew N. McCall <mccallm@gmail.com>

Depends R (>= 3.4), SummarizedExperiment

Suggests BiocGenerics, RUnit

biocViews ExperimentData, CellCulture, CancerData, SequencingData,

RNASeqData, miRNAData

License GPL (>= 2)

git_url https://git.bioconductor.org/packages/microRNAome

git_branch RELEASE_3_22

git_last_commit b62652f

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-17

Contents

microRNAome .

.

.

.

.

.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2

3

Index

1

2

microRNAome

microRNAome

MicroRNAome Data

Description

Read counts per miRNA for the microRNAome collection of RNA-Seq experiments

Usage

data("microRNAome")

Format

SummarizedExperiment

Details

Small RNA-seq data on 2406 samples from the Sequence Read Archive (SRA) processed using the
miRge3 pipeline.

Source

Read count matrix prepared and provided by authors of the study

References

Matthew N McCall, Min-Sik Kim, Mohammed Adil, Arun H Patil, Yin Lu, Christopher J Mitchell,
Pamela Leal-Rojas, Jinchong Xu, Manoj Kumar, Valina L Dawson, Ted M Dawson, Alexander
S Baras, Avi Z Rosenberg, Dan E Arking, Kathleen H Burns, Akhilesh Pandey, Marc Halushka
(2017). Toward the human cellular microRNAome. Genome Research. 27(10):1769-1781.\ \ Patil
AH, Baran A, Brehm ZP, McCall MN, Halushka MK. A curated human cellular microRNAome
based on 196 primary cell types. Gigascience. 2022 Aug 25;11:giac083. doi: 10.1093/giga-
science/giac083.

Examples

data(microRNAome)
## the microRNAome SummarizedExperiment object contains only one matrix
## in the assays field: a matrix of miRNA counts
names(assays(microRNAome))
assays(microRNAome)$counts[1:3,1:3]

Index

∗ datasets

microRNAome, 2

microRNAome, 2

3

