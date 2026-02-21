Package ‘h5vcData’

February 12, 2026

Type Package

Title Example data for the h5vc package

Version 2.30.0

Date 2013-10-16

Author Paul Theodor Pyl

Maintainer Paul Theodor Pyl <pyl@embl.de>

Description This package contains the data used in the vignettes and examples of the 'h5vc' package

License GPL (>= 3)

Suggests h5vc

biocViews CancerData

git_url https://git.bioconductor.org/packages/h5vcData

git_branch RELEASE_3_22

git_last_commit 1ba3cbe

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

h5vcData-package .

.

.

.

.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

1

3

Index

h5vcData-package

Example data for the h5vc package

Description

This package contains the example data needed for the vignettes and examples of the h5vc package.

1

2

Details

h5vcData-package

h5vcData
Package:
Package
Type:
1.0.0
Version:
Date:
2013-10-16
License: GPL (>= 3)

This package contains the following files in inst/extdata:

example.tally.hfs5: The example HDF5 tally file

NRAS.AML.bam: BAM file containig reads spanning the NRAS locus from an AML sample

NRAS.AML.bam.bai: BAM file index for NRAS.AML.bam

NRAS.Control.bam: BAM file containig reads spanning the NRAS locus from the matched control
sample

NRAS.Control.bam.bai: BAM file index for NRAS.Control.bam

Pt*bam: BAM file containing reads spannign DNMT3A locus of cancer or control samples from
a total of 6 pairs Pt*bam.bam: Corresponding index files for the set of bam files overlapping the
DNMT3A locus

This package contains the following data objects in data:

variantCalls is the data.frame containing a set of example variant calls on the example tally file

Author(s)

Paul Theodor Pyl Maintainer: Paul Theodor Pyl <pyl@embl.de>

See Also

h5vc

Examples

tallyFile <- system.file("extdata", "example.tally.hfs5", package = "h5vcData")
caseBamFile <- system.file("extdata", "NRAS.AML.bam", package = "h5vcData")
controlBamFile <- system.file("extdata", "NRAS.Control.bam", package = "h5vcData")
data( "example.variants", package = "h5vcData" )
head(variantCalls)

Index

∗ package

h5vcData-package, 1

h5vc, 2
h5vcData (h5vcData-package), 1
h5vcData-package, 1

variantCalls (h5vcData-package), 1

3

