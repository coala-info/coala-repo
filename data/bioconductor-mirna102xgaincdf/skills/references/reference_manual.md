mirna102xgaincdf

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

numeric. x-coordinate (from 1 to 230)

numeric. y-coordinate (from 1 to 230)

numeric. single-number index (from 1 to 52900)

Type i2xy and xy2i at the R prompt to view the function definitions.

See Also

mirna102xgaincdf

Examples

= 1:(230*230)

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

mirna102xgaindim

mirna102xgaincdf

mirna102xgaincdf

Description

environment describing the CDF file

mirna102xgaindim

mirna102xgaindim

Description

environment describing the CDF dimensions

Index

∗ datasets

i2xy, 1
mirna102xgaincdf, 2
mirna102xgaindim, 2

i2xy, 1

mirna102xgaincdf, 1, 2
mirna102xgaindim, 2

xy2i (i2xy), 1

3

