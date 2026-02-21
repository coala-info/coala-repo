Package ‘plasFIA’

April 11, 2019

Version 1.10.0

Date 2017-07-01

Title FIA-HRMS plasma dataset

Author Alexis Delabriere, Etienne Thevenot, Ulli Hohenester and

Christophe Junot.

Maintainer Alexis Delabriere <alexis.delabriere@cea.fr>

Depends proFIA

ZipData no

Description Positive Ionization FIA-HRMS data of human plasma spiked

with a pool of 40 compounds acquired in FIA-HRMS mode on an
orbitrap fusion. plasFIA also include the result of the
processing by the proFIA package with adapted parameters for an
Orbitrap Fusion.

biocViews ExperimentData, MassSpectrometryData

License LGPL

NeedsCompilation no

RoxygenNote 6.0.1

git_url https://git.bioconductor.org/packages/plasFIA

git_branch RELEASE_3_8

git_last_commit bedc6c2

git_last_commit_date 2018-10-30

Date/Publication 2019-04-11

R topics documented:

plasFIA-package .
.
plasMols .
.
.
plasSamples .
.
.
plasSet .

.
.
.

.
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

.
.
.
.

.
.
.
.

.
.
.
.

.
.
.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2
2
2
3

4

1

2

plasSamples

plasFIA-package

FIA-HRMS spiked plasma dataset.

Description

6 samples of human plasma spiked with 3 different concentrations of molecules ranging from 10
ng/mL to 1000ng/mL in 2 replicates have been acquired on an Orbitrap Fusion. The resulting
data are in the mzML directory under mzML centroid format, the proFIAset object containg the
integrated signal is in the plasSet object information on the samples is in plasSamples and infor-
mations about molecules is in plasMols.

plasMols

Information on the 40 molecules from the plasFIA package.

Description

A dataset giving the formula, the name, the class, the mass and the mass of the single-charged
molecule of the plasFIA dataset.

• formula. The formula of the molecule

• names. The usual names of the molecules

• classes. The chemical family of the molecules.

• mass. The mass of the molecules.

• mass_M+H. The mass of the signly charge ion. ...

Usage

data(plasMols)

Format

A data frame with 40 rows and 5 variables

plasSamples

Information on the 6 samples form the plasFIA package.

Description

A dataset giving name the replicate and the concentration in molecules in plasMols molecules of
the ﬁles in the plasFIA.

• ﬁlename. The name of the ﬁle.

• concentration_ng_ml. The concentration in spiked molecule in ng/ML.

• replicate. A factor giving the molecules coming from the same sample. ...

plasSet

Usage

data(plasSamples)

Format

A data frame with 6 rows and 3 variables

3

plasSet

Signal detected by the proFIA package in the plasFIA dataset.

Description

A proFIAset object giving the signals detected in the mzML ﬁles of the plasFIA datasets using the
analyzeAcquisitionFIA function with the following parameters :

• ppm. 2

• fracGroup. 0.2

• ppmgroup. 0.5

Usage

data(plasSet)

Format

A "proFIAset" object containing 1 classes. Data matrix has been created. 3529 peaks detected. 834
features have been grouped. The data matrix is avalaible. Memory usage: 0.61 MB

Details

Which were adapted to an Orbitrap Fusion.

Index

∗Topic datasets
plasMols, 2
plasSamples, 2

∗Topic dataset
plasSet, 3

plasFIA (plasFIA-package), 2
plasFIA-package, 2
plasMols, 2
plasSamples, 2
plasSet, 3

4

