Package
‘FlowSorted.CordBloodNorway.450k’

February 12, 2026

Version 1.36.0

Title Illumina HumanMethylation data on sorted cord blood cell

populations

Description Raw data objects for the Illumina 450k DNA methylation

microarrays, for cell type composition estimation.

License Artistic-2.0

URL https://bitbucket.com/kasperdanielhansen/Illumina_CordBlood

Depends R (>= 3.2.0), minfi (>= 1.21.2)

LazyData yes

biocViews ExperimentData, Homo_sapiens_Data, Tissue, MicroarrayData,

TissueMicroarrayData, MethylationArrayData

git_url https://git.bioconductor.org/packages/FlowSorted.CordBloodNorway.450k

git_branch RELEASE_3_22

git_last_commit a5da2ea

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Author kristina gervin [cre, aut],
Kasper Daniel Hansen [aut]

Maintainer kristina gervin <kristina.gervin@medisin.uio.no>

Contents

FlowSorted.CordBloodNorway.450k . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2

3

Index

1

2

FlowSorted.CordBloodNorway.450k

FlowSorted.CordBloodNorway.450k

Illumina Human Methylation data from 450k on sorted cord blood cell
populations

Description

The FlowSorted.CordBloodNorway.450k package contains Illumina HumanMethylation450 (“450k”))
DNA methylation microarray data provided by Kristina Gervin and coworkers (manuscript in prepa-
ration), consisting of 77 umbilical cord blood samples, formatted as an RGset object for easy inte-
gration and normalization using existing Bioconductor packages.

This package contains data equivalent to the FlowSorted.Blood.450k package consisting of data
from peripheral blood samples generated from adult men. However, minfi estimates of cell type
composition in umbilical cord blood samples using the FlowSorted.Blood.450k package does not
correlate well with cell counts (see references). Hence, this package consists of appropriate data for
deconvolution of cord blood samples used in for example EWAS.

Researchers may find this package useful as these samples represent different cellular populations
(lymphocytes (CD4+ and CD8+), B cells (CD19+), monocytes (CD14+), NK cells (CD56+) and
granulocytes of whole umbilical cord blood generated on the same 11 (6 girls and 5 boys) indi-
viduals using flow sorting, an experimental procedure that can separate heterogeneous biological
samples like umbilical blood into pure cellular populations. This data can be directly integrated
with the minfi Bioconductor package to estimate cellular composition in users’ whole blood Illu-
mina 450k samples using a modified version of the algorithm described in Houseman et al. 2012.

Usage

data(FlowSorted.CordBloodNorway.450k)

Format

An object of class RGset.

Details

The FlowSorted.CordBloodNorway.450k objects is based an samples assayed by Kristina Gervin
and collegaues; manuscript in preparation.

References

P Yousefi et al. (2015). Estimation of blood cellular heterogeneity in newborns and children for
epigenome-wide association studies. Environ. Mol. Mutagen. 56, 751-758.
EA Houseman et al. (2012) DNA methylation arrays as surrogate measures of cell mixture distri-
bution. BMC Bioinformatics 13, 86.

See Also

See the minfi package for tools for estimating cell type composition in blood using these data. See
the FlowSorted.CordBlood.450k for an alternative reference dataset for Cord Blood samples.

Examples

data(FlowSorted.CordBloodNorway.450k)

Index

∗ datasets

FlowSorted.CordBloodNorway.450k, 2

FlowSorted.CordBloodNorway.450k, 2

3

