The pepDat User Guide

Renan Sauteraud∗

November 4, 2025

Contents

1 Introduction

2 Peptide collections

Information . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.1
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2 Structure
2.3 pep hxb2 . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.4 pep hxb2JPT . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.5 pep mac239 . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.6 pep m239smE543 . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3 Loading the collections

4 Create collections

1

Introduction

1

1
1
2
2
2
2
2

2

3

pepDat is an R package that stores sample files, data for vignettes and peptide collections. It is intended
to be used in conjunction with other packages for peptide analysis and visualisation: pepStat anf Pviz.

As with any R package, it should first be loaded in the session

library(pepDat)

2 Peptide collections

2.1

Information

For each peptide, the following collections display information about the position relative to the reference
sequence, the alignment, the trimmed alignment, the zSums for the physicochemical properties as well as
the clades where they can be found.

∗rsautera@fhcrc.org

1

2.2 Structure

The datasets in this package are GRanges objects. For more information about the class, its accessors
and setters, please refer to GenomicRanges documentation.

2.3 pep hxb2

This collection is based on the alignment of the reference HIV sequence hxb2 and seven subtypes (clades)
A, B, C, D, M, CRF01 and CRF02.

2.4 pep hxb2JPT

This collection adds a few more clades to the previous one: CM244, CON 01 AE, LAI A04321 and
MN DD328842.

2.5 pep mac239

This collection is for SIV, with the clades mac239 and E660.

2.6 pep m239smE543

This collection is for SIV, with the clades mac239 and E543.

3 Loading the collections

The peptide collections can be loaded like any other R dataset.

data(pep_hxb2)
head(pep_hxb2)

seqnames

names
<character>
* | MRVKETQMNWPNLWK
* | MRVMGIQKNYPLLWR
* | MRVMGIQRNCQHLWR
* | MRVKGIRKNYQHLWR
* | MRVRGILRNWQQWWI
* | MRVRGIERNYQHLWR

MRVKETQMNWPNLWK
MRVMGIQKNYPLLWR
MRVMGIQRNCQHLWR
MRVKGIRKNYQHLWR
MRVRGILRNWQQWWI
MRVRGIERNYQHLWR

ranges strand |
<Rle> <IRanges> <Rle> |
gp160
gp160
gp160
gp160
gp160
gp160

## GRanges object with 6 ranges and 10 metadata columns:
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##
##

MRVKETQMNWPNLWK MRVKETQMNWPNL----WK MRVKenWPNL----WK
MRVMGIQKNYPLLWR MRVMGIQKNYPLL----WR MRVMgnYPLL----WR
MRVMGIQRNCQHLWR MRVMGIQRNCQHL----WR MRVMgnCQHL----WR
MRVKGIRKNYQHLWR MRVKGIRKNYQHL----WR MRVKgnYQHL----WR
MRVRGILRNWQQWWI MRVRGILRNWQQW----WI MRVRgnWQQW----WI
MRVRGIERNYQHLWR MRVRGIERNYQHL----WR MRVRgnYQHL----WR

1-16
1-16
1-16
1-16
1-16
1-16
aligned
<factor>

trimmed

clade
seqNb
<factor> <integer> <character>
CRF01
CRF02
A
B
C
D

1
1
1
1
1
1

2

##
##
##
##
##
##
##
##
##
##

z4

z3

z1

z2

z5
<numeric> <numeric> <numeric> <numeric> <numeric>
1.36
0.76
-2.99
-0.87
-2.37
-1.91

MRVKETQMNWPNLWK
MRVMGIQKNYPLLWR
MRVMGIQRNCQHLWR
MRVKGIRKNYQHLWR
MRVRGILRNWQQWWI
MRVRGIERNYQHLWR
-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

-3.14
-13.12
1.65
3.95
-11.42
6.00

-8.14
-11.96
-11.22
-18.51
-16.19
-17.14

6.72
7.09
10.31
12.55
10.33
8.52

9.87
3.19
4.17
9.78
10.26
10.76

4 Create collections

While the package comes with datasets for HIV and SIV. It is possible to create new collections for
different organisms or proteins using the create db function in pepStat. Please refer to pepStat’s user
guide and ?create db for more information.

3

