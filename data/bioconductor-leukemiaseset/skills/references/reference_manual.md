Package ‘leukemiasEset’

February 12, 2026

Type Package

Title Leukemia's microarray gene expression data (expressionSet).

Version 1.46.0

Date 2013-03-20

Author Sara Aibar, Celia Fontanillo and Javier De Las Rivas. Bioinformatics and Functional Ge-

nomics Group. Cancer Research Center (CiC-IBMCC, CSIC/USAL). Salamanca. Spain.

Maintainer Sara Aibar <saibar@usal.es>

Depends R (>= 2.10.1), Biobase (>= 2.5.5)

Description Expressionset containing gene expresion data from 60 bone marrow samples of pa-

tients with one of the four main types of leukemia (ALL, AML, CLL, CML) or non-leukemia.

License GPL (>= 2)

LazyLoad yes

biocViews Tissue, Genome, Homo_sapiens_Data, CancerData,
LeukemiaCancerData, MicroarrayData, ChipOnChipData,
TissueMicroarrayData, GEO

git_url https://git.bioconductor.org/packages/leukemiasEset

git_branch RELEASE_3_22

git_last_commit 68a2d04

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

leukemiasEset .

.

.

.

.

.

.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2

5

Index

1

2

leukemiasEset

leukemiasEset

Leukemia’s microarray gene expression data (expressionSet).

Description

ExpressionSet containing gene expresion data from 60 bone marrow samples of patients with one
of the four main types of leukemia (ALL, AML, CLL, CML) or no-leukemia controls.

Platform: Affymetrix Human Genome U133 Plus 2.0
Annotation: genemapperhgu133plus2 (CDF from GATExplorer)
Mapping: Gene Ensembl ID (20172 features)

Tissue: Bone Marrow
Cell type: Mononuclear cells isolated by Ficoll density centrifugation
Disease type:

1. Acute Lymphoblastic Leukemia (ALL). Subtype: c-ALL / pre-B-ALL without t(9;22)

2. Acute Myeloid Leukemia (AML). Subtype: Normal karyotype

3. Chronic Lymphocytic Leukemia (CLL)

4. Chronic Myeloid Leukemia (CML)

5. Non-leukemia and healthy bone marrow (NoL)

All samples were obtained from untreated patients at the time of diagnosis.

Preprocessing: The microarrays were normalized with RMA using a redefined probe mapping from
Affymetrix probesets to Ensembl genes (Ensembl IDs ENSG). This alternative Chip Definition
File (CDF) with complete unambiguous mapping of microarray probes to genes (GeneMapper)
is available at GATExplorer (http://bioinfow.dep.usal.es/xgate/mapping/mapping.php) (Risueno et
al. 2010).

Usage

data(leukemiasEset)

Format

ExpressionSet with phenoData:

• Project: "Mile1" for all samples

• Tissue: "BoneMarrow"

• LeukemiaType: Leukemia type acronym: "ALL", "AML", "CLL", "CML" or "NoL"

• LeukemiaTypeFullName: The full leukemia type name.

• Subtype: "AML with normal karyotype and other abnormalities", or "c_ALL/Pre_B_ALL

without t(9 22)" if applies

leukemiasEset

Details

3

Package:
Type:
Version:
Date:
License:
LazyLoad:

leukemiasEset
Package
1.0
2013-03-13
GPL (>=2)
yes

Author(s)

Author: Sara Aibar, Celia Fontanillo and Javier De Las Rivas. Bioinformatics and Functional
Genomics Group. Cancer Research Center (CiC-IBMCC, CSIC/USAL). Salamanca. Spain.

Maintainer: Sara Aibar <saibar@usal.es>

Source

This is a subset of the samples collected by the Microarray Innovations in Leukemia (MILE) study
(Kohlmann et al. 2008, Haferlach et al. 2010). Full study microarray raw data can be found at
the NCBI Gene Expression Omnibus database (GEO, http://www.ncbi.nlm.nih.gov/geo/) under se-
ries accession number GSE13159. The selected samples are labelled keeping their source GEO IDs.

References

Kohlmann A, Kipps TJ, Rassenti LZ, Downing JR et al. An international standardization programme
towards the application of gene expression profiling in routine leukaemia diagnostics:
the Mi-
croarray Innovations in LEukemia study prephase. Br J Haematol (2008) 142(5):802-7. PMID:
18573112

Haferlach T, Kohlmann A, Wieczorek L, Basso G et al. Clinical utility of microarray-based gene ex-
pression profiling in the diagnosis and subclassification of leukemia: report from the International
Microarray Innovations in Leukemia Study Group. J Clin Oncol (2010) 28(15):2529-37. PMID:
20406941

Risueno A, Fontanillo C, Dinger ME, De Las Rivas J. GATExplorer: genomic and transcriptomic
explorer; mapping expression probes to gene loci, transcripts, exons and ncRNAs. BMC Bioinfor-
matics (2010) 11:221. PMID: 20429936.

See Also

This dataset is used in the examples on package geNetClassifier.

Examples

# Load expression set:
library(leukemiasEset)
data(leukemiasEset)

# ExpressionSet overview:

4

leukemiasEset

leukemiasEset

# Phenodata:
pData(leukemiasEset)

# Number of samples per class:
summary(leukemiasEset$LeukemiaType)

# For adding a prefix with the disease to the sample name:
sampleNames(leukemiasEset) <- paste(leukemiasEset$LeukemiaType,

sampleNames(leukemiasEset), sep="_")

colnames(exprs(leukemiasEset))

Index

∗ cancer

leukemiasEset, 2

∗ datasets

leukemiasEset, 2

∗ expression

leukemiasEset, 2

∗ leukemia

leukemiasEset, 2

∗ microarrays

leukemiasEset, 2

ExpressionSet, 2

geNetClassifier, 3

leukemiasEset, 2
leukemiasEset-package (leukemiasEset), 2

RMA, 2

5

