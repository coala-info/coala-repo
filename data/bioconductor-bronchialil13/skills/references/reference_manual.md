Package ‘bronchialIL13’

February 12, 2026

Version 1.48.0

Title time course experiment involving il13

Author Vince Carey <stvjc@channing.harvard.edu>

Depends R(>= 2.10.0), affy (>= 1.23.4)

Maintainer Vince Carey <stvjc@channing.harvard.edu>

Description derived from CNMC (pepr.cnmcresearch.org)

http://pepr.cnmcresearch.org/browse.do?action=list_prj_exp&projectId=95
Human Bronchial Cell line A549

License GPL-2

biocViews ExperimentData, MicroarrayData

URL http://www.biostat.harvard.edu/~carey

git_url https://git.bioconductor.org/packages/bronchialIL13

git_branch RELEASE_3_22

git_last_commit 818c46b

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

HAHrma

.

.

.

.

.

.

.

.

.

. .

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

Index

HAHrma

Description

data on Affymetrix U133a chips regarding time course response of
human bronchial cell line A549 to IL13

1

3

data on Affymetrix U133a chips regarding time course response of human bronchial cell line A549
to IL13

1

2

Usage

data(HAHrma)
data(HAH)

Format

HAHrma

The format is a Biobase exprSet structure. phenoData variables are id, trt and time (hours). HAH
is derived from a ReadAffy of 15 CEL files, and HAHrma is derived from rma(HAH), with manual
construction of the phenoData based on the filenames. The CEL files are in inst/cel/dataoq.zip.

Source

http://pepr.cnmcresearch.org/browse.do?action=list_prj_exp&projectId=95

Examples

data(HAHrma)
table(HAHrma$time, HAHrma$trt)

Index

∗ data

HAHrma, 1

HAH (HAHrma), 1
HAHrma, 1

3

