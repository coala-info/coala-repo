Package ‘AffymetrixDataTestFiles’

Version 0.48.0

February 12, 2026

Title Affymetrix Data Files (CEL, CDF, CHP, EXP, PGF, PSI) for Testing

Author Henrik Bengtsson [aut, cre], James Bullard [aut], Kasper Daniel Hansen [aut]

Description This package contains annotation data files and sample data files of Affymetrix file for-

mats. The files originate from the Affymetrix' Fusion SDK distribution and other official sources.

Depends R (>= 2.5.0)

License LGPL-2.1

LazyLoad yes

biocViews ExperimentData, MicroarrayData

git_url https://git.bioconductor.org/packages/AffymetrixDataTestFiles

git_branch RELEASE_3_22

git_last_commit d77ca79

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Maintainer Henrik Bengtsson <henrikb@braju.com>

Contents

AffymetrixDataTestFiles-package . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

1

4

Index

AffymetrixDataTestFiles-package

Package AffymetrixDataTestFiles

Description

This package contains annotation data files and sample data files of Affymetrix file formats. The
files originate from the Affymetrix’ Fusion SDK distribution and other official sources. This pack-
age contains only data files.

1

2

Requirements

None.

Installation

AffymetrixDataTestFiles-package

To install this package, see http://www.bioconductor.org/.

Location of data files

Data files are located in two different directory tree depending if they are annotation data files or
sample data files. The roots of these two directory structures are:

system.file("annotationData", package="AffymetrixDataTestFiles")
system.file("rawData", package="AffymetrixDataTestFiles")

Where applicable, ASCII, XDA, and Calvin files are separated in different subdirectories for easy
access to either type.

Directory structure:

annotationData/
chipTypes/
HG-Focus/

+-HG-Focus.PSI
3.ASCII/

+-HG-Focus.CDF

HuGene-1_0-st-v1/

+-HuGene-1_0-st-v1.r4,10_probesets.pgf

Mapping10K_Xba131/

1.XDA/

+-Mapping10K_Xba131.CDF

3.ASCII/

+-Mapping10K_Xba131.CDF

Test3/

+-Test3.PSI
1.XDA/

+-Test3.CDF

3.ASCII/

+-Test3.CDF

rawData/

FusionSDK_HG-Focus/

HG-Focus/

+-HG-Focus-1-121502.EXP
+-HG-Focus-2-121502.EXP
1.XDA/

+-HG-Focus-1-121502.CHP
+-HG-Focus-2-121502.CHP

2.Calvin/

+-HG-Focus-1-121502.CEL
+-HG-Focus-1-121502.CHP
+-HG-Focus-2-121502.CEL
+-HG-Focus-2-121502.CHP

AffymetrixDataTestFiles-package

3

3.ASCII/

+-HG-Focus-1-121502.CEL
+-HG-Focus-2-121502.CEL

FusionSDK_HG-U133A/

HG-U133A/

2.Calvin/

+-ethan1-1.CEL

FusionSDK_Test3/

Test3/

+-Test3-1-121502.EXP
+-Test3-2-121502.EXP
1.XDA/

+-Test3-1-121502.CHP
+-Test3-2-121502.CHP

2.Calvin/

+-Test3-1-121502.CEL
+-Test3-1-121502.CHP
+-Test3-2-121502.CEL
+-Test3-2-121502.CHP

3.ASCII/

+-Test3-1-121502.CEL
+-Test3-2-121502.CEL

License

LGPL version 2.1 according to [1].

Author(s)

Adopted from [1] by the authors of this package.

References

[1] Affymetrix Inc, Fusion Software Developers Kit (SDK), 2007. http://www.affymetrix.com/
support/developer/fusion/

Index

∗ package

AffymetrixDataTestFiles-package, 1

AffymetrixDataTestFiles

(AffymetrixDataTestFiles-package),
1

AffymetrixDataTestFiles-package, 1

4

