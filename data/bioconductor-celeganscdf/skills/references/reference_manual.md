celeganscdf

February 11, 2026

celeganscdf

celeganscdf

Description

environment describing the CDF file

celegansdim

celegansdim

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

numeric. x-coordinate (from 1 to 712)

numeric. y-coordinate (from 1 to 712)

numeric. single-number index (from 1 to 506944)

1

2

Details

Type i2xy and xy2i at the R prompt to view the function definitions.

i2xy

See Also

celeganscdf

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

Index

∗ datasets

celeganscdf, 1
celegansdim, 1
i2xy, 1

celeganscdf, 1, 2
celegansdim, 1

i2xy, 1

xy2i (i2xy), 1

3

