Package ‘shinyMethylData’

February 17, 2026

Version 1.30.0

Title Example dataset of input data for shinyMethyl

Description Extracted data from 369 TCGA Head and Neck Cancer DNA
methylation samples. The extracted data serve as an example
dataset for the package shinyMethyl. Original samples are from
450k methylation arrays, and were obtained from The Cancer
Genome Atlas (TCGA). 310 samples are from tumor, 50 are matched
normals and 9 are technical replicates of a control cell line.

Maintainer Jean-Philippe Fortin <jfortin@jhsph.edu>

License Artistic-2.0

Depends R (>= 3.0.0)

LazyData yes

biocViews Genome, CancerData

Url https://github.com/Jfortin1/shinyMethylData

Author Jean-Philippe Fortin [cre, aut], Kasper Daniel Hansen [aut]

git_url https://git.bioconductor.org/packages/shinyMethylData

git_branch RELEASE_3_22

git_last_commit fa68252

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-17

Contents

summary.tcga.norm .
.
summary.tcga.raw .

.
.

.
.

.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.

2
2

4

Index

1

2

summary.tcga.raw

summary.tcga.norm

Example dataset of input data for shinyMethyl

Description

Extracted data from 369 TCGA Head and Neck Cancer DNA methylation samples. The extracted
data serve as an example dataset for the package shinyMethyl. Original samples are from 450k
methylation arrays, and were obtained from The Cancer Genome Atlas (TCGA). 310 samples are
from tumor, 50 are matched normals and 9 are technical replicates of a control cell line.

Usage

data(summary.tcga.norm)

Format

A list containing the necessary information to launch a shinyMethyl session. See the links below
for more details on the data.

References

The Cancer Genome Atltas (TCGA) Head and Neck Cancer dataset: http://cancergenome.nih.gov/cancersselected/headandneck

See Also

These data objects were created by See shinySummarize for details on how to perform the data
extraction. See runShinyMethyl for how to launch a shinyMethyl session.

Examples

data(summary.tcga.norm)
## Not run:
runShinyMethyl(summary.tcga.norm)

## End(Not run)

summary.tcga.raw

Example dataset of input data for shinyMethyl

Description

Extracted data from 369 TCGA Head and Neck Cancer DNA methylation samples. The extracted
data serve as an example dataset for the package shinyMethyl. Original samples are from 450k
methylation arrays, and were obtained from The Cancer Genome Atlas (TCGA). 310 samples are
from tumor, 50 are matched normals and 9 are technical replicates of a control cell line.

Usage

data(summary.tcga.raw)

summary.tcga.raw

Format

3

A list containing the necessary information to launch a shinyMethyl session. See the links below
for more details on the data.

References

The Cancer Genome Atltas (TCGA) Head and Neck Cancer dataset: http://cancergenome.nih.gov/cancersselected/headandneck

See Also

See shinySummarize for details on how to perform the data extraction. See runShinyMethyl for
how to launch a shinyMethyl session.

Examples

data(summary.tcga.raw)
## Not run:
runShinyMethyl(summary.tcga.raw)

## End(Not run)

Index

∗ datasets

summary.tcga.norm, 2
summary.tcga.raw, 2

runShinyMethyl, 2, 3

shinySummarize, 2, 3
summary.tcga.norm, 2
summary.tcga.raw, 2

4

