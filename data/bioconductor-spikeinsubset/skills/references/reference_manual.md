Package ‘SpikeInSubset’

February 17, 2026

Title Part of Affymetrix's Spike-In Experiment Data

Version 1.50.0

Author Rafael Irizarry <rafa@ds.dfci.harvard.edu> and Zhijin Wu

Maintainer Robert D Shear <rshear@ds.dfci.harvard.edu>

URL https://bioconductor.org/packages/SpikeInSubset

BugReports https://github.com/rafalab/SpikeInSubset/issues

Description

Includes probe-level and expression data for the HGU133 and HGU95 spike-in experiments

License LGPL

Depends R (>= 2.4.0), Biobase (>= 2.5.5), affy (>= 1.23.4)

biocViews ExperimentData, MicroarrayData

git_url https://git.bioconductor.org/packages/SpikeInSubset

git_branch RELEASE_3_22

git_last_commit 33c8bf1

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-17

Contents

hgu133a.spikein.xhyb .
.
.
SpikeIn .

.

.

.

.

.

Index

.
.

.
.

. .
. .

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2
2

4

1

2

SpikeIn

hgu133a.spikein.xhyb

Cross hybridizers

Description

Probe Sets likely to crosshybridize to spiked-in probesets in the Affymetrix HGU133A spike in

This objact is list. Each component of the list contains probeset names of possible crosshybridizers.
The sequences of each spiked-in clone were collected and blasted against all HG-U133A target
sequences. Target sequences are the ~600bp regions from which probes were selected. Thresholds
of 100, 150 and 200bp were used and define the three components of the list.

Usage

data(hgu133a.spikein.xhyb)

Format

A list

Source

Simon Cawley <simon_cawley@affymetrix.com>

SpikeIn

Subset of Affymetrix SpikeIn Experiment Data

Description

Probe-level and pre-proecssed data for six arrays (two triplicates) from the HGU95 and HGU133
SpikeIn experiments.

Usage

data(spikein95)
data(rma95)
data(mas95)

data(spikein133)
data(rma133)
data(mas133)

Format

SpikeIn is ProbeSet containing the $PM$ and $MM$ intensities for a gene spiked in at different
concentrations. Use pData to see the cosntrations.

SpikeIn

Source

3

spikein95 and spikein133 are instances of ProbeSet with the probe-level data for six arrays
(two triplicates) from the HGU95 and HGU133 SpikeIn experiments respectively. rma95 and
rma133 contain the data pre-processed with RMA. mas95 and mas133 contain the data preproc-
ssed with mas5 (expression and present/absent calls). The calls are in objects called pacalls95 and
pacalls133.

For more information see Irizarry, R.A., et al. NAR (2003) http://www.biostat.jhsph.edu/
~ririzarr/papers/index.html

Index

∗ datasets

hgu133a.spikein.xhyb, 2
SpikeIn, 2

hgu133a.spikein.xhyb, 2

mas133 (SpikeIn), 2
mas95 (SpikeIn), 2

pacalls133 (SpikeIn), 2
pacalls95 (SpikeIn), 2
ProbeSet, 2, 3

rma133 (SpikeIn), 2
rma95 (SpikeIn), 2

SpikeIn, 2
spikein133 (SpikeIn), 2
spikein95 (SpikeIn), 2

4

