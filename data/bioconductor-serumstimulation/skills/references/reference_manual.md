Package ‘serumStimulation’

February 17, 2026

Version 1.46.0

Date 2011-08-09

Title serumStimulation is a data package which is used by examples in

package pcaGoPromoter

Author Morten Hansen <mhansen@sund.ku.dk>

Maintainer Morten Hansen, <mhansen@sund.ku.dk>

Description Contains 13 micro array data results from a serum stimulation experiment

biocViews ExperimentData, MicroarrayData

LazyLoad yes

License GPL (>= 2)

Depends R (>= 2.10)

git_url https://git.bioconductor.org/packages/serumStimulation

git_branch RELEASE_3_22

git_last_commit cdc3700

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-17

Contents

serumStimulation .

.

.

.

.

.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

1

3

Index

serumStimulation

Data set from serum stimulation DNA micro array

Description

The serumStimulation data set is from an DNA micro array analysis of 13 samples from a serum
stimulation experiment. There is 5 controls, 5 serum stimulated with inhibitor and 3 serum stimu-
lation without inhibitor.

The original .CEL files have been read with ReadAffy and normalized with rma.

The data is the output of exprs( rma( ReadAffy() ) )

1

2

Usage

serumStimulation

Format

See exprs for description of output.

serumStimulation

Index

∗ datasets

serumStimulation, 1

serumStimulation, 1

3

