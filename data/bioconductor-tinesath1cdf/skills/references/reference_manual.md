Package ‘tinesath1cdf’

February 17, 2026

Title tinesath1cdf

Version 1.48.0

Created Monday August 7th 2006

Author Tine Casneuf

Description A package containing an environment represeting the

newcdf/tinesATH1.cdf.cdf file.

Maintainer Tine Casneuf <tine@ebi.ac.uk>

License Artistic-2.0

biocViews Arabidopsis_thaliana_Data, ChipOnChipData

git_url https://git.bioconductor.org/packages/tinesath1cdf

git_branch RELEASE_3_22

git_last_commit f4c210d

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-17

Contents

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

1
2

3

Convert (x,y)-coordinates to single-number indices and back.

.
.
i2xy .
tinesath1cdf .

.

.

Index

i2xy

Description

Convert (x,y)-coordinates on the chip (and in the CEL file) to the single-number indices used in
AffyBatch and CDF environment, and back.

Usage

i2xy(i)
xy2i(x,y)

1

2

Arguments

x

y

i

Details

tinesath1cdf

numeric. x-coordinate (from 1 to 712)

numeric. y-coordinate (from 1 to 712)

numeric. single-number index (from 1 to 506944)

Type i2xy and xy2i at the R prompt to view the function definitions.

Examples

= 1:(712*712)

xy2i(5,5)
i
coord = i2xy(i)
j
stopifnot(all(i==j))
range(coord[, "x"])
range(coord[, "y"])

= xy2i(coord[, "x"], coord[, "y"])

tinesath1cdf

environment containing the location probe set membership mapping

Description

environment describing the CDF file

Index

∗ datasets

i2xy, 1
tinesath1cdf, 2

i2xy, 1

tinesath1cdf, 2

xy2i (i2xy), 1

3

