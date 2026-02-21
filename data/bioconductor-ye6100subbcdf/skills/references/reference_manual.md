ye6100subbcdf

February 18, 2026

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

numeric. x-coordinate (from 1 to 264)

numeric. y-coordinate (from 1 to 264)

numeric. single-number index (from 1 to 69696)

Type i2xy and xy2i at the R prompt to view the function definitions.

See Also

ye6100subbcdf

Examples

= 1:(264*264)

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

ye6100subbdim

ye6100subbcdf

ye6100subbcdf

Description

environment describing the CDF file

ye6100subbdim

ye6100subbdim

Description

environment describing the CDF dimensions

Index

∗ datasets

i2xy, 1
ye6100subbcdf, 2
ye6100subbdim, 2

i2xy, 1

xy2i (i2xy), 1

ye6100subbcdf, 1, 2
ye6100subbdim, 2

3

