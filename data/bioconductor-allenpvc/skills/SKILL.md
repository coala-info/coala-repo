---
name: bioconductor-allenpvc
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/allenpvc.html
---

# bioconductor-allenpvc

name: bioconductor-allenpvc
description: Access and analyze the Tasic et al. (2016) single-cell RNA-sequencing data from the mouse primary visual cortex. Use this skill to load the allenpvc SingleCellExperiment object, access count/RPKM/TPM matrices, and retrieve cell-type metadata for adult mouse cortical cell taxonomy.

# bioconductor-allenpvc

## Overview
The `allenpvc` package provides a `SingleCellExperiment` (SCE) object containing transcriptomic data from 1,809 cells of the adult mouse primary visual cortex. The data includes 49 identified cell types and provides expression matrices for counts, RPKM, and TPM, along with extensive metadata regarding Cre lines, quality control, and cell classifications.

## Data Loading and Initialization
The data is hosted on ExperimentHub and is retrieved using the package's main constructor function.

```R
library(allenpvc)

# Load the SingleCellExperiment object
apvc <- allenpvc()
```

## Accessing Expression Data
The object contains three assay types: `"counts"`, `"rpkm"`, and `"tpm"`. Use the `assay()` function to extract these matrices.

```R
# Extract count matrix
counts_matrix <- assay(apvc, "counts")

# Extract RPKM matrix
rpkm_matrix <- assay(apvc, "rpkm")

# Extract TPM matrix (Note: Spike-in genes in TPM are filled with NAs)
tpm_matrix <- assay(apvc, "tpm")
```

## Exploring Metadata
Cell-level metadata is stored in `colData`. Key columns include `primary_type`, `broad_type`, `cre_driver_1`, and `pass_qc_checks`.

```R
# View all metadata columns
head(colData(apvc))

# Access specific metadata columns directly
cell_types <- apvc$primary_type
broad_categories <- apvc$broad_type

# Filter for cells that passed QC
apvc_qc <- apvc[, apvc$pass_qc_checks == "Y"]
```

## Handling Spike-in Genes
The dataset includes ERCC spike-ins and tdTomato expression. These are integrated into the main matrices but can be separated using `isSpike`.

```R
# Identify spike-in names
spikeNames(apvc)

# Subset to endogenous genes only
apvc_endo <- apvc[!isSpike(apvc), ]

# Subset to spike-in genes only
apvc_spike <- apvc[isSpike(apvc), ]
```

## Common Workflows
1. **Quality Control Filtering**: Use the `pass_qc_checks` column to ensure you are working with high-quality cells as defined by the original study.
2. **Cell Type Analysis**: Group or subset the SCE object by `broad_type` (e.g., GABA-ergic Neuron, Glutamatergic Neuron, Astrocyte) for lineage-specific analysis.
3. **Normalization Comparison**: Compare `counts` vs `rpkm` assays for downstream differential expression or clustering.

## Reference documentation
- [Overview of the allenpvc data set](./references/allenpvc.md)