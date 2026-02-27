ragene10stv1cdf

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

numeric. x-coordinate (from 1 to 1050)

numeric. y-coordinate (from 1 to 1050)

numeric. single-number index (from 1 to 1102500)

Type i2xy and xy2i at the R prompt to view the function definitions.

See Also

ragene10stv1cdf

Examples

= 1:(1050*1050)

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

ragene10stv1dim

ragene10stv1cdf

ragene10stv1cdf

Description

environment describing the CDF file

ragene10stv1dim

ragene10stv1dim

Description

environment describing the CDF dimensions

Index

∗ datasets

i2xy, 1
ragene10stv1cdf, 2
ragene10stv1dim, 2

i2xy, 1

ragene10stv1cdf, 1, 2
ragene10stv1dim, 2

xy2i (i2xy), 1

3

