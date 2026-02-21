Package ‘facsDorit’

April 11, 2019

Version 1.24.0

Date 2006-06-08

Title DKFZ FACS example data

Author Florian Hahne <f.hahne@dfkz-heidelberg.de>

Depends R (>= 1.9.1), prada (>= 1.0.5)

Maintainer Florian Hahne <f.hahne@dfkz-heidelberg.de>

Description FACS example data for cell-

based assays. This data is used in the examples and vignettes of the package prada.

License GPL-2

URL http://www.dkfz.de/mga

biocViews ExperimentData, MicrotitrePlateAssayData

git_url https://git.bioconductor.org/packages/facsDorit

git_branch RELEASE_3_8

git_last_commit 69a2b6d

git_last_commit_date 2018-10-30

Date/Publication 2019-04-11

R topics documented:

Apoptosis and MAP-Kinase example data . . . . . . . . . . . . . . . . . . . . . . . . .

1

3

Index

Apoptosis and MAP-Kinase example data

FACS data for cell-based apoptosis assay

Description

Set of FCS 3.0 ﬁles containing FACS data for each well of a 96 well microtitre plate

1

2

Format

Apoptosis and MAP-Kinase example data

map and apoptosis are directories, each containing 96 FCS 3.0 ﬁles derived from a FACS exper-
iment to characterize effectors of the MAP-Kinase and apoptotic pathways, respectively. The ﬁles
may be imported using function readFCS (for single ﬁles) or function readCytoSet (for all ﬁles in
the directory).

Source

Mamatha Sauermann (apoptosis), Meher Majety (MAP-Kinase), both at DKFZ Heidelberg

See Also

readFCS, readCytoSet

Examples

apo <- readFCS(system.file("extdata", "apoptosis",
"test2933T3.A01", package="facsDorit"))

apo
exprs(apo[1:3,])
description(apo)[3:6]

map <- readFCS(system.file("extdata", "map",

"060304MAPK_controls.A01", package="facsDorit"))

map
exprs(map[1:3,])
description(map)[3:6]

Index

Apoptosis and MAP-Kinase example data,

1

facsDorit (Apoptosis and MAP-Kinase

example data), 1

readCytoSet, 2
readFCS, 2

3

