Package ‘ConnectivityMap’

February 12, 2026

Type Package

Title Functional connections between drugs, genes and diseases as

revealed by common gene-expression changes

Version 1.46.0

Date 2013-03-15

Author Paul Shannon

Maintainer Paul Shannon<pshannon@systemsbiology.org>

Depends R (>= 2.15.1)

Suggests RUnit, BiocGenerics

Description The Broad Institute's Connectivity Map (cmap02) is a ``large
reference catalogue of gene-expression data from cultured human
cells perturbed with many chemicals and genetic reagents'', containing more
than 7000 gene expression profiles and 1300 small molecules.

biocViews ExperimentData, CancerData, MicroarrayData

License GPL-3

git_url https://git.bioconductor.org/packages/ConnectivityMap

git_branch RELEASE_3_22

git_last_commit 184b3e3

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

ConnectivityMap .

.

.

.

.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2

4

Index

1

2

ConnectivityMap

ConnectivityMap

ConnectivityMap: Functional connections between drugs, genes and
diseases as revealed by common gene-expression changes

Description

The Broad Institute’s Connectivity Map (cmap02) http://www.broadinstitute.org/cmap/

is a "large reference catalogue of gene-expression data from cultured human cells perturbed with
many chemicals and genetic reagents", containing more than 7000 gene expression profiles and
1300 small molecules. Quoting further:

To pursue a systematic approach to the discovery of functional connections among diseases, genetic
perturbation, and drug action, we have created the first installment of a reference collection of
gene-expression profiles from cultured human cells treated with bioactive small molecules, together
with pattern-matching software to mine these data. We demonstrate that this "Connectivity Map"
resource can be used to find connections among small molecules sharing a mechanism of action,
chemicals and physiological processes, and diseases and drugs. These results indicate the feasibility
of the approach and suggest the value of a large-scale community Connectivity Map project.

This data package contains two data objects, obtained with permission from the Broad Institute,
transformed very modestly, and presented as serialied RData objecgs:

• rankMatrix: 22283 rows (human Affymetrix probeIDs) x 6100 perturbation "instances"
• instances: 14 columns of metadata describing each of the 6100 instances.

The metadata matrix, instances has these columns:

• instance_id

• batch_id

• cmap_name

• INN1

• concentration (M) (appears as "conentration..M.")

• duration (h) (appears as "duration..h.")

• cell2

• array3

• perturbation_scan_id

• vehicle_scan_id4

• scanner

• vehicle

• vendor

• catalog_number

• catalog_name

References

Lamb, Justin, et al. "The Connectivity Map: using gene-expression signatures to connect small
molecules, genes, and disease." Science Signalling 313.5795 (2006): 1929.

Lamb, Justin. "The Connectivity Map: a new tool for biomedical research." Nature Reviews Cancer
7.1 (2007): 54-60.

ConnectivityMap

Examples

library(ConnectivityMap)
data(rankMatrix)
data(instances)
print(table(instances$cell2))

# identify the pertubrations in the rankMatrix from the SKMEL5 skin
# melanoma cell line

skmel.instance.names <- rownames(subset(instances, cell2=="SKMEL5"))
matrix.skmel <- rankMatrix[, skmel.instance.names]

3

Index

∗ datasets

ConnectivityMap, 2

ConnectivityMap, 2

instances (ConnectivityMap), 2

rankMatrix (ConnectivityMap), 2

4

