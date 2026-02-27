mu19ksubccdf

February 25, 2026

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

numeric. x-coordinate (from 1 to 534)

numeric. y-coordinate (from 1 to 534)

numeric. single-number index (from 1 to 285156)

Type i2xy and xy2i at the R prompt to view the function definitions.

See Also

mu19ksubccdf

Examples

= 1:(534*534)

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

mu19ksubcdim

mu19ksubccdf

mu19ksubccdf

Description

environment describing the CDF file

mu19ksubcdim

mu19ksubcdim

Description

environment describing the CDF dimensions

Index

∗ datasets

i2xy, 1
mu19ksubccdf, 2
mu19ksubcdim, 2

i2xy, 1

mu19ksubccdf, 1, 2
mu19ksubcdim, 2

xy2i (i2xy), 1

3

