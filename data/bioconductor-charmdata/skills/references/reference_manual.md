Package ‘charmData’

April 11, 2019

Type Package

Title An example dataset for use with the charm package

Version 1.18.0

Date 2010-10-13

Author Martin Aryee

Maintainer Martin Aryee <aryee@jhu.edu>

Description An example dataset for use with the charm package

License LGPL (>= 2)

Depends R(>= 2.11.0), charm, pd.charm.hg18.example

biocViews ExperimentData, MicroarrayData

ZipData no

LazyLoad yes

git_url https://git.bioconductor.org/packages/charmData

git_branch RELEASE_3_8

git_last_commit 171210a

git_last_commit_date 2018-10-30

Date/Publication 2019-04-11

R topics documented:

charmData-package .

.

.

.

.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

1

3

Index

charmData-package

An example dataset for the charm package

Description

This is a small example DNA methylation microarray dataset for use with the charm package. It
contains Nimblegen xys (raw data) ﬁles for 8 samples and the corresponding sample description
ﬁle.

1

charmData-package

2

Author(s)

Martin Aryee <aryee@jhu.edu>

Examples

dataDir <- system.file("data", package="charmData")
setwd(dataDir)
dir()

Index

charmData (charmData-package), 1
charmData-package, 1

3

