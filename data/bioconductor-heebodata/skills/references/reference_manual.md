Package ‘HEEBOdata’

February 12, 2026

Type Package

Title HEEBO set and HEEBO controls.

Version 1.48.0

Date 2006-08-31

Author Agnes Paquet

Maintainer Agnes Paquet <apaquet@medsfgh.ucsf.edu>

Description R objects describing the HEEBO oligo set.

biocViews ExperimentData

License LGPL

URL http://alizadehlab.stanford.edu/ http://arrays.ucsf.edu/

git_url https://git.bioconductor.org/packages/HEEBOdata

git_branch RELEASE_3_22

git_last_commit 3ac4685

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

HEEBO .
.
.
StanfordExampleData .

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
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

1
2

3

Index

HEEBO

Annotations and controls for the HEEBO set.

1

2

Description

StanfordExampleData

HEEBOset: character matrix containing annotations for all oligos in the HEEBO set, e.g. sequence
id, name, description of the oligo. The annotations used here come from the original HEEBO
dataset and are not updated.

HEEBOctrl: list of matrices describing mismatch transcripts and negative controls. For each of
the 10 unique transcripts used to design the mismatch controls, we provide some annotations for
all derived mismatch probes (like sequnce id, array identifier, description...), the type of mismatch
(anchored or Distributed), the number of mismatched bases, and the binding energy. The last object
is a list of negative controls identifiers.

HEEBOtilingres: list of 11 vectors, one for each sequence used to design the series of tiling controls.
Each vector contains the unique HEEBO identifiers and the distance from 3’ end for each tiling
controls recognizing this sequence.

Source

These data were derived from the HEEBO set description files provided by Ash Alizadeh. The R
code used to parse the file is available upon request. For more information about the HEEBO set,
please refer to http://alizadehlab.stanford.edu.

StanfordExampleData

Example of MEEBO GPR files and associated doping control infor-
mation.

Description

63421.gpr and hoc.gal are an example of hybridization on HEEBO arrays, using a doping-control
mixture from SFGF.

DCV2.0June06.txt is an example of spike-type file from SFGF.

Source

These data were provided by members of the Brown lab (Stanford) and the Stanford Shared Ge-
nomics Core Facility.

Index

∗ datasets

HEEBO, 1
StanfordExampleData, 2

63421.gpr (StanfordExampleData), 2

DCV2.0June06.txt (StanfordExampleData),

2

HEEBO, 1
HEEBOctrl (HEEBO), 1
HEEBOset (HEEBO), 1
HEEBOtilingres (HEEBO), 1
hoc.gal (StanfordExampleData), 2

StanfordExampleData, 2

3

