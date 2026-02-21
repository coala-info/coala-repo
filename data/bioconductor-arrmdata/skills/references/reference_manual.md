Package ‘ARRmData’

February 12, 2026

Version 1.46.0

Title Example dataset for normalization of Illumina 450k Methylation

data

Description Raw Beta values from 36 samples across 3 groups from Illumina 450k methylation arrays

Author Jean-Philippe Fortin, Celia M.T. Greenwood, Aurelie Labbe

Maintainer Jean-Philippe Fortin <jfortin@jhsph.edu>

License Artistic-2.0

Depends R (>= 3.0.0)

biocViews ExperimentData, MethylationArrayData

git_url https://git.bioconductor.org/packages/ARRmData

git_branch RELEASE_3_22

git_last_commit 2d2dd34

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

.

.

.

.

betaMatrix .
.
greenControlMatrix .
.
redControlMatrix .
.
.
sampleNames .

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

. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .

1
2
3
3

5

Index

betaMatrix

Example of a matrix of Beta values from the Illumina 450k array

Description

The matrix contains the Beta values of a set of 36 samples from the Illumina Infinium Human-
Methylation 450k array

1

2

Usage

data(betaMatrix)

Format

greenControlMatrix

A data frame with 485577 observations (rows) and 36 samples (columns)

Details

Column names correspond to the sample names (of the form 5621146025_R06C02)

See Also

normalizeARRm for normalization of the Beta values, greenControlMatrix and redControlMatrix
for the associated negative control probe data.

Examples

data(betaMatrix)

greenControlMatrix

Example of a matrix containing the green negative control probes from
the Illumina 450k array

Description

The matrix contains the raw intensities of 600 negative control probes measured in the green channel
for 36 samples from the Illumina Infinium HumanMethylation 450k array

Usage

data(greenControlMatrix)

Format

A data frame with 600 observations (rows) and 36 samples (columns)

Details

Column names correspond to the sample names (of the form 5621146023_R01C01). These samples
correspond to those of betaMatrix.

See Also

getBackground to obtain background information, redControlMatrix for the equivalent negative
contol probes in the red channel

Examples

data(greenControlMatrix)

redControlMatrix

3

redControlMatrix

Example of a matrix containing the red negative control probes from
the Illumina 450k array

Description

The matrix contains the raw intensities of 600 negative control probes measured in the red channel
for 36 samples from the Illumina Infinium HumanMethylation 450k array

Usage

data(redControlMatrix)

Format

A data frame with 600 observations (rows) and 36 samples (columns)

Details

Column names correspond to the sample names (of the form 5621146023_R01C01). These samples
correspond to those of betaMatrix

See Also

getBackground to obtain background information, greenControlMatrix for the equivalent nega-
tive contol probes in the green channel

Examples

data(redControlMatrix)

sampleNames

An example of sample names for the Illumina 450k array

Description

Sample names for a dataset containing 36 samples from the Illumina Infinium HumanMethylation
450k array.

Usage

data(sampleNames)

Format

A character vector

Details

Names are of the form 5621146023_R01C01. These sample names correspond to the names of the
samples in betaMatrix

4

See Also

getDesignInfo to obtain design information,

Examples

data(sampleNames)

sampleNames

Index

∗ datasets

betaMatrix, 1
greenControlMatrix, 2
redControlMatrix, 3
sampleNames, 3

betaMatrix, 1, 2, 3

getBackground, 2, 3
getDesignInfo, 4
greenControlMatrix, 2, 2, 3

normalizeARRm, 2

redControlMatrix, 2, 3

sampleNames, 3

5

