Package ‘waveTilingData’

April 9, 2019

Title waveTiling Example Data

Version 1.18.0

Created 2012-05-30

Author Kristof De Beuf <kristof.debeuf@ugent.be>

Description

Experiment and Annotation Data ﬁles used by the examples / vignette in the waveTiling package

Maintainer Kristof De Beuf <kristof.debeuf@ugent.be>

Depends R (>= 2.14.0)

License GPL (>= 2)

biocViews ExperimentData, Arabidopsis_thaliana_Data, MicroarrayData

git_url https://git.bioconductor.org/packages/waveTilingData

git_branch RELEASE_3_8

git_last_commit 72046c7

git_last_commit_date 2018-10-30

Date/Publication 2019-04-09

R topics documented:

.

waveTilingData-package .
.
.
.
leafdev .
.
.
.
.
leafdevBQ .
.
leafdevFit
.
.
.
leafdevInfCompare .
.
leafdevMapAndFilterTAIR9 .

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

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
.
.

Index

1

2
2
3
3
4
4

5

2

leafdev

waveTilingData-package

Example datasets for the waveTiling package

Description

This package contains the datasets used in the waveTiling package vignette and examples.

Author(s)

Kristof De Beuf <kristof.debeuf@ugent.be>

See Also

leafdev,leafdevBQ,leafdevFit,leafdevInfCompare,leafdevMapAndFilterTAIR9

Examples

dataDir <- system.file("data", package="waveTilingData")
setwd(dataDir)
dir()

leafdev

Example data

Description

Example data set (TilingFeatureSet) on leaf development in the plant Arabidopsis thaliana [1] for
use of the waveTiling package. The data set contains 6553600 features and 18 samples. Transcrip-
tome analysis was conducted for 6 developmental time points (day 8 to day 13), with 3 biological
replicates per time point. The focus of the initial study was to unravel the underlying mechanisms
of on one hand the transition from cell division to cell expansion and on the other hand the transition
from non-photosynthetic to photosynthetic leaves.

Usage

data(leafdev)

References

[1] Andriankaja M, Dhondt S, De Bodt S, Vanhaeren H, Coppens F, et al. (2012) Exit from prolif-
eration during leaf development in Arabidopsis thaliana: A not-so-gradual process. Developmental
Cell 22: 64-78.

Examples

data(leafdev)

leafdevBQ

3

leafdevBQ

Example data

Description

Example data set (TilingFeatureSet) on leaf development in the plant Arabidopsis thaliana for
use of the waveTiling package. The data are taken from [1]. The dataset contains the background-
corrected and quantile-normalized expression data

Usage

data(leafdevBQ)

References

[1] Andriankaja M, Dhondt S, De Bodt S, Vanhaeren H, Coppens F, et al. (2012) Exit from prolif-
eration during leaf development in Arabidopsis thaliana: A not-so-gradual process. Developmental
Cell 22: 64-78.

Examples

data(leafdevBQ)

leafdevFit

Example waveTiling ﬁt object

Description

Example WfmFit-class object as output after ﬁtting the wavelet-based functional model to the
leafdev data for the forward strand of chromosome 1.

Usage

data(leafdevFit)

Examples

data(leafdevFit)

4

leafdevMapAndFilterTAIR9

leafdevInfCompare

Example waveTiling inference object

Description

Example WfmInf-class object as output after transcriptome analysis of the leafdev data for the
forward strand of chromosome 1, using pairwise comparisons between the different time points.

Usage

data(leafdevInfCompare)

Examples

data(leafdevInfCompare)

leafdevMapAndFilterTAIR9

Example waveTiling mapFilterProbe object

Description

Example mapFilterProbe-class object as output after ﬁltering redundant probes (PM/MM and/or
forward/reverse strand) and remapping the probes to the Arabidopsis thaliana TAIR9 genome se-
quence.

Usage

data(leafdevMapAndFilterTAIR9)

Examples

data(leafdevMapAndFilterTAIR9)

Index

∗Topic datasets

leafdev, 2
leafdevBQ, 3
leafdevFit, 3
leafdevInfCompare, 4
leafdevMapAndFilterTAIR9, 4

leafdev, 2, 2
leafdevBQ, 2, 3
leafdevFit, 2, 3
leafdevInfCompare, 2, 4
leafdevMapAndFilterTAIR9, 2, 4

waveTilingData

(waveTilingData-package), 2

waveTilingData-package, 2

5

