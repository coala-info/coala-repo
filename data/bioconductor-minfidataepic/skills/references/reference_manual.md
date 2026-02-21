Package ‘minfiDataEPIC’

February 17, 2026

Version 1.36.0

Title Example data for the Illumina Methylation EPIC array

Description

Data from 3 technical replicates of the cell line GM12878 from the EPIC methylation array.

Author Jean-Philippe Fortin, Kasper Daniel Hansen

Maintainer Kasper Daniel Hansen <kasperdanielhansen@gmail.com>

License Artistic-2.0

Depends R (>= 3.3), minfi (>= 1.21.2),

IlluminaHumanMethylationEPICmanifest,
IlluminaHumanMethylationEPICanno.ilm10b2.hg19

LazyData yes

biocViews Homo_sapiens_Data, MethylationArrayData, MicroarrayData

NeedsCompilation no

git_url https://git.bioconductor.org/packages/minfiDataEPIC

git_branch RELEASE_3_22

git_last_commit b6347d8

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-17

Contents

MsetEPIC .
.
RGsetEPIC .

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

2
2

4

Index

1

2

RGsetEPIC

MsetEPIC

An example dataset for Illumina’s Human Methylation EPIC dataset,
after preprocessing.

Description

This contains the raw data for 3 technical replicates of the cell line GM12878 from the Illumina’s
Human Methylation EPIC platform. The data has been preprocessed with preprocessRaw.

Usage

data(MsetEPIC)

Format

An object of class "MethylSet"

Details

Scripts for creating the object is found in the scripts directory of the package and extdata con-
tains the IDAT files. The data has been preprocessed using preprocessRaw.

See Also

MethylSet for the class definition, preprocessRaw for the preprocessing function, RGsetEPIC for
the companion raw data.

Examples

data(MsetEPIC)
pData(MsetEPIC)

RGsetEPIC

An example dataset for the Illumina’s Human Methylation EPIC plat-
form.

Description

This contains the raw data for 3 technical replicates of the cell line GM12878 from the Illumina’s
Human Methylation EPIC platform.

Usage

data(RGsetEPIC)

Format

An object of class "RGChannelSet"

RGsetEPIC

Details

3

Scripts for creating the object is found in the scripts directory of the package and extdata con-
tains the IDAT files.

See Also

RGChannelSet for the class definition, MsetEPIC for the comparion preprocessed data.

Examples

data(RGsetEPIC)
pData(RGsetEPIC)

Index

∗ datasets

MsetEPIC, 2
RGsetEPIC, 2

MethylSet, 2
MsetEPIC, 2, 3

preprocessRaw, 2

RGChannelSet, 3
RGsetEPIC, 2, 2

4

