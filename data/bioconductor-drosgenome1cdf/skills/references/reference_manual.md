drosgenome1cdf

February 11, 2026

drosgenome1cdf

drosgenome1cdf

Description

environment describing the CDF file

drosgenome1dim

drosgenome1dim

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

numeric. x-coordinate (from 1 to 640)

numeric. y-coordinate (from 1 to 640)

numeric. single-number index (from 1 to 409600)

1

2

Details

Type i2xy and xy2i at the R prompt to view the function definitions.

i2xy

See Also

drosgenome1cdf

Examples

= 1:(640*640)

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

drosgenome1cdf, 1
drosgenome1dim, 1
i2xy, 1

drosgenome1cdf, 1, 2
drosgenome1dim, 1

i2xy, 1

xy2i (i2xy), 1

3

