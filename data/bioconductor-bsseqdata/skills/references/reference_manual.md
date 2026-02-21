Package ‘bsseqData’

February 12, 2026

Version 0.48.0

Title Example whole genome bisulfite data for the bsseq package

Description Example whole genome bisulfite data for the bsseq package

Author Kasper Daniel Hansen

Maintainer Kasper Daniel Hansen <khansen@jhsph.edu>

Depends R (>= 2.15), bsseq (>= 1.16.0)

License Artistic-2.0

LazyData yes

biocViews Genome, CancerData, ColonCancerData, SequencingData

git_url https://git.bioconductor.org/packages/bsseqData

git_branch RELEASE_3_22

git_last_commit 9ebed48

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

.
BS.cancer.ex .
BS.cancer.ex.fit
.
BS.cancer.ex.tstat
.
keepLoci.ex .

.

.
.
.
.

.
.
.
.

.
.
.
.

.
.
.
.

.
.
.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

1
2
3
4

5

Index

BS.cancer.ex

WGBS for colon cancer, chr 21 and 22

Description

Whole-genome bisulfite sequencing data (WGBS) for colon cancer on chromosome 21 and 22. 3
patients were sequenced and the data contains matched colon cancer and normal colon.

1

BS.cancer.ex.fit

2

Usage

data(BS.cancer.ex)

Format

The data is stored as an object of class "BSseq".

Details

The file ‘scripts/create_BS.cancer.R’ (see example for location) is a script that generates all
data objects in this package from the raw alignment output, contained in the directory ‘umtab’ (see
example for location). The raw alignment output is the output from the BSmooth alignment suite,
using an old (legacy) format.

This dataset BS.cancer.ex.fit is the same basic data, but it also contains smoothed methylation
values.

References

Hansen, K. D. et al. (2011) Increased methylation variation in epigenetic domains across cancer
types. Nature Genetics 43, 768-775.

See Also

BS.cancer.ex.fit, BS.cancer.ex.tstat (t-statistics for this dataset) and keepLoci.ex for re-
lated datasets and the "BSseq" class. Also see the vignette(s) in the bsseq package.

Examples

data(BS.cancer.ex)
BS.cancer.ex

script <- system.file("scripts", "create_BS.cancer.R",

package = "bsseqData")

script
readLines(script)
system.file("umtab", package = "bsseqData")

BS.cancer.ex.fit

WGBS for colon cancer, chr 21 and 22, including smoothed methyla-
tion values

Description

Whole-genome bisulfite sequencing data (WGBS) for colon cancer on chromosome 21 and 22. 3
patients were sequenced and the data contains matched colon cancer and normal colon. This dataset
includes smoothed methylation values.

Usage

data(BS.cancer.ex.fit)

BS.cancer.ex.tstat

Format

The data is stored as an object of class "BSseq".

Details

3

The file ‘scripts/create_BS.cancer.R’ (see example for location) is a script that generates all
data objects in this package from the raw alignment output, contained in the directory ‘umtab’ (see
example for location). The raw alignment output is the output from the BSmooth alignment suite,
using an old (legacy) format.

This dataset is exactly like BS.cancer.ex except it also contains smoothed methylation values.

References

Hansen, K. D. et al. (2011) Increased methylation variation in epigenetic domains across cancer
types. Nature Genetics 43, 768-775.

See Also

BS.cancer.ex, BS.cancer.ex.tstat (t-statistics for this dataset) and keepLoci.ex for related
datasets as well as the "BSseq" class and the BSmooth function. Also see the vignette(s) in the
bsseq package.

Examples

data(BS.cancer.ex.fit)
BS.cancer.ex.fit

script <- system.file("scripts", "create_BS.cancer.R",

package = "bsseqData")

script
readLines(script)
system.file("umtab", package = "bsseqData")

BS.cancer.ex.tstat

T-statistics for WGBS data for colon cancer, chr 21 and 22

Description

T-statistics produced by the BSmooth.tstat function, run on the BS.cancer.ex.fit object sub-
setted by keepLoci.ex.

Usage

data(BS.cancer.ex.tstat)

Format

The data is stored as an object of class "BSseqTstat".

Details

See below for the script creating this object.

4

References

keepLoci.ex

Hansen, K. D. et al. (2011) Increased methylation variation in epigenetic domains across cancer
types. Nature Genetics 43, 768-775.

See Also

BS.cancer.ex.fit (data used to produce the t-statistics) and keepLoci.ex (used for subsetting) as
well as the "BSseqTstat" class and BSmooth.tstat. Also see the vignette(s) in the bsseq package.

Examples

data(BS.cancer.ex.tstat)
BS.cancer.ex.tstat
## This script shows how the object was created
script <- system.file("scripts", "create_BS.cancer.R",

package = "bsseqData")

script
readLines(script)

keepLoci.ex

Which methylation loci were included in an analysis of BS.cancer.ex.

Description

This object describes which methylation loci were kept, when t-statistics were generated from
BS.cancer.fit.ex using the function BSmooth.tstat.

Usage

data(keepLoci.ex)

Format

A vector of indices into BS.cancer.fit.ex.

Details

See below how this object was created and used.

See Also

BS.cancer.ex.fit (this is the data the subsetting index works on) and BS.cancer.ex.tstat and
the BSmooth.tstat function . Also see the vignette(s) in the bsseq package.

Examples

data(keepLoci.ex)
## This script shows how the object was created
script <- system.file("scripts", "create_BS.cancer.R",

package = "bsseqData")

script
readLines(script)

Index

∗ datasets

BS.cancer.ex, 1
BS.cancer.ex.fit, 2
BS.cancer.ex.tstat, 3
keepLoci.ex, 4

BS.cancer.ex, 1, 3
BS.cancer.ex.fit, 2, 2, 4
BS.cancer.ex.tstat, 2, 3, 3, 4
BSmooth, 3
BSmooth.tstat, 4
BSseq, 2, 3
BSseqTstat, 4

keepLoci.ex, 2–4, 4

5

