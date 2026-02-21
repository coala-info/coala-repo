hgu133a2cdf

February 11, 2026

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

Details

numeric. x-coordinate (from 1 to 732)

numeric. y-coordinate (from 1 to 732)

numeric. single-number index (from 1 to 535824)

Type i2xy and xy2i at the R prompt to view the function definitions.

See Also

hgu133a2cdf

Examples

= 1:(732*732)

xy2i(5,5)
i
coord = i2xy(i)
j
stopifnot(all(i==j))
range(coord[, "x"])
range(coord[, "y"])

= xy2i(coord[, "x"], coord[, "y"])

1

2

hgu133a2dim

hgu133a2cdf

hgu133a2cdf

Description

environment describing the CDF file

hgu133a2dim

hgu133a2dim

Description

environment describing the CDF dimensions

Index

∗ datasets

hgu133a2cdf, 2
hgu133a2dim, 2
i2xy, 1

hgu133a2cdf, 1, 2
hgu133a2dim, 2

i2xy, 1

xy2i (i2xy), 1

3

