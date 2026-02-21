Package ‘JASPAR2014’

February 12, 2026

Version 1.46.0

Date 2014-03-10

Title Data package for JASPAR

Description

Data package for JASPAR 2014. To search this databases, please use the package TFBSTools.

Author Ge Tan <ge_tan@live.com>

Maintainer Ge Tan <ge_tan@live.com>

Depends R (>= 3.0.1), methods, Biostrings (>= 2.29.19)

License GPL-2

URL http://jaspar.genereg.net/

Type Package

biocViews ExperimentData, SequencingData

NeedsCompilation no

LazyData yes

git_url https://git.bioconductor.org/packages/JASPAR2014

git_branch RELEASE_3_22

git_last_commit a36b7fd

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

JASPAR2014-package .
.
JASPAR2014-class .
JASPAR2014SitesSeqs .

.

.
.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2
2
3

4

Index

1

2

JASPAR2014-class

JASPAR2014-package

Data package for JASPAR 2014

Description

Data package for JASPAR 2014. To search this databases, please use th e package TFBSTools.

Details

Package:
Version:
Date:
Depends:
License:
URL:
Type:
NeedsCompilation:
LazyData:

JASPAR2014
0.99.2
2013-10-07
R (>= 3.0.1), methods, Biostrings (>= 2.29.19)
GPL-2
http://jaspardev.genereg.net/
Package
no
yes

Author(s)

Ge Tan <ge.tan09@imperial.ac.uk>

Maintainer: Ge Tan <ge.tan09@imperial.ac.uk>

References

See http://jaspardev.genereg.net/ for more details about JASPAR.

Examples

## load the library
library(JASPAR2014)
## list the contents that are loaded into memory
ls("package:JASPAR2014")

JASPAR2014-class

JASPAR2014 object

Description

The JASPAR2014 object class is a thin class for storing the path of JASPAR2014 style SQLite file.

Slots

db: Object of class "character": a character string of the path of SQLite file.

JASPAR2014SitesSeqs

3

Author(s)

Ge Tan

See Also

JASPAR2014SitesSeqs,

Examples

## Not run:

library(JASPAR2014)
JASPAR2014

## End(Not run)

JASPAR2014SitesSeqs

Sites sequences

Description

A list of DNAStringSet storing transcription factor binding sites sequences from JASPAR 2014
release with JASPAR IDs as names

Source

http://jaspar.binf.ku.dk/html/DOWNLOAD/sites/

Examples

## Not run:

library(JASPAR2014)
JASPAR2014SitesSeqs

## End(Not run)

Index

∗ classes

JASPAR2014-class, 2

∗ datasets

JASPAR2014SitesSeqs, 3

∗ package

JASPAR2014-package, 2

JASPAR2014 (JASPAR2014-class), 2
JASPAR2014-class, 2
JASPAR2014-package, 2
JASPAR2014SitesSeqs, 3, 3

4

