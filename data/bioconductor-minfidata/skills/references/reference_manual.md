Package ‘minfiData’

February 17, 2026

Version 0.56.0

Title Example data for the Illumina Methylation 450k array

Description Data from 6 samples across 2 groups from 450k methylation arrays.

Author Kasper Daniel Hansen, Martin Aryee, Winston Timp

Maintainer Kasper Daniel Hansen <kasperdanielhansen@gmail.com>

License Artistic-2.0

Depends R (>= 3.3.0), minfi (>= 1.21.2),

IlluminaHumanMethylation450kmanifest,
IlluminaHumanMethylation450kanno.ilmn12.hg19

LazyData yes

biocViews Homo_sapiens_Data, MethylationArrayData, MicroarrayData

git_url https://git.bioconductor.org/packages/minfiData

git_branch RELEASE_3_22

git_last_commit 7e79eee

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-17

Contents

MsetEx .
RGsetEx .

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
.

.
.

.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

Index

MsetEx

Description

An example dataset for Illumina’s Human Methylation 450k dataset,
after preprocessing.

1
2

4

This contains the raw data for 6 samples from Illumina’s Human Methylation 450k dataset. The
data has been preprocessed.

1

2

Usage

data(MsetEx)
data(MsetEx.sub)

Details

RGsetEx

Currently, the pheno data for these 6 samples are masked. Scripts for creating the object is found
in the scripts directory of the package and extdata contains the IDAT files. The data has been
preprocessed using preprocessRaw.

The MsetEx.sub is a subset with 600 CpGs (200 of Type II, 200 of Type I - Red and 200 of Type II
- Green), used for examples.

Value

An object of class "MethylSet"

See Also

MethylSet for the class definition, preprocessRaw for the preprocessing function, RGsetEx for the
companion raw data.

Examples

data(MsetEx)
data(MsetEx.sub)
pData(MsetEx)

RGsetEx

An example dataset for Illumina’s Human Methylation 450k dataset.

Description

This contains the raw data for 6 samples from Illumina’s Human Methylation 450k dataset.

Usage

data(RGsetEx)
data(RGsetEx.sub)

Details

Currently, the pheno data for these 6 samples are masked. Scripts for creating the object is found in
the scripts directory of the package and extdata contains the IDAT files.

The RGsetEx.sub is a subset with 600 CpGs (200 of Type II, 200 of Type I - Red and 200 of Type
II - Green), used for examples.

Value

An object of class "RGChannelSet"

RGsetEx

See Also

3

RGChannelSet for the class definition, MsetEx for the comparion preprocessed data.

Examples

data(RGsetEx)
data(RGsetEx.sub)
pData(RGsetEx)

Index

∗ datasets

MsetEx, 1
RGsetEx, 2

MethylSet, 2
MsetEx, 1, 3

preprocessRaw, 2

RGChannelSet, 3
RGsetEx, 2, 2

4

