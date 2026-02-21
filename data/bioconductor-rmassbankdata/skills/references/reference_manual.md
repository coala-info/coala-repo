Package ‘RMassBankData’

February 17, 2026

Type Package

Title Test dataset for RMassBank

Version 1.48.0

Author Michael Stravs, Emma Schymanski, Steffen Neumann

Maintainer Michael Stravs, Emma Schymanski <massbank@eawag.ch>

Description Example spectra, example compound list(s) and an example annotation
list for a narcotics dataset; required to test RMassBank. The package is
described in the man page for RMassBankData. Includes new XCMS test data.

biocViews ExperimentData, MassSpectrometryData

License Artistic-2.0

Suggests RMassBank

Collate 'RMassBankData.R'

git_url https://git.bioconductor.org/packages/RMassBankData

git_branch RELEASE_3_22

git_last_commit 01372ab

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-17

Contents

RMassBankData

.

.

.

.

.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

1

3

Index

RMassBankData

RMassBank test dataset

Description

This contains data suitable to test the RMassBank functionalities.

1

2

Details

The package contains the folders:

RMassBankData

• spectra LC-MS runs of 15 narcotics standards, in mzML format and deprofiled.

• listA CSV list with compound informations for the 15 narcotics, as needed by RMassBank.

• infolistsA complete CSV list with annotations for the 15 standards.

• infolists_incompleteA partial list of infolists, to demonstrate the download of missing en-

tries.

• infolists_editedThe downloaded missing entries, subsequently checked and completed by hand.

• resultsThe intermediate and final results of the msms_workflow runs. This serves to build the
vignette, since it would take too long to run the whole workflow during the vignette build.

Author(s)

Michael Stravs, Eawag <michael.stravs@eawag.ch

Index

∗ datasets

RMassBankData, 1

∗ data

RMassBankData, 1

RMassBankData, 1

3

