moe430acdf

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

numeric. x-coordinate (from 1 to 712)

numeric. y-coordinate (from 1 to 712)

numeric. single-number index (from 1 to 506944)

Type i2xy and xy2i at the R prompt to view the function definitions.

See Also

moe430acdf

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

1

2

moe430adim

moe430acdf

moe430acdf

Description

environment describing the CDF file

moe430adim

moe430adim

Description

environment describing the CDF dimensions

Index

∗ datasets

i2xy, 1
moe430acdf, 2
moe430adim, 2

i2xy, 1

moe430acdf, 1, 2
moe430adim, 2

xy2i (i2xy), 1

3

