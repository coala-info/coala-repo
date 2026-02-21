ecoli2cdf

February 11, 2026

ecoli2cdf

ecoli2cdf

Description

environment describing the CDF file

ecoli2dim

ecoli2dim

Description

environment describing the CDF dimensions

i2xy

Convert (x,y)-coordinates to single-number indices and back.

Description

Convert (x,y)-coordinates on the chip (and in the CEL file) to the single-number indices used in
AffyBatch and CDF environment, and back.

Usage

i2xy(i)
xy2i(x,y)

Arguments

x

y

i

numeric. x-coordinate (from 1 to 478)

numeric. y-coordinate (from 1 to 478)

numeric. single-number index (from 1 to 228484)

1

2

Details

Type i2xy and xy2i at the R prompt to view the function definitions.

i2xy

See Also

ecoli2cdf

Examples

= 1:(478*478)

xy2i(5,5)
i
coord = i2xy(i)
j
stopifnot(all(i==j))
range(coord[, "x"])
range(coord[, "y"])

= xy2i(coord[, "x"], coord[, "y"])

Index

∗ datasets

ecoli2cdf, 1
ecoli2dim, 1
i2xy, 1

ecoli2cdf, 1, 2
ecoli2dim, 1

i2xy, 1

xy2i (i2xy), 1

3

