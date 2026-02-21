Package ‘JASPAR2016’

February 12, 2026

Version 1.38.0

Date 2015-11-04

Title Data package for JASPAR 2016

Description Data package for JASPAR 2016. To search this databases, please use the package

TFBSTools (>= 1.8.1).

Author Ge Tan <ge_tan@live.com>

Maintainer Ge Tan <ge_tan@live.com>

Depends R (>= 3.2.2), methods

License GPL-2

URL http://jaspar.genereg.net/

Type Package

biocViews ExperimentData, MotifAnnotation, GeneRegulation

NeedsCompilation no

LazyData no

git_url https://git.bioconductor.org/packages/JASPAR2016

git_branch RELEASE_3_22

git_last_commit ce701a6

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

JASPAR2016-class .

.

.

.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2

3

Index

1

2

JASPAR2016-class

JASPAR2016-class

JASPAR2016 object

Description

The JASPAR2016 object class is a thin class for storing the path of JASPAR2016 style SQLite file.

Slots

db: Object of class "character": a character string of the path of SQLite file.

Author(s)

Ge Tan

Examples

## Not run:

library(JASPAR2016)
JASPAR2016

library(TFBSTools)

opts <- list()
opts[["species"]] <- 9606
opts[["type"]] <- "SELEX"
opts[["all_versions"]] <- TRUE
PFMatrixList <- getMatrixSet(JASPAR2016, opts)

opts2 <- list()
opts2[["type"]] <- "SELEX"
PFMatrixList2 <- getMatrixSet(JASPAR2016, opts2)

## End(Not run)

Index

∗ classes

JASPAR2016-class, 2

JASPAR2016 (JASPAR2016-class), 2
JASPAR2016-class, 2

3

