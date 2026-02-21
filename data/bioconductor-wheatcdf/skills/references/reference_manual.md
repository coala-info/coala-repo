wheatcdf

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

numeric. x-coordinate (from 1 to 1164)

numeric. y-coordinate (from 1 to 1164)

numeric. single-number index (from 1 to 1354896)

Type i2xy and xy2i at the R prompt to view the function definitions.

See Also

wheatcdf

Examples

= 1:(1164*1164)

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

wheatdim

wheatcdf

wheatcdf

Description

environment describing the CDF file

wheatdim

wheatdim

Description

environment describing the CDF dimensions

Index

∗ datasets

i2xy, 1
wheatcdf, 2
wheatdim, 2

i2xy, 1

wheatcdf, 1, 2
wheatdim, 2

xy2i (i2xy), 1

3

