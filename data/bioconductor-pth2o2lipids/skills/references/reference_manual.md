Package ‘PtH2O2lipids’

February 17, 2026

Title P. tricornutum HPLC-ESI-MS Lipid Data from van Creveld et al.

(2015)

Version 1.36.0

Date 2016-07-06

Depends R (>= 3.3), xcms, CAMERA, LOBSTAHS, methods, utils

Suggests gplots, RColorBrewer, cluster, vegan

Description Annotated HPLC-ESI-MS lipid data in positive ionization
mode from an experiment in which cultures of the marine diatom
Phaeodactylum tricornutum were treated with various
concentrations of hydrogen peroxide (H2O2) to induce oxidative
stress. The experiment is described in Graff van Creveld, et
al., 2015, ``Early perturbation in mitochondria redox
homeostasis in response to environmental stress predicts cell
fate in diatoms,'' ISME Journal 9:385-395. PtH2O2lipids consists
of two objects: A CAMERA xsAnnotate object
(ptH2O2lipids$xsAnnotate) and LOBSTAHS LOBSet object
(ptH2O2lipids$xsAnnotate$LOBSet). The LOBSet includes putative
compound assignments from the default LOBSTAHS database. Isomer
annotation is recorded in three other LOBSet slots.

License MIT + file LICENSE

URL http://dx.doi.org/10.1038/ismej.2014.136,

https://github.com/vanmooylipidomics/PtH2O2lipids,
http://www.whoi.edu/page.do?pid=133616&tid=282&cid=192529

BugReports https://github.com/vanmooylipidomics/PtH2O2lipids/issues/new

biocViews ReproducibleResearch, CellCulture, MassSpectrometryData,

Phaeodactylum_tricornutum_data

NeedsCompilation no

Author Shiri Graff van Creveld [aut], Shilo Rosenwasser [aut],
Daniella Schatz [aut], Ilan Koren [aut], Assaf Vardi [aut],
James Collins [cre]

Maintainer James Collins <james.r.collins@aya.yale.edu>
git_url https://git.bioconductor.org/packages/PtH2O2lipids

git_branch RELEASE_3_22

git_last_commit 0adfb19

1

2

ptH2O2lipids

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-17

Contents

ptH2O2lipids .

.

.

.

.

.

.

.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2

5

Index

ptH2O2lipids

P. tricornutum HPLC-ESI-MS Lipid Data from van Creveld et al.
(2015)

Description

Positive ionization mode HPLC-ESI-MS lipid data from an experiment in which cultures of the ma-
rine diatom Phaeodactylum tricornutum were treated with various concentrations of hydrogen per-
oxide (H2O2) to induce oxidative stress. ptH2O2lipids$LOBSet was generated from ptH2O2lipids$xsAnnotate
using the LOBSTAHS function doLOBscreen.

Usage

data(ptH2O2lipids)

Format

A list object containing the lipid data in two forms:

ptH2O2lipids$LOBSet A 1.2 MB object of formal class "LOBSet" containing screened peak data
to which compound assignments and isomer identifications have been made. The structure of
ptH2O2lipids$LOBSet is:

Formal class 'LOBSet' [package "LOBSTAHS"] with 9 slots

:'data.frame': 2056 obs. of 54 variables
:List of 2056
:List of 2056
:List of 2056

4 variables:
2 variables:

..@ peakdata
..@ iso_C3r
..@ iso_C3f
..@ iso_C3c
..@ LOBscreen_diagnostics:'data.frame': 6 obs. of
..@ LOBisoID_diagnostics :'data.frame': 3 obs. of
:List of 6
..@ LOBscreen_settings
: chr "default"
.. ..$ database
.. ..$ remove.iso
: logi TRUE
.. ..$ rt.restrict : logi TRUE
.. ..$ rt.windows
.. ..$ exclude.oddFA: logi TRUE
.. ..$ match.ppm
..@ polarity
..@ sampnames

: chr "default"

: num 2.5

: Factor w/ 1 level "positive": 1

: chr [1:16] "0uM_24h_Orbi_0468" "0uM_24h_Orbi_0473" "0uM_4h_Orbi_0476" "0uM_8h_Orbi_0472" ...

ptH2O2lipids

3

ptH2O2lipids$xsAnnotate An 80 MB object of formal class "xsAnnotate" containing 18,314
peakgroups in 5,080 pseudospectra. This is the object from which ptH2O2lipids$LOBSet was
created using doLOBscreen. It includes annotation of possible isotope peaks from findIsotopes.
The xcmsSet from which the xsAnnotate object was created (64.5 MB) can be accessed at
ptH2O2lipids$xsAnnotate@xcmsSet.

Details

ptH2O2lipids$LOBSet includes compound identifications assigned from the default LOBSTAHS
positive mode database. ptH2O2lipids$LOBSet also includes in the slots iso_C3r, iso_C3f, and
iso_C3c the various possible isomers identified for each compound. Note that all other slots in the
ptH2O2lipids object can be accessed using the accessor functions described for the "LOBSet-class"
object class.

The dataset contains peaks from 16 samples that span three H2O2 treatments (0, 30 and 150 µM)
and three timepoints (+4, +8, and +24 hours) in duplicate. The dataset contains only one replicate
sample for the 0 and 150 µM treatments at + 4h.

The mzXML files and Thermo .raw files from which these objects are derived can be accessed at
https://github.com/vanmooylipidomics/PtH2O2lipids/tree/master/mzXML and http://www.
whoi.edu/page.do?pid=133616&tid=282&cid=192529, respectively.

Users should note that the LOBSet in this package does not include any PUA (polyunsaturated
aldehyde) identifications.

Source

http://www.nature.com/ismej/journal/v9/n2/full/ismej2014136a.html

References

Collins, J.R., B.R. Edwards, H.F. Fredricks, and B.A.S. Van Mooy. 2016. LOBSTAHS: An adduct-
based lipidomics strategy for discovery and identification of oxidative stress biomarkers. Analytical
Chemistry.

Graff van Creveld, et al., 2015, “Early perturbation in mitochondria redox homeostasis in response
to environmental stress predicts cell fate in diatoms”, ISME Journal 9:385-395

See Also

LOBSet-class, LOBSet, doLOBscreen, getLOBpeaklist, xcmsSet, xsAnnotate

Examples

## generate the object in ptH2O2lipids$LOBSet using ptH2O2lipids$xsAnnotate as
## input
library(PtH2O2lipids)

## yields output identical to ptH2O2lipids$LOBSet
myPtH202LOBSet = doLOBscreen(ptH2O2lipids$xsAnnotate, polarity = "positive",
database = NULL, remove.iso = TRUE, rt.restrict = TRUE, rt.windows = NULL,
exclude.oddFA = TRUE, match.ppm = 2.5)

## access xsAnnotate object
ptH2O2lipids$xsAnnotate

4

ptH2O2lipids

## access xcmsSet
ptH2O2lipids$xsAnnotate@xcmsSet

Index

∗ datasets

ptH2O2lipids, 2

doLOBscreen, 2, 3

findIsotopes, 3

getLOBpeaklist, 3

LOBSet, 2, 3

PtH2O2lipids (ptH2O2lipids), 2
ptH2O2lipids, 2

xcmsSet, 3
xsAnnotate, 3

5

