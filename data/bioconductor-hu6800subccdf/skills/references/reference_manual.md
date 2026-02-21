hu6800subccdf

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

numeric. x-coordinate (from 1 to 276)

numeric. y-coordinate (from 1 to 276)

numeric. single-number index (from 1 to 76176)

Type i2xy and xy2i at the R prompt to view the function definitions.

See Also

hu6800subccdf

Examples

= 1:(276*276)

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

hu6800subcdim

hu6800subccdf

hu6800subccdf

Description

environment describing the CDF file

hu6800subcdim

hu6800subcdim

Description

environment describing the CDF dimensions

Index

∗ datasets

hu6800subccdf, 2
hu6800subcdim, 2
i2xy, 1

hu6800subccdf, 1, 2
hu6800subcdim, 2

i2xy, 1

xy2i (i2xy), 1

3

