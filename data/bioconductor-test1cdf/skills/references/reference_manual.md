test1cdf

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

numeric. x-coordinate (from 1 to 256)

numeric. y-coordinate (from 1 to 256)

numeric. single-number index (from 1 to 65536)

Type i2xy and xy2i at the R prompt to view the function definitions.

See Also

test1cdf

Examples

= 1:(256*256)

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

test1dim

test1cdf

test1cdf

Description

environment describing the CDF file

test1dim

test1dim

Description

environment describing the CDF dimensions

Index

∗ datasets

i2xy, 1
test1cdf, 2
test1dim, 2

i2xy, 1

test1cdf, 1, 2
test1dim, 2

xy2i (i2xy), 1

3

