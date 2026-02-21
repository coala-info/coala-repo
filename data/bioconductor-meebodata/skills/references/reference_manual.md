Package ‘MEEBOdata’

February 17, 2026

Type Package

Title MEEBO set and MEEBO controls.

Version 1.48.0

Date 2006-08-31

Author Agnes Paquet

Maintainer Agnes Paquet <apaquet@medsfgh.ucsf.edu>

Description R objects describing the MEEBO set.

biocViews ExperimentData

License LGPL

URL http://alizadehlab.stanford.edu/ http://arrays.ucsf.edu/

git_url https://git.bioconductor.org/packages/MEEBOdata

git_branch RELEASE_3_22

git_last_commit 06cd6c6

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-17

Contents

MEEBO .
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

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

1
2

3

Index

MEEBO

Annotations and controls for the MEEBO set.

1

2

Description

StanfordExampleData

MEEBOset: character matrix containing annotations for all oligos in the MEEBO set, e.g. sequence
id, name, description of the oligo. The annotations used here come from the original MEEBO
dataset and are not updated.

MEEBOctrl: list of matrices describing mismatch transcripts and negative controls. For each of
the 10 unique transcripts used to design the mismatch controls, we provide some annotations for
all derived mismatch probes (like sequnce id, array identifier, description...), the type of mismatch
(anchored or Distributed), the number of mismatched bases, and the binding energy. The last object
is a list of negative controls identifiers.

MEEBOtilingres: list of 11 vectors, one for each sequence used to design the series of tiling con-
trols. Each vector contains the unique MEEBO identifiers and the distance from 3’ end for each
tiling controls recognizing this sequence.

Source

These data were derived from the MEEBO set description files provided by Ash Alizadeh. The R
code used to parse the file is available upon request. For more information about the MEEBO set,
please refer to http://alizadehlab.stanford.edu.

StanfordExampleData

Example of MEEBO GPR files and associated doping control infor-
mation.

Description

RDI108\_n.gpr is an example of hybridization on MEEBO arrays, using a doping-control mixture
from SFGF.

StanfordDCV1.7complete.txt is an example of spike-type file from SFGF.

Source

These data were provided by members of the Brown lab (Stanford) and the Stanford Shared Ge-
nomics Core Facility.

Index

∗ datasets

MEEBO, 1
StanfordExampleData, 2

MEEBO, 1
MEEBOctrl (MEEBO), 1
MEEBOset (MEEBO), 1
MEEBOtilingres (MEEBO), 1

RDI108_n.gpr (StanfordExampleData), 2

StanfordDCV1.7complete.txt

(StanfordExampleData), 2

StanfordExampleData, 2

3

