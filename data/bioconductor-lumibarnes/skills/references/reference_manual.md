Package ‘lumiBarnes’

February 12, 2026

Type Package

Title Barnes Benchmark Illumina Tissues Titration Data

Version 1.50.0

Date 2010-10-12

Author Pan Du

Maintainer Pan Du <dupan@northwestern.edu>

Description The Barnes benchmark dataset can be used to evaluate the algorithms for Illumina mi-
croarrays. It measured a titration series of two human tissues, blood and placenta, and in-
cludes six samples with the titration ratio of blood and pla-
centa as 100:0, 95:5, 75:25, 50:50, 25:75 and 0:100. The samples were hybridized on Human-
Ref-8 BeadChip (Illumina, Inc) in duplicate. The data is loaded as an LumiBatch Ob-
ject (see documents in the lumi package).

License LGPL

Depends R (>= 2.0), Biobase (>= 2.5.5), lumi (>= 1.1.0)

biocViews ExperimentData, Tissue, MicroarrayData, ChipOnChipData

git_url https://git.bioconductor.org/packages/lumiBarnes

git_branch RELEASE_3_22

git_last_commit 51b3d66

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

lumiBarnes

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

3

Index

1

2

lumiBarnes

lumiBarnes

Barnes Benchmark Illumina Tissues Titration Data

Description

The Barnes data set measured a titration series of two human tissues, blood and placenta. It includes
six samples with the titration ratio of blood and placenta as 100:0, 95:5, 75:25, 50:50, 25:75 and
0:100. The samples were hybridized on HumanRef-8 BeadChip (Illumina, Inc) in duplicate. See
(Barnes, et al., 2005) for details. The data is saved as a LumiBatch object and should be use together
with lumi package.

Because the Barnes data utilized the pre-released version of HumanRef-8 version 1 BeadChip, some
probes on the chip do not exist in the public released HumanRef-8 version 1 BeadChip. For annota-
tion consistence, these probes was removed in the lumiBarnes package. For the interested users, the
raw data can be downloaded from the paper companion website: http://www.bioinformatics.ubc.ca/pavlidis/lab/platformCompare/.

Usage

data(lumiBarnes)

Format

lumiBarnes is a LumiBatch-class object.

Source

Barnes, M., Freudenberg, J., Thompson, S., Aronow, B. and Pavlidis, P. (2005) Ex-perimental
comparison and cross-validation of the Affymetrix and Illumina gene expression analysis platforms,
Nucleic Acids Res, 33, 5914-5923.

Examples

data(lumiBarnes)
lumiBarnes

Index

∗ datasets

lumiBarnes, 2

lumiBarnes, 2

3

