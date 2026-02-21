hcg110cdf

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

numeric. x-coordinate (from 1 to 336)

numeric. y-coordinate (from 1 to 336)

numeric. single-number index (from 1 to 112896)

Type i2xy and xy2i at the R prompt to view the function definitions.

See Also

hcg110cdf

Examples

= 1:(336*336)

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

hcg110dim

hcg110cdf

hcg110cdf

Description

environment describing the CDF file

hcg110dim

hcg110dim

Description

environment describing the CDF dimensions

Index

∗ datasets

hcg110cdf, 2
hcg110dim, 2
i2xy, 1

hcg110cdf, 1, 2
hcg110dim, 2

i2xy, 1

xy2i (i2xy), 1

3

