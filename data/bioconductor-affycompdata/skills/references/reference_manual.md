Package ‘affycompData’

February 12, 2026

Version 1.48.0

Title affycomp data

Author Rafael A. Irizarry <rafa@ds.dfci.harvard.edu> and Zhijin Wu

<zwu@stat.brown.edu> with contributions from Simon Cawley

<simon_cawley@affymetrix.com>

Maintainer Robert D Shear <rshear@ds.dfci.harvard.edu>

URL https://bioconductor.org/packages/affycompData

BugReports https://github.com/rafalab/affyCompData/issues

Depends R (>= 2.13.0), methods, Biobase (>= 2.3.3), affycomp

Description Data needed by the affycomp package.

License GPL (>= 2)

biocViews MicroarrayData

git_url https://git.bioconductor.org/packages/affycompData

git_branch RELEASE_3_22

git_last_commit 45dff8f

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

.
lw.sd.assessment
.
mas5.assessment
rma.assessment
.
rma.sd.assessment .

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
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .

2
2
3
3

4

Index

1

2

mas5.assessment

lw.sd.assessment

An example of the result of an SD assessment

Description

The Dilution files were processed with the dChip package (using PM-only), and then the function
assessSD from the affycomp package was applied.

Usage

data(lw.sd.assessment)

Format

A list.

mas5.assessment

Examples of the result of assessments

Description

The Dilution and both (HGU95 and HGU133) types of Spike-in data were processed with Affymetrix
MAS 5.0 software, yielding three "MAS 5.0" ExpressionSet’s. (These are available, in csv-format,
at http://affycomp.jhsph.edu/AFFY2/rafa@jhu.edu/030424.1033/.) Then various assess-
ment functions from the affycomp package (most recently, version 1.28.0) were applied. mas5.assessment
resulted from assessAll on Dilution and HGU95; mas5.assessment.133 from assessSpikeIn
on HGU133; mas5.assessment2 from assessSpikeIn2 on HGU95; and mas5.assessment2.133
from assessSpikeIn2 on HGU133.

Usage

data(mas5.assessment)
data(mas5.assessment.133)
data(mas5.assessment2)
data(mas5.assessment2.133)

Format

A list of list.

rma.assessment

3

rma.assessment

Examples of the result of assessments

Description

The Dilution and both (HGU95 and HGU133) types of Spike-in data were processed with the
(version 1.0) function rma, yielding three "RMA" ExpressionSet’s. (These are available, in csv-
format, at http://affycomp.jhsph.edu/AFFY2/rafa@jhu.edu/030429.1332/.) Then various
assessment functions from the affycomp package (most recently, version 1.28.0) were applied.
rma.assessment resulted from assessAll on Dilution and HGU95; rma.assessment.133 from
assessSpikeIn on HGU133; rma.assessment2 from assessSpikeIn2 on HGU95; and rma.assessment2.133
from assessSpikeIn2 on HGU133.

Usage

data(rma.assessment)
data(rma.assessment.133)
data(rma.assessment2)
data(rma.assessment2.133)

Format

A list of list.

rma.sd.assessment

An example of the result of an SD assessment

Description

The Dilution files were processed with the affy version 1.0 package rma add-on function, and then
the function assessSD from the affycomp package was applied.

Usage

data(rma.sd.assessment)

Format

A list.

Index

∗ datasets

lw.sd.assessment, 2
mas5.assessment, 2
rma.assessment, 3
rma.sd.assessment, 3

assessAll, 2, 3
assessSD, 2, 3
assessSpikeIn, 2, 3
assessSpikeIn2, 2, 3

ExpressionSet, 2, 3

lw.sd.assessment, 2

mas5.assessment, 2
mas5.assessment2 (mas5.assessment), 2

rma, 3
rma.assessment, 3
rma.assessment2 (rma.assessment), 3
rma.sd.assessment, 3

4

