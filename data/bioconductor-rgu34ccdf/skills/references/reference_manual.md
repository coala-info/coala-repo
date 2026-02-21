rgu34ccdf

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

numeric. x-coordinate (from 1 to 534)

numeric. y-coordinate (from 1 to 534)

numeric. single-number index (from 1 to 285156)

Type i2xy and xy2i at the R prompt to view the function definitions.

See Also

rgu34ccdf

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

rgu34cdim

rgu34ccdf

rgu34ccdf

Description

environment describing the CDF file

rgu34cdim

rgu34cdim

Description

environment describing the CDF dimensions

Index

∗ datasets

i2xy, 1
rgu34ccdf, 2
rgu34cdim, 2

i2xy, 1

rgu34ccdf, 1, 2
rgu34cdim, 2

xy2i (i2xy), 1

3

