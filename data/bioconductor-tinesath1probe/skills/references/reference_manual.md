Package ‘tinesath1probe’

Title Probe sequence data for microarrays of type tinesath1

February 17, 2026

Version 1.48.0

Created Mon Aug 7 17:00:54 2006

Author The Bioconductor Project www.bioconductor.org

Description This package was automatically created by package matchprobes ver-

sion 1.4.0. The probe sequence data was obtained from http://www.affymetrix.com.

Maintainer Tine Casneuf <tine@ebi.ac.uk>

Depends R (>= 1.6), AnnotationDbi (>= 1.11.9)

License LGPL

biocViews Arabidopsis_thaliana_Data, SequencingData, MicroarrayData

git_url https://git.bioconductor.org/packages/tinesath1probe

git_branch RELEASE_3_22

git_last_commit ec33445

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-17

Contents

tinesath1probe .

.

.

.

.

.

.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

1

3

Index

tinesath1probe

Probe sequence for microarrays of type tinesath1.

Description

This data object was automatically created by the package matchprobes version 1.4.0.

Usage

data(tinesath1probe)

1

2

Format

tinesath1probe

A data frame with 221802 rows and 6 columns, as follows.

sequence
x
y
Probe.Set.Name
Probe.Interrogation.Position
Target.Strandedness

probe sequence
x-coordinate on the array
y-coordinate on the array

character
integer
integer
character Affymetrix Probe Set Name
Probe Interrogation Position
integer
Target Strandedness
factor

Source

The probe sequence data was obtained from http://www.affymetrix.com.

Examples

data(tinesath1probe)
tinesath1probe
as.data.frame(tinesath1probe[1:3,])

Index

∗ datasets

tinesath1probe, 1

tinesath1probe, 1

3

