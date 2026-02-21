Package ‘plier’

February 13, 2026

Title Implements the Affymetrix PLIER algorithm

Version 1.80.0

Author Affymetrix Inc., Crispin J Miller, PICR

Description The PLIER (Probe Logarithmic Error Intensity Estimate)

method produces an improved signal by accounting for
experimentally observed patterns in probe behavior and
handling error at the appropriately at low and high signal
values.

Maintainer Crispin Miller <cmiller@picr.man.ac.uk>

Depends R (>= 2.0), methods

Imports affy, Biobase, methods

License GPL (>= 2)

biocViews Software

git_url https://git.bioconductor.org/packages/plier

git_branch RELEASE_3_22

git_last_commit 14a702b

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

justPlier .

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

1

4

Index

justPlier

Implements the PLIER algorithm

Description

Provides a wrapper around Affymetrix’s API to provide an implementation of the PLIER alogrimth

1

2

Usage

justPlier

justPlier(eset=ReadAffy(),replicate=1:length(eset),get.affinities=FALSE,normalize=FALSE,norm.type="together",augmentation=0.1,defaultaffinity=1.0,defaultconcentration=1.0,attenuation=0.005,seaconvergence=0.000001,seaiteration=3000,gmcutoff=0.15,probepenalty=0.001,concpenalty=0.000001,usemm=TRUE,usemodel=FALSE,fitaffinity=TRUE,plierconvergence=0.000001,plieriteration=3000,dropmax=3.0,lambdalimit=0.01,optimization=0)

Arguments

eset

An AffyBatch object containing the raw data

replicate

A factor containing the replicate structure to use for grouping samples

get.affinities If TRUE, then return affinities in the description@preprocessing slot of the Ex-

pressionSet object

normalize

If TRUE then apply quantile normalization to the probes before generating ex-
pression calls

norm.type

Can be ’separate’, ’pmonly’, ’mmonly’ or ’together’

augmentation Model parameter
defaultaffinity

Model parameter

defaultconcentration

Model parameter

attenuation

Model parameter

seaconvergence Model parameter

seaiteration Model parameter

gmcutoff

Model parameter

probepenalty Model parameter

concpenalty

Model parameter

usemm

usemodel

Model parameter

Model parameter

fitaffinity
plierconvergence

Model parameter

Model parameter

plieriteration Model parameter

dropmax

Model parameter

lambdalimit

Model parameter

optimization Model parameter

Details

This function is a thin wrapper around the Affymetrix implementation. For more details, including
information about the meaning of the different model parameters, please see the plier documentation
at www.affymetrix.com.

Value

An Expression set containing PLIER generated expression calls

Author(s)

Crispin J Miller (wrapper), Earl Hubbell (algorithm)

justPlier

References

bioinf.picr.man.ac.uk www.affymetrix.com

See Also

normalize.AffyBatch.quantiles

3

Index

∗ misc

justPlier, 1

justPlier, 1

4

