Package ‘SpikeIn’

February 17, 2026

Title Affymetrix Spike-In Experiment Data

Version 1.52.0

Author Rafael Irizarry <rafa@ds.dfci.harvard.edu>

Description Contains the HGU133 and HGU95 spikein experiment data.

Maintainer Robert D Shear <rshear@ds.dfci.harvard.edu>

URL https://bioconductor.org/packages/SpikeIn

BugReports https://github.com/rafalab/SpikeIn/issues

License Artistic-2.0

Depends R (>= 2.10), affy (>= 1.23.4)

biocViews ExperimentData, MicroarrayData

git_url https://git.bioconductor.org/packages/SpikeIn

git_branch RELEASE_3_22

git_last_commit 9367cd3

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-17

Contents

SpikeIn .

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

1

3

Index

SpikeIn

Affymetrix SpikeIn Experiment Data

Description

Probe-level data for data from the HGU95 and HGU133 SpikeIn experiments.

Usage

data(SpikeIn95)
data(SpikeIn133)

1

2

Format

SpikeIn

Both SpikeIn95 and SpikeIn133 are instances of the AffyBatch containing the $PM$ and $MM$
intensities for a genes spiked in at different concentrations. The spike-in concentrations used are
provided as ppart of the phenotypic data (e.g. pData).

Source

For more information see Irizarry, R.A., et al. NAR (2003) http://www.biostat.jhsph.edu/
~ririzarr/papers/index.html

Index

∗ datasets

SpikeIn, 1

AffyBatch, 2

SpikeIn, 1
SpikeIn133 (SpikeIn), 1
SpikeIn95 (SpikeIn), 1

3

