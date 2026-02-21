---
name: bioconductor-kodata
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/KOdata.html
---

# bioconductor-kodata

name: bioconductor-kodata
description: Access and utilize LINCS Knock-Out (KO) consensus genomic signatures and baseline gene expression data. Use this skill when a user needs to retrieve experimental cell-line specific gene knock-out data or baseline expression measurements (Affymetrix, RNA-seq, copy number) for genes across various cell lines, particularly for use with the KEGGlincs package.

# bioconductor-kodata

## Overview
The `KOdata` package is a Bioconductor experiment data package that provides access to the Library of Integrated Network-based Cellular Signatures (LINCS) knock-out data. It contains consensus genomic signatures (CGS) resulting from experimental gene knock-outs conducted by the Broad Institute, as well as baseline gene expression data for a subset of these cell lines. It is primarily designed to support the `KEGGlincs` package for functional analysis of metabolic pathways.

## Loading the Package and Data
To use the data, you must first load the library and then use the `data()` function to load the specific datasets into your R environment.

```r
# Load the package
library(KOdata)

# Load the baseline expression data
data(gene_cell_info)

# Load the knock-out signatures
data(KO_data)
```

## Working with Datasets

### Baseline Expression (`gene_cell_info`)
This dataset contains baseline measurements for genes in cell lines without experimental perturbations.
- **Structure**: A data frame with variables including `pr_gene_symbol`, `cell`, `basex_affx` (Affymetrix), `basex_rnaseq` (RNA-seq), `copy_number`, and `is_expressed`.
- **Usage**: Use this to filter for genes that are natively expressed in a specific cell line before analyzing knock-out effects.

```r
# Example: Filter for genes expressed in a specific cell line (e.g., "A549")
a549_baseline <- subset(gene_cell_info, cell == "A549" & is_expressed == TRUE)
```

### Knock-Out Signatures (`KO_data`)
This dataset contains the consensus genome signatures (CGS) from Broad Institute knock-out studies.
- **Structure**: A data frame containing `cell_id`, `pert_desc` (the gene knocked out), `pert_time`, and various columns for up-regulated and down-regulated genes (e.g., `up100_full`, `dn100_full`, `up50_lm`).
- **Usage**: Use this to identify which genes are significantly impacted when a specific target gene is knocked out.

```r
# Example: Find signatures for a specific gene knock-out
tp53_ko <- subset(KO_data, pert_desc == "TP53")

# View the top 100 up-regulated genes for the first entry
print(tp53_ko$up100_full[1])
```

## Typical Workflow
1. **Identify Target**: Choose a gene of interest (e.g., a kinase or transcription factor).
2. **Retrieve KO Data**: Extract the `KO_data` rows where `pert_desc` matches your target.
3. **Contextualize**: Use `gene_cell_info` to verify the baseline state of the cell lines used in the KO experiments.
4. **Pathway Analysis**: Pass the resulting signatures to `KEGGlincs` to visualize how the knock-out affects specific KEGG pathways.

## Reference documentation
- [KOdata Reference Manual](./references/reference_manual.md)